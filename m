Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80245D93A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhKYLbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:31:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:29177 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234513AbhKYLau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:30:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="259395639"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="259395639"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 03:25:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="510269878"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 25 Nov 2021 03:25:34 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqCsf-0006HP-Kq; Thu, 25 Nov 2021 11:25:33 +0000
Date:   Thu, 25 Nov 2021 19:25:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.15 132/139]
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2835:5: warning: no previous
 prototype for function 'arm_smmu_group_set_mpam'
Message-ID: <202111251929.J9Dyac7K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.15
head:   ce3629841262f725a5f3a327403fcaf0e604a85e
commit: 2f98d2f8d6ffedf8a76bc37dd864aa41cff0c9ea [132/139] untested: iommu/arm-smmu-v3: Add mpam helpers to query and set state
config: arm64-randconfig-r012-20211115 (https://download.01.org/0day-ci/archive/20211125/202111251929.J9Dyac7K-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project fbe72e41b99dc7994daac300d208a955be3e4a0a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=2f98d2f8d6ffedf8a76bc37dd864aa41cff0c9ea
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.15
        git checkout 2f98d2f8d6ffedf8a76bc37dd864aa41cff0c9ea
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:14:
   In file included from include/linux/arm_mpam.h:11:
   arch/arm64/include/asm/mpam.h:110:6: warning: variable 'regval' set but not used [-Wunused-but-set-variable]
           u64 regval;
               ^
   arch/arm64/include/asm/mpam.h:133:6: warning: variable 'regval' set but not used [-Wunused-but-set-variable]
           u64 regval = mpam_get_regval(tsk);
               ^
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2835:5: warning: no previous prototype for function 'arm_smmu_group_set_mpam' [-Wmissing-prototypes]
   int arm_smmu_group_set_mpam(struct iommu_group *group, u16 partid, u8 pmg)
       ^
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2835:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int arm_smmu_group_set_mpam(struct iommu_group *group, u16 partid, u8 pmg)
   ^
   static 
>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2886:5: warning: no previous prototype for function 'arm_smmu_group_get_mpam' [-Wmissing-prototypes]
   int arm_smmu_group_get_mpam(struct iommu_group *group, u16 *partid, u8 *pmg)
       ^
   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2886:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int arm_smmu_group_get_mpam(struct iommu_group *group, u16 *partid, u8 *pmg)
   ^
   static 
   4 warnings generated.


vim +/arm_smmu_group_set_mpam +2835 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c

  2834	
> 2835	int arm_smmu_group_set_mpam(struct iommu_group *group, u16 partid, u8 pmg)
  2836	{
  2837		int i;
  2838		u32 sid;
  2839		__le64 *step;
  2840		unsigned long flags;
  2841		struct iommu_domain *domain;
  2842		struct arm_smmu_device *smmu;
  2843		struct arm_smmu_master *master;
  2844		struct arm_smmu_cmdq_batch cmds;
  2845		struct arm_smmu_domain *smmu_domain;
  2846		struct arm_smmu_cmdq_ent cmd = {
  2847			.opcode	= CMDQ_OP_CFGI_STE,
  2848			.cfgi	= {
  2849				.leaf	= true,
  2850			},
  2851		};
  2852	
  2853		domain = iommu_get_domain_for_group(group);
  2854		if (!domain || domain->ops != &arm_smmu_ops)
  2855			return -EINVAL;
  2856	
  2857		smmu_domain = to_smmu_domain(domain);
  2858		if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_MPAM))
  2859			return -EIO;
  2860		smmu = smmu_domain->smmu;
  2861	
  2862		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
  2863		list_for_each_entry(master, &smmu_domain->devices, domain_head) {
  2864			for (i = 0; i < master->num_streams; i++) {
  2865				sid = master->streams[i].id;
  2866				step = arm_smmu_get_step_for_sid(smmu, sid);
  2867	
  2868				/* These need locking if the VMSPtr is ever used */
  2869				step[4] = FIELD_PREP(STRTAB_STE_4_PARTID, partid);
  2870				step[5] = FIELD_PREP(STRTAB_STE_5_PMG, pmg);
  2871	
  2872				cmd.cfgi.sid = sid;
  2873				arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
  2874			}
  2875	
  2876			master->partid = partid;
  2877			master->pmg = pmg;
  2878		}
  2879		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
  2880	
  2881		arm_smmu_cmdq_batch_submit(smmu, &cmds);
  2882	
  2883		return 0;
  2884	}
  2885	
> 2886	int arm_smmu_group_get_mpam(struct iommu_group *group, u16 *partid, u8 *pmg)
  2887	{
  2888		int err = -EINVAL;
  2889		unsigned long flags;
  2890		struct iommu_domain *domain;
  2891		struct arm_smmu_master *master;
  2892		struct arm_smmu_domain *smmu_domain;
  2893	
  2894		domain = iommu_get_domain_for_group(group);
  2895		if (!domain || domain->ops != &arm_smmu_ops)
  2896			return -EINVAL;
  2897	
  2898		smmu_domain = to_smmu_domain(domain);
  2899		if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_MPAM))
  2900			return -EIO;
  2901	
  2902		if (!partid && !pmg)
  2903			return 0;
  2904	
  2905		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
  2906		master = list_first_entry_or_null(&smmu_domain->devices,
  2907						  typeof(*master), domain_head);
  2908		if (master) {
  2909			if (partid)
  2910				*partid = master->partid;
  2911			if (pmg)
  2912				*pmg = master->pmg;
  2913			err = 0;
  2914		}
  2915		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
  2916	
  2917		return err;
  2918	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
