Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006973FB072
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhH3EaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:30:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:15699 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhH3EaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:30:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="216358628"
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="gz'50?scan'50,208,50";a="216358628"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 21:29:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="gz'50?scan'50,208,50";a="686973819"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2021 21:29:12 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKYv2-0004pF-4J; Mon, 30 Aug 2021 04:29:12 +0000
Date:   Mon, 30 Aug 2021 12:28:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: kernel/bpf/verifier.c:9383:12: warning: stack frame size (2224)
 exceeds limit (2048) in function 'do_check'
Message-ID: <202108301202.nNtGrTLW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7d2a07b769330c34b4deabeed939325c77a7ec2f
commit: 198688edbf77c6fc0e65f5d062f810d83d090166 MIPS: Fix inline asm input/output type mismatch in checksum.h used with Clang
date:   7 months ago
config: mips-randconfig-r026-20210829 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 510e106fa8635e7f9c51c896180b971de6309b2f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=198688edbf77c6fc0e65f5d062f810d83d090166
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 198688edbf77c6fc0e65f5d062f810d83d090166
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/verifier.c:9383:12: warning: stack frame size (2224) exceeds limit (2048) in function 'do_check' [-Wframe-larger-than]
   static int do_check(struct bpf_verifier_env *env)
              ^
   1 warning generated.
--
   kernel/sched/core.c:2828:6: warning: no previous prototype for function 'sched_set_stop_task'
   void sched_set_stop_task(int cpu, struct task_struct
   ^
   kernel/sched/core.c:2828:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void sched_set_stop_task(int cpu, struct task_struct
   ^
   static
   kernel/sched/core.c:4238:13: warning: variable 'rq' set but not used
   struct rq
   ^
   kernel/sched/core.c:5176:35: warning: no previous prototype for function 'schedule_user'
   asmlinkage __visible void __sched schedule_user(void)
   ^
   kernel/sched/core.c:5176:22: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage __visible void __sched schedule_user(void)
   ^
   static
   kernel/sched/core.c:1788:20: warning: unused function 'rq_has_pinned_tasks'
   static inline bool rq_has_pinned_tasks(struct rq
   ^
>> kernel/sched/core.c:7355:20: warning: unused function 'balance_hotplug_wait'
   static inline void balance_hotplug_wait(void)
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set noat
   .set push
   .set arch=r4000
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/cmpxchg.h", .line = 171, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: lld $0, $2 # __cmpxchg_asm
   bne $0, ${3:z}, 2f
   .set pop
   move $$1, ${4:z}
   .set arch=r4000
   scd $$1, $1
   beqz $$1, 1b
   .set pop
   2: .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/cmpxchg.h", .line = 171, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 510e106fa8635e7f9c51c896180b971de6309b2f)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-510e106fa8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers fs include kernel mm net nr_bisected scripts source usr
--
>> kernel/sched/topology.c:157:20: warning: unused function 'sched_debug'
   static inline bool sched_debug(void)
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/bitops.h", .line = 133, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: lld $0, $1
   and $0, $2
   scd $0, $1
   beqz $0, 1b
   .set pop
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 510e106fa8635e7f9c51c896180b971de6309b2f)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-510e106fa8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers fs include kernel mm net nr_bisected scripts source usr
--
>> drivers/infiniband/sw/siw/siw_qp_tx.c:1012:5: warning: stack frame size (2768) exceeds limit (2048) in function 'siw_qp_sq_process'
   int siw_qp_sq_process(struct siw_qp
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/atomic.h", .line = 154, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $1, $2 # atomic_fetch_sub
   subu $0, $1, $3
   sc $0, $2
   beqz $0, 1b
   .set pop
   move $0, $1
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 510e106fa8635e7f9c51c896180b971de6309b2f)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-510e106fa8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers fs include kernel mm net nr_bisected scripts source usr
--
>> net/ipv4/netfilter/ipt_CLUSTERIP.c:83:1: warning: unused function 'clusterip_config_get'
   clusterip_config_get(struct clusterip_config
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/atomic.h", .line = 154, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $1, $2 # atomic_fetch_sub
   subu $0, $1, $3
   sc $0, $2
   beqz $0, 1b
   .set pop
   move $0, $1
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 510e106fa8635e7f9c51c896180b971de6309b2f)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-510e106fa8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers fs include kernel mm net nr_bisected scripts source usr
--
>> drivers/nvme/target/tcp.c:1201:13: warning: stack frame size (2336) exceeds limit (2048) in function 'nvmet_tcp_io_work'
   static void nvmet_tcp_io_work(struct work_struct
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set noat
   .set push
   .set arch=r4000
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/cmpxchg.h", .line = 86, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: lld $0, $2 # __xchg_asm
   .set pop
   move $$1, ${3:z}
   .set arch=r4000
   scd $$1, $1
   beqz $$1, 1b
   .set pop
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 510e106fa8635e7f9c51c896180b971de6309b2f)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-510e106fa8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers fs include kernel mm net nr_bisected scripts source usr
--
>> net/openvswitch/actions.c:1234:12: warning: stack frame size (2304) exceeds limit (2048) in function 'do_execute_actions'
   static int do_execute_actions(struct datapath struct sk_buff
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set noat
   .set push
   .set arch=r4000
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/cmpxchg.h", .line = 163, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   1: ll $0, $2 # __cmpxchg_asm
   bne $0, ${3:z}, 2f
   .set pop
   move $$1, ${4:z}
   .set arch=r4000
   sc $$1, $1
   beqz $$1, 1b
   .set pop
   2: .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/cmpxchg.h", .line = 163, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 510e106fa8635e7f9c51c896180b971de6309b2f)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-510e106fa8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers fs include kernel mm net nr_bisected scripts source usr


vim +/do_check +9383 kernel/bpf/verifier.c

c64b7983288e63 Joe Stringer       2018-10-02  9382  
58e2af8b3a6b58 Jakub Kicinski     2016-09-21 @9383  static int do_check(struct bpf_verifier_env *env)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9384  {
6f8a57ccf85117 Andrii Nakryiko    2020-04-23  9385  	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
51c39bb1d5d105 Alexei Starovoitov 2020-01-09  9386  	struct bpf_verifier_state *state = env->cur_state;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9387  	struct bpf_insn *insns = env->prog->insnsi;
638f5b90d46016 Alexei Starovoitov 2017-10-31  9388  	struct bpf_reg_state *regs;
06ee7115b0d174 Alexei Starovoitov 2019-04-01  9389  	int insn_cnt = env->prog->len;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9390  	bool do_print_state = false;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  9391  	int prev_insn_idx = -1;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9392  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9393  	for (;;) {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9394  		struct bpf_insn *insn;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9395  		u8 class;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9396  		int err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9397  
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  9398  		env->prev_insn_idx = prev_insn_idx;
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9399  		if (env->insn_idx >= insn_cnt) {
61bd5218eef349 Jakub Kicinski     2017-10-09  9400  			verbose(env, "invalid insn idx %d insn_cnt %d\n",
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9401  				env->insn_idx, insn_cnt);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9402  			return -EFAULT;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9403  		}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9404  
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9405  		insn = &insns[env->insn_idx];
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9406  		class = BPF_CLASS(insn->code);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9407  
06ee7115b0d174 Alexei Starovoitov 2019-04-01  9408  		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
61bd5218eef349 Jakub Kicinski     2017-10-09  9409  			verbose(env,
61bd5218eef349 Jakub Kicinski     2017-10-09  9410  				"BPF program is too large. Processed %d insn\n",
06ee7115b0d174 Alexei Starovoitov 2019-04-01  9411  				env->insn_processed);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9412  			return -E2BIG;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9413  		}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9414  
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9415  		err = is_state_visited(env, env->insn_idx);
f1bca824dabba4 Alexei Starovoitov 2014-09-29  9416  		if (err < 0)
f1bca824dabba4 Alexei Starovoitov 2014-09-29  9417  			return err;
f1bca824dabba4 Alexei Starovoitov 2014-09-29  9418  		if (err == 1) {
f1bca824dabba4 Alexei Starovoitov 2014-09-29  9419  			/* found equivalent state, can prune the search */
06ee7115b0d174 Alexei Starovoitov 2019-04-01  9420  			if (env->log.level & BPF_LOG_LEVEL) {
f1bca824dabba4 Alexei Starovoitov 2014-09-29  9421  				if (do_print_state)
979d63d50c0c0f Daniel Borkmann    2019-01-03  9422  					verbose(env, "\nfrom %d to %d%s: safe\n",
979d63d50c0c0f Daniel Borkmann    2019-01-03  9423  						env->prev_insn_idx, env->insn_idx,
979d63d50c0c0f Daniel Borkmann    2019-01-03  9424  						env->cur_state->speculative ?
979d63d50c0c0f Daniel Borkmann    2019-01-03  9425  						" (speculative execution)" : "");
f1bca824dabba4 Alexei Starovoitov 2014-09-29  9426  				else
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9427  					verbose(env, "%d: safe\n", env->insn_idx);
f1bca824dabba4 Alexei Starovoitov 2014-09-29  9428  			}
f1bca824dabba4 Alexei Starovoitov 2014-09-29  9429  			goto process_bpf_exit;
f1bca824dabba4 Alexei Starovoitov 2014-09-29  9430  		}
f1bca824dabba4 Alexei Starovoitov 2014-09-29  9431  
c3494801cd1785 Alexei Starovoitov 2018-12-03  9432  		if (signal_pending(current))
c3494801cd1785 Alexei Starovoitov 2018-12-03  9433  			return -EAGAIN;
c3494801cd1785 Alexei Starovoitov 2018-12-03  9434  
3c2ce60bdd3d57 Daniel Borkmann    2017-05-18  9435  		if (need_resched())
3c2ce60bdd3d57 Daniel Borkmann    2017-05-18  9436  			cond_resched();
3c2ce60bdd3d57 Daniel Borkmann    2017-05-18  9437  
06ee7115b0d174 Alexei Starovoitov 2019-04-01  9438  		if (env->log.level & BPF_LOG_LEVEL2 ||
06ee7115b0d174 Alexei Starovoitov 2019-04-01  9439  		    (env->log.level & BPF_LOG_LEVEL && do_print_state)) {
06ee7115b0d174 Alexei Starovoitov 2019-04-01  9440  			if (env->log.level & BPF_LOG_LEVEL2)
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9441  				verbose(env, "%d:", env->insn_idx);
c5fc9692d101d1 David S. Miller    2017-05-10  9442  			else
979d63d50c0c0f Daniel Borkmann    2019-01-03  9443  				verbose(env, "\nfrom %d to %d%s:",
979d63d50c0c0f Daniel Borkmann    2019-01-03  9444  					env->prev_insn_idx, env->insn_idx,
979d63d50c0c0f Daniel Borkmann    2019-01-03  9445  					env->cur_state->speculative ?
979d63d50c0c0f Daniel Borkmann    2019-01-03  9446  					" (speculative execution)" : "");
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9447  			print_verifier_state(env, state->frame[state->curframe]);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9448  			do_print_state = false;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9449  		}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9450  
06ee7115b0d174 Alexei Starovoitov 2019-04-01  9451  		if (env->log.level & BPF_LOG_LEVEL) {
7105e828c087de Daniel Borkmann    2017-12-20  9452  			const struct bpf_insn_cbs cbs = {
7105e828c087de Daniel Borkmann    2017-12-20  9453  				.cb_print	= verbose,
abe0884011f1a5 Jiri Olsa          2018-03-23  9454  				.private_data	= env,
7105e828c087de Daniel Borkmann    2017-12-20  9455  			};
7105e828c087de Daniel Borkmann    2017-12-20  9456  
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9457  			verbose_linfo(env, env->insn_idx, "; ");
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9458  			verbose(env, "%d: ", env->insn_idx);
abe0884011f1a5 Jiri Olsa          2018-03-23  9459  			print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9460  		}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9461  
cae1927c0b4a93 Jakub Kicinski     2017-12-27  9462  		if (bpf_prog_is_dev_bound(env->prog->aux)) {
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9463  			err = bpf_prog_offload_verify_insn(env, env->insn_idx,
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9464  							   env->prev_insn_idx);
13a27dfc669724 Jakub Kicinski     2016-09-21  9465  			if (err)
13a27dfc669724 Jakub Kicinski     2016-09-21  9466  				return err;
cae1927c0b4a93 Jakub Kicinski     2017-12-27  9467  		}
13a27dfc669724 Jakub Kicinski     2016-09-21  9468  
638f5b90d46016 Alexei Starovoitov 2017-10-31  9469  		regs = cur_regs(env);
51c39bb1d5d105 Alexei Starovoitov 2020-01-09  9470  		env->insn_aux_data[env->insn_idx].seen = env->pass_cnt;
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  9471  		prev_insn_idx = env->insn_idx;
fd978bf7fd3125 Joe Stringer       2018-10-02  9472  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9473  		if (class == BPF_ALU || class == BPF_ALU64) {
1be7f75d1668d6 Alexei Starovoitov 2015-10-07  9474  			err = check_alu_op(env, insn);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9475  			if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9476  				return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9477  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9478  		} else if (class == BPF_LDX) {
3df126f35f88dc Jakub Kicinski     2016-09-21  9479  			enum bpf_reg_type *prev_src_type, src_reg_type;
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9480  
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9481  			/* check for reserved fields is already done */
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9482  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9483  			/* check src operand */
dc503a8ad98474 Edward Cree        2017-08-15  9484  			err = check_reg_arg(env, insn->src_reg, SRC_OP);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9485  			if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9486  				return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9487  
dc503a8ad98474 Edward Cree        2017-08-15  9488  			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9489  			if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9490  				return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9491  
725f9dcd58dedf Alexei Starovoitov 2015-04-15  9492  			src_reg_type = regs[insn->src_reg].type;
725f9dcd58dedf Alexei Starovoitov 2015-04-15  9493  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9494  			/* check that memory (src_reg + off) is readable,
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9495  			 * the state of dst_reg will be updated by this func
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9496  			 */
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9497  			err = check_mem_access(env, env->insn_idx, insn->src_reg,
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9498  					       insn->off, BPF_SIZE(insn->code),
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9499  					       BPF_READ, insn->dst_reg, false);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9500  			if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9501  				return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9502  
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9503  			prev_src_type = &env->insn_aux_data[env->insn_idx].ptr_type;
3df126f35f88dc Jakub Kicinski     2016-09-21  9504  
3df126f35f88dc Jakub Kicinski     2016-09-21  9505  			if (*prev_src_type == NOT_INIT) {
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9506  				/* saw a valid insn
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9507  				 * dst_reg = *(u32 *)(src_reg + off)
3df126f35f88dc Jakub Kicinski     2016-09-21  9508  				 * save type to validate intersecting paths
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9509  				 */
3df126f35f88dc Jakub Kicinski     2016-09-21  9510  				*prev_src_type = src_reg_type;
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9511  
c64b7983288e63 Joe Stringer       2018-10-02  9512  			} else if (reg_type_mismatch(src_reg_type, *prev_src_type)) {
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9513  				/* ABuser program is trying to use the same insn
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9514  				 * dst_reg = *(u32*) (src_reg + off)
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9515  				 * with different pointer types:
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9516  				 * src_reg == ctx in one branch and
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9517  				 * src_reg == stack|map in some other branch.
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9518  				 * Reject it.
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9519  				 */
61bd5218eef349 Jakub Kicinski     2017-10-09  9520  				verbose(env, "same insn cannot be used with different pointers\n");
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9521  				return -EINVAL;
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9522  			}
9bac3d6d548e5c Alexei Starovoitov 2015-03-13  9523  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9524  		} else if (class == BPF_STX) {
3df126f35f88dc Jakub Kicinski     2016-09-21  9525  			enum bpf_reg_type *prev_dst_type, dst_reg_type;
d691f9e8d4405c Alexei Starovoitov 2015-06-04  9526  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9527  			if (BPF_MODE(insn->code) == BPF_XADD) {
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9528  				err = check_xadd(env, env->insn_idx, insn);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9529  				if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9530  					return err;
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9531  				env->insn_idx++;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9532  				continue;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9533  			}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9534  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9535  			/* check src1 operand */
dc503a8ad98474 Edward Cree        2017-08-15  9536  			err = check_reg_arg(env, insn->src_reg, SRC_OP);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9537  			if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9538  				return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9539  			/* check src2 operand */
dc503a8ad98474 Edward Cree        2017-08-15  9540  			err = check_reg_arg(env, insn->dst_reg, SRC_OP);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9541  			if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9542  				return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9543  
d691f9e8d4405c Alexei Starovoitov 2015-06-04  9544  			dst_reg_type = regs[insn->dst_reg].type;
d691f9e8d4405c Alexei Starovoitov 2015-06-04  9545  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9546  			/* check that memory (dst_reg + off) is writeable */
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9547  			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9548  					       insn->off, BPF_SIZE(insn->code),
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9549  					       BPF_WRITE, insn->src_reg, false);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9550  			if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9551  				return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9552  
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9553  			prev_dst_type = &env->insn_aux_data[env->insn_idx].ptr_type;
3df126f35f88dc Jakub Kicinski     2016-09-21  9554  
3df126f35f88dc Jakub Kicinski     2016-09-21  9555  			if (*prev_dst_type == NOT_INIT) {
3df126f35f88dc Jakub Kicinski     2016-09-21  9556  				*prev_dst_type = dst_reg_type;
c64b7983288e63 Joe Stringer       2018-10-02  9557  			} else if (reg_type_mismatch(dst_reg_type, *prev_dst_type)) {
61bd5218eef349 Jakub Kicinski     2017-10-09  9558  				verbose(env, "same insn cannot be used with different pointers\n");
d691f9e8d4405c Alexei Starovoitov 2015-06-04  9559  				return -EINVAL;
d691f9e8d4405c Alexei Starovoitov 2015-06-04  9560  			}
d691f9e8d4405c Alexei Starovoitov 2015-06-04  9561  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9562  		} else if (class == BPF_ST) {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9563  			if (BPF_MODE(insn->code) != BPF_MEM ||
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9564  			    insn->src_reg != BPF_REG_0) {
61bd5218eef349 Jakub Kicinski     2017-10-09  9565  				verbose(env, "BPF_ST uses reserved fields\n");
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9566  				return -EINVAL;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9567  			}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9568  			/* check src operand */
dc503a8ad98474 Edward Cree        2017-08-15  9569  			err = check_reg_arg(env, insn->dst_reg, SRC_OP);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9570  			if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9571  				return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9572  
f37a8cb84cce18 Daniel Borkmann    2018-01-16  9573  			if (is_ctx_reg(env, insn->dst_reg)) {
9d2be44a7f33d5 Joe Stringer       2018-10-02  9574  				verbose(env, "BPF_ST stores into R%d %s is not allowed\n",
2a159c6f82381a Daniel Borkmann    2018-10-21  9575  					insn->dst_reg,
2a159c6f82381a Daniel Borkmann    2018-10-21  9576  					reg_type_str[reg_state(env, insn->dst_reg)->type]);
f37a8cb84cce18 Daniel Borkmann    2018-01-16  9577  				return -EACCES;
f37a8cb84cce18 Daniel Borkmann    2018-01-16  9578  			}
f37a8cb84cce18 Daniel Borkmann    2018-01-16  9579  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9580  			/* check that memory (dst_reg + off) is writeable */
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9581  			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9582  					       insn->off, BPF_SIZE(insn->code),
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9583  					       BPF_WRITE, -1, false);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9584  			if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9585  				return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9586  
092ed0968bb648 Jiong Wang         2019-01-26  9587  		} else if (class == BPF_JMP || class == BPF_JMP32) {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9588  			u8 opcode = BPF_OP(insn->code);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9589  
2589726d12a1b1 Alexei Starovoitov 2019-06-15  9590  			env->jmps_processed++;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9591  			if (opcode == BPF_CALL) {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9592  				if (BPF_SRC(insn->code) != BPF_K ||
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9593  				    insn->off != 0 ||
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9594  				    (insn->src_reg != BPF_REG_0 &&
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9595  				     insn->src_reg != BPF_PSEUDO_CALL) ||
092ed0968bb648 Jiong Wang         2019-01-26  9596  				    insn->dst_reg != BPF_REG_0 ||
092ed0968bb648 Jiong Wang         2019-01-26  9597  				    class == BPF_JMP32) {
61bd5218eef349 Jakub Kicinski     2017-10-09  9598  					verbose(env, "BPF_CALL uses reserved fields\n");
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9599  					return -EINVAL;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9600  				}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9601  
d83525ca62cf8e Alexei Starovoitov 2019-01-31  9602  				if (env->cur_state->active_spin_lock &&
d83525ca62cf8e Alexei Starovoitov 2019-01-31  9603  				    (insn->src_reg == BPF_PSEUDO_CALL ||
d83525ca62cf8e Alexei Starovoitov 2019-01-31  9604  				     insn->imm != BPF_FUNC_spin_unlock)) {
d83525ca62cf8e Alexei Starovoitov 2019-01-31  9605  					verbose(env, "function calls are not allowed while holding a lock\n");
d83525ca62cf8e Alexei Starovoitov 2019-01-31  9606  					return -EINVAL;
d83525ca62cf8e Alexei Starovoitov 2019-01-31  9607  				}
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9608  				if (insn->src_reg == BPF_PSEUDO_CALL)
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9609  					err = check_func_call(env, insn, &env->insn_idx);
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9610  				else
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9611  					err = check_helper_call(env, insn->imm, env->insn_idx);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9612  				if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9613  					return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9614  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9615  			} else if (opcode == BPF_JA) {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9616  				if (BPF_SRC(insn->code) != BPF_K ||
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9617  				    insn->imm != 0 ||
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9618  				    insn->src_reg != BPF_REG_0 ||
092ed0968bb648 Jiong Wang         2019-01-26  9619  				    insn->dst_reg != BPF_REG_0 ||
092ed0968bb648 Jiong Wang         2019-01-26  9620  				    class == BPF_JMP32) {
61bd5218eef349 Jakub Kicinski     2017-10-09  9621  					verbose(env, "BPF_JA uses reserved fields\n");
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9622  					return -EINVAL;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9623  				}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9624  
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9625  				env->insn_idx += insn->off + 1;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9626  				continue;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9627  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9628  			} else if (opcode == BPF_EXIT) {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9629  				if (BPF_SRC(insn->code) != BPF_K ||
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9630  				    insn->imm != 0 ||
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9631  				    insn->src_reg != BPF_REG_0 ||
092ed0968bb648 Jiong Wang         2019-01-26  9632  				    insn->dst_reg != BPF_REG_0 ||
092ed0968bb648 Jiong Wang         2019-01-26  9633  				    class == BPF_JMP32) {
61bd5218eef349 Jakub Kicinski     2017-10-09  9634  					verbose(env, "BPF_EXIT uses reserved fields\n");
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9635  					return -EINVAL;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9636  				}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9637  
d83525ca62cf8e Alexei Starovoitov 2019-01-31  9638  				if (env->cur_state->active_spin_lock) {
d83525ca62cf8e Alexei Starovoitov 2019-01-31  9639  					verbose(env, "bpf_spin_unlock is missing\n");
d83525ca62cf8e Alexei Starovoitov 2019-01-31  9640  					return -EINVAL;
d83525ca62cf8e Alexei Starovoitov 2019-01-31  9641  				}
d83525ca62cf8e Alexei Starovoitov 2019-01-31  9642  
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9643  				if (state->curframe) {
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9644  					/* exit from nested function */
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9645  					err = prepare_func_exit(env, &env->insn_idx);
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9646  					if (err)
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9647  						return err;
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9648  					do_print_state = true;
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9649  					continue;
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9650  				}
f4d7e40a5b7157 Alexei Starovoitov 2017-12-14  9651  
fd978bf7fd3125 Joe Stringer       2018-10-02  9652  				err = check_reference_leak(env);
fd978bf7fd3125 Joe Stringer       2018-10-02  9653  				if (err)
fd978bf7fd3125 Joe Stringer       2018-10-02  9654  					return err;
fd978bf7fd3125 Joe Stringer       2018-10-02  9655  
390ee7e29fc8e6 Alexei Starovoitov 2017-10-02  9656  				err = check_return_code(env);
390ee7e29fc8e6 Alexei Starovoitov 2017-10-02  9657  				if (err)
390ee7e29fc8e6 Alexei Starovoitov 2017-10-02  9658  					return err;
f1bca824dabba4 Alexei Starovoitov 2014-09-29  9659  process_bpf_exit:
2589726d12a1b1 Alexei Starovoitov 2019-06-15  9660  				update_branch_counts(env, env->cur_state);
b5dc0163d8fd78 Alexei Starovoitov 2019-06-15  9661  				err = pop_stack(env, &prev_insn_idx,
6f8a57ccf85117 Andrii Nakryiko    2020-04-23  9662  						&env->insn_idx, pop_log);
638f5b90d46016 Alexei Starovoitov 2017-10-31  9663  				if (err < 0) {
638f5b90d46016 Alexei Starovoitov 2017-10-31  9664  					if (err != -ENOENT)
638f5b90d46016 Alexei Starovoitov 2017-10-31  9665  						return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9666  					break;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9667  				} else {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9668  					do_print_state = true;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9669  					continue;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9670  				}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9671  			} else {
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9672  				err = check_cond_jmp_op(env, insn, &env->insn_idx);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9673  				if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9674  					return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9675  			}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9676  		} else if (class == BPF_LD) {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9677  			u8 mode = BPF_MODE(insn->code);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9678  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9679  			if (mode == BPF_ABS || mode == BPF_IND) {
ddd872bc3098f9 Alexei Starovoitov 2014-12-01  9680  				err = check_ld_abs(env, insn);
ddd872bc3098f9 Alexei Starovoitov 2014-12-01  9681  				if (err)
ddd872bc3098f9 Alexei Starovoitov 2014-12-01  9682  					return err;
ddd872bc3098f9 Alexei Starovoitov 2014-12-01  9683  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9684  			} else if (mode == BPF_IMM) {
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9685  				err = check_ld_imm(env, insn);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9686  				if (err)
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9687  					return err;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9688  
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9689  				env->insn_idx++;
51c39bb1d5d105 Alexei Starovoitov 2020-01-09  9690  				env->insn_aux_data[env->insn_idx].seen = env->pass_cnt;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9691  			} else {
61bd5218eef349 Jakub Kicinski     2017-10-09  9692  				verbose(env, "invalid BPF_LD mode\n");
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9693  				return -EINVAL;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9694  			}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9695  		} else {
61bd5218eef349 Jakub Kicinski     2017-10-09  9696  			verbose(env, "unknown insn class %d\n", class);
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9697  			return -EINVAL;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9698  		}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9699  
c08435ec7f2bc8 Daniel Borkmann    2019-01-03  9700  		env->insn_idx++;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9701  	}
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9702  
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9703  	return 0;
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9704  }
17a5267067f3c3 Alexei Starovoitov 2014-09-26  9705  

:::::: The code at line 9383 was first introduced by commit
:::::: 58e2af8b3a6b587e4ac8414343581da4349d3c0f bpf: expose internal verfier structures

:::::: TO: Jakub Kicinski <jakub.kicinski@netronome.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--1yeeQ81UyVL57Vl7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
5JmmSnnxd7c4J6H/AwSc34J+2AEA

--1yeeQ81UyVL57Vl7--
