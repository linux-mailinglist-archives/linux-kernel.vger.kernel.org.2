Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED187351C34
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbhDASOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:14:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:34866 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235803AbhDAR4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:56:18 -0400
IronPort-SDR: LezfKTgV+UkteARxcT1eG4rH75BH75bB0ifGdUIWOmyU3ZUAXHO7L+0QKtQatl3TSohWPyxAYK
 +gqzYyGcXy7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179424672"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179424672"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 10:10:34 -0700
IronPort-SDR: SVhoU0UJ3fGdFEExd7oMY1yGfar2OZXN9zrbheP5uk6xYw/NnQku2SewxDS+I+mddHxtOXFp+g
 wly6/fHY4nlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="607674069"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 01 Apr 2021 10:10:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 189B0A1; Thu,  1 Apr 2021 20:10:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] driver core: Replace printf() specifier and drop unneeded casting
Date:   Thu,  1 Apr 2021 20:10:42 +0300
Message-Id: <20210401171042.60612-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size_t type has very well established specifier, i.e. "%zu",
use it directly instead of casting to unsigned long with "%lu".

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/devres.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index fb9d5289a620..fa2cdb250af4 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -58,8 +58,8 @@ static void devres_log(struct device *dev, struct devres_node *node,
 		       const char *op)
 {
 	if (unlikely(log_devres))
-		dev_err(dev, "DEVRES %3s %p %s (%lu bytes)\n",
-			op, node, node->name, (unsigned long)node->size);
+		dev_err(dev, "DEVRES %3s %p %s (%zu bytes)\n",
+			op, node, node->name, node->size);
 }
 #else /* CONFIG_DEBUG_DEVRES */
 #define set_node_dbginfo(node, n, s)	do {} while (0)
-- 
2.30.2

