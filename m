Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959C73B453F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhFYOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:10:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:46294 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229700AbhFYOKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:10:22 -0400
IronPort-SDR: 7ZMf++IdR4xil9pRjqruaDZ/mN8e+S7dO2c3skUYMzbSQvs52bZymuvB3v1vSo9QGRqid6zA72
 yhXJEQNmIzEw==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="194969151"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="194969151"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 07:08:01 -0700
IronPort-SDR: 7/vj2hf4lxY5fR3zx931tpwPzxjmnlNIXT0n93Eqq81FQsS3r/kapvJOlQkmSULMqeRHUnqopl
 zLs7jcAGSJHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="407396110"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Jun 2021 07:08:00 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lwmUx-0007CO-7f; Fri, 25 Jun 2021 14:07:59 +0000
Date:   Fri, 25 Jun 2021 22:07:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/powerpc.c:1141:7: warning: Redundant assignment of
 'gpr' to itself. [selfAssignment]
Message-ID: <202106252219.3RFYWdTc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cédric,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   44db63d1ad8d71c6932cbe007eb41f31c434d140
commit: 9236f57a9e51c72ce426ccd2e53e123de7196a0f KVM: PPC: Make the VMX instruction emulation routines static
date:   5 months ago
compiler: powerpc64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> arch/powerpc/kvm/powerpc.c:1141:7: warning: Redundant assignment of 'gpr' to itself. [selfAssignment]
     gpr = sp_to_dp(gpr);
         ^
>> arch/powerpc/kvm/powerpc.c:1341:7: warning: Redundant assignment of 'val' to itself. [selfAssignment]
     val = dp_to_sp(val);
         ^

vim +/gpr +1141 arch/powerpc/kvm/powerpc.c

6f63e81bda98cb Bin Lu               2017-02-21  1112  
8c99d34578628b Tianjia Zhang        2020-04-27  1113  static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu)
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1114  {
8c99d34578628b Tianjia Zhang        2020-04-27  1115  	struct kvm_run *run = vcpu->run;
3f649ab728cda8 Kees Cook            2020-06-03  1116  	u64 gpr;
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1117  
8e5b26b55a8b6a Alexander Graf       2010-01-08  1118  	if (run->mmio.len > sizeof(gpr)) {
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1119  		printk(KERN_ERR "bad MMIO length: %d\n", run->mmio.len);
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1120  		return;
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1121  	}
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1122  
d078eed35de386 David Gibson         2015-02-03  1123  	if (!vcpu->arch.mmio_host_swabbed) {
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1124  		switch (run->mmio.len) {
b104d06632d089 Alexander Graf       2010-02-19  1125  		case 8: gpr = *(u64 *)run->mmio.data; break;
8e5b26b55a8b6a Alexander Graf       2010-01-08  1126  		case 4: gpr = *(u32 *)run->mmio.data; break;
8e5b26b55a8b6a Alexander Graf       2010-01-08  1127  		case 2: gpr = *(u16 *)run->mmio.data; break;
8e5b26b55a8b6a Alexander Graf       2010-01-08  1128  		case 1: gpr = *(u8 *)run->mmio.data; break;
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1129  		}
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1130  	} else {
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1131  		switch (run->mmio.len) {
d078eed35de386 David Gibson         2015-02-03  1132  		case 8: gpr = swab64(*(u64 *)run->mmio.data); break;
d078eed35de386 David Gibson         2015-02-03  1133  		case 4: gpr = swab32(*(u32 *)run->mmio.data); break;
d078eed35de386 David Gibson         2015-02-03  1134  		case 2: gpr = swab16(*(u16 *)run->mmio.data); break;
8e5b26b55a8b6a Alexander Graf       2010-01-08  1135  		case 1: gpr = *(u8 *)run->mmio.data; break;
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1136  		}
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1137  	}
8e5b26b55a8b6a Alexander Graf       2010-01-08  1138  
6f63e81bda98cb Bin Lu               2017-02-21  1139  	/* conversion between single and double precision */
6f63e81bda98cb Bin Lu               2017-02-21  1140  	if ((vcpu->arch.mmio_sp64_extend) && (run->mmio.len == 4))
6f63e81bda98cb Bin Lu               2017-02-21 @1141  		gpr = sp_to_dp(gpr);
6f63e81bda98cb Bin Lu               2017-02-21  1142  
3587d5348ced08 Alexander Graf       2010-02-19  1143  	if (vcpu->arch.mmio_sign_extend) {
3587d5348ced08 Alexander Graf       2010-02-19  1144  		switch (run->mmio.len) {
3587d5348ced08 Alexander Graf       2010-02-19  1145  #ifdef CONFIG_PPC64
3587d5348ced08 Alexander Graf       2010-02-19  1146  		case 4:
3587d5348ced08 Alexander Graf       2010-02-19  1147  			gpr = (s64)(s32)gpr;
3587d5348ced08 Alexander Graf       2010-02-19  1148  			break;
3587d5348ced08 Alexander Graf       2010-02-19  1149  #endif
3587d5348ced08 Alexander Graf       2010-02-19  1150  		case 2:
3587d5348ced08 Alexander Graf       2010-02-19  1151  			gpr = (s64)(s16)gpr;
3587d5348ced08 Alexander Graf       2010-02-19  1152  			break;
3587d5348ced08 Alexander Graf       2010-02-19  1153  		case 1:
3587d5348ced08 Alexander Graf       2010-02-19  1154  			gpr = (s64)(s8)gpr;
3587d5348ced08 Alexander Graf       2010-02-19  1155  			break;
3587d5348ced08 Alexander Graf       2010-02-19  1156  		}
3587d5348ced08 Alexander Graf       2010-02-19  1157  	}
3587d5348ced08 Alexander Graf       2010-02-19  1158  
b3c5d3c2a49602 Alexander Graf       2012-01-07  1159  	switch (vcpu->arch.io_gpr & KVM_MMIO_REG_EXT_MASK) {
b3c5d3c2a49602 Alexander Graf       2012-01-07  1160  	case KVM_MMIO_REG_GPR:
b104d06632d089 Alexander Graf       2010-02-19  1161  		kvmppc_set_gpr(vcpu, vcpu->arch.io_gpr, gpr);
b104d06632d089 Alexander Graf       2010-02-19  1162  		break;
b3c5d3c2a49602 Alexander Graf       2012-01-07  1163  	case KVM_MMIO_REG_FPR:
2e6baa46b4ae78 Simon Guo            2018-05-21  1164  		if (vcpu->kvm->arch.kvm_ops->giveup_ext)
2e6baa46b4ae78 Simon Guo            2018-05-21  1165  			vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu, MSR_FP);
2e6baa46b4ae78 Simon Guo            2018-05-21  1166  
efff19122315f1 Paul Mackerras       2013-10-15  1167  		VCPU_FPR(vcpu, vcpu->arch.io_gpr & KVM_MMIO_REG_MASK) = gpr;
b104d06632d089 Alexander Graf       2010-02-19  1168  		break;
287d5611fab5a4 Alexander Graf       2010-04-01  1169  #ifdef CONFIG_PPC_BOOK3S
b3c5d3c2a49602 Alexander Graf       2012-01-07  1170  	case KVM_MMIO_REG_QPR:
b3c5d3c2a49602 Alexander Graf       2012-01-07  1171  		vcpu->arch.qpr[vcpu->arch.io_gpr & KVM_MMIO_REG_MASK] = gpr;
b104d06632d089 Alexander Graf       2010-02-19  1172  		break;
b3c5d3c2a49602 Alexander Graf       2012-01-07  1173  	case KVM_MMIO_REG_FQPR:
efff19122315f1 Paul Mackerras       2013-10-15  1174  		VCPU_FPR(vcpu, vcpu->arch.io_gpr & KVM_MMIO_REG_MASK) = gpr;
b3c5d3c2a49602 Alexander Graf       2012-01-07  1175  		vcpu->arch.qpr[vcpu->arch.io_gpr & KVM_MMIO_REG_MASK] = gpr;
b104d06632d089 Alexander Graf       2010-02-19  1176  		break;
6f63e81bda98cb Bin Lu               2017-02-21  1177  #endif
6f63e81bda98cb Bin Lu               2017-02-21  1178  #ifdef CONFIG_VSX
6f63e81bda98cb Bin Lu               2017-02-21  1179  	case KVM_MMIO_REG_VSX:
2e6baa46b4ae78 Simon Guo            2018-05-21  1180  		if (vcpu->kvm->arch.kvm_ops->giveup_ext)
2e6baa46b4ae78 Simon Guo            2018-05-21  1181  			vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu, MSR_VSX);
2e6baa46b4ae78 Simon Guo            2018-05-21  1182  
da2a32b876e979 Simon Guo            2018-05-21  1183  		if (vcpu->arch.mmio_copy_type == KVMPPC_VSX_COPY_DWORD)
6f63e81bda98cb Bin Lu               2017-02-21  1184  			kvmppc_set_vsr_dword(vcpu, gpr);
da2a32b876e979 Simon Guo            2018-05-21  1185  		else if (vcpu->arch.mmio_copy_type == KVMPPC_VSX_COPY_WORD)
6f63e81bda98cb Bin Lu               2017-02-21  1186  			kvmppc_set_vsr_word(vcpu, gpr);
da2a32b876e979 Simon Guo            2018-05-21  1187  		else if (vcpu->arch.mmio_copy_type ==
6f63e81bda98cb Bin Lu               2017-02-21  1188  				KVMPPC_VSX_COPY_DWORD_LOAD_DUMP)
6f63e81bda98cb Bin Lu               2017-02-21  1189  			kvmppc_set_vsr_dword_dump(vcpu, gpr);
da2a32b876e979 Simon Guo            2018-05-21  1190  		else if (vcpu->arch.mmio_copy_type ==
94dd7fa1c0b75e Simon Guo            2018-05-21  1191  				KVMPPC_VSX_COPY_WORD_LOAD_DUMP)
94dd7fa1c0b75e Simon Guo            2018-05-21  1192  			kvmppc_set_vsr_word_dump(vcpu, gpr);
6f63e81bda98cb Bin Lu               2017-02-21  1193  		break;
09f984961c137c Jose Ricardo Ziviani 2018-02-03  1194  #endif
09f984961c137c Jose Ricardo Ziviani 2018-02-03  1195  #ifdef CONFIG_ALTIVEC
09f984961c137c Jose Ricardo Ziviani 2018-02-03  1196  	case KVM_MMIO_REG_VMX:
2e6baa46b4ae78 Simon Guo            2018-05-21  1197  		if (vcpu->kvm->arch.kvm_ops->giveup_ext)
2e6baa46b4ae78 Simon Guo            2018-05-21  1198  			vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu, MSR_VEC);
2e6baa46b4ae78 Simon Guo            2018-05-21  1199  
acc9eb9305fecd Simon Guo            2018-05-21  1200  		if (vcpu->arch.mmio_copy_type == KVMPPC_VMX_COPY_DWORD)
09f984961c137c Jose Ricardo Ziviani 2018-02-03  1201  			kvmppc_set_vmx_dword(vcpu, gpr);
acc9eb9305fecd Simon Guo            2018-05-21  1202  		else if (vcpu->arch.mmio_copy_type == KVMPPC_VMX_COPY_WORD)
acc9eb9305fecd Simon Guo            2018-05-21  1203  			kvmppc_set_vmx_word(vcpu, gpr);
acc9eb9305fecd Simon Guo            2018-05-21  1204  		else if (vcpu->arch.mmio_copy_type ==
acc9eb9305fecd Simon Guo            2018-05-21  1205  				KVMPPC_VMX_COPY_HWORD)
acc9eb9305fecd Simon Guo            2018-05-21  1206  			kvmppc_set_vmx_hword(vcpu, gpr);
acc9eb9305fecd Simon Guo            2018-05-21  1207  		else if (vcpu->arch.mmio_copy_type ==
acc9eb9305fecd Simon Guo            2018-05-21  1208  				KVMPPC_VMX_COPY_BYTE)
acc9eb9305fecd Simon Guo            2018-05-21  1209  			kvmppc_set_vmx_byte(vcpu, gpr);
09f984961c137c Jose Ricardo Ziviani 2018-02-03  1210  		break;
873db2cd9a6d7f Suraj Jitindar Singh 2018-12-14  1211  #endif
873db2cd9a6d7f Suraj Jitindar Singh 2018-12-14  1212  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
873db2cd9a6d7f Suraj Jitindar Singh 2018-12-14  1213  	case KVM_MMIO_REG_NESTED_GPR:
873db2cd9a6d7f Suraj Jitindar Singh 2018-12-14  1214  		if (kvmppc_need_byteswap(vcpu))
873db2cd9a6d7f Suraj Jitindar Singh 2018-12-14  1215  			gpr = swab64(gpr);
873db2cd9a6d7f Suraj Jitindar Singh 2018-12-14  1216  		kvm_vcpu_write_guest(vcpu, vcpu->arch.nested_io_gpr, &gpr,
873db2cd9a6d7f Suraj Jitindar Singh 2018-12-14  1217  				     sizeof(gpr));
873db2cd9a6d7f Suraj Jitindar Singh 2018-12-14  1218  		break;
287d5611fab5a4 Alexander Graf       2010-04-01  1219  #endif
b104d06632d089 Alexander Graf       2010-02-19  1220  	default:
b104d06632d089 Alexander Graf       2010-02-19  1221  		BUG();
b104d06632d089 Alexander Graf       2010-02-19  1222  	}
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1223  }
bbf45ba57eaec5 Hollis Blanchard     2008-04-16  1224  

:::::: The code at line 1141 was first introduced by commit
:::::: 6f63e81bda98cbb549b01faf978884692ded438d KVM: PPC: Book3S: Add MMIO emulation for FP and VSX instructions

:::::: TO: Bin Lu <lblulb@linux.vnet.ibm.com>
:::::: CC: Paul Mackerras <paulus@ozlabs.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
