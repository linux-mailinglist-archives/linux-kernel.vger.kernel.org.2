Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF6F327475
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 21:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhB1UoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 15:44:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:13207 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhB1UoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 15:44:14 -0500
IronPort-SDR: KZT/Ea++Pq8sSdmV4OpHTlmHKpHCsY4TFFloqI+BTozfpvTu2lvj1beFp6+B0e7BedGk+nS35g
 sbX08xxKLJqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="271293848"
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="gz'50?scan'50,208,50";a="271293848"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 12:43:32 -0800
IronPort-SDR: EVCHfDDXCgkj3PxZEoFOQqjJK3HFERQE736i4hlNPeCclV9Ti6mWo7cdjBJXYQ1wwFcNgrGVVU
 YiPuZaoXxopw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="gz'50?scan'50,208,50";a="504287172"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2021 12:43:30 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lGSuX-0004Gt-RL; Sun, 28 Feb 2021 20:43:29 +0000
Date:   Mon, 1 Mar 2021 04:42:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/pci/ops-loongson2.c:93:44: sparse: sparse: incorrect type
 in argument 2 (different address spaces)
Message-ID: <202103010421.TOVnVcrZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jiaxun,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5695e51619745d4fe3ec2506a2f0cd982c5e27a4
commit: b13812ddea615b6507beef24f76540c0c1143c5c MIPS: Loongson2ef: Disable Loongson MMI instructions
date:   5 months ago
config: mips-randconfig-s031-20210301 (attached as .config)
compiler: mips64el-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-241-geaceeafa-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b13812ddea615b6507beef24f76540c0c1143c5c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b13812ddea615b6507beef24f76540c0c1143c5c
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   arch/mips/pci/ops-loongson2.c:93:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   arch/mips/pci/ops-loongson2.c:93:24: sparse:     expected unsigned int [usertype] val
   arch/mips/pci/ops-loongson2.c:93:24: sparse:     got restricted __le32 [usertype]
>> arch/mips/pci/ops-loongson2.c:93:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *[assigned] addrp @@
   arch/mips/pci/ops-loongson2.c:93:44: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/pci/ops-loongson2.c:93:44: sparse:     got void *[assigned] addrp
>> arch/mips/pci/ops-loongson2.c:95:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *[assigned] addrp @@
   arch/mips/pci/ops-loongson2.c:95:25: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/pci/ops-loongson2.c:95:25: sparse:     got void *[assigned] addrp
   arch/mips/pci/ops-loongson2.c:95:25: sparse: sparse: cast to restricted __le32
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> arch/mips/loongson2ef/common/reset.c:24:17: sparse: sparse: cast removes address space '__iomem' of expression
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> arch/mips/loongson2ef/common/cs5536/cs5536_isa.c:84:6: sparse: sparse: symbol 'pci_isa_write_bar' was not declared. Should it be static?
>> arch/mips/loongson2ef/common/cs5536/cs5536_isa.c:110:5: sparse: sparse: symbol 'pci_isa_read_bar' was not declared. Should it be static?

vim +93 arch/mips/pci/ops-loongson2.c

e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   30  
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   31  
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   32  static int loongson_pcibios_config_access(unsigned char access_type,
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   33  				      struct pci_bus *bus,
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   34  				      unsigned int devfn, int where,
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   35  				      u32 *data)
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   36  {
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   37  	u32 busnum = bus->number;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   38  	u32 addr, type;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   39  	u32 dummy;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   40  	void *addrp;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   41  	int device = PCI_SLOT(devfn);
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   42  	int function = PCI_FUNC(devfn);
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   43  	int reg = where & ~3;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   44  
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   45  	if (busnum == 0) {
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   46  		/* board-specific part,currently,only fuloong2f,yeeloong2f
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   47  		 * use CS5536, fuloong2e use via686b, gdium has no
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   48  		 * south bridge
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   49  		 */
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   50  #ifdef CONFIG_CS5536
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   51  		/* cs5536_pci_conf_read4/write4() will call _rdmsr/_wrmsr() to
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   52  		 * access the regsters PCI_MSR_ADDR, PCI_MSR_DATA_LO,
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   53  		 * PCI_MSR_DATA_HI, which is bigger than PCI_MSR_CTRL, so, it
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   54  		 * will not go this branch, but the others. so, no calling dead
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   55  		 * loop here.
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   56  		 */
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   57  		if ((PCI_IDSEL_CS5536 == device) && (reg < PCI_MSR_CTRL)) {
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   58  			switch (access_type) {
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   59  			case PCI_ACCESS_READ:
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   60  				*data = cs5536_pci_conf_read4(function, reg);
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   61  				break;
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   62  			case PCI_ACCESS_WRITE:
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   63  				cs5536_pci_conf_write4(function, reg, *data);
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   64  				break;
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   65  			}
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   66  			return 0;
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   67  		}
1032bce3ef81cb arch/mips/pci/ops-loongson2.c Wu Zhangjin 2009-11-10   68  #endif
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   69  		/* Type 0 configuration for onboard PCI bus */
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   70  		if (device > MAX_DEV_NUM)
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   71  			return -1;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   72  
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   73  		addr = (1 << (device + ID_SEL_BEGIN)) | (function << 8) | reg;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   74  		type = 0;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   75  	} else {
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   76  		/* Type 1 configuration for offboard PCI bus */
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   77  		addr = (busnum << 16) | (device << 11) | (function << 8) | reg;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   78  		type = 0x10000;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   79  	}
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   80  
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   81  	/* Clear aborts */
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   82  	LOONGSON_PCICMD |= LOONGSON_PCICMD_MABORT_CLR | \
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   83  				LOONGSON_PCICMD_MTABORT_CLR;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   84  
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   85  	LOONGSON_PCIMAP_CFG = (addr >> 16) | type;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   86  
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   87  	/* Flush Bonito register block */
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   88  	dummy = LOONGSON_PCIMAP_CFG;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   89  	mmiowb();
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   90  
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   91  	addrp = CFG_SPACE_REG(addr & 0xffff);
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   92  	if (access_type == PCI_ACCESS_WRITE)
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  @93  		writel(cpu_to_le32(*data), addrp);
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   94  	else
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  @95  		*data = le32_to_cpu(readl(addrp));
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   96  
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   97  	/* Detect Master/Target abort */
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   98  	if (LOONGSON_PCICMD & (LOONGSON_PCICMD_MABORT_CLR |
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16   99  			     LOONGSON_PCICMD_MTABORT_CLR)) {
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  100  		/* Error occurred */
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  101  
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  102  		/* Clear bits */
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  103  		LOONGSON_PCICMD |= (LOONGSON_PCICMD_MABORT_CLR |
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  104  				  LOONGSON_PCICMD_MTABORT_CLR);
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  105  
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  106  		return -1;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  107  	}
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  108  
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  109  	return 0;
e2fee5723bbda4 arch/mips/pci/ops-fuloong2e.c Wu Zhangjin 2009-10-16  110  

:::::: The code at line 93 was first introduced by commit
:::::: e2fee5723bbda4a05c86f16a9d0f889a2c4ecede MIPS: Bonito64: Make Loongson independent from Bonito64 code.

:::::: TO: Wu Zhangjin <wuzhangjin@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--7JfCtLOvnd9MIVvH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--7JfCtLOvnd9MIVvH--
