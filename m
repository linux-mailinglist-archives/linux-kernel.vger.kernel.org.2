Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219DA3720A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhECTli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECTlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:41:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4139EC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 12:40:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b11-20020a7bc24b0000b0290148da0694ffso3929294wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r64+vqw2QbWknWWBUrMupdYojd5Pf3tBCcBBzOw6sH4=;
        b=PitqLSo4VK+6AWM9/PXAutv097YZwY13hpLE0XxE0frL9lQM5BNzeBHzizwUDT3sPH
         d7ZWF6NKM7Lv/41WIhGZfpZu3tirFSSIE90zNZy635WyICy+vvHaNGsia6g1sDGqE/Rb
         VW8Bwiwcdt/VHBIZFgSH3QvelvVvYW2lKaGYesZHP4jI0fdJHmq2DfZe4HqHDYc8Btml
         T0HtK5yNR+Voq+Er0L3JurxLUJAEsyYTelt35jFG76hGCw4wc2CkvNgBIpZgONbkm/UY
         E/Q6F4ru2/KiL9n6Rcmecqj8AgMyLw6r9YNP8h3itzSRydoe4PZ6EXgohv9X+rjtRF5o
         h+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r64+vqw2QbWknWWBUrMupdYojd5Pf3tBCcBBzOw6sH4=;
        b=ViWmzZ4MLUCt+zbFE3J2M+QBlstOgZQK2/syGcLR19HoTLAmZDK6V3wvzPBObHfiDV
         73QGLIdMMBNrK8iKjP++jw0fsesPmsOt8I6OHBAdx4p5X4225r6MikJBquhgBkDqkx0o
         bLTBsKV4xFJTyrZcSWzV8M34KhMxqoVaFufy5UIpp5al3iAytCKCpBfgEXcVkl3LfKlx
         jsTAaOxhxfS0Oah6IRZ0z2R+w8rPoN9NDmuEsz988joHRFrBVEvFUuYsGs9a8+zGaO27
         30rSjz6EbJaOJl5dRKdh37lVvP5GSjmfoXCRTffDDYSvzBAUZp0SmF5wCKwW9rjnQLcG
         zAsQ==
X-Gm-Message-State: AOAM532hZm9/PUrjMrRbccP3It3GZZltlXV0Ed/iLMw7fIqLv4pigPw9
        bKwbrWHxOCK1QxmpeIK58GGnE1SCS2eksQ==
X-Google-Smtp-Source: ABdhPJz6NW1mH8Umi7x+CzG+81hZ8hbn2V0gDUA4uIezghMGpp9dWGpL976XrhhnmJ/XbHu74sd5oA==
X-Received: by 2002:a1c:c91a:: with SMTP id f26mr165658wmb.15.1620070842702;
        Mon, 03 May 2021 12:40:42 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:915c:8fda:c2d8:722c? (p200300ea8f384600915c8fdac2d8722c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:915c:8fda:c2d8:722c])
        by smtp.googlemail.com with ESMTPSA id r2sm13048807wrt.79.2021.05.03.12.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 12:40:42 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Jason Baron <jbaron@akamai.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <f527618e-54f2-c2fb-e267-8065ac34e462@gmail.com>
Subject: [PATCH 1/2] dyndbg: add pr_debug return value if dynamic debugging is
 enabled
Message-ID: <c552470c-f963-aff8-9b51-af70a664a590@gmail.com>
Date:   Mon, 3 May 2021 21:39:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f527618e-54f2-c2fb-e267-8065ac34e462@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a pr_cont() follows a pr_debug() then it must not print something if
the the pr_debug() output is suppressed. We can use the pr_debug() return
value as criteria, however this fails in case dynamic debugging is enabled
because dynamic_pr_debug() has no return value. So let's add this missing
feature.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/dynamic_debug.h | 14 +++++++++++---
 lib/dynamic_debug.c           |  7 +++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a57ee7534..1de271d1a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -57,7 +57,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 				const char *modname);
 extern int ddebug_remove_module(const char *mod_name);
 extern __printf(2, 3)
-void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
+int __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
 
 extern int ddebug_dyndbg_module_param_cb(char *param, char *val,
 					const char *modname);
@@ -123,6 +123,14 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #endif /* CONFIG_JUMP_LABEL */
 
+#define __dynamic_func_call_pr_debug(id, fmt, ...) ({		\
+	DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);			\
+	int ret = 0;						\
+	if (DYNAMIC_DEBUG_BRANCH(id))				\
+		ret = __dynamic_pr_debug(&id, __VA_ARGS__);	\
+	ret;							\
+})
+
 #define __dynamic_func_call(id, fmt, func, ...) do {	\
 	DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);		\
 	if (DYNAMIC_DEBUG_BRANCH(id))			\
@@ -154,8 +162,8 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	__dynamic_func_call_no_desc(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
 
 #define dynamic_pr_debug(fmt, ...)				\
-	_dynamic_func_call(fmt,	__dynamic_pr_debug,		\
-			   pr_fmt(fmt), ##__VA_ARGS__)
+	__dynamic_func_call_pr_debug(__UNIQUE_ID(ddebug), fmt,	\
+				     pr_fmt(fmt), ##__VA_ARGS__)
 
 #define dynamic_dev_dbg(dev, fmt, ...)				\
 	_dynamic_func_call(fmt,__dynamic_dev_dbg, 		\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c70d6347a..f7a771c06 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -618,11 +618,12 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	return buf;
 }
 
-void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
+int __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
 	va_list args;
 	struct va_format vaf;
 	char buf[PREFIX_SIZE];
+	int ret;
 
 	BUG_ON(!descriptor);
 	BUG_ON(!fmt);
@@ -632,9 +633,11 @@ void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	printk(KERN_DEBUG "%s%pV", dynamic_emit_prefix(descriptor, buf), &vaf);
+	ret = printk(KERN_DEBUG "%s%pV", dynamic_emit_prefix(descriptor, buf), &vaf);
 
 	va_end(args);
+
+	return ret;
 }
 EXPORT_SYMBOL(__dynamic_pr_debug);
 
-- 
2.31.1


