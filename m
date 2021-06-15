Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414663A74E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFODTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:19:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:14782 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhFODTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:19:24 -0400
IronPort-SDR: pTqv5eVJDgwHO1ZWtKU0xqM2AZJPqjw3cehDiuSF7LhhEq+Eyvdf7A9z7hXFc1LKobELBHgSV4
 pfT9E5TWAMaw==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="202879192"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="202879192"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 18:08:57 -0700
IronPort-SDR: m8YrB9Yd4usLrMSp/h4lqUHwCbGVQo7pLituvmU1gNRLs8LagHH5JCFvkOw23mRlA4Jsrwgnrq
 Gp1VlLZVuD1g==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="450065067"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 18:08:55 -0700
Date:   Tue, 15 Jun 2021 09:08:53 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [tip:tmp.tmp2 302/364] drivers/video/backlight/rave-sp-backlight.c:
 linux/backlight.h is included more than once.
Message-ID: <20210615010853.GM237458@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.tmp2
head:   adcceb5eb7aee38e4a9c15bdf599655f0e1b1324
commit: 3fb8658426ac271948eb757e1c5a5554afdc5cf8 [302/364] sched/headers, fb: Simplify <linux/fb.h> dependencies
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> drivers/video/backlight/rave-sp-backlight.c: linux/backlight.h is included more than once.
--
>> drivers/video/backlight/lm3639_bl.c: linux/backlight.h is included more than once.
--
>> drivers/video/backlight/kb3886_bl.c: linux/backlight.h is included more than once.
--
>> drivers/video/backlight/da9052_bl.c: linux/backlight.h is included more than once.
--
>> drivers/video/backlight/cr_bllcd.c: linux/backlight.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
