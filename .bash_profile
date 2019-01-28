export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/bin:/bin

export GOROOT=~/go
export GOPATH=~/goworks-berith
#export GOPATH=~/goworks
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export BOOTNODE=enode://c76ba3e26c694db780e78c4f0a48bcc681ed167fc1cc303167d1f595235ac356d02b24c605fdf251cbb0278a19196f6e61776a818f9d009eee2394952f4ab770@192.168.50.13:30310
export BOOTNODE_NET=192.168.50.0/24

function bootnode-run { nohup bootnode -netrestrict "$BOOTNODE_NET" -nodekey boot.key -verbosity 9 -addr :30310 >> ~/bootnode.log & }
alias bootnode-address='bootnode -nodekey boot.key -verbosity 9 -addr :30310 -writeaddress'
alias bootnode-log="tail -f ~/bootnode.log"

alias geth-kill="ps -ef | grep geth | grep grep -v | awk '{print \$2}' | xargs -i  kill -2 {}"
alias geth-init='nohup geth --datadir=~/testnet --nodiscover --cache=2048 init ~/testnet/genesis.json >> ~/geth.log &'
function geth-run { nohup geth --datadir=~/testnet --bootnodes "$BOOTNODE" --syncmode "full" --cache=2048 >> ~/geth.log & }
alias geth-console='geth --datadir=~/testnet --nodiscover console'
alias geth-attach='geth --datadir=~/testnet --nodiscover attach'
alias geth-remove-db='geth --datadir=~/testnet removedb'
alias geth-log='tail -f ~/geth.log'
alias geth-remove-data='cd ~/testnet;ls | grep -v genesis.json | xargs -i rm -rf {}'

function goto-berith { 
	cd $GOPATH/src/bitbucket.org/ibizsoftware/berith-chain 
}

function geth-init-run {
        geth-kill
        sleep 1
        geth-remove-data
        sleep 1
        geth-init
        sleep 1
        geth-run
}

