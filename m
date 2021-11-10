Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6E44BEB8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhKJKeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:34:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:28167 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhKJKeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:34:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="219539732"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="219539732"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 02:31:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="492045682"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 10 Nov 2021 02:31:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 487C2155; Wed, 10 Nov 2021 12:31:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] kobject: Replace kernel.h with the necessary inclusions
Date:   Wed, 10 Nov 2021 12:31:28 +0200
Message-Id: <20211110103128.59888-1-andriy.shevchenko@linux.intel.com>
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
 include/linux/kobject.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index efd56f990a46..c740062b4b1a 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -19,10 +19,10 @@
 #include <linux/list.h>
 #include <linux/sysfs.h>
 #include <linux/compiler.h>
+#include <linux/container_of.h>
 #include <linux/spinlock.h>
 #include <linux/kref.h>
 #include <linux/kobject_ns.h>
-#include <linux/kernel.h>
 #include <linux/wait.h>
 #include <linux/atomic.h>
 #include <linux/workqueue.h>
-- 
2.33.0

