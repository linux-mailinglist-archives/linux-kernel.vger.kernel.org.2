Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABC93A86E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhFOQzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFOQzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:55:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970BDC0617AF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:52:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f2so19080983wri.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fYEeg99K54RwiBwR+HQrVUbm4Xw+Uq9Wu0V98w2W96I=;
        b=P3fEF9thGHo0uk4eD+3rbspzS6ko4DuqJH6qdGTbVsSs9+KWia0TMF6on83y0YPiif
         D4mVFP+djHkKn5K96WGYu5DIuAIDdMSEhIPU8JWiLplT7wTpFhpGGG/fFTSmq+iX922F
         bg0OdoDgDPCiMHOuIhus5dEf0Qy9Ka4QeHRmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fYEeg99K54RwiBwR+HQrVUbm4Xw+Uq9Wu0V98w2W96I=;
        b=igShw+D8ap0BpQpw7yxCUHeKnTzWDdFowS5iS6AuUV2dLuaGWzGH9JwiszLj4Sv0fl
         BQ17XrR18BbrRo+WZh+mIWeKmwOTrujl03BpM+IhtkPykuUkFw5nBzXm6t7YoR03ACKz
         4PMWjOqF3vYG3nZlJKkmbG9kzn1eTlMITc7gbYicqak2t7Ho8owK81IE9HY+lHWvFYeD
         K4cmped8BsIfEHTlubYBc7WrO4bxiigahdETPsb1cL8AfN1sTVhLFujTs1oRhhzTI+sK
         SyzpztnLkkm93SiJONmFwja4SL/3gpCuj1hd8sOjOSCxqR6XTTWz+gIFM/IKT27tynt3
         g52g==
X-Gm-Message-State: AOAM533dt9jIiIHu4zbYlPlvl2F3lSAo1SqmKIzIFDu/aAvtHv4dQaP8
        LrDXMQeclLRhjB+GQ4fvbGXnywrM2NDHT6etL34=
X-Google-Smtp-Source: ABdhPJwHy0BvY6nfTvhrvQentVKiQ1rMmrWkNiQd7v2wLm0KQIci5+hkwSrGgkYQn4dhO1jejWuZkA==
X-Received: by 2002:a5d:564a:: with SMTP id j10mr31550wrw.171.1623775977892;
        Tue, 15 Jun 2021 09:52:57 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id r18sm19665662wro.62.2021.06.15.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:52:57 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:52:56 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: [PATCH v7 5/5] printk: index: Add indexing support to dev_printk
Message-ID: <959c7aed1017cb2c9de922e0a820d397e29c6a5a.1623775748.git.chris@chrisdown.name>
References: <cover.1623775748.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623775748.git.chris@chrisdown.name>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While for most kinds of issues we have counters, tracepoints, or metrics
with a stable interface which can reliably be used to indicate issues,
in order to react to production issues quickly we sometimes need to work
with the interface which most kernel developers naturally use when
developing: printk, and printk-esques like dev_printk.

dev_printk is by far the most likely custom subsystem printk to benefit
from the printk indexing infrastructure, since niche device issues
brought about by production changes, firmware upgrades, and the like are
one of the most common things that we need printk infrastructure's
assistance to monitor.

Often these errors were never expected to practically manifest in
reality, and exhibit in code without extensive (or any) metrics present.
As such, there are typically very few options for issue detection
available to those with large fleets at the time the incident happens,
and we thus benefit strongly from monitoring netconsole in these
instances.

As such, add the infrastructure for dev_printk to be indexed in the
printk index. Even on a minimal kernel config, the coverage of the base
kernel's printk index is significantly improved:

Before:

    [root@ktst ~]# wc -l /sys/kernel/debug/printk/index/vmlinux
    4497 /sys/kernel/debug/printk/index/vmlinux

After:

    [root@ktst ~]# wc -l /sys/kernel/debug/printk/index/vmlinux
    5573 /sys/kernel/debug/printk/index/vmlinux

In terms of implementation, in order to trivially disambiguate them,
dev_printk is now a macro which wraps _dev_printk.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/core.c        |  6 ++--
 include/linux/dev_printk.h | 66 ++++++++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b8a8c96dca58..31a24b4e27cd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4579,8 +4579,8 @@ static void __dev_printk(const char *level, const struct device *dev,
 		printk("%s(NULL device *): %pV", level, vaf);
 }
 
-void dev_printk(const char *level, const struct device *dev,
-		const char *fmt, ...)
+void _dev_printk(const char *level, const struct device *dev,
+		 const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -4594,7 +4594,7 @@ void dev_printk(const char *level, const struct device *dev,
 
 	va_end(args);
 }
-EXPORT_SYMBOL(dev_printk);
+EXPORT_SYMBOL(_dev_printk);
 
 #define define_dev_printk_level(func, kern_level)		\
 void func(const struct device *dev, const char *fmt, ...)	\
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 6f009559ee54..8da7452cae3f 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -38,8 +38,8 @@ __printf(3, 4) __cold
 int dev_printk_emit(int level, const struct device *dev, const char *fmt, ...);
 
 __printf(3, 4) __cold
-void dev_printk(const char *level, const struct device *dev,
-		const char *fmt, ...);
+void _dev_printk(const char *level, const struct device *dev,
+		 const char *fmt, ...);
 __printf(2, 3) __cold
 void _dev_emerg(const struct device *dev, const char *fmt, ...);
 __printf(2, 3) __cold
@@ -69,7 +69,7 @@ static inline void __dev_printk(const char *level, const struct device *dev,
 				struct va_format *vaf)
 {}
 static inline __printf(3, 4)
-void dev_printk(const char *level, const struct device *dev,
+void _dev_printk(const char *level, const struct device *dev,
 		 const char *fmt, ...)
 {}
 
@@ -97,25 +97,57 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 
 #endif
 
+/*
+ * Need to take variadic arguments even though we don't use them, as dev_fmt()
+ * may only just have been expanded and may result in multiple arguments.
+ */
+#define dev_printk_index_emit(level, fmt, ...) \
+	printk_index_subsys_emit("%s %s: ", level, fmt)
+
+#define dev_printk_index_wrap(_p_func, level, dev, fmt, ...)		\
+	({								\
+		dev_printk_index_emit(level, fmt);			\
+		_p_func(dev, fmt, ##__VA_ARGS__);			\
+	})
+
+/*
+ * Some callsites directly call dev_printk rather than going through the
+ * dev_<level> infrastructure, so we need to emit here as well as inside those
+ * level-specific macros. Only one index entry will be produced, either way,
+ * since dev_printk's `fmt` isn't known at compile time if going through the
+ * dev_<level> macros.
+ *
+ * dev_fmt() isn't called for dev_printk when used directly, as it's used by
+ * the dev_<level> macros internally which already have dev_fmt() processed.
+ *
+ * We also can't use dev_printk_index_wrap directly, because we have a separate
+ * level to process.
+ */
+#define dev_printk(level, dev, fmt, ...)				\
+	({								\
+		dev_printk_index_emit(level, fmt);			\
+		_dev_printk(level, dev, fmt, ##__VA_ARGS__);		\
+	})
+
 /*
  * #defines for all the dev_<level> macros to prefix with whatever
  * possible use of #define dev_fmt(fmt) ...
  */
 
-#define dev_emerg(dev, fmt, ...)					\
-	_dev_emerg(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#define dev_crit(dev, fmt, ...)						\
-	_dev_crit(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#define dev_alert(dev, fmt, ...)					\
-	_dev_alert(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#define dev_err(dev, fmt, ...)						\
-	_dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#define dev_warn(dev, fmt, ...)						\
-	_dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#define dev_notice(dev, fmt, ...)					\
-	_dev_notice(dev, dev_fmt(fmt), ##__VA_ARGS__)
-#define dev_info(dev, fmt, ...)						\
-	_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_emerg(dev, fmt, ...) \
+	dev_printk_index_wrap(_dev_emerg, KERN_EMERG, dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_crit(dev, fmt, ...) \
+	dev_printk_index_wrap(_dev_crit, KERN_CRIT, dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_alert(dev, fmt, ...) \
+	dev_printk_index_wrap(_dev_alert, KERN_ALERT, dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_err(dev, fmt, ...) \
+	dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_warn(dev, fmt, ...) \
+	dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_notice(dev, fmt, ...) \
+	dev_printk_index_wrap(_dev_notice, KERN_NOTICE, dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_info(dev, fmt, ...) \
+	dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
 
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
-- 
2.31.1

