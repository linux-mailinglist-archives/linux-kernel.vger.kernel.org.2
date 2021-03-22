Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D434400F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhCVLne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhCVLnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:43:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E26626198E;
        Mon, 22 Mar 2021 11:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616413382;
        bh=qMzyLTwRsQxqow8tyY07YBmgakAUL8J9tbwkqHUTAwI=;
        h=From:To:Cc:Subject:Date:From;
        b=MEwKWV7AE6r+0okmaK1sxlMUYzEw1NY7I/zVC2pSN3eX9ChtxaWxlhfUZqxVCyPFg
         bsbOc18YCLba9W33XGCUWAUT6MKnUMuxldA1QgoydBUEEqv3rdDla51f2vAWO7vreR
         JtPhCeJcYg4azaMlsVWfLmUuu8bJCzSDducDWAwEYuNnRTjc4ePDfVifBFH0iYPYGp
         KN2/K3xImJGhLYUgPbhcQ0m5ia1QO0ecybjR1HH7reXFahgvzexGurOvR6VfCbD5Ui
         PntjG7WfDuK0PneE2P6Znqc2MMf4U9od1aLWcXPSwm4EfA5nFovxBHSfaLdXuDzvb5
         wQnNrF7xsC7LQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] devcoredump: avoid -Wempty-body warnings
Date:   Mon, 22 Mar 2021 12:42:51 +0100
Message-Id: <20210322114258.3420937-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Cleaning out the last -Wempty-body warnings found some interesting
cases with empty macros, along with harmless warnings like this one:

drivers/base/devcoredump.c: In function 'dev_coredumpm':
drivers/base/devcoredump.c:297:56: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  297 |                 /* nothing - symlink will be missing */;
      |                                                        ^
drivers/base/devcoredump.c:301:56: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  301 |                 /* nothing - symlink will be missing */;
      |                                                        ^

Randy tried addressing this one before, and there were multiple
other ideas in that thread.

Add a runtime warning and code comment here.

Link: https://lore.kernel.org/lkml/20200418184111.13401-8-rdunlap@infradead.org/
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/base/devcoredump.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 9243468e2c99..352de5d41466 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -292,13 +292,16 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
+	/*
+	 * These should normally not fail, but there is no problem
+	 * continuing without the links, so just warn instead of
+	 * failing.
+	 */
 	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
-			      "failing_device"))
-		/* nothing - symlink will be missing */;
-
-	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
-			      "devcoredump"))
-		/* nothing - symlink will be missing */;
+			      "failing_device") ||
+	    sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
+		              "devcoredump"))
+		dev_warn(dev, "devcoredump create_link failed\n");
 
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
-- 
2.29.2

