Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6013D4987
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 21:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGXSxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 14:53:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:20956 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhGXSxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:53:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10055"; a="273142219"
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="scan'208";a="273142219"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2021 12:34:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="scan'208";a="472798807"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2021 12:34:19 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m7NPf-0003jR-5g; Sat, 24 Jul 2021 19:34:19 +0000
Date:   Sun, 25 Jul 2021 03:33:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, Larry.Finger@lwfinger.net,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, fabioaiuto83@gmail.com
Subject: Re: [PATCH v3 4/7] staging: r8188eu: introduce new os_dep dir for
 RTL8188eu driver
Message-ID: <202107250343.7ZGG76Q3-lkp@intel.com>
References: <20210724001055.1613840-5-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724001055.1613840-5-phil@philpotter.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Phillip-Potter/staging-rtl8188eu-replace-driver-with-better-version/20210724-081451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git f133717efc6f28052667daf682e99ffd4b3d7588
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> drivers/staging/r8188eu/os_dep/os_intfs.c: linux/version.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
