Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4689244B3EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbhKIUa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 15:30:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:27401 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243090AbhKIUa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:30:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="213266655"
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="gz'50?scan'50,208,50";a="213266655"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 12:27:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="gz'50?scan'50,208,50";a="669544368"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Nov 2021 12:27:56 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mkXil-000Dtn-TY; Tue, 09 Nov 2021 20:27:55 +0000
Date:   Wed, 10 Nov 2021 04:26:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-altera-dfl.c:52:30: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202111100447.I9NJVyIb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cb690f5238d71f543f4ce874aa59237cf53a877c
commit: ba2fc167e9447596a812e828842d0130ea9cd0e4 spi: altera: Add DFL bus driver for Altera API Controller
date:   7 months ago
config: m68k-randconfig-s031-20211109 (attached as .config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba2fc167e9447596a812e828842d0130ea9cd0e4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ba2fc167e9447596a812e828842d0130ea9cd0e4
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-altera-dfl.c:52:30: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void *context @@
   drivers/spi/spi-altera-dfl.c:52:30: sparse:     expected void [noderef] __iomem *base
   drivers/spi/spi-altera-dfl.c:52:30: sparse:     got void *context
   drivers/spi/spi-altera-dfl.c:78:30: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void *context @@
   drivers/spi/spi-altera-dfl.c:78:30: sparse:     expected void [noderef] __iomem *base
   drivers/spi/spi-altera-dfl.c:78:30: sparse:     got void *context
>> drivers/spi/spi-altera-dfl.c:161:22: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void *bus_context @@     got void [noderef] __iomem *[assigned] base @@
   drivers/spi/spi-altera-dfl.c:161:22: sparse:     expected void *bus_context
   drivers/spi/spi-altera-dfl.c:161:22: sparse:     got void [noderef] __iomem *[assigned] base

vim +52 drivers/spi/spi-altera-dfl.c

    48	
    49	static int indirect_bus_reg_read(void *context, unsigned int reg,
    50					 unsigned int *val)
    51	{
  > 52		void __iomem *base = context;
    53		int loops;
    54		u64 v;
    55	
    56		writeq((reg >> 2) | INDIRECT_RD, base + INDIRECT_ADDR);
    57	
    58		loops = 0;
    59		while ((readq(base + INDIRECT_ADDR) & INDIRECT_RD) &&
    60		       (loops++ < INDIRECT_TIMEOUT))
    61			cpu_relax();
    62	
    63		if (loops >= INDIRECT_TIMEOUT) {
    64			pr_err("%s timed out %d\n", __func__, loops);
    65			return -ETIME;
    66		}
    67	
    68		v = readq(base + INDIRECT_RD_DATA);
    69	
    70		*val = v & INDIRECT_DATA_MASK;
    71	
    72		return 0;
    73	}
    74	
    75	static int indirect_bus_reg_write(void *context, unsigned int reg,
    76					  unsigned int val)
    77	{
    78		void __iomem *base = context;
    79		int loops;
    80	
    81		writeq(val, base + INDIRECT_WR_DATA);
    82		writeq((reg >> 2) | INDIRECT_WR, base + INDIRECT_ADDR);
    83	
    84		loops = 0;
    85		while ((readq(base + INDIRECT_ADDR) & INDIRECT_WR) &&
    86		       (loops++ < INDIRECT_TIMEOUT))
    87			cpu_relax();
    88	
    89		if (loops >= INDIRECT_TIMEOUT) {
    90			pr_err("%s timed out %d\n", __func__, loops);
    91			return -ETIME;
    92		}
    93		return 0;
    94	}
    95	
    96	static const struct regmap_config indirect_regbus_cfg = {
    97		.reg_bits = 32,
    98		.reg_stride = 4,
    99		.val_bits = 32,
   100		.fast_io = true,
   101		.max_register = 24,
   102	
   103		.reg_write = indirect_bus_reg_write,
   104		.reg_read = indirect_bus_reg_read,
   105	};
   106	
   107	static struct spi_board_info m10_bmc_info = {
   108		.modalias = "m10-d5005",
   109		.max_speed_hz = 12500000,
   110		.bus_num = 0,
   111		.chip_select = 0,
   112	};
   113	
   114	static void config_spi_master(void __iomem *base, struct spi_master *master)
   115	{
   116		u64 v;
   117	
   118		v = readq(base + SPI_CORE_PARAMETER);
   119	
   120		master->mode_bits = SPI_CS_HIGH;
   121		if (FIELD_GET(CLK_POLARITY, v))
   122			master->mode_bits |= SPI_CPOL;
   123		if (FIELD_GET(CLK_PHASE, v))
   124			master->mode_bits |= SPI_CPHA;
   125	
   126		master->num_chipselect = FIELD_GET(NUM_CHIPSELECT, v);
   127		master->bits_per_word_mask =
   128			SPI_BPW_RANGE_MASK(1, FIELD_GET(DATA_WIDTH, v));
   129	}
   130	
   131	static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
   132	{
   133		struct device *dev = &dfl_dev->dev;
   134		struct spi_master *master;
   135		struct altera_spi *hw;
   136		void __iomem *base;
   137		int err = -ENODEV;
   138	
   139		master = spi_alloc_master(dev, sizeof(struct altera_spi));
   140		if (!master)
   141			return -ENOMEM;
   142	
   143		master->bus_num = dfl_dev->id;
   144	
   145		hw = spi_master_get_devdata(master);
   146	
   147		hw->dev = dev;
   148	
   149		base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
   150	
   151		if (IS_ERR(base)) {
   152			dev_err(dev, "%s get mem resource fail!\n", __func__);
   153			return PTR_ERR(base);
   154		}
   155	
   156		config_spi_master(base, master);
   157		dev_dbg(dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
   158			master->num_chipselect, master->bits_per_word_mask,
   159			master->mode_bits);
   160	
 > 161		hw->regmap = devm_regmap_init(dev, NULL, base, &indirect_regbus_cfg);
   162		if (IS_ERR(hw->regmap))
   163			return PTR_ERR(hw->regmap);
   164	
   165		hw->irq = -EINVAL;
   166	
   167		altera_spi_init_master(master);
   168	
   169		err = devm_spi_register_master(dev, master);
   170		if (err) {
   171			dev_err(dev, "%s failed to register spi master %d\n", __func__, err);
   172			goto exit;
   173		}
   174	
   175		if (!spi_new_device(master,  &m10_bmc_info)) {
   176			dev_err(dev, "%s failed to create SPI device: %s\n",
   177				__func__, m10_bmc_info.modalias);
   178		}
   179	
   180		return 0;
   181	exit:
   182		spi_master_put(master);
   183		return err;
   184	}
   185	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--fUYQa+Pmc3FrFX/N
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
kOnAlEQS54qnOcqDZ3r6X/82BM3MbAEA

--fUYQa+Pmc3FrFX/N--
