Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDBA410095
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 23:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244733AbhIQVI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 17:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344237AbhIQVI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 17:08:27 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2730C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 14:07:04 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h10-20020a05620a284a00b003d30e8c8cb5so74187382qkp.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1RUt2IvhDUKLquM1kcv9z34EUuW3smlZ2afUa2bIZHg=;
        b=mBDQt0NeEIlmClEh53VD2jNMytDjF+f478ehVEuynsRp1GhLR4kW4nc8kdusDfUHvf
         W4LW2+jw6NnX+0xT/t0YI0FgaWlNSz4k+wYfcAOdpt3e8VjWs6aXixTxpA/LLckXq0Rn
         cNs/9yqN8XOG8iYQ/ZFT2Wtx+OVQYQfp8ScKjBhgH2WCurSVX9YukLnO4aaSLmIFfGCD
         qFFt5bXowqWDsbY0aywODmPFyYUVu0t33qYV+cWHIwbGZttKzyp5NWs64VZuTs0f1HdS
         p9xLiBUEDdLpoFo3tjY55HpoHDx/1LPaLvO/KOVUeBWpme1B+KZ5ep2WNmqKNd6aSSWU
         mf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1RUt2IvhDUKLquM1kcv9z34EUuW3smlZ2afUa2bIZHg=;
        b=z0mzR7cgWn3Q/9Y1KkT+TUETZ6bq+TqBzHtURl1dqGO5jwuRmdT/L6f3N+3aHULTiA
         wExxtBsMIbE+UQ4UrWC51HYBeCzzCS3MvtepJPR+b7L+5B6L7akNLM6Ls2HGQL8vBVxd
         1LjH0nsXJjwYOXO+B3Ye9l6/tfVJbfErbOtzoLYNEeV1dUnoy5Pje7tYqNweg6wWGjRP
         y1z/L5dfQJKZNVL6ljeEwqaZEa3cHbR2FsW7fKJ7OvY/vb/mPPgPdw1e/SRGPaWTMgw6
         mZ6GVc0tIkOzuFBztscFqRAzQ37lqI+QVHquCuGH9nk55PoXD0PB/vbqGsDJGn6KMf8n
         Q4DQ==
X-Gm-Message-State: AOAM532A2CmUAjZbvmS0fTB15ZYvMCfjdmT5j/s36Pj3uvJ70KB8erGO
        ppKO4ms4tK4KDPYuZrLN8cqLgJKaa2CI
X-Google-Smtp-Source: ABdhPJwuhT21pwC4HbZIBKQBRcwBDZARIC5/y4SimyqpdTFIflIFMCV85KKaekuSd1m8ES8YnF7vy4AzjNZD
X-Received: from bg.sfo.corp.google.com ([2620:15c:11a:202:4316:322d:79c2:7a14])
 (user=bgeffon job=sendgmr) by 2002:a0c:d6cd:: with SMTP id
 l13mr13168135qvi.24.1631912824132; Fri, 17 Sep 2021 14:07:04 -0700 (PDT)
Date:   Fri, 17 Sep 2021 14:06:40 -0700
Message-Id: <20210917210640.214211-1-bgeffon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH] zram: Introduce an aged idle interface
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

This change introduces a new sysfs file for the zram idle interface.
The current idle interface has only a single mode "all." This is
severely limiting in that it requires that you have the foresight
to know that you'll want to have pages idle at some point in the future
and forces the user to mark everything as idle.

This new proposed file idle_aged takes a single integer argument which
represents the age of the pages (in seconds since access) to mark as idle.
Because it requires accessed tracking it is only enabled when
CONFIG_ZRAM_MEMORY_TRACKING is enabled. There are a few
reasons why  this is being proposed as a new file rather than extending
the existing file. The first reason is that it wouldn't allow more code
sharing as this change already refactors the existing code to do so.
Secondly, having a standalone file allows a caller to quickly check if this
idle_aged interface is supported. Finally, it simplifies the parsing
logic because now you only need to parse an int rather than more complex
logic which would need to parse things like "aged 50."

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 Documentation/admin-guide/blockdev/zram.rst | 11 ++-
 drivers/block/zram/zram_drv.c               | 75 +++++++++++++++++----
 2 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 700329d25f57..ecd1c4916a1c 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -209,6 +209,8 @@ compact           	WO	trigger memory compaction
 debug_stat        	RO	this file is used for zram debugging purposes
 backing_dev	  	RW	set up backend storage for zram to write out
 idle		  	WO	mark allocated slot as idle
+idle_aged              WO      mark allocated slot older than 'age' seconds
+                                as idle (see later)
 ======================  ======  ===============================================
 
 
@@ -325,8 +327,13 @@ as idle::
 
 	echo all > /sys/block/zramX/idle
 
-From now on, any pages on zram are idle pages. The idle mark
-will be removed until someone requests access of the block.
+Alternatively if the config option CONFIG_ZRAM_MEMORY_TRACKING is enabled
+the idle_aged interface can be used to mark only pages older than 'age'
+seconds as idle::
+
+        echo 86400 > /sys/block/zramX/idle_aged
+
+The idle mark will be removed until someone requests access of the block.
 IOW, unless there is access request, those pages are still idle pages.
 
 Admin can request writeback of those idle pages at right timing via::
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f..a371dc0edf9d 100644
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
@@ -314,16 +308,63 @@ static ssize_t idle_store(struct device *dev,
 		 */
 		zram_slot_lock(zram, index);
 		if (zram_allocated(zram, index) &&
-				!zram_test_flag(zram, index, ZRAM_UNDER_WB))
-			zram_set_flag(zram, index, ZRAM_IDLE);
+				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+			is_idle = (!cutoff || cutoff >= zram->table[index].ac_time);
+#endif
+			if (is_idle)
+				zram_set_flag(zram, index, ZRAM_IDLE);
+		}
 		zram_slot_unlock(zram, index);
 	}
+}
+
+static ssize_t idle_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+
+	if (!sysfs_streq(buf, "all"))
+		return -EINVAL;
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram)) {
+		up_read(&zram->init_lock);
+		return -EINVAL;
+	}
 
+	/* Mark everything as idle */
+	mark_idle(zram, 0);
 	up_read(&zram->init_lock);
 
 	return len;
 }
 
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+static ssize_t idle_aged_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	ktime_t cutoff_time;
+	u64 age_sec;
+	ssize_t rv = -EINVAL;
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram))
+		goto out;
+
+	if (kstrtoull(buf, 10, &age_sec))
+		goto out;
+
+	rv = len;
+	cutoff_time = ktime_sub(ktime_get_boottime(), ns_to_ktime(age_sec * NSEC_PER_SEC));
+	mark_idle(zram, cutoff_time);
+out:
+	up_read(&zram->init_lock);
+	return rv;
+}
+#endif
+
 #ifdef CONFIG_ZRAM_WRITEBACK
 static ssize_t writeback_limit_enable_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
@@ -1840,6 +1881,9 @@ static DEVICE_ATTR_WO(reset);
 static DEVICE_ATTR_WO(mem_limit);
 static DEVICE_ATTR_WO(mem_used_max);
 static DEVICE_ATTR_WO(idle);
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+static DEVICE_ATTR_WO(idle_aged);
+#endif
 static DEVICE_ATTR_RW(max_comp_streams);
 static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
@@ -1857,6 +1901,9 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_mem_limit.attr,
 	&dev_attr_mem_used_max.attr,
 	&dev_attr_idle.attr,
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+	&dev_attr_idle_aged.attr,
+#endif
 	&dev_attr_max_comp_streams.attr,
 	&dev_attr_comp_algorithm.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
-- 
2.33.0.464.g1972c5931b-goog

