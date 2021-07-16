Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AAA3CB4F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbhGPJEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:04:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:11753 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239728AbhGPJEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:04:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="190382236"
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="190382236"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 02:01:40 -0700
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="495985905"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.42]) ([10.255.28.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 02:01:38 -0700
Subject: Re: [PATCH v2 6/7] soc: mediatek: mmsys: Add reset controller support
References: <202107150857.sniQJ86e-lkp@intel.com>
In-Reply-To: <202107150857.sniQJ86e-lkp@intel.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     chunkuang.hu@kernel.org, hsinyi@chromium.org, kernel@collabora.com,
        drinkcat@chromium.org, eizan@chromium.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, Philipp Zabel <p.zabel@pengutronix.de>,
        kbuild-all@lists.01.org
From:   kernel test robot <rong.a.chen@intel.com>
X-Forwarded-Message-Id: <202107150857.sniQJ86e-lkp@intel.com>
Message-ID: <baf4a35e-8025-460c-85b6-214ad23d7b89@intel.com>
Date:   Fri, 16 Jul 2021 17:01:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Enric,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on pza/reset/next linux/master linus/master 
v5.14-rc1 next-20210714]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url: 
https://github.com/0day-ci/linux/commits/Enric-Balletbo-i-Serra/Add-support-to-the-mmsys-driver-to-be-a-reset-controller/20210714-181318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git 
for-next
compiler: riscv64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/soc/mediatek/mtk-mmsys.c:104:6: warning: Unused variable: i [unusedVariable]
     int i;
         ^

vim +104 drivers/soc/mediatek/mtk-mmsys.c

2c758e301ed95a Enric Balletbo i Serra 2020-03-25   97  08a3068f9490f0 
Enric Balletbo i Serra 2021-07-14   98  static int 
mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned long id,
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14   99  				  bool assert)
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  100  {
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  101  	struct mtk_mmsys 
*mmsys = container_of(rcdev, struct mtk_mmsys, rcdev);
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  102  	unsigned long flags;
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  103  	u32 reg;
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14 @104  	int i;
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  105  08a3068f9490f0 
Enric Balletbo i Serra 2021-07-14  106  	spin_lock_irqsave(&mmsys->lock, 
flags);
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  107  08a3068f9490f0 
Enric Balletbo i Serra 2021-07-14  108  	reg = readl_relaxed(mmsys->regs 
+ MMSYS_SW0_RST_B);
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  109  08a3068f9490f0 
Enric Balletbo i Serra 2021-07-14  110  	if (assert)
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  111  		reg &= ~BIT(id);
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  112  	else
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  113  		reg |= BIT(id);
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  114  08a3068f9490f0 
Enric Balletbo i Serra 2021-07-14  115  	writel_relaxed(reg, mmsys->regs 
+ MMSYS_SW0_RST_B);
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  116  08a3068f9490f0 
Enric Balletbo i Serra 2021-07-14  117 
spin_unlock_irqrestore(&mmsys->lock, flags);
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  118  08a3068f9490f0 
Enric Balletbo i Serra 2021-07-14  119  	return 0;
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  120  }
08a3068f9490f0 Enric Balletbo i Serra 2021-07-14  121
---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

