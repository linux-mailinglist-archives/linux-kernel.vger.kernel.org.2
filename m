Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D346C3A074C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhFHWvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:51:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:50704 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhFHWvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:51:16 -0400
IronPort-SDR: 3f3pJCmTvMGEH91nb/CqLCEB7JN23rTeTEWAVw/88+6vDWS/g844aAnnp4656uz0tv148y0qoi
 wI8XGU6gaQcQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="226322659"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="gz'50?scan'50,208,50";a="226322659"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 15:49:20 -0700
IronPort-SDR: d8rgP13xVI6FK80Dpjsl7cPis21XqPo4ufGaRvBzPjYH71/SqFtXT4Av//XWHA/d9+tCEW9GZ+
 QJdX0kXg+o3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="gz'50?scan'50,208,50";a="619468827"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2021 15:49:17 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lqkX7-0009Fa-9G; Tue, 08 Jun 2021 22:49:17 +0000
Date:   Wed, 9 Jun 2021 06:49:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Robert Marko <robert.marko@sartura.hr>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
Message-ID: <202106090617.01ImG4mc-lkp@intel.com>
References: <20210608190327.22071-2-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20210608190327.22071-2-vadym.kochan@plvision.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Vadym,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linux/master linus/master v5.13-rc5 next-20210608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Vadym-Kochan/nvmem-add-ONIE-NVMEM-cells-parser/20210609-031008
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e7cd03f23c4980914d9de330fd018cb733f84d8f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Vadym-Kochan/nvmem-add-ONIE-NVMEM-cells-parser/20210609-031008
        git checkout e7cd03f23c4980914d9de330fd018cb733f84d8f
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/rtc.h:18,
                    from arch/powerpc/kernel/time.c:47:
   include/linux/nvmem-provider.h: In function 'nvmem_parser_register':
>> include/linux/nvmem-provider.h:183:9: error: returning 'int' from a function with return type 'struct nvmem_parser *' makes pointer from integer without a cast [-Werror=int-conversion]
     183 |  return -EOPNOTSUPP;
         |         ^
   cc1: all warnings being treated as errors


vim +183 include/linux/nvmem-provider.h

   179	
   180	static inline struct nvmem_parser *
   181	nvmem_parser_register(const struct nvmem_parser_config *config)
   182	{
 > 183		return -EOPNOTSUPP;
   184	}
   185	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--4Ckj6UjgE2iN1+kY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/w+Jd0PT12QAAA==

--4Ckj6UjgE2iN1+kY--
