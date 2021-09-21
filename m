Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3363413A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbhIUSx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhIUSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:53:25 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572D8C061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:51:56 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h7-20020a37b707000000b003fa4d25d9d0so1263072qkf.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qxxb2w/M5fiqHKkhvOBDSrBf9iLSsSPoKQsdSta11bU=;
        b=Pd3yK4io43ZZA6XcTe6q1mRXI8C4EHFbBXhptEwxeD7sLqNdc5ugPi/3s/uBnW6UsV
         xfWUTffzb3iqfktMlPN3EBM1U0JftxjarIQ0EsXK50Jo5aYJHafX19nbP/ZlxrZ32yhH
         UaM4mqG/8cWuHTV/s3/cDuvQCclW5bBLfryWnjEyjnwJ7yow+SsI3h/ioquJC3rKN4Xm
         2Nlv7rsNJAPo6OFcJmkHc/EaQDIPoDO5OXjk+8SBVbJdcA+HTajJEGgFm/3EJZLC3OYT
         JVl36dED6yfjs2pPQAsYtE9CHY4dHVuXXczwp6O/Io7KXyoOsdFZIl7d3SG725BX77Ia
         RsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qxxb2w/M5fiqHKkhvOBDSrBf9iLSsSPoKQsdSta11bU=;
        b=uUi7tpkfrXEGbEmfdHv8eCyi9tKP1Sz313w22cBxFjbMmomIXuDf4kI7rP15uns+/l
         AA+mK1VRdzD6+OjYBhX+Ht450eEW6q1S0nhpOG2kNed2zzNIZsGEkk3WRDozYhYLOLun
         sQ8uuyx8W4Oy2QeWhG7Yg2JFcuSKWRoEOPNgS3oVShpzqRKNe6xz3pV4RPHjUjGPZshT
         xg+6coZVnR218Sx+YKer4Dxt4Iv8fA2y7otk27WGe/DxI/kS9/N9tlX++QH6Nr8qwQ0B
         1pWAS79+fZP2YkXC4payMaPnbaqJrjiakBupXL8cNOSqmfpVhzn1KvZAOIqSDEPtF+9w
         /TSg==
X-Gm-Message-State: AOAM5311cuRPB+zJ3GMzMNbX6jgJCT2qtEw/aeV+yjGoeDMeJfJO3xBH
        Qx56/I62CrgDQwUVxq8tr3pS1TkO7PSY
X-Google-Smtp-Source: ABdhPJzr3+VvuTdtJ1ZDwvCQh+Off/E60wCu6siZEv/DiSq5zaz12wVOQzpBZRuYj9BDpZpr0TnljeMtnRmr
X-Received: from bg.sfo.corp.google.com ([2620:15c:11a:202:4ba8:c770:5378:a8b7])
 (user=bgeffon job=sendgmr) by 2002:a0c:e102:: with SMTP id
 w2mr32739256qvk.44.1632250315291; Tue, 21 Sep 2021 11:51:55 -0700 (PDT)
Date:   Tue, 21 Sep 2021 11:51:30 -0700
In-Reply-To: <20210917210640.214211-1-bgeffon@google.com>
Message-Id: <20210921185130.944058-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20210917210640.214211-1-bgeffon@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2] zram: Introduce an aged idle interface
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change introduces an aged idle interface to the existing
idle sysfs file for zram.

When CONFIG_ZRAM_MEMORY_TRACKING is enabled the idle file
now also accepts an integer argument. This integer is the
age (in seconds) of pages to mark as idle. The idle file
still supports 'all' as it always has. This new approach
allows for much more control over which pages get marked
as idle.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 Documentation/admin-guide/blockdev/zram.rst |  8 +++
 drivers/block/zram/zram_drv.c               | 60 +++++++++++++++------
 2 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 700329d25f57..8c8a92e5c00c 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -328,6 +328,14 @@ as idle::
 From now on, any pages on zram are idle pages. The idle mark
 will be removed until someone requests access of the block.
 IOW, unless there is access request, those pages are still idle pages.
+Additionally, when CONFIG_ZRAM_MEMORY_TRACKING is enabled pages can be
+marked as idle based on how long (in seconds) it's been since they were
+last accessed, in seconds::
+
+        echo 86400 > /sys/block/zramX/idle
+
+In this example all pages which haven't been accessed in more than 86400
+seconds (one day) will be marked idle.
 
 Admin can request writeback of those idle pages at right timing via::
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f..1d1472fe4094 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -291,22 +291,16 @@ static ssize_t mem_used_max_store(struct device *dev,
 	return len;
 }
 
-static ssize_t idle_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+/*
+ * Mark all pages which are older than or equal to cutoff as IDLE.
+ * Callers should hold the zram init lock in read mode
+ **/
+static void mark_idle(struct zram *zram, ktime_t cutoff)
 {
-	struct zram *zram = dev_to_zram(dev);
+	int is_idle = 1;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 	int index;
 
-	if (!sysfs_streq(buf, "all"))
-		return -EINVAL;
-
-	down_read(&zram->init_lock);
-	if (!init_done(zram)) {
-		up_read(&zram->init_lock);
-		return -EINVAL;
-	}
-
 	for (index = 0; index < nr_pages; index++) {
 		/*
 		 * Do not mark ZRAM_UNDER_WB slot as ZRAM_IDLE to close race.
@@ -314,14 +308,48 @@ static ssize_t idle_store(struct device *dev,
 		 */
 		zram_slot_lock(zram, index);
 		if (zram_allocated(zram, index) &&
-				!zram_test_flag(zram, index, ZRAM_UNDER_WB))
-			zram_set_flag(zram, index, ZRAM_IDLE);
+				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+			is_idle = (!cutoff || ktime_after(cutoff, zram->table[index].ac_time));
+#endif
+			if (is_idle)
+				zram_set_flag(zram, index, ZRAM_IDLE);
+		}
 		zram_slot_unlock(zram, index);
 	}
+}
 
-	up_read(&zram->init_lock);
+static ssize_t idle_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u64 age_sec;
+	ktime_t cutoff_time = 0;
+	ssize_t rv = -EINVAL;
 
-	return len;
+	if (!sysfs_streq(buf, "all")) {
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+		/* If it did not parse as 'all' try to treat it as an integer */
+		if (!kstrtoull(buf, 10, &age_sec))
+			cutoff_time = ktime_sub(ktime_get_boottime(),
+					ns_to_ktime(age_sec * NSEC_PER_SEC));
+		else
+#endif
+			goto out;
+	}
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram))
+		goto out_unlock;
+
+	/* A age_sec of 0 marks everything as idle, this is the "all" behavior */
+	mark_idle(zram, cutoff_time);
+	rv = len;
+
+out_unlock:
+	up_read(&zram->init_lock);
+out:
+	return rv;
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
-- 
2.33.0.464.g1972c5931b-goog

