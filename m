Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AF43E2E02
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244912AbhHFP4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:56:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:24998 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244887AbhHFP4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:56:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="214124008"
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="214124008"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 08:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="420763857"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 06 Aug 2021 08:55:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D8E23DE; Fri,  6 Aug 2021 18:49:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86/intel: int33fe: Use y instead of objs in Makefile
Date:   Fri,  6 Aug 2021 18:49:41 +0300
Message-Id: <20210806154941.4491-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'objs' is for user space tools, for the kernel modules
we should use 'y'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/int33fe/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/int33fe/Makefile b/drivers/platform/x86/intel/int33fe/Makefile
index cc11183ce179..9456e3b37f6f 100644
--- a/drivers/platform/x86/intel/int33fe/Makefile
+++ b/drivers/platform/x86/intel/int33fe/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_INTEL_CHT_INT33FE)		+= intel_cht_int33fe.o
-intel_cht_int33fe-objs			:= intel_cht_int33fe_common.o \
+intel_cht_int33fe-y			:= intel_cht_int33fe_common.o \
 					   intel_cht_int33fe_typec.o \
 					   intel_cht_int33fe_microb.o
-- 
2.30.2

