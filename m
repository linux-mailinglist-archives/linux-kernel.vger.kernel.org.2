Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE745F563
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbhKZTth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:49:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:60856 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233483AbhKZTrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:47:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="296511450"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="296511450"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 11:44:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="607971271"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2021 11:44:14 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqh8n-0008VL-Cp; Fri, 26 Nov 2021 19:44:13 +0000
Date:   Sat, 27 Nov 2021 03:43:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/tegra/tegra210_adx.c:125:14: sparse: sparse: restricted
 snd_pcm_format_t degrades to integer
Message-ID: <202111270332.sDUjP9Xg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1bff7d7e8c487b9b0ceab70b43b781f1d45f55eb
commit: a99ab6f395a9e45ca3f9047e9b88d6e02737419f ASoC: tegra: Add Tegra210 based ADX driver
date:   10 weeks ago
config: riscv-randconfig-s032-20211126 (https://download.01.org/0day-ci/archive/20211127/202111270332.sDUjP9Xg-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a99ab6f395a9e45ca3f9047e9b88d6e02737419f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a99ab6f395a9e45ca3f9047e9b88d6e02737419f
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash sound/soc/tegra/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> sound/soc/tegra/tegra210_adx.c:125:14: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/soc/tegra/tegra210_adx.c:128:14: sparse: sparse: restricted snd_pcm_format_t degrades to integer
   sound/soc/tegra/tegra210_adx.c:131:14: sparse: sparse: restricted snd_pcm_format_t degrades to integer
>> sound/soc/tegra/tegra210_adx.c:153:38: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int format @@     got restricted snd_pcm_format_t @@
   sound/soc/tegra/tegra210_adx.c:153:38: sparse:     expected unsigned int format
   sound/soc/tegra/tegra210_adx.c:153:38: sparse:     got restricted snd_pcm_format_t
   sound/soc/tegra/tegra210_adx.c:162:56: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int format @@     got restricted snd_pcm_format_t @@
   sound/soc/tegra/tegra210_adx.c:162:56: sparse:     expected unsigned int format
   sound/soc/tegra/tegra210_adx.c:162:56: sparse:     got restricted snd_pcm_format_t

vim +125 sound/soc/tegra/tegra210_adx.c

   109	
   110	static int tegra210_adx_set_audio_cif(struct snd_soc_dai *dai,
   111					      unsigned int channels,
   112					      unsigned int format,
   113					      unsigned int reg)
   114	{
   115		struct tegra210_adx *adx = snd_soc_dai_get_drvdata(dai);
   116		struct tegra_cif_conf cif_conf;
   117		int audio_bits;
   118	
   119		memset(&cif_conf, 0, sizeof(struct tegra_cif_conf));
   120	
   121		if (channels < 1 || channels > 16)
   122			return -EINVAL;
   123	
   124		switch (format) {
 > 125		case SNDRV_PCM_FORMAT_S8:
   126			audio_bits = TEGRA_ACIF_BITS_8;
   127			break;
   128		case SNDRV_PCM_FORMAT_S16_LE:
   129			audio_bits = TEGRA_ACIF_BITS_16;
   130			break;
   131		case SNDRV_PCM_FORMAT_S32_LE:
   132			audio_bits = TEGRA_ACIF_BITS_32;
   133			break;
   134		default:
   135			return -EINVAL;
   136		}
   137	
   138		cif_conf.audio_ch = channels;
   139		cif_conf.client_ch = channels;
   140		cif_conf.audio_bits = audio_bits;
   141		cif_conf.client_bits = audio_bits;
   142	
   143		tegra_set_cif(adx->regmap, reg, &cif_conf);
   144	
   145		return 0;
   146	}
   147	
   148	static int tegra210_adx_out_hw_params(struct snd_pcm_substream *substream,
   149					      struct snd_pcm_hw_params *params,
   150					      struct snd_soc_dai *dai)
   151	{
   152		return tegra210_adx_set_audio_cif(dai, params_channels(params),
 > 153				params_format(params),
   154				TEGRA210_ADX_TX1_CIF_CTRL + ((dai->id - 1) * TEGRA210_ADX_AUDIOCIF_CH_STRIDE));
   155	}
   156	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
