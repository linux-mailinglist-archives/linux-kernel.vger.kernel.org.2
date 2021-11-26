Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E99145E9B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359726AbhKZI7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:59:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:47244 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243536AbhKZI5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:57:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="321866794"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="321866794"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 00:54:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="741486503"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2021 00:54:21 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqWzt-0007rh-0M; Fri, 26 Nov 2021 08:54:21 +0000
Date:   Fri, 26 Nov 2021 16:54:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zoeb Mithaiwala <zoebm@google.com>, trivial@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Zoeb Mithaiwala <zoebm@google.com>
Subject: Re: [PATCH] Staging: rtl8712: rtl871x_security: fixed a camel case
 variable name coding style issue
Message-ID: <202111261635.wXZz1PMT-lkp@intel.com>
References: <20211120080658.1070907-1-zoebm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120080658.1070907-1-zoebm@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zoeb,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Zoeb-Mithaiwala/Staging-rtl8712-rtl871x_security-fixed-a-camel-case-variable-name-coding-style-issue/20211120-160918
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 1189d2fb15a4b09b2e8dd01d60a0817d985d933d
config: m68k-randconfig-r026-20211121 (https://download.01.org/0day-ci/archive/20211126/202111261635.wXZz1PMT-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8c1ab61206da180488d1d32547a73288052736cd
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Zoeb-Mithaiwala/Staging-rtl8712-rtl871x_security-fixed-a-camel-case-variable-name-coding-style-issue/20211120-160918
        git checkout 8c1ab61206da180488d1d32547a73288052736cd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/staging/rtl8712/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/staging/rtl8712/rtl871x_security.c: In function 'secmicappendbyte':
>> drivers/staging/rtl8712/rtl871x_security.c:288:51: error: 'struct mic_data' has no member named 'n_bytes_in_m'; did you mean 'nbytes_in_m'?
     288 |         pmicdata->M |= ((u32)b) << (8 * pmicdata->n_bytes_in_m);
         |                                                   ^~~~~~~~~~~~
         |                                                   nbytes_in_m


vim +288 drivers/staging/rtl8712/rtl871x_security.c

   284	
   285	static void secmicappendbyte(struct mic_data *pmicdata, u8 b)
   286	{
   287		/* Append the byte to our word-sized buffer */
 > 288		pmicdata->M |= ((u32)b) << (8 * pmicdata->n_bytes_in_m);
   289		pmicdata->nbytes_in_m++;
   290		/* Process the word if it is full. */
   291		if (pmicdata->nbytes_in_m >= 4) {
   292			pmicdata->L ^= pmicdata->M;
   293			pmicdata->R ^= ROL32(pmicdata->L, 17);
   294			pmicdata->L += pmicdata->R;
   295			pmicdata->R ^= ((pmicdata->L & 0xff00ff00) >> 8) |
   296				       ((pmicdata->L & 0x00ff00ff) << 8);
   297			pmicdata->L += pmicdata->R;
   298			pmicdata->R ^= ROL32(pmicdata->L, 3);
   299			pmicdata->L += pmicdata->R;
   300			pmicdata->R ^= ROR32(pmicdata->L, 2);
   301			pmicdata->L += pmicdata->R;
   302			/* Clear the buffer */
   303			pmicdata->M = 0;
   304			pmicdata->nbytes_in_m = 0;
   305		}
   306	}
   307	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
