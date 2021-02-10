Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AC2316419
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhBJKn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhBJKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:41:27 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF71AC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:40:44 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z6so1012235pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QFyw9lzR5KuBwKughvvp6awUxwIYi1PK1JiYv7ubCV8=;
        b=UW0AAKBmtvHjMoq3Z0psC0snPvz/sIkst8npIkuUWZooXmT1Z4vnCZintNILHxfbve
         0wK2U5RDiIpqm7jAQBen63L3ZYibULVC7UjZy/rWicOwat9UJyJvPmiwYQokadA3bEZo
         MJAeDuBgX44vkur8ILEKLh7wCWhE869WWA5Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QFyw9lzR5KuBwKughvvp6awUxwIYi1PK1JiYv7ubCV8=;
        b=qKKT6YqlN9BoQoSzn7J80VorO5SN3IZwRHbN7Zy+6fSdXp1+7P3DYzewTyvZgS2MSy
         CCduwX+2M5II8bfw9pxsPn6sJmn0cYQZFTK1EtkRG8iuI/sOHy4PvStrcpJXWt1Prxxo
         oxyflEj4+VzkQvBb1eBXJ2JZINeI1LMoYag4ieMcjHq67oyeYuQV4eFXD2gl7IqJVub6
         Gplm7TUFDyDeE0wEyyyi8j/olF0FLOMKDdUWn5c39AZfABinxgSVpZkzcIH8n61gKtnM
         HvZr3+h6VNXBR8QcTcxrMGzv9bSlxVG1VUZ0kLXQYXTeVzl46vhq8YQdMTX3KAarQy1w
         gGyA==
X-Gm-Message-State: AOAM532ztiF9sCv9iU1vXQpBhPdK/YcxjJ0gt2SXxVa1FNcco4rLihRJ
        dNUwtPP/ddYWdNhMToqpQkZk5+pMkG5jNfD4rt8=
X-Google-Smtp-Source: ABdhPJybMuRkxP5AIRw9OikuFs3ylW1f0kL4txkPsNYaQXgZw3WIawXoRILNHNXTTVCZt1wFgYzVbg==
X-Received: by 2002:a63:1e1e:: with SMTP id e30mr2552213pge.156.1612953644194;
        Wed, 10 Feb 2021 02:40:44 -0800 (PST)
Received: from hikalium0.c.googlers.com.com (160.131.236.35.bc.googleusercontent.com. [35.236.131.160])
        by smtp.gmail.com with ESMTPSA id j20sm1908729pfe.172.2021.02.10.02.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 02:40:43 -0800 (PST)
From:   Hikaru Nishida <hikalium@chromium.org>
X-Google-Original-From: Hikaru Nishida <hikalium@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     suleiman@google.com, Hikaru Nishida <hikalium@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 1/2] timekeeping: Add timekeeping_adjust_boottime
Date:   Wed, 10 Feb 2021 19:39:07 +0900
Message-Id: <20210210193728.RFC.1.I123660cac7339e5b982ade27775a48b8ebbd9435@changeid>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210210103908.1720658-1-hikalium@google.com>
References: <20210210103908.1720658-1-hikalium@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hikaru Nishida <hikalium@chromium.org>

This introduces timekeeping_adjust_boottime() to give an interface to
modules that enables to advance CLOCK_BOOTTIME from userspace for
virtualized environments. Later patch introduces a sysfs interface
which calls this function.

Signed-off-by: Hikaru Nishida <hikalium@chromium.org>
---

 include/linux/timekeeping.h |  2 ++
 kernel/time/timekeeping.c   | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index c6792cf01bc7..9bb91fbd945c 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -221,6 +221,8 @@ extern bool timekeeping_rtc_skipresume(void);
 
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
+extern int timekeeping_adjust_boottime(const struct timespec64 *delta);
+
 /*
  * struct ktime_timestanps - Simultaneous mono/boot/real timestamps
  * @mono:	Monotonic timestamp
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6aee5768c86f..02892deede62 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1740,6 +1740,32 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 }
 #endif
 
+#if defined(CONFIG_BOOTTIME_ADJUSTMENT)
+/**
+ * timekeeping_adjust_boottime - Adjust CLOCK_BOOTTIME by adding a given delta
+ */
+int timekeeping_adjust_boottime(const struct timespec64 *delta)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned long flags;
+
+	if (!timespec64_valid_strict(delta))
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	write_seqcount_begin(&tk_core.seq);
+
+	tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
+	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+
+	write_seqcount_end(&tk_core.seq);
+	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(timekeeping_adjust_boottime);
+#endif
+
 /**
  * timekeeping_resume - Resumes the generic timekeeping subsystem.
  */
-- 
2.30.0.478.g8a0d178c01-goog

