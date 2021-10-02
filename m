Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A989D41FA27
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 08:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbhJBGqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 02:46:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:62737 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232355AbhJBGqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 02:46:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="223759862"
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; 
   d="scan'208";a="223759862"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 23:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; 
   d="scan'208";a="709234814"
Received: from lkp-server01.sh.intel.com (HELO 72c3bd3cf19c) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Oct 2021 23:44:14 -0700
Received: from kbuild by 72c3bd3cf19c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mWYko-00024d-0v; Sat, 02 Oct 2021 06:44:14 +0000
Date:   Sat, 2 Oct 2021 14:43:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [intel-tdx:guest 70/126] arch/x86/kernel/cc_platform.c: asm/tdx.h is
 included more than once.
Message-ID: <202110021453.x1teJzru-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest
head:   00e7708dd946e76b7a5e973162ae71111ca32aea
commit: 6a67679c8809382f3bb97bd485c6e99e424543f2 [70/126] x86/tdx: Add device filter support for x86 TDX guest platform
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cc_platform.c: asm/tdx.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
