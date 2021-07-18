Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3E63CCA4E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 20:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhGRSzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 14:55:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:61756 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhGRSzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 14:55:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="190550905"
X-IronPort-AV: E=Sophos;i="5.84,249,1620716400"; 
   d="gz'50?scan'50,208,50";a="190550905"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2021 11:52:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,249,1620716400"; 
   d="gz'50?scan'50,208,50";a="659461999"
Received: from lkp-server01.sh.intel.com (HELO a467b34d8c10) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jul 2021 11:52:47 -0700
Received: from kbuild by a467b34d8c10 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5BuA-0000Op-EV; Sun, 18 Jul 2021 18:52:46 +0000
Date:   Mon, 19 Jul 2021 02:52:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [linux-chenxing:mstar_v5_14_rebase_i2_drm 257/349]
 drivers/clk/mstar/clk-msc313-mux.c:27:2: error: implicit declaration of
 function 'regmap_field_read'; did you mean 'regmap_field_write'?
Message-ID: <202107190200.Z2RoQoYz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://github.com/linux-chenxing/linux.git mstar_v5_14_rebase_i2_drm
head:   93dfb2364436067bf34c6d4ddcd282496182cc0f
commit: 395724ba20fe2aa13e0167b43b6914f94f128df0 [257/349] clk: mstar: msc313 clock mux base
config: mips-bigsur_defconfig (attached as .config)
compiler: mips64-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/395724ba20fe2aa13e0167b43b6914f94f128df0
        git remote add linux-chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags linux-chenxing mstar_v5_14_rebase_i2_drm
        git checkout 395724ba20fe2aa13e0167b43b6914f94f128df0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/mstar/clk-msc313-mux.c: In function 'msc313_mux_mux_get_parent':
>> drivers/clk/mstar/clk-msc313-mux.c:27:2: error: implicit declaration of function 'regmap_field_read'; did you mean 'regmap_field_write'? [-Werror=implicit-function-declaration]
      27 |  regmap_field_read(mux->mux, &index);
         |  ^~~~~~~~~~~~~~~~~
         |  regmap_field_write
   drivers/clk/mstar/clk-msc313-mux.c: In function 'msc313_mux_register_muxes':
>> drivers/clk/mstar/clk-msc313-mux.c:146:10: error: variable 'gate_field' has initializer but incomplete type
     146 |   struct reg_field gate_field = REG_FIELD(mux_data->offset,
         |          ^~~~~~~~~
>> drivers/clk/mstar/clk-msc313-mux.c:146:33: error: implicit declaration of function 'REG_FIELD' [-Werror=implicit-function-declaration]
     146 |   struct reg_field gate_field = REG_FIELD(mux_data->offset,
         |                                 ^~~~~~~~~
>> drivers/clk/mstar/clk-msc313-mux.c:146:20: error: storage size of 'gate_field' isn't known
     146 |   struct reg_field gate_field = REG_FIELD(mux_data->offset,
         |                    ^~~~~~~~~~
>> drivers/clk/mstar/clk-msc313-mux.c:148:10: error: variable 'mux_field' has initializer but incomplete type
     148 |   struct reg_field mux_field = REG_FIELD(mux_data->offset,
         |          ^~~~~~~~~
>> drivers/clk/mstar/clk-msc313-mux.c:148:20: error: storage size of 'mux_field' isn't known
     148 |   struct reg_field mux_field = REG_FIELD(mux_data->offset,
         |                    ^~~~~~~~~
>> drivers/clk/mstar/clk-msc313-mux.c:150:10: error: variable 'deglitch_field' has initializer but incomplete type
     150 |   struct reg_field deglitch_field = REG_FIELD(mux_data->offset,
         |          ^~~~~~~~~
>> drivers/clk/mstar/clk-msc313-mux.c:150:20: error: storage size of 'deglitch_field' isn't known
     150 |   struct reg_field deglitch_field = REG_FIELD(mux_data->offset,
         |                    ^~~~~~~~~~~~~~
>> drivers/clk/mstar/clk-msc313-mux.c:157:16: error: implicit declaration of function 'devm_regmap_field_alloc' [-Werror=implicit-function-declaration]
     157 |    mux->gate = devm_regmap_field_alloc(dev, regmap, gate_field);
         |                ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mstar/clk-msc313-mux.c:150:20: warning: unused variable 'deglitch_field' [-Wunused-variable]
     150 |   struct reg_field deglitch_field = REG_FIELD(mux_data->offset,
         |                    ^~~~~~~~~~~~~~
   drivers/clk/mstar/clk-msc313-mux.c:148:20: warning: unused variable 'mux_field' [-Wunused-variable]
     148 |   struct reg_field mux_field = REG_FIELD(mux_data->offset,
         |                    ^~~~~~~~~
   drivers/clk/mstar/clk-msc313-mux.c:146:20: warning: unused variable 'gate_field' [-Wunused-variable]
     146 |   struct reg_field gate_field = REG_FIELD(mux_data->offset,
         |                    ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +27 drivers/clk/mstar/clk-msc313-mux.c

    21	
    22	static u8 msc313_mux_mux_get_parent(struct clk_hw *hw)
    23	{
    24		struct msc313_mux *mux = mux_to_mux(hw);
    25		unsigned int index;
    26	
  > 27		regmap_field_read(mux->mux, &index);
    28	
    29		return index;
    30	}
    31	
    32	static const struct clk_ops msc313_mux_mux_ops = {
    33		.set_parent = msc313_mux_mux_set_parent,
    34		.get_parent = msc313_mux_mux_get_parent,
    35	};
    36	
    37	static int msc313_mux_deglitch_enable(struct clk_hw *hw)
    38	{
    39		struct msc313_mux *mux = deglitch_to_mux(hw);
    40	
    41		if (mux->gate)
    42			regmap_field_write(mux->gate, 0);
    43	
    44		return 0;
    45	}
    46	
    47	static void msc313_mux_deglitch_disable(struct clk_hw *hw)
    48	{
    49		struct msc313_mux *mux = deglitch_to_mux(hw);
    50	
    51		if (mux->gate)
    52			regmap_field_write(mux->gate, 1);
    53	}
    54	
    55	static int msc313_mux_deglitch_is_enabled(struct clk_hw *hw)
    56	{
    57		struct msc313_mux *mux = deglitch_to_mux(hw);
    58		unsigned int notgated;
    59	
    60		if (mux->gate) {
    61			regmap_field_read(mux->gate, &notgated);
    62			return !notgated;
    63		}
    64	
    65		return 1;
    66	}
    67	
    68	static int msc313_mux_deglitch_set_parent(struct clk_hw *hw, u8 index)
    69	{
    70		struct msc313_mux *mux = deglitch_to_mux(hw);
    71	
    72		if (!mux->deglitch)
    73			return -ENOTSUPP;
    74	
    75		return regmap_field_write(mux->deglitch, index);
    76	}
    77	
    78	static u8 msc313_mux_deglitch_get_parent(struct clk_hw *hw)
    79	{
    80		struct msc313_mux *mux = deglitch_to_mux(hw);
    81		unsigned int index = 0;
    82	
    83		if (mux->deglitch){
    84			regmap_field_read(mux->deglitch, &index);
    85		}
    86	
    87		return index;
    88	}
    89	
    90	static const struct clk_ops msc313_mux_deglitch_ops = {
    91		.enable = msc313_mux_deglitch_enable,
    92		.disable = msc313_mux_deglitch_disable,
    93		.is_enabled = msc313_mux_deglitch_is_enabled,
    94		.set_parent = msc313_mux_deglitch_set_parent,
    95		.get_parent = msc313_mux_deglitch_get_parent,
    96	};
    97	
    98	struct clk_hw *msc313_mux_xlate(struct of_phandle_args *clkspec, void *data)
    99	{
   100		struct msc313_muxes *muxes = data;
   101		unsigned int of_idx = clkspec->args[0];
   102		unsigned int idx = of_idx / 2;
   103	
   104		/* mux, deglitch, mux, deglitch,.. */
   105		if (of_idx >= muxes->muxes_data->num_muxes * 2)
   106			return ERR_PTR(-EINVAL);
   107	
   108		if (of_idx % 2)
   109			return &muxes->muxes[idx].deglitch_hw;
   110	
   111		return &muxes->muxes[idx].mux_hw;
   112	}
   113	
   114	struct msc313_muxes *msc313_mux_register_muxes(struct device *dev,
   115			struct regmap *regmap, const struct msc313_muxes_data *muxes_data,
   116			int (*fill_clk_parent_data)(struct clk_parent_data*, void*, const void*, const struct msc313_muxes*, unsigned int, unsigned int), void *data)
   117	{
   118		const struct msc313_mux_data *mux_data = muxes_data->muxes;
   119		struct clk_init_data mux_init = {
   120			.ops = &msc313_mux_mux_ops,
   121		};
   122		struct clk_init_data deglitch_init = {
   123			.ops = &msc313_mux_deglitch_ops,
   124		};
   125		struct clk_parent_data *dynamic_parent_data = NULL;
   126		struct msc313_muxes *muxes;
   127		struct msc313_mux *mux;
   128		struct clk_hw *clk_hw;
   129		int i, ret, mux_parent;
   130	
   131		/*
   132		 * If using the dynamic clk_parent_data mode you have to have both
   133		 * a callback and data.
   134		 */
   135		if ((fill_clk_parent_data && !data) || (!fill_clk_parent_data && data))
   136			return ERR_PTR(-EINVAL);
   137	
   138		muxes = devm_kzalloc(dev, struct_size(muxes, muxes, muxes_data->num_muxes), GFP_KERNEL);
   139	        if (!muxes)
   140			return ERR_PTR(-ENOMEM);
   141	
   142		muxes->muxes_data = muxes_data;
   143	        mux = muxes->muxes;
   144	
   145		for (i = 0; i < muxes_data->num_muxes; i++, mux++, mux_data++) {
 > 146			struct reg_field gate_field = REG_FIELD(mux_data->offset,
   147					mux_data->gate_shift, mux_data->gate_shift);
 > 148			struct reg_field mux_field = REG_FIELD(mux_data->offset,
   149					mux_data->mux_shift, mux_data->mux_shift + (mux_data->mux_width - 1));
 > 150			struct reg_field deglitch_field = REG_FIELD(mux_data->offset,
   151					mux_data->deglitch_shift, mux_data->deglitch_shift);
   152	
   153			if(!mux_data->name)
   154				continue;
   155	
   156			if (mux_data->gate_shift != -1) {
 > 157				mux->gate = devm_regmap_field_alloc(dev, regmap, gate_field);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--jRHKVT23PllUwdXP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--jRHKVT23PllUwdXP--
