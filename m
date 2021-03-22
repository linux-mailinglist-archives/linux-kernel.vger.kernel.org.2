Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53ACD343DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCVKUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhCVKUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:20:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A5D56197F;
        Mon, 22 Mar 2021 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616408407;
        bh=xUPvoccOHTqaMWLwk7M/QzM3U8CIOa5zv4qejCYM16A=;
        h=From:To:Cc:Subject:Date:From;
        b=Y2iAO8QMhT5MnhRvYEnLa8p9FndyFg3/Y938bWLCYBay+4xlNQ7+CVqi4BCtSyDBY
         lfvFRpadkBQgcW4wcV2mJVQNHGY60bpUn16Q5HE/80KY/UpzC64SVE3Nht2SdWboI3
         TBeMNMaYTZDaE7t15vCrMLATEmEruSLnb7LDRXIlqcksFWyfi1Br5a0f/ZhejAIisg
         YJmXQ94BTwePUTKx4yH8l3mA0tIM1hZiFV8q36fcvYPuHaAKBqvf7H3fFA5PZULID4
         Gz8A33DR9lD/uXk087HIk2W+ho+p1SpoaE5W37MSeLVYzBLNNWcM7+7Y1h2DcChVdw
         BeMWD31BQWFXw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] devcoredump: avoid -Wempty-body warnings
Date:   Mon, 22 Mar 2021 11:19:53 +0100
Message-Id: <20210322102002.28990-1-arnd@kernel.org>
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

Pick up the one that Matthew Wilcox suggested by adding a
WARN_ON_ONCE() and a comment.

Link: https://lore.kernel.org/lkml/20200418184111.13401-8-rdunlap@infradead.org/
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/base/devcoredump.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 9243468e2c99..88e0d931439e 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -292,13 +292,16 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 	if (device_add(&devcd->devcd_dev))
 		goto put_device;
 
-	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
-			      "failing_device"))
-		/* nothing - symlink will be missing */;
+	/*
+	 * These should normally not fail, but there is no problem
+	 * continuing without the links, so just warn instead of
+	 * failing.
+	 */
+	WARN_ON_ONCE(sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
+				       "failing_device"));
 
-	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
-			      "devcoredump"))
-		/* nothing - symlink will be missing */;
+	WARN_ON_ONCE(sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
+				       "devcoredump"));
 
 	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
-- 
2.29.2

