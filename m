Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE91E430847
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 13:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245451AbhJQLQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 07:16:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:33692 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237741AbhJQLP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 07:15:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10139"; a="215036708"
X-IronPort-AV: E=Sophos;i="5.85,380,1624345200"; 
   d="gz'50?scan'50,208,50";a="215036708"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 04:13:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,380,1624345200"; 
   d="gz'50?scan'50,208,50";a="443739335"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Oct 2021 04:13:47 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mc46s-000AG9-FE; Sun, 17 Oct 2021 11:13:46 +0000
Date:   Sun, 17 Oct 2021 19:13:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxim Mikityanskiy <maximmi@nvidia.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>
Subject: [saeed:mlx5-queue 6/13] kernel/bpf/verifier.c:3552:11: error:
 implicit declaration of function 'bpf_ct_is_valid_access'
Message-ID: <202110171924.8zaNhMYq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git mlx5-queue
head:   46fb2d6328c851496c3bcc5e50a1e58786c83acb
commit: 66d7b124a88b85fab8335567dd9c69450a9648dc [6/13] bpf: Expose struct nf_conn to BPF
config: riscv-randconfig-r006-20211017 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 746dd6a700931988dd9021d3d04718f1929885a5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?id=66d7b124a88b85fab8335567dd9c69450a9648dc
        git remote add saeed https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
        git fetch --no-tags saeed mlx5-queue
        git checkout 66d7b124a88b85fab8335567dd9c69450a9648dc
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/verifier.c:12:
   In file included from include/linux/bpf_verifier.h:9:
   In file included from include/linux/filter.h:11:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from kernel/bpf/verifier.c:12:
   In file included from include/linux/bpf_verifier.h:9:
   In file included from include/linux/filter.h:11:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from kernel/bpf/verifier.c:12:
   In file included from include/linux/bpf_verifier.h:9:
   In file included from include/linux/filter.h:11:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> kernel/bpf/verifier.c:3552:11: error: implicit declaration of function 'bpf_ct_is_valid_access' [-Werror,-Wimplicit-function-declaration]
                   valid = bpf_ct_is_valid_access(off, size, t, &info);
                           ^
   kernel/bpf/verifier.c:3552:11: note: did you mean 'bpf_sock_is_valid_access'?
   include/linux/bpf.h:2165:20: note: 'bpf_sock_is_valid_access' declared here
   static inline bool bpf_sock_is_valid_access(int off, int size,
                      ^
>> kernel/bpf/verifier.c:12388:25: error: use of undeclared identifier 'bpf_ct_convert_ctx_access'; did you mean 'bpf_sock_convert_ctx_access'?
                           convert_ctx_access = bpf_ct_convert_ctx_access;
                                                ^~~~~~~~~~~~~~~~~~~~~~~~~
                                                bpf_sock_convert_ctx_access
   include/linux/bpf.h:2171:19: note: 'bpf_sock_convert_ctx_access' declared here
   static inline u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
                     ^
   7 warnings and 2 errors generated.


vim +/bpf_ct_is_valid_access +3552 kernel/bpf/verifier.c

  3535	
  3536	static int check_ct_access(struct bpf_verifier_env *env, int insn_idx,
  3537				   u32 regno, int off, int size, enum bpf_access_type t)
  3538	{
  3539		struct bpf_reg_state *regs = cur_regs(env);
  3540		struct bpf_reg_state *reg = &regs[regno];
  3541		struct bpf_insn_access_aux info = {};
  3542		bool valid;
  3543	
  3544		if (reg->smin_value < 0) {
  3545			verbose(env, "R%d min value is negative, either use unsigned index or do a if (index >=0) check.\n",
  3546				regno);
  3547			return -EACCES;
  3548		}
  3549	
  3550		switch (reg->type) {
  3551		case PTR_TO_NF_CONN:
> 3552			valid = bpf_ct_is_valid_access(off, size, t, &info);
  3553			break;
  3554		default:
  3555			valid = false;
  3556		}
  3557	
  3558		if (valid) {
  3559			env->insn_aux_data[insn_idx].ctx_field_size =
  3560				info.ctx_field_size;
  3561			return 0;
  3562		}
  3563	
  3564		verbose(env, "R%d invalid %s access off=%d size=%d\n",
  3565			regno, reg_type_str[reg->type], off, size);
  3566	
  3567		return -EACCES;
  3568	}
  3569	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--6TrnltStXW4iwmi0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--6TrnltStXW4iwmi0--
