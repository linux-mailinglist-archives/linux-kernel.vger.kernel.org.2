Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC783AC1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhFREUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:20:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:17145 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhFREUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:20:47 -0400
IronPort-SDR: kPr7QDd/K0Q6lXtFRWvFUeDfocuNDz4IKiCig2IpHw1Zy8mcPWjAHQm+muUnEko9OkRadkeHv+
 YFwMk91G6eOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="204663559"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="gz'50?scan'50,208,50";a="204663559"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 21:18:37 -0700
IronPort-SDR: HpowwBIGwReiLeGGHtcuFXtxVBp6xcpJ5ULfGm/QsTOosTZFHGL5PtCold/W8esmOn8Kysu++x
 WV5GqlYzrPYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="gz'50?scan'50,208,50";a="422093891"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 Jun 2021 21:18:33 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lu5xh-0002Zv-20; Fri, 18 Jun 2021 04:18:33 +0000
Date:   Fri, 18 Jun 2021 12:17:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     alexandru.tachici@analog.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, robh+dt@kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, petre.minciunescu@analog.com,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: clock: ad9545: Add documentation
Message-ID: <202106181239.KSMga630-lkp@intel.com>
References: <20210614070718.78041-3-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20210614070718.78041-3-alexandru.tachici@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on robh/for-next linux/master linus/master v5.13-rc6 next-20210617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/alexandru-tachici-analog-com/clk-ad9545-Add-support/20210616-153412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: h8300-randconfig-s031-20210618 (attached as .config)
compiler: h8300-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://github.com/0day-ci/linux/commit/b46755cf562ff8a1a9841a4560e344099f3f054e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review alexandru-tachici-analog-com/clk-ad9545-Add-support/20210616-153412
        git checkout b46755cf562ff8a1a9841a4560e344099f3f054e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=h8300 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/clk/adi/clk-ad9545.c:1114:43: sparse: sparse: cast from restricted __le32
>> drivers/clk/adi/clk-ad9545.c:1114:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [addressable] [usertype] regval @@
   drivers/clk/adi/clk-ad9545.c:1114:43: sparse:     expected unsigned int [usertype] val
   drivers/clk/adi/clk-ad9545.c:1114:43: sparse:     got restricted __le32 [addressable] [usertype] regval
   drivers/clk/adi/clk-ad9545.c:1114:43: sparse: sparse: cast from restricted __le32
   drivers/clk/adi/clk-ad9545.c:1114:43: sparse: sparse: cast from restricted __le32
   drivers/clk/adi/clk-ad9545.c:1114:43: sparse: sparse: cast from restricted __le32
   drivers/clk/adi/clk-ad9545.c:1114:43: sparse: sparse: cast from restricted __le32
   drivers/clk/adi/clk-ad9545.c:1114:43: sparse: sparse: restricted __le32 degrades to integer
   drivers/clk/adi/clk-ad9545.c:1407:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] regval @@     got unsigned int freq_lock_fill_rate @@
   drivers/clk/adi/clk-ad9545.c:1407:24: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] regval
   drivers/clk/adi/clk-ad9545.c:1407:24: sparse:     got unsigned int freq_lock_fill_rate
   drivers/clk/adi/clk-ad9545.c:1409:88: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int val @@     got restricted __le32 [addressable] [assigned] [usertype] regval @@
   drivers/clk/adi/clk-ad9545.c:1409:88: sparse:     expected unsigned int val
   drivers/clk/adi/clk-ad9545.c:1409:88: sparse:     got restricted __le32 [addressable] [assigned] [usertype] regval
   drivers/clk/adi/clk-ad9545.c:1414:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] regval @@     got unsigned int freq_lock_drain_rate @@
   drivers/clk/adi/clk-ad9545.c:1414:24: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] regval
   drivers/clk/adi/clk-ad9545.c:1414:24: sparse:     got unsigned int freq_lock_drain_rate
   drivers/clk/adi/clk-ad9545.c:1416:89: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int val @@     got restricted __le32 [addressable] [assigned] [usertype] regval @@
   drivers/clk/adi/clk-ad9545.c:1416:89: sparse:     expected unsigned int val
   drivers/clk/adi/clk-ad9545.c:1416:89: sparse:     got restricted __le32 [addressable] [assigned] [usertype] regval
   drivers/clk/adi/clk-ad9545.c:1421:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] regval @@     got unsigned int phase_lock_fill_rate @@
   drivers/clk/adi/clk-ad9545.c:1421:24: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] regval
   drivers/clk/adi/clk-ad9545.c:1421:24: sparse:     got unsigned int phase_lock_fill_rate
   drivers/clk/adi/clk-ad9545.c:1423:89: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int val @@     got restricted __le32 [addressable] [assigned] [usertype] regval @@
   drivers/clk/adi/clk-ad9545.c:1423:89: sparse:     expected unsigned int val
   drivers/clk/adi/clk-ad9545.c:1423:89: sparse:     got restricted __le32 [addressable] [assigned] [usertype] regval
   drivers/clk/adi/clk-ad9545.c:1428:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] regval @@     got unsigned int phase_lock_drain_rate @@
   drivers/clk/adi/clk-ad9545.c:1428:24: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] regval
   drivers/clk/adi/clk-ad9545.c:1428:24: sparse:     got unsigned int phase_lock_drain_rate
   drivers/clk/adi/clk-ad9545.c:1430:90: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int val @@     got restricted __le32 [addressable] [assigned] [usertype] regval @@
   drivers/clk/adi/clk-ad9545.c:1430:90: sparse:     expected unsigned int val
   drivers/clk/adi/clk-ad9545.c:1430:90: sparse:     got restricted __le32 [addressable] [assigned] [usertype] regval

vim +1114 drivers/clk/adi/clk-ad9545.c

f88d17c990b731 Alexandru Tachici 2021-06-14  1089  
f88d17c990b731 Alexandru Tachici 2021-06-14  1090  static int ad9545_out_clk_get_phase(struct clk_hw *hw)
f88d17c990b731 Alexandru Tachici 2021-06-14  1091  {
f88d17c990b731 Alexandru Tachici 2021-06-14  1092  	struct ad9545_out_clk *clk = to_out_clk(hw);
f88d17c990b731 Alexandru Tachici 2021-06-14  1093  	u64 input_edges_nr;
f88d17c990b731 Alexandru Tachici 2021-06-14  1094  	u64 phase_code;
f88d17c990b731 Alexandru Tachici 2021-06-14  1095  	__le32 regval;
f88d17c990b731 Alexandru Tachici 2021-06-14  1096  	u32 phase_conf;
f88d17c990b731 Alexandru Tachici 2021-06-14  1097  	u32 qdiv;
f88d17c990b731 Alexandru Tachici 2021-06-14  1098  	int ret;
f88d17c990b731 Alexandru Tachici 2021-06-14  1099  
f88d17c990b731 Alexandru Tachici 2021-06-14  1100  	ret = ad9545_get_q_div(clk->st, clk->address, &qdiv);
f88d17c990b731 Alexandru Tachici 2021-06-14  1101  	if (ret < 0)
f88d17c990b731 Alexandru Tachici 2021-06-14  1102  		return ret;
f88d17c990b731 Alexandru Tachici 2021-06-14  1103  
f88d17c990b731 Alexandru Tachici 2021-06-14  1104  	ret = regmap_read(clk->st->regmap, AD9545_QX_PHASE_CONF(clk->address), &phase_conf);
f88d17c990b731 Alexandru Tachici 2021-06-14  1105  	if (ret < 0)
f88d17c990b731 Alexandru Tachici 2021-06-14  1106  		return ret;
f88d17c990b731 Alexandru Tachici 2021-06-14  1107  
f88d17c990b731 Alexandru Tachici 2021-06-14  1108  	ret = regmap_bulk_read(clk->st->regmap, AD9545_QX_PHASE(clk->address), &regval, 4);
f88d17c990b731 Alexandru Tachici 2021-06-14  1109  	if (ret < 0)
f88d17c990b731 Alexandru Tachici 2021-06-14  1110  		return ret;
f88d17c990b731 Alexandru Tachici 2021-06-14  1111  
f88d17c990b731 Alexandru Tachici 2021-06-14  1112  	/* Qxy phase bitfield is 33 bits long, with last bit in PHASE_CONF reg */
f88d17c990b731 Alexandru Tachici 2021-06-14  1113  	phase_code = !!(phase_conf & AD9545_QX_PHASE_32_MSK);
f88d17c990b731 Alexandru Tachici 2021-06-14 @1114  	phase_code = (phase_code >> 32) + cpu_to_le32(regval);
f88d17c990b731 Alexandru Tachici 2021-06-14  1115  
f88d17c990b731 Alexandru Tachici 2021-06-14  1116  	input_edges_nr = 2 * qdiv + !!(phase_conf & AD9545_QX_HALF_DIV_MSK);
f88d17c990b731 Alexandru Tachici 2021-06-14  1117  
f88d17c990b731 Alexandru Tachici 2021-06-14  1118  	/*
f88d17c990b731 Alexandru Tachici 2021-06-14  1119  	 * phase = 360 * (Qxy Phase / E) where:
f88d17c990b731 Alexandru Tachici 2021-06-14  1120  	 * E is the total number of input edges per output period of the Q-divider.
f88d17c990b731 Alexandru Tachici 2021-06-14  1121  	 */
f88d17c990b731 Alexandru Tachici 2021-06-14  1122  	return div64_u64(phase_code * 360, input_edges_nr);
f88d17c990b731 Alexandru Tachici 2021-06-14  1123  }
f88d17c990b731 Alexandru Tachici 2021-06-14  1124  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--4Ckj6UjgE2iN1+kY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--4Ckj6UjgE2iN1+kY--
