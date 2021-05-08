Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5F73773C4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 21:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhEHTLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 15:11:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:23684 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhEHTLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 15:11:35 -0400
IronPort-SDR: yB1+WEbfklHlqlIlR+CGXWoGb1G7RN7ShLaNIDJrPlyiMNPGXMzuE2aecdXfzfM3wEDAXfNeMo
 LRro9tAF1SOw==
X-IronPort-AV: E=McAfee;i="6200,9189,9978"; a="219862135"
X-IronPort-AV: E=Sophos;i="5.82,284,1613462400"; 
   d="gz'50?scan'50,208,50";a="219862135"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2021 12:10:31 -0700
IronPort-SDR: B594U8HolIV8wdsEF6/b7LI1me43AWFAOv8LDXp0qnyB/rW7dKLpGoSlu5z17D2ctFdJ1+QnM3
 N5lUJqphPiNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,284,1613462400"; 
   d="gz'50?scan'50,208,50";a="435459572"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 May 2021 12:10:29 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lfSLM-000Bl4-DD; Sat, 08 May 2021 19:10:28 +0000
Date:   Sun, 9 May 2021 03:09:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/arm64/kvm/vgic/vgic-mmio.c:881:22: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202105090345.eFcLWmLn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   07db05638aa25ed66e6fc89b45f6773ef3e69396
commit: 9ed24f4b712b855dcf7be3025b75b051cb73a2b7 KVM: arm64: Move virt/kvm/arm to arch/arm64
date:   12 months ago
config: arm64-randconfig-s032-20210508 (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9ed24f4b712b855dcf7be3025b75b051cb73a2b7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9ed24f4b712b855dcf7be3025b75b051cb73a2b7
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/arm64/kvm/vgic/vgic-mmio.c:854:24: sparse: sparse: cast to restricted __le16
   arch/arm64/kvm/vgic/vgic-mmio.c:856:24: sparse: sparse: cast to restricted __le32
   arch/arm64/kvm/vgic/vgic-mmio.c:858:24: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-mmio.c:878:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long data @@     got restricted __le16 [usertype] @@
   arch/arm64/kvm/vgic/vgic-mmio.c:878:22: sparse:     expected unsigned long data
   arch/arm64/kvm/vgic/vgic-mmio.c:878:22: sparse:     got restricted __le16 [usertype]
>> arch/arm64/kvm/vgic/vgic-mmio.c:881:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long data @@     got restricted __le32 [usertype] @@
   arch/arm64/kvm/vgic/vgic-mmio.c:881:22: sparse:     expected unsigned long data
   arch/arm64/kvm/vgic/vgic-mmio.c:881:22: sparse:     got restricted __le32 [usertype]
   arch/arm64/kvm/vgic/vgic-mmio.c:884:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long data @@     got restricted __le64 [usertype] @@
   arch/arm64/kvm/vgic/vgic-mmio.c:884:22: sparse:     expected unsigned long data
   arch/arm64/kvm/vgic/vgic-mmio.c:884:22: sparse:     got restricted __le64 [usertype]
   arch/arm64/kvm/vgic/vgic-mmio.c:88:17: sparse: sparse: context imbalance in 'vgic_mmio_write_group' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-mmio.c:124:9: sparse: sparse: context imbalance in 'vgic_mmio_write_senable' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-mmio.c:195:9: sparse: sparse: context imbalance in 'vgic_uaccess_write_senable' - different lock contexts for basic block
>> arch/arm64/kvm/vgic/vgic-mmio.c:278:9: sparse: sparse: context imbalance in 'vgic_mmio_write_spending' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-mmio.c:320:9: sparse: sparse: context imbalance in 'vgic_uaccess_write_spending' - different lock contexts for basic block
>> arch/arm64/kvm/vgic/vgic-mmio.c:565:9: sparse: sparse: context imbalance in 'vgic_mmio_change_active' - wrong count at exit
   arch/arm64/kvm/vgic/vgic-mmio.c:773:30: sparse: sparse: context imbalance in 'vgic_write_irq_line_level_info' - different lock contexts for basic block
--
>> arch/arm64/kvm/vgic/vgic-mmio-v2.c:134:9: sparse: sparse: context imbalance in 'vgic_mmio_write_sgir' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-mmio-v2.c:244:9: sparse: sparse: context imbalance in 'vgic_mmio_write_sgipends' - different lock contexts for basic block
--
>> arch/arm64/kvm/vgic/vgic-mmio-v3.c:338:9: sparse: sparse: context imbalance in 'vgic_v3_uaccess_write_pending' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-mmio-v3.c:1025:17: sparse: sparse: context imbalance in 'vgic_v3_dispatch_sgi' - different lock contexts for basic block
--
   arch/arm64/kvm/vgic/vgic-its.c:825:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:956:24: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-its.c:2134:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [assigned] [usertype] val @@     got restricted __le64 [usertype] @@
   arch/arm64/kvm/vgic/vgic-its.c:2134:13: sparse:     expected unsigned long long [assigned] [usertype] val
   arch/arm64/kvm/vgic/vgic-its.c:2134:13: sparse:     got restricted __le64 [usertype]
   arch/arm64/kvm/vgic/vgic-its.c:2160:15: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2281:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [assigned] [usertype] val @@     got restricted __le64 [usertype] @@
   arch/arm64/kvm/vgic/vgic-its.c:2281:13: sparse:     expected unsigned long long [assigned] [usertype] val
   arch/arm64/kvm/vgic/vgic-its.c:2281:13: sparse:     got restricted __le64 [usertype]
   arch/arm64/kvm/vgic/vgic-its.c:2307:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2405:17: sparse: sparse: cast to restricted __le64
   arch/arm64/kvm/vgic/vgic-its.c:2461:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [assigned] [usertype] val @@     got restricted __le64 [usertype] @@
   arch/arm64/kvm/vgic/vgic-its.c:2461:13: sparse:     expected unsigned long long [assigned] [usertype] val
   arch/arm64/kvm/vgic/vgic-its.c:2461:13: sparse:     got restricted __le64 [usertype]
   arch/arm64/kvm/vgic/vgic-its.c:2477:15: sparse: sparse: cast to restricted __le64
>> arch/arm64/kvm/vgic/vgic-its.c:280:12: sparse: sparse: context imbalance in 'update_lpi_config' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-its.c:443:9: sparse: sparse: context imbalance in 'its_sync_lpi_pending_table' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-its.c:730:12: sparse: sparse: context imbalance in 'vgic_its_trigger_msi' - different lock contexts for basic block
   arch/arm64/kvm/vgic/vgic-its.c:752:5: sparse: sparse: context imbalance in 'vgic_its_inject_cached_translation' - wrong count at exit

vim +881 arch/arm64/kvm/vgic/vgic-mmio.c

4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  861  
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  862  /*
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  863   * kvm_mmio_write_buf() expects a value in a format such that if converted to
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  864   * a byte array it is observed as the guest would see it if it could perform
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  865   * the load directly.  Since the GIC is LE, and the guest knows this, the
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  866   * guest expects a value in little endian format.
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  867   *
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  868   * We convert the data value from the CPUs native format to LE so that the
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  869   * value is returned in the proper format.
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  870   */
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  871  void vgic_data_host_to_mmio_bus(void *buf, unsigned int len,
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  872  				unsigned long data)
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  873  {
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  874  	switch (len) {
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  875  	case 1:
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  876  		break;
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  877  	case 2:
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  878  		data = cpu_to_le16(data);
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  879  		break;
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  880  	case 4:
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26 @881  		data = cpu_to_le32(data);
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  882  		break;
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  883  	default:
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  884  		data = cpu_to_le64(data);
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  885  	}
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  886  
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  887  	kvm_mmio_write_buf(buf, len, data);
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  888  }
4493b1c4866a03 virt/kvm/arm/vgic/vgic-mmio.c Marc Zyngier 2016-04-26  889  

:::::: The code at line 881 was first introduced by commit
:::::: 4493b1c4866a03963a35be7d157c911a617a3694 KVM: arm/arm64: vgic-new: Add MMIO handling framework

:::::: TO: Marc Zyngier <marc.zyngier@arm.com>
:::::: CC: Christoffer Dall <christoffer.dall@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--BXVAT5kNtrzKuDFl
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--BXVAT5kNtrzKuDFl--
