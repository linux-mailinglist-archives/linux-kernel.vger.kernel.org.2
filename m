Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079C7387844
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348978AbhERMCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbhERMCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:02:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DEDC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:00:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so1325746wmg.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AdmdWz0ZuUjyLuIJtQQK0QbXX0QdjMKWz2XY/sEGAjU=;
        b=BecK8iJGG9RGzlicf31GthNJqzoswqTx+epBMvxv13JnO8WpW8MCBdrnouQyGoPHnA
         EXmWSKuB6Op8dPoLd/rUEoLBHtFCfaSqO6L8k9mqC6qOXeh6/1LuAe+FpmPLWN3kAnx5
         ZUawBRN3srvu/bCgmPIKPnWUwuKXpiCx8DYOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AdmdWz0ZuUjyLuIJtQQK0QbXX0QdjMKWz2XY/sEGAjU=;
        b=Ly/If3kKL6DWIoxvI75/sPY4ZNy/FB7yfvLt8zs1bBhf2K9JjbvbfvnrnJMq6iEm4d
         mKsNPEzHpsgH6i5/cD8kJ4nNR8jqmbi/NdoEoZ95mNNmVQTW/Xgx/jHLH3LFaWP/wuVN
         ltrUlirdI8HtBFbLp34AwGBPe8tzzJbI1zX9jAvn63BKCJ/72kF9o/8B/t1464oZLt8y
         d67xHe8mFRUqGIHIhvHUe6dwqgxdwTpjPwaM4+SPHbxM5eHsGfZi5+mADosPa1xI/axe
         2pFD7DsjU870YOokQ/TjansIc03kYpxOeTg2NFzQAUjQha6WYj7GmCKyO00NGnaWT/w5
         0sOg==
X-Gm-Message-State: AOAM532Vgg6PSly5MK+cRGIjIMFW68XCzIf1urz35Lbh9qv80KlkIxqg
        LtF+i/2xKOPlwg1fFa+SMrxzlGPHeuWggWxSE+o=
X-Google-Smtp-Source: ABdhPJzavpXhV72yfhu+6b2h6LxfToOvgCWrSKj+nK/nuY+GTGBJqbjlrT0WruAXNaE668iRSEQCkw==
X-Received: by 2002:a1c:a758:: with SMTP id q85mr4662928wme.79.1621339249422;
        Tue, 18 May 2021 05:00:49 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:5c4a])
        by smtp.gmail.com with ESMTPSA id g128sm9205132wme.0.2021.05.18.05.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:00:49 -0700 (PDT)
Date:   Tue, 18 May 2021 13:00:48 +0100
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
Subject: [PATCH v6 4/4] printk: index: Add indexing support to dev_printk
Message-ID: <fff5e1c790f14e9af4559e902ba9689ec93d38e2.1621338324.git.chris@chrisdown.name>
References: <cover.1621338324.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621338324.git.chris@chrisdown.name>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
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
dev_printk is now a macro which wraps _dev_printk. If preferred, it's
also possible to have the macro and function have the same name.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/core.c        |  6 ++--
 include/linux/dev_printk.h | 63 ++++++++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 60c5f5ea0268..78b8297e7f2b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4547,8 +4547,8 @@ static void __dev_printk(const char *level, const struct device *dev,
 		printk("%s(NULL device *): %pV", level, vaf);
 }
 
-void dev_printk(const char *level, const struct device *dev,
-		const char *fmt, ...)
+void _dev_printk(const char *level, const struct device *dev,
+		 const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -4562,7 +4562,7 @@ void dev_printk(const char *level, const struct device *dev,
 
 	va_end(args);
 }
-EXPORT_SYMBOL(dev_printk);
+EXPORT_SYMBOL(_dev_printk);
 
 #define define_dev_printk_level(func, kern_level)		\
 void func(const struct device *dev, const char *fmt, ...)	\
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 6f009559ee54..202c6a9ea7eb 100644
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
 
@@ -97,25 +97,54 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 
 #endif
 
+/*
+ * Some callsites directly call dev_printk rather than going through the
+ * dev_<level> infrastructure, so we need to emit here as well as inside those
+ * level-specific macros. Only one index entry will be produced, either way,
+ * since dev_printk's `fmt` isn't known at compile time if going through the
+ * dev_<level> macros.
+ */
+#define dev_printk(level, dev, fmt, ...) ({			\
+	dev_printk_index_emit(level, fmt);			\
+	_dev_printk(level, dev, fmt, ##__VA_ARGS__);		\
+})
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
+#define dev_printk_index_emit(level, fmt)				\
+	printk_index_subsys_emit("%s %s: ", "", level, fmt)
+
+#define dev_emerg(dev, fmt, ...) ({					\
+	dev_printk_index_emit(KERN_EMERG, dev_fmt(fmt));		\
+	_dev_emerg(dev, dev_fmt(fmt), ##__VA_ARGS__);			\
+})
+#define dev_crit(dev, fmt, ...) ({					\
+	dev_printk_index_emit(KERN_CRIT, dev_fmt(fmt));			\
+	_dev_crit(dev, dev_fmt(fmt), ##__VA_ARGS__);			\
+})
+#define dev_alert(dev, fmt, ...) ({					\
+	dev_printk_index_emit(KERN_ALERT, dev_fmt(fmt));		\
+	_dev_alert(dev, dev_fmt(fmt), ##__VA_ARGS__);			\
+})
+#define dev_err(dev, fmt, ...) ({					\
+	dev_printk_index_emit(KERN_ERR, dev_fmt(fmt));			\
+	_dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__);			\
+})
+#define dev_warn(dev, fmt, ...) ({					\
+	dev_printk_index_emit(KERN_WARNING, dev_fmt(fmt));		\
+	_dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__);			\
+})
+#define dev_notice(dev, fmt, ...) ({					\
+	dev_printk_index_emit(KERN_NOTICE, dev_fmt(fmt));		\
+	_dev_notice(dev, dev_fmt(fmt), ##__VA_ARGS__);			\
+})
+#define dev_info(dev, fmt, ...) ({					\
+	dev_printk_index_emit(KERN_INFO, dev_fmt(fmt));			\
+	_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__);			\
+})
 
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
-- 
2.31.1

