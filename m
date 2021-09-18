Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48453410445
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 08:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhIRGQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 02:16:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:39535 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhIRGQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 02:16:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="308462100"
X-IronPort-AV: E=Sophos;i="5.85,303,1624345200"; 
   d="gz'50?scan'50,208,50";a="308462100"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 23:15:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,303,1624345200"; 
   d="gz'50?scan'50,208,50";a="701570861"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 17 Sep 2021 23:15:28 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mRTdH-0004fs-VC; Sat, 18 Sep 2021 06:15:27 +0000
Date:   Sat, 18 Sep 2021 14:14:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <cong.wang@bytedance.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:bpf 5/5] net/ipv4/tcp.c:566:25: error: implicit
 declaration of function 'tcp_bpf_poll'; did you mean 'tcp_bpf_rtt'?
Message-ID: <202109181447.Nwq0VTzX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/congwang/linux.git bpf
head:   5d467183b34e09531688cab9bae950fa6d5d04d3
commit: 5d467183b34e09531688cab9bae950fa6d5d04d3 [5/5] tcp_bpf: poll psock queues too in tcp_poll()
config: ia64-defconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/5d467183b34e09531688cab9bae950fa6d5d04d3
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang bpf
        git checkout 5d467183b34e09531688cab9bae950fa6d5d04d3
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/ipv4/tcp.c: In function 'tcp_poll':
>> net/ipv4/tcp.c:566:25: error: implicit declaration of function 'tcp_bpf_poll'; did you mean 'tcp_bpf_rtt'? [-Werror=implicit-function-declaration]
     566 |                 mask |= tcp_bpf_poll(sk);
         |                         ^~~~~~~~~~~~
         |                         tcp_bpf_rtt
   cc1: some warnings being treated as errors


vim +566 net/ipv4/tcp.c

   494	
   495	/*
   496	 *	Wait for a TCP event.
   497	 *
   498	 *	Note that we don't need to lock the socket, as the upper poll layers
   499	 *	take care of normal races (between the test and the event) and we don't
   500	 *	go look at any of the socket buffers directly.
   501	 */
   502	__poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
   503	{
   504		__poll_t mask;
   505		struct sock *sk = sock->sk;
   506		const struct tcp_sock *tp = tcp_sk(sk);
   507		int state;
   508	
   509		sock_poll_wait(file, sock, wait);
   510	
   511		state = inet_sk_state_load(sk);
   512		if (state == TCP_LISTEN)
   513			return inet_csk_listen_poll(sk);
   514	
   515		/* Socket is not locked. We are protected from async events
   516		 * by poll logic and correct handling of state changes
   517		 * made by other threads is impossible in any case.
   518		 */
   519	
   520		mask = 0;
   521	
   522		/*
   523		 * EPOLLHUP is certainly not done right. But poll() doesn't
   524		 * have a notion of HUP in just one direction, and for a
   525		 * socket the read side is more interesting.
   526		 *
   527		 * Some poll() documentation says that EPOLLHUP is incompatible
   528		 * with the EPOLLOUT/POLLWR flags, so somebody should check this
   529		 * all. But careful, it tends to be safer to return too many
   530		 * bits than too few, and you can easily break real applications
   531		 * if you don't tell them that something has hung up!
   532		 *
   533		 * Check-me.
   534		 *
   535		 * Check number 1. EPOLLHUP is _UNMASKABLE_ event (see UNIX98 and
   536		 * our fs/select.c). It means that after we received EOF,
   537		 * poll always returns immediately, making impossible poll() on write()
   538		 * in state CLOSE_WAIT. One solution is evident --- to set EPOLLHUP
   539		 * if and only if shutdown has been made in both directions.
   540		 * Actually, it is interesting to look how Solaris and DUX
   541		 * solve this dilemma. I would prefer, if EPOLLHUP were maskable,
   542		 * then we could set it on SND_SHUTDOWN. BTW examples given
   543		 * in Stevens' books assume exactly this behaviour, it explains
   544		 * why EPOLLHUP is incompatible with EPOLLOUT.	--ANK
   545		 *
   546		 * NOTE. Check for TCP_CLOSE is added. The goal is to prevent
   547		 * blocking on fresh not-connected or disconnected socket. --ANK
   548		 */
   549		if (sk->sk_shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
   550			mask |= EPOLLHUP;
   551		if (sk->sk_shutdown & RCV_SHUTDOWN)
   552			mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
   553	
   554		/* Connected or passive Fast Open socket? */
   555		if (state != TCP_SYN_SENT &&
   556		    (state != TCP_SYN_RECV || rcu_access_pointer(tp->fastopen_rsk))) {
   557			int target = sock_rcvlowat(sk, 0, INT_MAX);
   558	
   559			if (READ_ONCE(tp->urg_seq) == READ_ONCE(tp->copied_seq) &&
   560			    !sock_flag(sk, SOCK_URGINLINE) &&
   561			    tp->urg_data)
   562				target++;
   563	
   564			if (tcp_stream_is_readable(sk, target))
   565				mask |= EPOLLIN | EPOLLRDNORM;
 > 566			mask |= tcp_bpf_poll(sk);
   567	
   568			if (!(sk->sk_shutdown & SEND_SHUTDOWN)) {
   569				if (__sk_stream_is_writeable(sk, 1)) {
   570					mask |= EPOLLOUT | EPOLLWRNORM;
   571				} else {  /* send SIGIO later */
   572					sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);
   573					set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
   574	
   575					/* Race breaker. If space is freed after
   576					 * wspace test but before the flags are set,
   577					 * IO signal will be lost. Memory barrier
   578					 * pairs with the input side.
   579					 */
   580					smp_mb__after_atomic();
   581					if (__sk_stream_is_writeable(sk, 1))
   582						mask |= EPOLLOUT | EPOLLWRNORM;
   583				}
   584			} else
   585				mask |= EPOLLOUT | EPOLLWRNORM;
   586	
   587			if (tp->urg_data & TCP_URG_VALID)
   588				mask |= EPOLLPRI;
   589		} else if (state == TCP_SYN_SENT && inet_sk(sk)->defer_connect) {
   590			/* Active TCP fastopen socket with defer_connect
   591			 * Return EPOLLOUT so application can call write()
   592			 * in order for kernel to generate SYN+data
   593			 */
   594			mask |= EPOLLOUT | EPOLLWRNORM;
   595		}
   596		/* This barrier is coupled with smp_wmb() in tcp_reset() */
   597		smp_rmb();
   598		if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
   599			mask |= EPOLLERR;
   600	
   601		return mask;
   602	}
   603	EXPORT_SYMBOL(tcp_poll);
   604	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--xHFwDpU9dbj6ez1V
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--xHFwDpU9dbj6ez1V--
