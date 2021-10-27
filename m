Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D4043CCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhJ0PGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:06:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:38582 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbhJ0PGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:06:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="293641261"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="293641261"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 08:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="465757963"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 27 Oct 2021 08:03:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 95912107; Wed, 27 Oct 2021 18:03:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] delay: Replace kernel.h with the necessary inclusions
Date:   Wed, 27 Oct 2021 18:03:24 +0300
Message-Id: <20211027150324.79827-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/delay.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index 1d0e2ce6b6d9..8eacf67eb212 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -19,7 +19,7 @@
  *   https://lists.openwall.net/linux-kernel/2011/01/09/56
  */
 
-#include <linux/kernel.h>
+#include <linux/math.h>
 
 extern unsigned long loops_per_jiffy;
 
-- 
2.33.0

