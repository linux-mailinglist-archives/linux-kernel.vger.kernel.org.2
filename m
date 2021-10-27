Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A0943CCFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbhJ0PIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:08:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:6512 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235373AbhJ0PIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:08:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="210960603"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="210960603"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 08:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="579689409"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 27 Oct 2021 08:05:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 20242107; Wed, 27 Oct 2021 18:05:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] radix-tree: Replace kernel.h with the necessary inclusions
Date:   Wed, 27 Oct 2021 18:05:28 +0300
Message-Id: <20211027150528.80003-1-andriy.shevchenko@linux.intel.com>
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
 include/linux/radix-tree.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 64ad900ac742..f7c1d21c2f39 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -9,8 +9,10 @@
 #define _LINUX_RADIX_TREE_H
 
 #include <linux/bitops.h>
-#include <linux/kernel.h>
+#include <linux/gfp.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
+#include <linux/math.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/rcupdate.h>
-- 
2.33.0

