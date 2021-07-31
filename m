Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67D03DC5E5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 14:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhGaMTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 08:19:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:43886 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232182AbhGaMTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 08:19:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="200406262"
X-IronPort-AV: E=Sophos;i="5.84,284,1620716400"; 
   d="scan'208";a="200406262"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2021 05:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,284,1620716400"; 
   d="scan'208";a="665454386"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jul 2021 05:19:31 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9nxi-000B7z-C6; Sat, 31 Jul 2021 12:19:30 +0000
Date:   Sat, 31 Jul 2021 20:18:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev
Subject: [staging:staging-next 160/164]
 drivers/staging/r8188eu/os_dep/ioctl_linux.c: ../include/rtw_android.h is
 included more than once.
Message-ID: <202107312004.g8f9buXX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git staging-next
head:   9b6818c1ac0e545c632265e4bf0aa1171347ebea
commit: 78f2b22efc8f7649dcde44143e78149457f1162c [160/164] staging: r8188eu: fix include directory mess
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> drivers/staging/r8188eu/os_dep/ioctl_linux.c: ../include/rtw_android.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
