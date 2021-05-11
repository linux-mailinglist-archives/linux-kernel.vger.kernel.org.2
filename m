Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7B37AEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhEKSw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:28 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C8BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:21 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id i7so11698366ioa.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sTUPuFc66ybePyVc1BipkRA9wzdceMEI5lxpFNGBTY=;
        b=Ejt6pYdhRRT/Y99OtH6AqvCn+KURqUFlvSmqQYYC6RQ6BuuQljq3uRuLepMpaUyF2O
         q5H+LqUdg0JzK9dJcSVcRe5CZIuLe1ExMHs9WDYbHFnwjPeu60302dqMM9Vga1EM+lNQ
         uiLjx9PijnJNal5gs9NqFR2fU/Afuk+UFubRaGO9H5dg/h7BIkAja45+pIIsETAxhG28
         6cvcu+yFJO4Yyv8Lgdc7vhXV+379QExU+vqoSYrsN0eN43JNav3jcBGoUIwwKTQbvlyf
         vBMaUxQbIm0LErKcUxIxqNTz2LkWP493xXiAwywvTYA5rSXSdi3O70ohUDLCx92+iVi/
         Sctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sTUPuFc66ybePyVc1BipkRA9wzdceMEI5lxpFNGBTY=;
        b=mJqYkhkoXWqZGQunIEUgl/xZB/JMTiTLUhAiTm1LJSmU+yA8NZDMSY2o+6345xaARJ
         cKgfaAM0iPa1JcSIFBgj7KIYd77yfDXd+dU34OiL4+t7fjiwjifS/9tpSc4S9UNwiTOu
         sn5QcxoGHt2mponvrD8qGdBsJHTauPRduUxAhGWQGlCVQ6p2Fop9eAMrumyzDBlksYeK
         tT665TUriOBLy74P68kSOThbZdoQG0C39/FySKfF0HNfzEO7Nezu+/Py2Mxty9uMyigL
         C5W4mhxsc67IG2hHiJXdhzP7h25nzTuoUWL9E+Ns6hffmJPYPrpGMYvioQlnduRpiPZe
         HSyQ==
X-Gm-Message-State: AOAM530INK5YRZdg/393MWeEMx3LL8iQKt0PsfKLRt1nxq42PlPUGIwd
        RUqcuRr0967hBIQceQ62F7I=
X-Google-Smtp-Source: ABdhPJzfp/aDRmoziPojTcrdukG+4wgAm6I/Yg15+Asnz8wLXjxY1VrZGxPuvnMMl1uFWN2iXZsHYg==
X-Received: by 2002:a02:bb98:: with SMTP id g24mr28108373jan.19.1620759080669;
        Tue, 11 May 2021 11:51:20 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:20 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 01/28] dyndbg: avoid calling dyndbg_emit_prefix when it has no work
Date:   Tue, 11 May 2021 12:50:30 -0600
Message-Id: <20210511185057.3815777-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap function in a static-inline one, which checks flags to avoid
calling the function unnecessarily.

And hoist its output-buffer initialization to the grand-caller, which
is already allocating the buffer on the stack, and can trivially
initialize it too.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h |  5 +++++
 lib/dynamic_debug.c           | 19 ++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a57ee75342cf..dce631e678dd 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,6 +32,11 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+
+#define _DPRINTK_FLAGS_INCL_ANY		\
+	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
+	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID)
+
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c70d6347afa2..ede4a491ee87 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -586,13 +586,11 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
+static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
 
-	*buf = '\0';
-
 	if (desc->flags & _DPRINTK_FLAGS_INCL_TID) {
 		if (in_interrupt())
 			pos += snprintf(buf + pos, remaining(pos), "<intr> ");
@@ -618,11 +616,18 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 	return buf;
 }
 
+static inline char *dynamic_emit_prefix(struct _ddebug *desc, char *buf)
+{
+	if (unlikely(desc->flags & _DPRINTK_FLAGS_INCL_ANY))
+		return __dynamic_emit_prefix(desc, buf);
+	return buf;
+}
+
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
 	va_list args;
 	struct va_format vaf;
-	char buf[PREFIX_SIZE];
+	char buf[PREFIX_SIZE] = "";
 
 	BUG_ON(!descriptor);
 	BUG_ON(!fmt);
@@ -655,7 +660,7 @@ void __dynamic_dev_dbg(struct _ddebug *descriptor,
 	if (!dev) {
 		printk(KERN_DEBUG "(NULL device *): %pV", &vaf);
 	} else {
-		char buf[PREFIX_SIZE];
+		char buf[PREFIX_SIZE] = "";
 
 		dev_printk_emit(LOGLEVEL_DEBUG, dev, "%s%s %s: %pV",
 				dynamic_emit_prefix(descriptor, buf),
@@ -684,7 +689,7 @@ void __dynamic_netdev_dbg(struct _ddebug *descriptor,
 	vaf.va = &args;
 
 	if (dev && dev->dev.parent) {
-		char buf[PREFIX_SIZE];
+		char buf[PREFIX_SIZE] = "";
 
 		dev_printk_emit(LOGLEVEL_DEBUG, dev->dev.parent,
 				"%s%s %s %s%s: %pV",
@@ -720,7 +725,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 	vaf.va = &args;
 
 	if (ibdev && ibdev->dev.parent) {
-		char buf[PREFIX_SIZE];
+		char buf[PREFIX_SIZE] = "";
 
 		dev_printk_emit(LOGLEVEL_DEBUG, ibdev->dev.parent,
 				"%s%s %s %s: %pV",
-- 
2.31.1

