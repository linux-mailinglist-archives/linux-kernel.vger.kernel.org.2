Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0143FAB76
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 14:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbhH2MpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 08:45:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:49608 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235334AbhH2Mo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:44:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10090"; a="217874546"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="217874546"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 05:44:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="529825929"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2021 05:43:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4B60EDE; Sun, 29 Aug 2021 15:44:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] pvpanic: Fix typos in the comments
Date:   Sun, 29 Aug 2021 15:43:53 +0300
Message-Id: <20210829124354.81653-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210829124354.81653-1-andriy.shevchenko@linux.intel.com>
References: <20210829124354.81653-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few spelling typos in the comments.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/pvpanic/pvpanic-mmio.c | 2 +-
 drivers/misc/pvpanic/pvpanic.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index be4016084979..61dbff5f0065 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -100,7 +100,7 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 	pi->base = base;
 	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
 
-	/* initlize capability by RDPT */
+	/* initialize capability by RDPT */
 	pi->capability &= ioread8(base);
 	pi->events = pi->capability;
 
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index fb5411dfd614..254d35efb0b7 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -58,7 +58,7 @@ pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
 
 static struct notifier_block pvpanic_panic_nb = {
 	.notifier_call = pvpanic_panic_notify,
-	.priority = 1, /* let this called before broken drm_fb_helper */
+	.priority = 1, /* let this called before broken drm_fb_helper() */
 };
 
 static void pvpanic_remove(void *param)
-- 
2.33.0

