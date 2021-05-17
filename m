Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D838D382C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhEQMaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:30:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:35548 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231608AbhEQMap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:30:45 -0400
IronPort-SDR: VJ/JHjxvAbx5nc/8Edz0vmcZ76HKVnBiUR95SaB5bwTO7CTDs47wKt9pnhgDwCYKjlD/zjLPD4
 hWS53bQQhjBg==
X-IronPort-AV: E=McAfee;i="6200,9189,9986"; a="285982251"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="285982251"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 05:29:28 -0700
IronPort-SDR: HTlzslxjG2Cv4ofSOZR3v/BGTcXZmd0oKbHpf/lInxIBTEQWyR7VkKgezXgutLEeCDPs+MvT+J
 976n+7WnJcXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="437737405"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 17 May 2021 05:29:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2EDE2348; Mon, 17 May 2021 15:29:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 1/4] devres: Make locking straight forward in release_nodes()
Date:   Mon, 17 May 2021 15:29:43 +0300
Message-Id: <20210517122946.53161-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems for the sake of saving stack memory of couple of pointers,
the locking in release_nodes() callers becomes interesting.

Replace this logic with a straight forward locking and unlocking scheme.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v4: rebased on top of v5.13-rc2
 drivers/base/devres.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 8746f2212781..7970217191e0 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -503,28 +503,18 @@ static int remove_nodes(struct device *dev,
 	return cnt;
 }
 
-static int release_nodes(struct device *dev, struct list_head *first,
-			 struct list_head *end, unsigned long flags)
-	__releases(&dev->devres_lock)
+static void release_nodes(struct device *dev, struct list_head *todo)
 {
-	LIST_HEAD(todo);
-	int cnt;
 	struct devres *dr, *tmp;
 
-	cnt = remove_nodes(dev, first, end, &todo);
-
-	spin_unlock_irqrestore(&dev->devres_lock, flags);
-
 	/* Release.  Note that both devres and devres_group are
 	 * handled as devres in the following loop.  This is safe.
 	 */
-	list_for_each_entry_safe_reverse(dr, tmp, &todo, node.entry) {
+	list_for_each_entry_safe_reverse(dr, tmp, todo, node.entry) {
 		devres_log(dev, &dr->node, "REL");
 		dr->node.release(dev, dr->data);
 		kfree(dr);
 	}
-
-	return cnt;
 }
 
 /**
@@ -537,13 +527,19 @@ static int release_nodes(struct device *dev, struct list_head *first,
 int devres_release_all(struct device *dev)
 {
 	unsigned long flags;
+	LIST_HEAD(todo);
+	int cnt;
 
 	/* Looks like an uninitialized device structure */
 	if (WARN_ON(dev->devres_head.next == NULL))
 		return -ENODEV;
+
 	spin_lock_irqsave(&dev->devres_lock, flags);
-	return release_nodes(dev, dev->devres_head.next, &dev->devres_head,
-			     flags);
+	cnt = remove_nodes(dev, dev->devres_head.next, &dev->devres_head, &todo);
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+
+	release_nodes(dev, &todo);
+	return cnt;
 }
 
 /**
@@ -679,6 +675,7 @@ int devres_release_group(struct device *dev, void *id)
 {
 	struct devres_group *grp;
 	unsigned long flags;
+	LIST_HEAD(todo);
 	int cnt = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
@@ -691,7 +688,10 @@ int devres_release_group(struct device *dev, void *id)
 		if (!list_empty(&grp->node[1].entry))
 			end = grp->node[1].entry.next;
 
-		cnt = release_nodes(dev, first, end, flags);
+		cnt = remove_nodes(dev, first, end, &todo);
+		spin_unlock_irqrestore(&dev->devres_lock, flags);
+
+		release_nodes(dev, &todo);
 	} else {
 		WARN_ON(1);
 		spin_unlock_irqrestore(&dev->devres_lock, flags);
-- 
2.30.2

