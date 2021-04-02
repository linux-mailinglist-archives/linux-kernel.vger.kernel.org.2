Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836E2352EA2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhDBRnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:43:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:20606 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235657AbhDBRn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:43:29 -0400
IronPort-SDR: s3T7MkIxLv49qaI7TmTQk1Xs/rGDn+GuHQO3qwhvUgKRWqvwCqiMxqIpifcGwmoUhGltv+9A5K
 uT2PrEnCe00A==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="256488265"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="256488265"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 10:43:25 -0700
IronPort-SDR: R3DMuhPkLfJbrnF3VglYYveAnNMX+QV3ajIGIJfwkUA/PicU4u4WeYPrjxfEOoHDnlDI9707mE
 2Zhgl/t/7FKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="596812981"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 02 Apr 2021 10:43:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 70C5522B; Fri,  2 Apr 2021 20:43:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Corey Minyard <cminyard@mvista.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 00/10] ipmi_si: Set of clean ups
Date:   Fri,  2 Apr 2021 20:43:24 +0300
Message-Id: <20210402174334.13466-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series contains set of clean ups, main parts of which are:
 - use ne platform_get_mem_or_io() API
 - use match_string() API

Since v2:
- patch 3: rephrased commit message (Corey)
- patch 5: added a comment that array maps to enum (Corey)
- patch 5: added "ipmi" prefix to the name of the array
- patch 6: just exported array w/o moving to header (Corey)
- wrapped up cover letter

Andy Shevchenko (10):
  ipmi_si: Switch to use platform_get_mem_or_io()
  ipmi_si: Remove bogus err_free label
  ipmi_si: Utilize temporary variable to hold device pointer
  ipmi_si: Use proper ACPI macros to check error code for failures
  ipmi_si: Introduce ipmi_panic_event_str[] array
  ipmi_si: Reuse si_to_str[] array in ipmi_hardcode_init_one()
  ipmi_si: Get rid of ->addr_source_cleanup()
  ipmi_si: Use strstrip() to remove surrounding spaces
  ipmi_si: Drop redundant check before calling put_device()
  ipmi_si: Join string literals back

 drivers/char/ipmi/ipmi_msghandler.c  | 54 ++++++----------
 drivers/char/ipmi/ipmi_si.h          |  8 ++-
 drivers/char/ipmi/ipmi_si_hardcode.c | 73 ++++++++-------------
 drivers/char/ipmi/ipmi_si_hotmod.c   | 24 ++-----
 drivers/char/ipmi/ipmi_si_intf.c     | 32 ++++------
 drivers/char/ipmi/ipmi_si_pci.c      | 22 ++-----
 drivers/char/ipmi/ipmi_si_platform.c | 95 ++++++++++++----------------
 7 files changed, 112 insertions(+), 196 deletions(-)

-- 
2.30.2

