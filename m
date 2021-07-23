Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0B23D3ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhGWQxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:53:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:14485 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhGWQxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:53:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="297494713"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="297494713"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 10:34:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="660272184"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2021 10:34:03 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m6z3j-00028S-2D; Fri, 23 Jul 2021 17:34:03 +0000
Date:   Sat, 24 Jul 2021 01:33:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, Larry.Finger@lwfinger.net,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, fabioaiuto83@gmail.com
Subject: Re: [PATCH 4/7] staging: rtl8188eu: introduce new os_dep dir for
 RTL8188eu driver
Message-ID: <202107240158.eu1Bu0i9-lkp@intel.com>
References: <20210723004214.912295-5-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723004214.912295-5-phil@philpotter.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Phillip-Potter/staging-rtl8188eu-replace-driver-with-better-version/20210723-084513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 334201d503d5903f38f6e804263fc291ce8f451a
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> drivers/staging/rtl8188eu/os_dep/rtw_proc.c: ../../hal/hal_halmac.h is included more than once.
--
>> drivers/staging/rtl8188eu/os_dep/rtw_cfgvendor.c: linux/kernel.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
