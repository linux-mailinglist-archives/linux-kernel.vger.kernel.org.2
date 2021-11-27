Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6798545FF6A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 15:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhK0OpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 09:45:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:6159 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhK0OnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 09:43:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="236002218"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="236002218"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 06:39:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="539516202"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Nov 2021 06:39:54 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqyrp-0009ed-IY; Sat, 27 Nov 2021 14:39:53 +0000
Date:   Sat, 27 Nov 2021 22:38:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: kernel/bpf/verifier.c:9383:12: warning: stack frame size (2208)
 exceeds limit (2048) in 'do_check'
Message-ID: <202111272232.qgIs1lVb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tiezhu,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5c17547b778975b3d83a73c8d84e8fb5ecf3ba5
commit: 198688edbf77c6fc0e65f5d062f810d83d090166 MIPS: Fix inline asm input/output type mismatch in checksum.h used with Clang
date:   10 months ago
config: mips-buildonly-randconfig-r003-20211127 (https://download.01.org/0day-ci/archive/20211127/202111272232.qgIs1lVb-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=198688edbf77c6fc0e65f5d062f810d83d090166
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 198688edbf77c6fc0e65f5d062f810d83d090166
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/cavium-octeon/crypto/ arch/mips/cavium-octeon/executive/ arch/mips/kernel/ arch/mips/mm/ arch/mips/pci/ drivers/isdn/capi/ drivers/net/ethernet/broadcom/ drivers/net/ethernet/chelsio/cxgb3/ drivers/net/ethernet/chelsio/cxgb4/ drivers/nvme/target/ drivers/scsi/aacraid/ drivers/scsi/ufs/ kernel/ net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/verifier.c:9383:12: warning: stack frame size (2208) exceeds limit (2048) in 'do_check' [-Wframe-larger-than]
   static int do_check(struct bpf_verifier_env *env)
              ^
   1 warning generated.
   Assembler messages:
   Warning: a different -march was already specified, is now octeon
--
>> drivers/isdn/capi/kcapi_proc.c:97:36: warning: unused variable 'seq_controller_ops' [-Wunused-const-variable]
   static const struct seq_operations seq_controller_ops = {
                                      ^
>> drivers/isdn/capi/kcapi_proc.c:104:36: warning: unused variable 'seq_contrstats_ops' [-Wunused-const-variable]
   static const struct seq_operations seq_contrstats_ops = {
                                      ^
>> drivers/isdn/capi/kcapi_proc.c:179:36: warning: unused variable 'seq_applications_ops' [-Wunused-const-variable]
   static const struct seq_operations seq_applications_ops = {
                                      ^
>> drivers/isdn/capi/kcapi_proc.c:186:36: warning: unused variable 'seq_applstats_ops' [-Wunused-const-variable]
   static const struct seq_operations seq_applstats_ops = {
                                      ^
>> drivers/isdn/capi/kcapi_proc.c:202:30: warning: unused variable 'empty_proc_ops' [-Wunused-const-variable]
   static const struct proc_ops empty_proc_ops = {
                                ^
   5 warnings generated.
   Assembler messages:
   Warning: a different -march was already specified, is now octeon
--
>> net/netfilter/nf_conntrack_netlink.c:365:19: warning: unused function 'ctnetlink_label_size'
   static inline int ctnetlink_label_size(const struct nf_conn
   ^
>> net/netfilter/nf_conntrack_netlink.c:641:22: warning: unused function 'ctnetlink_acct_size'
   static inline size_t ctnetlink_acct_size(const struct nf_conn
   ^
>> net/netfilter/nf_conntrack_netlink.c:651:19: warning: unused function 'ctnetlink_secctx_size'
   static inline int ctnetlink_secctx_size(const struct nf_conn
   ^
>> net/netfilter/nf_conntrack_netlink.c:667:22: warning: unused function 'ctnetlink_timestamp_size'
   static inline size_t ctnetlink_timestamp_size(const struct nf_conn
   ^
   net/netfilter/nf_conntrack_netlink.c:2997:33: warning: unused variable 'any_addr'
   static const union nf_inet_addr any_addr;
   ^
   net/netfilter/nf_conntrack_netlink.c:3497:32: warning: unused variable 'exp_nat_nla_policy'
   static const struct nla_policy = {
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x04 ) != -1)) 0x04 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 27, $); 0x04 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept (1 - (0x04 == 0x04)); sync 0x04; .endr; .set pop; .else; ; .endif'
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-5162b558d8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers include kernel net nr_bisected scripts source usr
--
>> drivers/net/ethernet/broadcom/bcmsysport.c:48:1: warning: unused function 'txchk_readl'
   BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
   ^
   drivers/net/ethernet/broadcom/bcmsysport.c:31:19: note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
   static inline u32 name##_readl(struct bcm_sysport_priv u32 off) ^
   <scratch space>:64:1: note: expanded from here
   txchk_readl
   ^
>> drivers/net/ethernet/broadcom/bcmsysport.c:48:1: warning: unused function 'txchk_writel'
   drivers/net/ethernet/broadcom/bcmsysport.c:36:20: note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
   static inline void name##_writel(struct bcm_sysport_priv ^
   <scratch space>:65:1: note: expanded from here
   txchk_writel
   ^
>> drivers/net/ethernet/broadcom/bcmsysport.c:50:1: warning: unused function 'tbuf_readl'
   BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
   ^
   drivers/net/ethernet/broadcom/bcmsysport.c:31:19: note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
   static inline u32 name##_readl(struct bcm_sysport_priv u32 off) ^
   <scratch space>:68:1: note: expanded from here
   tbuf_readl
   ^
>> drivers/net/ethernet/broadcom/bcmsysport.c:50:1: warning: unused function 'tbuf_writel'
   drivers/net/ethernet/broadcom/bcmsysport.c:36:20: note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
   static inline void name##_writel(struct bcm_sysport_priv ^
   <scratch space>:69:1: note: expanded from here
   tbuf_writel
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 16, $); 0x00 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept (1 - (0x00 == 0x04)); sync 0x00; .endr; .set pop; .else; ; .endif'
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-5162b558d8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers include kernel net nr_bisected scripts source usr
--
>> drivers/net/ethernet/broadcom/genet/bcmgenet.c:120:26: warning: unused function 'dmadesc_get_addr'
   static inline dma_addr_t dmadesc_get_addr(struct bcmgenet_priv
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 16, $); 0x00 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept (1 - (0x00 == 0x04)); sync 0x00; .endr; .set pop; .else; ; .endif'
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-5162b558d8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers include kernel net nr_bisected scripts source usr
--
>> drivers/nvme/target/tcp.c:1201:13: warning: stack frame size (2208) exceeds limit (2048) in 'nvmet_tcp_io_work'
   static void nvmet_tcp_io_work(struct work_struct
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x04 ) != -1)) 0x04 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 27, $); 0x04 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept (1 - (0x04 == 0x04)); sync 0x04; .endr; .set pop; .else; ; .endif'
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-5162b558d8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers include kernel net nr_bisected scripts source usr
--
>> drivers/net/ethernet/chelsio/cxgb3/sge.c:167:32: warning: unused function 'fl_to_qset'
   static inline struct sge_qset struct sge_fl int qidx)
   ^
   fatal error: error in backend: Nested variants found in inline asm string: ' .set push
   .set mips64r2
   .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/bitops.h", .line = 105, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept (1 - (0x00 == 0x04)); sync 0x00; .endr; .set pop; .else; ; .endif
   1: lld $0, $1
   or $0, $2
   scd $0, $1
   beqz $0, 1b
   .set pop
   '
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-5162b558d8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers include kernel net nr_bisected scripts source usr
--
>> net/netfilter/ipvs/ip_vs_xmit.c:107:1: warning: unused function '__mtu_check_toobig_v6'
   __mtu_check_toobig_v6(const struct sk_buff u32 mtu)
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x04 ) != -1)) 0x04 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 27, $); 0x04 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept (1 - (0x04 == 0x04)); sync 0x04; .endr; .set pop; .else; ; .endif'
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-5162b558d8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers include kernel net nr_bisected scripts source usr
--
>> drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c:2601:33: warning: unused function 'ethqset2pinfo'
   static inline struct port_info adapter int qset)
   ^
   fatal error: error in backend: Nested variants found in inline asm string: '.if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/barrier.h", .line = 16, $); 0x00 ) != -1)) : $))) ) && ( (1 << 0) ); .set push; .set mips64r2; .rept (1 - (0x00 == 0x04)); sync 0x00; .endr; .set pop; .else; ; .endif'
   clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
   clang version 14.0.0 (git://gitmirror/llvm_project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
   Target: mips64-unknown-linux
   Thread model: posix
   InstalledDir: /opt/cross/clang-5162b558d8/bin
   clang-14: note: diagnostic msg:
   Makefile arch block drivers include kernel net nr_bisected scripts source usr


vim +/do_check +9383 kernel/bpf/verifier.c

c64b7983288e636 Joe Stringer       2018-10-02  9382  
58e2af8b3a6b587 Jakub Kicinski     2016-09-21 @9383  static int do_check(struct bpf_verifier_env *env)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9384  {
6f8a57ccf851172 Andrii Nakryiko    2020-04-23  9385  	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
51c39bb1d5d105a Alexei Starovoitov 2020-01-09  9386  	struct bpf_verifier_state *state = env->cur_state;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9387  	struct bpf_insn *insns = env->prog->insnsi;
638f5b90d460163 Alexei Starovoitov 2017-10-31  9388  	struct bpf_reg_state *regs;
06ee7115b0d1742 Alexei Starovoitov 2019-04-01  9389  	int insn_cnt = env->prog->len;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9390  	bool do_print_state = false;
b5dc0163d8fd78e Alexei Starovoitov 2019-06-15  9391  	int prev_insn_idx = -1;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9392  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9393  	for (;;) {
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9394  		struct bpf_insn *insn;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9395  		u8 class;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9396  		int err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9397  
b5dc0163d8fd78e Alexei Starovoitov 2019-06-15  9398  		env->prev_insn_idx = prev_insn_idx;
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9399  		if (env->insn_idx >= insn_cnt) {
61bd5218eef349f Jakub Kicinski     2017-10-09  9400  			verbose(env, "invalid insn idx %d insn_cnt %d\n",
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9401  				env->insn_idx, insn_cnt);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9402  			return -EFAULT;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9403  		}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9404  
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9405  		insn = &insns[env->insn_idx];
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9406  		class = BPF_CLASS(insn->code);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9407  
06ee7115b0d1742 Alexei Starovoitov 2019-04-01  9408  		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
61bd5218eef349f Jakub Kicinski     2017-10-09  9409  			verbose(env,
61bd5218eef349f Jakub Kicinski     2017-10-09  9410  				"BPF program is too large. Processed %d insn\n",
06ee7115b0d1742 Alexei Starovoitov 2019-04-01  9411  				env->insn_processed);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9412  			return -E2BIG;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9413  		}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9414  
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9415  		err = is_state_visited(env, env->insn_idx);
f1bca824dabba4f Alexei Starovoitov 2014-09-29  9416  		if (err < 0)
f1bca824dabba4f Alexei Starovoitov 2014-09-29  9417  			return err;
f1bca824dabba4f Alexei Starovoitov 2014-09-29  9418  		if (err == 1) {
f1bca824dabba4f Alexei Starovoitov 2014-09-29  9419  			/* found equivalent state, can prune the search */
06ee7115b0d1742 Alexei Starovoitov 2019-04-01  9420  			if (env->log.level & BPF_LOG_LEVEL) {
f1bca824dabba4f Alexei Starovoitov 2014-09-29  9421  				if (do_print_state)
979d63d50c0c0f7 Daniel Borkmann    2019-01-03  9422  					verbose(env, "\nfrom %d to %d%s: safe\n",
979d63d50c0c0f7 Daniel Borkmann    2019-01-03  9423  						env->prev_insn_idx, env->insn_idx,
979d63d50c0c0f7 Daniel Borkmann    2019-01-03  9424  						env->cur_state->speculative ?
979d63d50c0c0f7 Daniel Borkmann    2019-01-03  9425  						" (speculative execution)" : "");
f1bca824dabba4f Alexei Starovoitov 2014-09-29  9426  				else
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9427  					verbose(env, "%d: safe\n", env->insn_idx);
f1bca824dabba4f Alexei Starovoitov 2014-09-29  9428  			}
f1bca824dabba4f Alexei Starovoitov 2014-09-29  9429  			goto process_bpf_exit;
f1bca824dabba4f Alexei Starovoitov 2014-09-29  9430  		}
f1bca824dabba4f Alexei Starovoitov 2014-09-29  9431  
c3494801cd1785e Alexei Starovoitov 2018-12-03  9432  		if (signal_pending(current))
c3494801cd1785e Alexei Starovoitov 2018-12-03  9433  			return -EAGAIN;
c3494801cd1785e Alexei Starovoitov 2018-12-03  9434  
3c2ce60bdd3d570 Daniel Borkmann    2017-05-18  9435  		if (need_resched())
3c2ce60bdd3d570 Daniel Borkmann    2017-05-18  9436  			cond_resched();
3c2ce60bdd3d570 Daniel Borkmann    2017-05-18  9437  
06ee7115b0d1742 Alexei Starovoitov 2019-04-01  9438  		if (env->log.level & BPF_LOG_LEVEL2 ||
06ee7115b0d1742 Alexei Starovoitov 2019-04-01  9439  		    (env->log.level & BPF_LOG_LEVEL && do_print_state)) {
06ee7115b0d1742 Alexei Starovoitov 2019-04-01  9440  			if (env->log.level & BPF_LOG_LEVEL2)
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9441  				verbose(env, "%d:", env->insn_idx);
c5fc9692d101d13 David S. Miller    2017-05-10  9442  			else
979d63d50c0c0f7 Daniel Borkmann    2019-01-03  9443  				verbose(env, "\nfrom %d to %d%s:",
979d63d50c0c0f7 Daniel Borkmann    2019-01-03  9444  					env->prev_insn_idx, env->insn_idx,
979d63d50c0c0f7 Daniel Borkmann    2019-01-03  9445  					env->cur_state->speculative ?
979d63d50c0c0f7 Daniel Borkmann    2019-01-03  9446  					" (speculative execution)" : "");
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9447  			print_verifier_state(env, state->frame[state->curframe]);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9448  			do_print_state = false;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9449  		}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9450  
06ee7115b0d1742 Alexei Starovoitov 2019-04-01  9451  		if (env->log.level & BPF_LOG_LEVEL) {
7105e828c087de9 Daniel Borkmann    2017-12-20  9452  			const struct bpf_insn_cbs cbs = {
7105e828c087de9 Daniel Borkmann    2017-12-20  9453  				.cb_print	= verbose,
abe0884011f1a56 Jiri Olsa          2018-03-23  9454  				.private_data	= env,
7105e828c087de9 Daniel Borkmann    2017-12-20  9455  			};
7105e828c087de9 Daniel Borkmann    2017-12-20  9456  
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9457  			verbose_linfo(env, env->insn_idx, "; ");
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9458  			verbose(env, "%d: ", env->insn_idx);
abe0884011f1a56 Jiri Olsa          2018-03-23  9459  			print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9460  		}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9461  
cae1927c0b4a93a Jakub Kicinski     2017-12-27  9462  		if (bpf_prog_is_dev_bound(env->prog->aux)) {
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9463  			err = bpf_prog_offload_verify_insn(env, env->insn_idx,
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9464  							   env->prev_insn_idx);
13a27dfc6697245 Jakub Kicinski     2016-09-21  9465  			if (err)
13a27dfc6697245 Jakub Kicinski     2016-09-21  9466  				return err;
cae1927c0b4a93a Jakub Kicinski     2017-12-27  9467  		}
13a27dfc6697245 Jakub Kicinski     2016-09-21  9468  
638f5b90d460163 Alexei Starovoitov 2017-10-31  9469  		regs = cur_regs(env);
51c39bb1d5d105a Alexei Starovoitov 2020-01-09  9470  		env->insn_aux_data[env->insn_idx].seen = env->pass_cnt;
b5dc0163d8fd78e Alexei Starovoitov 2019-06-15  9471  		prev_insn_idx = env->insn_idx;
fd978bf7fd31258 Joe Stringer       2018-10-02  9472  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9473  		if (class == BPF_ALU || class == BPF_ALU64) {
1be7f75d1668d62 Alexei Starovoitov 2015-10-07  9474  			err = check_alu_op(env, insn);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9475  			if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9476  				return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9477  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9478  		} else if (class == BPF_LDX) {
3df126f35f88dc7 Jakub Kicinski     2016-09-21  9479  			enum bpf_reg_type *prev_src_type, src_reg_type;
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9480  
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9481  			/* check for reserved fields is already done */
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9482  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9483  			/* check src operand */
dc503a8ad98474e Edward Cree        2017-08-15  9484  			err = check_reg_arg(env, insn->src_reg, SRC_OP);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9485  			if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9486  				return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9487  
dc503a8ad98474e Edward Cree        2017-08-15  9488  			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9489  			if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9490  				return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9491  
725f9dcd58dedfe Alexei Starovoitov 2015-04-15  9492  			src_reg_type = regs[insn->src_reg].type;
725f9dcd58dedfe Alexei Starovoitov 2015-04-15  9493  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9494  			/* check that memory (src_reg + off) is readable,
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9495  			 * the state of dst_reg will be updated by this func
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9496  			 */
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9497  			err = check_mem_access(env, env->insn_idx, insn->src_reg,
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9498  					       insn->off, BPF_SIZE(insn->code),
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9499  					       BPF_READ, insn->dst_reg, false);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9500  			if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9501  				return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9502  
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9503  			prev_src_type = &env->insn_aux_data[env->insn_idx].ptr_type;
3df126f35f88dc7 Jakub Kicinski     2016-09-21  9504  
3df126f35f88dc7 Jakub Kicinski     2016-09-21  9505  			if (*prev_src_type == NOT_INIT) {
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9506  				/* saw a valid insn
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9507  				 * dst_reg = *(u32 *)(src_reg + off)
3df126f35f88dc7 Jakub Kicinski     2016-09-21  9508  				 * save type to validate intersecting paths
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9509  				 */
3df126f35f88dc7 Jakub Kicinski     2016-09-21  9510  				*prev_src_type = src_reg_type;
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9511  
c64b7983288e636 Joe Stringer       2018-10-02  9512  			} else if (reg_type_mismatch(src_reg_type, *prev_src_type)) {
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9513  				/* ABuser program is trying to use the same insn
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9514  				 * dst_reg = *(u32*) (src_reg + off)
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9515  				 * with different pointer types:
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9516  				 * src_reg == ctx in one branch and
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9517  				 * src_reg == stack|map in some other branch.
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9518  				 * Reject it.
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9519  				 */
61bd5218eef349f Jakub Kicinski     2017-10-09  9520  				verbose(env, "same insn cannot be used with different pointers\n");
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9521  				return -EINVAL;
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9522  			}
9bac3d6d548e5cc Alexei Starovoitov 2015-03-13  9523  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9524  		} else if (class == BPF_STX) {
3df126f35f88dc7 Jakub Kicinski     2016-09-21  9525  			enum bpf_reg_type *prev_dst_type, dst_reg_type;
d691f9e8d4405c3 Alexei Starovoitov 2015-06-04  9526  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9527  			if (BPF_MODE(insn->code) == BPF_XADD) {
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9528  				err = check_xadd(env, env->insn_idx, insn);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9529  				if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9530  					return err;
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9531  				env->insn_idx++;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9532  				continue;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9533  			}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9534  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9535  			/* check src1 operand */
dc503a8ad98474e Edward Cree        2017-08-15  9536  			err = check_reg_arg(env, insn->src_reg, SRC_OP);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9537  			if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9538  				return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9539  			/* check src2 operand */
dc503a8ad98474e Edward Cree        2017-08-15  9540  			err = check_reg_arg(env, insn->dst_reg, SRC_OP);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9541  			if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9542  				return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9543  
d691f9e8d4405c3 Alexei Starovoitov 2015-06-04  9544  			dst_reg_type = regs[insn->dst_reg].type;
d691f9e8d4405c3 Alexei Starovoitov 2015-06-04  9545  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9546  			/* check that memory (dst_reg + off) is writeable */
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9547  			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9548  					       insn->off, BPF_SIZE(insn->code),
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9549  					       BPF_WRITE, insn->src_reg, false);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9550  			if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9551  				return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9552  
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9553  			prev_dst_type = &env->insn_aux_data[env->insn_idx].ptr_type;
3df126f35f88dc7 Jakub Kicinski     2016-09-21  9554  
3df126f35f88dc7 Jakub Kicinski     2016-09-21  9555  			if (*prev_dst_type == NOT_INIT) {
3df126f35f88dc7 Jakub Kicinski     2016-09-21  9556  				*prev_dst_type = dst_reg_type;
c64b7983288e636 Joe Stringer       2018-10-02  9557  			} else if (reg_type_mismatch(dst_reg_type, *prev_dst_type)) {
61bd5218eef349f Jakub Kicinski     2017-10-09  9558  				verbose(env, "same insn cannot be used with different pointers\n");
d691f9e8d4405c3 Alexei Starovoitov 2015-06-04  9559  				return -EINVAL;
d691f9e8d4405c3 Alexei Starovoitov 2015-06-04  9560  			}
d691f9e8d4405c3 Alexei Starovoitov 2015-06-04  9561  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9562  		} else if (class == BPF_ST) {
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9563  			if (BPF_MODE(insn->code) != BPF_MEM ||
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9564  			    insn->src_reg != BPF_REG_0) {
61bd5218eef349f Jakub Kicinski     2017-10-09  9565  				verbose(env, "BPF_ST uses reserved fields\n");
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9566  				return -EINVAL;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9567  			}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9568  			/* check src operand */
dc503a8ad98474e Edward Cree        2017-08-15  9569  			err = check_reg_arg(env, insn->dst_reg, SRC_OP);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9570  			if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9571  				return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9572  
f37a8cb84cce187 Daniel Borkmann    2018-01-16  9573  			if (is_ctx_reg(env, insn->dst_reg)) {
9d2be44a7f33d5e Joe Stringer       2018-10-02  9574  				verbose(env, "BPF_ST stores into R%d %s is not allowed\n",
2a159c6f82381a4 Daniel Borkmann    2018-10-21  9575  					insn->dst_reg,
2a159c6f82381a4 Daniel Borkmann    2018-10-21  9576  					reg_type_str[reg_state(env, insn->dst_reg)->type]);
f37a8cb84cce187 Daniel Borkmann    2018-01-16  9577  				return -EACCES;
f37a8cb84cce187 Daniel Borkmann    2018-01-16  9578  			}
f37a8cb84cce187 Daniel Borkmann    2018-01-16  9579  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9580  			/* check that memory (dst_reg + off) is writeable */
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9581  			err = check_mem_access(env, env->insn_idx, insn->dst_reg,
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9582  					       insn->off, BPF_SIZE(insn->code),
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9583  					       BPF_WRITE, -1, false);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9584  			if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9585  				return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9586  
092ed0968bb648c Jiong Wang         2019-01-26  9587  		} else if (class == BPF_JMP || class == BPF_JMP32) {
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9588  			u8 opcode = BPF_OP(insn->code);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9589  
2589726d12a1b12 Alexei Starovoitov 2019-06-15  9590  			env->jmps_processed++;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9591  			if (opcode == BPF_CALL) {
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9592  				if (BPF_SRC(insn->code) != BPF_K ||
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9593  				    insn->off != 0 ||
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9594  				    (insn->src_reg != BPF_REG_0 &&
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9595  				     insn->src_reg != BPF_PSEUDO_CALL) ||
092ed0968bb648c Jiong Wang         2019-01-26  9596  				    insn->dst_reg != BPF_REG_0 ||
092ed0968bb648c Jiong Wang         2019-01-26  9597  				    class == BPF_JMP32) {
61bd5218eef349f Jakub Kicinski     2017-10-09  9598  					verbose(env, "BPF_CALL uses reserved fields\n");
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9599  					return -EINVAL;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9600  				}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9601  
d83525ca62cf8eb Alexei Starovoitov 2019-01-31  9602  				if (env->cur_state->active_spin_lock &&
d83525ca62cf8eb Alexei Starovoitov 2019-01-31  9603  				    (insn->src_reg == BPF_PSEUDO_CALL ||
d83525ca62cf8eb Alexei Starovoitov 2019-01-31  9604  				     insn->imm != BPF_FUNC_spin_unlock)) {
d83525ca62cf8eb Alexei Starovoitov 2019-01-31  9605  					verbose(env, "function calls are not allowed while holding a lock\n");
d83525ca62cf8eb Alexei Starovoitov 2019-01-31  9606  					return -EINVAL;
d83525ca62cf8eb Alexei Starovoitov 2019-01-31  9607  				}
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9608  				if (insn->src_reg == BPF_PSEUDO_CALL)
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9609  					err = check_func_call(env, insn, &env->insn_idx);
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9610  				else
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9611  					err = check_helper_call(env, insn->imm, env->insn_idx);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9612  				if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9613  					return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9614  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9615  			} else if (opcode == BPF_JA) {
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9616  				if (BPF_SRC(insn->code) != BPF_K ||
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9617  				    insn->imm != 0 ||
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9618  				    insn->src_reg != BPF_REG_0 ||
092ed0968bb648c Jiong Wang         2019-01-26  9619  				    insn->dst_reg != BPF_REG_0 ||
092ed0968bb648c Jiong Wang         2019-01-26  9620  				    class == BPF_JMP32) {
61bd5218eef349f Jakub Kicinski     2017-10-09  9621  					verbose(env, "BPF_JA uses reserved fields\n");
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9622  					return -EINVAL;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9623  				}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9624  
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9625  				env->insn_idx += insn->off + 1;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9626  				continue;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9627  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9628  			} else if (opcode == BPF_EXIT) {
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9629  				if (BPF_SRC(insn->code) != BPF_K ||
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9630  				    insn->imm != 0 ||
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9631  				    insn->src_reg != BPF_REG_0 ||
092ed0968bb648c Jiong Wang         2019-01-26  9632  				    insn->dst_reg != BPF_REG_0 ||
092ed0968bb648c Jiong Wang         2019-01-26  9633  				    class == BPF_JMP32) {
61bd5218eef349f Jakub Kicinski     2017-10-09  9634  					verbose(env, "BPF_EXIT uses reserved fields\n");
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9635  					return -EINVAL;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9636  				}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9637  
d83525ca62cf8eb Alexei Starovoitov 2019-01-31  9638  				if (env->cur_state->active_spin_lock) {
d83525ca62cf8eb Alexei Starovoitov 2019-01-31  9639  					verbose(env, "bpf_spin_unlock is missing\n");
d83525ca62cf8eb Alexei Starovoitov 2019-01-31  9640  					return -EINVAL;
d83525ca62cf8eb Alexei Starovoitov 2019-01-31  9641  				}
d83525ca62cf8eb Alexei Starovoitov 2019-01-31  9642  
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9643  				if (state->curframe) {
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9644  					/* exit from nested function */
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9645  					err = prepare_func_exit(env, &env->insn_idx);
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9646  					if (err)
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9647  						return err;
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9648  					do_print_state = true;
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9649  					continue;
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9650  				}
f4d7e40a5b7157e Alexei Starovoitov 2017-12-14  9651  
fd978bf7fd31258 Joe Stringer       2018-10-02  9652  				err = check_reference_leak(env);
fd978bf7fd31258 Joe Stringer       2018-10-02  9653  				if (err)
fd978bf7fd31258 Joe Stringer       2018-10-02  9654  					return err;
fd978bf7fd31258 Joe Stringer       2018-10-02  9655  
390ee7e29fc8e6e Alexei Starovoitov 2017-10-02  9656  				err = check_return_code(env);
390ee7e29fc8e6e Alexei Starovoitov 2017-10-02  9657  				if (err)
390ee7e29fc8e6e Alexei Starovoitov 2017-10-02  9658  					return err;
f1bca824dabba4f Alexei Starovoitov 2014-09-29  9659  process_bpf_exit:
2589726d12a1b12 Alexei Starovoitov 2019-06-15  9660  				update_branch_counts(env, env->cur_state);
b5dc0163d8fd78e Alexei Starovoitov 2019-06-15  9661  				err = pop_stack(env, &prev_insn_idx,
6f8a57ccf851172 Andrii Nakryiko    2020-04-23  9662  						&env->insn_idx, pop_log);
638f5b90d460163 Alexei Starovoitov 2017-10-31  9663  				if (err < 0) {
638f5b90d460163 Alexei Starovoitov 2017-10-31  9664  					if (err != -ENOENT)
638f5b90d460163 Alexei Starovoitov 2017-10-31  9665  						return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9666  					break;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9667  				} else {
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9668  					do_print_state = true;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9669  					continue;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9670  				}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9671  			} else {
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9672  				err = check_cond_jmp_op(env, insn, &env->insn_idx);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9673  				if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9674  					return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9675  			}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9676  		} else if (class == BPF_LD) {
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9677  			u8 mode = BPF_MODE(insn->code);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9678  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9679  			if (mode == BPF_ABS || mode == BPF_IND) {
ddd872bc3098f9d Alexei Starovoitov 2014-12-01  9680  				err = check_ld_abs(env, insn);
ddd872bc3098f9d Alexei Starovoitov 2014-12-01  9681  				if (err)
ddd872bc3098f9d Alexei Starovoitov 2014-12-01  9682  					return err;
ddd872bc3098f9d Alexei Starovoitov 2014-12-01  9683  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9684  			} else if (mode == BPF_IMM) {
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9685  				err = check_ld_imm(env, insn);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9686  				if (err)
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9687  					return err;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9688  
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9689  				env->insn_idx++;
51c39bb1d5d105a Alexei Starovoitov 2020-01-09  9690  				env->insn_aux_data[env->insn_idx].seen = env->pass_cnt;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9691  			} else {
61bd5218eef349f Jakub Kicinski     2017-10-09  9692  				verbose(env, "invalid BPF_LD mode\n");
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9693  				return -EINVAL;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9694  			}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9695  		} else {
61bd5218eef349f Jakub Kicinski     2017-10-09  9696  			verbose(env, "unknown insn class %d\n", class);
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9697  			return -EINVAL;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9698  		}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9699  
c08435ec7f2bc8f Daniel Borkmann    2019-01-03  9700  		env->insn_idx++;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9701  	}
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9702  
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9703  	return 0;
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9704  }
17a5267067f3c37 Alexei Starovoitov 2014-09-26  9705  

:::::: The code at line 9383 was first introduced by commit
:::::: 58e2af8b3a6b587e4ac8414343581da4349d3c0f bpf: expose internal verfier structures

:::::: TO: Jakub Kicinski <jakub.kicinski@netronome.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
