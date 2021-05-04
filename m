Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72CC373247
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhEDWXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhEDWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:23:37 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 15:22:40 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e2so130992ilr.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 15:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0dKzQPSJ4r2qtzCM9GT0MOdnbTquuJQ1RlBh9kMtzE=;
        b=b2c0mJEE5+xyEQ1cGPmGzIYwSGq25Zk4Sf+3lhHVtRcrcdB4Zz9FbIo692JDe1u/Tp
         Wvz8rC5LrkiSW5Fmyb++X0le0Ibzf9sl2YzcgiEI1405Ib6a3YES8clyUrhn0EAEWJ90
         HOGe1ogXe00tAX7OPyvLIWJ6DD4RB1xHUKlnQhWCmZYpovuN9chMPR9kypBaqrRHLcw5
         WmDKscwjRfnHugfXydV+pjGCBkPQwiLDiU5VQJuSwOOJpk4gEdZhTRX00h+DWklG9cUA
         7e4/YG5U/F6A9uAN+ubh6YLlyYXmweIQYjNlzwinDjlR2UatIsqhpln0XHk0YGX9iDKy
         DijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0dKzQPSJ4r2qtzCM9GT0MOdnbTquuJQ1RlBh9kMtzE=;
        b=fTItSXcAgOMvrE3QRXSy7O+3ByUE9PCMBDznjBrOu4hBhvLGUnYghe/lSxvMww3IdY
         bfFXGHH1DuqOlwoGKaAT4v5QoFdHQ3I5fILinn+GF+qC22n6zCoibatr/q73SRgZYayP
         fbJQuOVdKlBhaz5cGlC642h44fUbzkPxH95lwtjDHAyGYqDJVGP6C3jxzkvwPAsRut8N
         nYRhWWMG+yW9+vkq2VZKNqUa+9nbieui2ZZqwQ2DJXeIA3urEY3+URHH5utvK/p2G1IC
         Vf19x6REKqAQqQlrBsLk4V6bGi9geU7FgceEUFIMm5XW9lFOOn1wZBbMJmMzi83uvxxP
         Icxg==
X-Gm-Message-State: AOAM5334Ka6/eqmGA26s3VvNzNYX2VV3aWFTOQ8ivIbd2zIgnuto4uSu
        SPF6320OsJkvW1KwGuakcqk=
X-Google-Smtp-Source: ABdhPJy2N5aCg22txpxq8ZJ0KnHAOkoiZiCu/otWV+r+cKEuEsKlorq66JZmFrq+epxWsY8kd3OVeQ==
X-Received: by 2002:a92:c56a:: with SMTP id b10mr23163575ilj.6.1620166960352;
        Tue, 04 May 2021 15:22:40 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id j19sm1626337iok.51.2021.05.04.15.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 15:22:39 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 1/2] dyndbg: avoid calling dyndbg_emit_prefix when it has no work
Date:   Tue,  4 May 2021 16:22:34 -0600
Message-Id: <20210504222235.1033685-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504222235.1033685-1-jim.cromie@gmail.com>
References: <20210504222235.1033685-1-jim.cromie@gmail.com>
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
2.30.2

