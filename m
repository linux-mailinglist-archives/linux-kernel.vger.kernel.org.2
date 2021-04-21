Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84169366380
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 04:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhDUCAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 22:00:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:19857 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233824AbhDUCAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 22:00:52 -0400
IronPort-SDR: tdS/cSRNhGbdFsSULr8cGDbvr6+0tuGv8gpNx+rYq+uJkrDPUQhkPsoZsZX62BBwohf+bp9V2C
 SYlst71zxSaA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="195739744"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="195739744"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 19:00:20 -0700
IronPort-SDR: tJV3RL6KxakuAgLIKV+4KnRAsHZyatVMmdDHV4Yp4WwVekPBjPbXWR7NDyBiXEK0EsMiACuyfM
 VXoByN+/KR1Q==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="427328411"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 19:00:18 -0700
Date:   Wed, 21 Apr 2021 09:59:18 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Subject: drivers/power/supply/bq256xx_charger.c:346:12: warning: Identical
 inner 'if' condition is always true. [identicalInnerCondition]
Message-ID: <20210421015918.GM1780177@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7af08140979a6e7e12b78c93b8625c8d25b084e2
commit: 32e4978bb920d047fe5de3ea42d176f267c01f63 power: supply: bq256xx: Introduce the BQ256XX charger driver
date:   3 months ago
compiler: mips64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/power/supply/bq256xx_charger.c:346:12: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
      if (val < array[i])
              ^
   drivers/power/supply/bq256xx_charger.c:345:33: note: outer condition: val<array[i]
     if (val > array[i - 1] && val < array[i]) {
                                   ^
   drivers/power/supply/bq256xx_charger.c:346:12: note: identical inner condition: val<array[i]
      if (val < array[i])
              ^

vim +/if +346 drivers/power/supply/bq256xx_charger.c

32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  330  
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  331  static int bq256xx_array_parse(int array_size, int val, const int array[])
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  332  {
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  333  	int i = 0;
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  334  
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  335  	if (val < array[i])
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  336  		return i - 1;
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  337  
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  338  	if (val >= array[array_size - 1])
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  339  		return array_size - 1;
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  340  
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  341  	for (i = 1; i < array_size; i++) {
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  342  		if (val == array[i])
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  343  			return i;
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  344  
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  345  		if (val > array[i - 1] && val < array[i]) {
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06 @346  			if (val < array[i])
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  347  				return i - 1;
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  348  			else
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  349  				return i;
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  350  		}
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  351  	}
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  352  	return -EINVAL;
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  353  }
32e4978bb920d0 Ricardo Rivera-Matos 2021-01-06  354  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
