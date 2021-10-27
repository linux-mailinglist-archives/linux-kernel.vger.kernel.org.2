Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A035543CCF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbhJ0PHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:07:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:27864 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235373AbhJ0PHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:07:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="253733464"
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="253733464"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 08:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,187,1631602800"; 
   d="scan'208";a="447580758"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 27 Oct 2021 08:04:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 80016107; Wed, 27 Oct 2021 18:04:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] sbitmap: Replace kernel.h with the necessary inclusions
Date:   Wed, 27 Oct 2021 18:04:37 +0300
Message-Id: <20211027150437.79921-1-andriy.shevchenko@linux.intel.com>
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
 include/linux/sbitmap.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 4a6ff274335a..fc0357a6e19b 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -9,8 +9,17 @@
 #ifndef __LINUX_SCALE_BITMAP_H
 #define __LINUX_SCALE_BITMAP_H
 
-#include <linux/kernel.h>
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/cache.h>
+#include <linux/list.h>
+#include <linux/log2.h>
+#include <linux/minmax.h>
+#include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+#include <linux/wait.h>
 
 struct seq_file;
 
-- 
2.33.0

