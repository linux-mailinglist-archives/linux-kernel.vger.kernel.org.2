Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF8B45DE5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356409AbhKYQNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:13:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:42456 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356411AbhKYQLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:11:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="321770171"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="321770171"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 08:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="741789414"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 25 Nov 2021 08:07:42 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqHHh-0006c1-MF; Thu, 25 Nov 2021 16:07:41 +0000
Date:   Fri, 26 Nov 2021 00:06:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap-20211125 9/11] drivers/cpufreq/pcc-cpufreq.c:596:6:
 error: implicit declaration of function 'num_present_cpus_ge'; did you mean
 'num_present_cpus_gt'?
Message-ID: <202111252347.HKeTRtV5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-20211125
head:   e3a9cfe4830141c88aa5d8a93eae3512b2ae2882
commit: 9a237acabf8c32b395723ad4a1642201573e6ed1 [9/11] lib/cpumask: introduce num_possible_cpus_{eq,gt,le}
config: i386-debian-10.3 (https://download.01.org/0day-ci/archive/20211125/202111252347.HKeTRtV5-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/norov/linux/commit/9a237acabf8c32b395723ad4a1642201573e6ed1
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-20211125
        git checkout 9a237acabf8c32b395723ad4a1642201573e6ed1
        # save the config file to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/cpufreq/pcc-cpufreq.c: In function 'pcc_cpufreq_init':
>> drivers/cpufreq/pcc-cpufreq.c:596:6: error: implicit declaration of function 'num_present_cpus_ge'; did you mean 'num_present_cpus_gt'? [-Werror=implicit-function-declaration]
     596 |  if (num_present_cpus_ge(4)) {
         |      ^~~~~~~~~~~~~~~~~~~
         |      num_present_cpus_gt
   cc1: some warnings being treated as errors


vim +596 drivers/cpufreq/pcc-cpufreq.c

   578	
   579	static int __init pcc_cpufreq_init(void)
   580	{
   581		int ret;
   582	
   583		/* Skip initialization if another cpufreq driver is there. */
   584		if (cpufreq_get_current_driver())
   585			return -EEXIST;
   586	
   587		if (acpi_disabled)
   588			return -ENODEV;
   589	
   590		ret = pcc_cpufreq_probe();
   591		if (ret) {
   592			pr_debug("pcc_cpufreq_init: PCCH evaluation failed\n");
   593			return ret;
   594		}
   595	
 > 596		if (num_present_cpus_ge(4)) {
   597			pcc_cpufreq_driver.flags |= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING;
   598			pr_err("%s: Too many CPUs, dynamic performance scaling disabled\n",
   599			       __func__);
   600			pr_err("%s: Try to enable another scaling driver through BIOS settings\n",
   601			       __func__);
   602			pr_err("%s: and complain to the system vendor\n", __func__);
   603		}
   604	
   605		ret = cpufreq_register_driver(&pcc_cpufreq_driver);
   606	
   607		return ret;
   608	}
   609	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
