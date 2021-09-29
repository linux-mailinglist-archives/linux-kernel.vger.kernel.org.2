Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4210741C6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbhI2Oc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbhI2Oc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:32:57 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB7AC061762
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:31:16 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r11-20020ac86d2b000000b002a688ea1f4bso8705326qtu.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rWICg8z18y6VVMgB2+FBawlhY9BT8cZzUVXfBU/5MDc=;
        b=lDmFatJxse2Wln+jGfebmXhp7ycDVxpvCtDN5lXIJGK6Cqt2tWheN/OsgOdlMKRBn3
         nUxGAmetg2Xz+ITdJ9SZKNJfMh3K1TV+RTJD7NtJAT3S0kEXXjbnWbZVRDi7I26Gw+pA
         if5ye7gfxc4hg/zbooMFmMgNyOvTDMfrx3DIO3HEzzx/lkeO+wqXumwFJHc4fl+9R3oa
         ILTW5xhoS3B4B4qYePulahGaD7oxojtUVWeolSwhNCj9jEffJ15zn8MOJO6TDQiG5Z8C
         JbAshmkT9/7neyVISnTlS9aGiexK4t1ibOVGuNmYhDEBaWxngYutYMXW7lquprr+bUDS
         xITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rWICg8z18y6VVMgB2+FBawlhY9BT8cZzUVXfBU/5MDc=;
        b=zRNA16ig/qzEZhdkBsgfdK65pIPx9Kvuz2lb1LfM5jS1uxRa+fdDnHwWa+ojGzSQEd
         Fl5v3r5Izhe3ez1+onqcNguw/sGwMDxtfKOnPFd1AEipQSd11FCs9dMXhehFufRKSVzZ
         BYZ8xRyCAb13XxjmS/GbgR1xXnqwXqYZ6hOAM9dHAh8wtruoiNiezqkIBHagbcXmlvFu
         5q2qQcknqLtAlts3dBoMeGRzD41dtsfidhcpmFQCFobwAb8Lzwr2jF0XuH4Ym7juH7RD
         YQX6+varpV8y72eShKaG0TZ08tskTGeUiHPHVVmdrJRDvGoNF6dthx5IUmC+4exlZp6B
         tHnA==
X-Gm-Message-State: AOAM533201Cm+MVlJmpOrKVGSCc5e+tNLeiTB4svifIQHMqKD3tH0TXL
        9x0v1WTEpKgfDwtSbTQqCQPq/9HOQ7gS
X-Google-Smtp-Source: ABdhPJwDV7ClEvzTaenTx9rrvJz3xctvGcdzsJSql0k1qJNvj4+7OO3EWhHwlFTBoaVZ+/f8jCZSYTGTNTbo
X-Received: from bg.sfo.corp.google.com ([2620:15c:11a:202:d5dd:2dee:3cc9:114])
 (user=bgeffon job=sendgmr) by 2002:a05:6214:1046:: with SMTP id
 l6mr11763064qvr.6.1632925875212; Wed, 29 Sep 2021 07:31:15 -0700 (PDT)
Date:   Wed, 29 Sep 2021 07:30:56 -0700
In-Reply-To: <20210917210640.214211-1-bgeffon@google.com>
Message-Id: <20210929143056.13067-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20210917210640.214211-1-bgeffon@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v6] zram: Introduce an aged idle interface
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

  v5 -> v6:
        - Sergey's cleanup suggestions.

  v4 -> v5:
        - Andrew's suggestions to use IS_ENABLED and
          cleanup comment.

  v3 -> v4:
        - Remove base10 restriction.

  v2 -> v3:
        - Correct unused variable warning when
          CONFIG_ZRAM_MEMORY_TRACKING is not enabled.
  v1 -> v2:
        - Switch to using existing idle file.
        - Dont compare ktime directly.

Signed-off-by: Brian Geffon <bgeffon@google.com>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  8 +++
 drivers/block/zram/zram_drv.c               | 62 +++++++++++++++------
 2 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 700329d25f57..3e11926a4df9 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -328,6 +328,14 @@ as idle::
 From now on, any pages on zram are idle pages. The idle mark
 will be removed until someone requests access of the block.
 IOW, unless there is access request, those pages are still idle pages.
+Additionally, when CONFIG_ZRAM_MEMORY_TRACKING is enabled pages can be
+marked as idle based on how long (in seconds) it's been since they were
+last accessed::
+
+        echo 86400 > /sys/block/zramX/idle
+
+In this example all pages which haven't been accessed in more than 86400
+seconds (one day) will be marked idle.
 
 Admin can request writeback of those idle pages at right timing via::
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f..4e76a75a7840 100644
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
+ */
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
@@ -314,14 +308,50 @@ static ssize_t idle_store(struct device *dev,
 		 */
 		zram_slot_lock(zram, index);
 		if (zram_allocated(zram, index) &&
-				!zram_test_flag(zram, index, ZRAM_UNDER_WB))
-			zram_set_flag(zram, index, ZRAM_IDLE);
+				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+			is_idle = !cutoff || ktime_after(cutoff, zram->table[index].ac_time);
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
+	ktime_t cutoff_time = 0;
+	ssize_t rv = -EINVAL;
 
-	return len;
+	if (!sysfs_streq(buf, "all")) {
+		/*
+		 * If it did not parse as 'all' try to treat it as an integer when
+		 * we have memory tracking enabled.
+		 */
+		u64 age_sec;
+
+		if (IS_ENABLED(CONFIG_ZRAM_MEMORY_TRACKING) && !kstrtoull(buf, 0, &age_sec))
+			cutoff_time = ktime_sub(ktime_get_boottime(),
+					ns_to_ktime(age_sec * NSEC_PER_SEC));
+		else
+			goto out;
+	}
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram))
+		goto out_unlock;
+
+	/* A cutoff_time of 0 marks everything as idle, this is the "all" behavior */
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
2.33.0.685.g46640cef36-goog

