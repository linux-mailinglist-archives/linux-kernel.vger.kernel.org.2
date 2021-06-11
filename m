Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA40E3A48EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhFKTBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:01:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:16805 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhFKTBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:01:00 -0400
IronPort-SDR: 6X1TK3KC8JQ2nt7FfUnNBQeni39GB01/a5dOdN3ae9/G6cipYS25+PkZxIDUqCZOgJ6zVFVeAl
 ZIGNbL000m0A==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="291219749"
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="291219749"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 11:59:02 -0700
IronPort-SDR: qQyGgt69KQ3qHDIa2X5z78SMNDTjeltjUCTdkERe+tF0bI3iNEi8IUciWBdDRxk3wvp5hmcYnH
 EReNimOumyuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,267,1616482800"; 
   d="scan'208";a="486683469"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2021 11:59:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EC23CE7; Fri, 11 Jun 2021 21:59:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/1] drm: Include only needed headers in ascii85.h
Date:   Fri, 11 Jun 2021 21:59:15 +0300
Message-Id: <20210611185915.44181-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ascii85.h is user of exactly two headers, i.e. math.h and types.h.
There is no need to carry on entire kernel.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/ascii85.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ascii85.h b/include/linux/ascii85.h
index 4cc40201273e..83ad775ad0aa 100644
--- a/include/linux/ascii85.h
+++ b/include/linux/ascii85.h
@@ -8,7 +8,8 @@
 #ifndef _ASCII85_H_
 #define _ASCII85_H_
 
-#include <linux/kernel.h>
+#include <linux/math.h>
+#include <linux/types.h>
 
 #define ASCII85_BUFSZ 6
 
-- 
2.30.2

