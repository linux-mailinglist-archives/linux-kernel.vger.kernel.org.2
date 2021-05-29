Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EA7394DFC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhE2UDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhE2UDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:03:40 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68661C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:03 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id n3-20020a9d74030000b029035e65d0a0b8so6960427otk.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sTUPuFc66ybePyVc1BipkRA9wzdceMEI5lxpFNGBTY=;
        b=Y22QGFoCh+H86gyn9A6r1Br3yQwjscRyIEu52DXcDQkT6ETk3lBYrOQTumvQOPaDss
         LNuQ/5lJJsdQwecunogECNGNEbxZY8duzGCmyO3OKtCI6OGcyrOQOu99CWEghv3hE50w
         C3dE8HoGjsbAiMcCCjFuEgHQ4nImoJ0UM6/QkOtBbQPaCTcfYgWVhwfwhqw9wNz3zxmf
         lqJDljl2ft0oP1wZ7jxkVrx2OcF9gWrtNnYglrYATBOA1d4oYJ+Me8xLcGuhK42g9Gu6
         a8Hr3hKQAU+9r8128+1eSenRxylCnUj+KKedpub2aVfQ6RMUdvS2RaqHtQg43/NNyz2X
         xnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sTUPuFc66ybePyVc1BipkRA9wzdceMEI5lxpFNGBTY=;
        b=iVF5VMLVDUqxxDahqFtnkhd1psomAVbmgV+Zy0H4+AuNm/WRDM/HgIyRIRUypOXIT1
         TossHs6UkFuphse32oDr+1Sgg2OWoW+FcKJrD9yidMj2/UEeRXxsM6JeDCJfg0E8Xqs3
         8qeE37CH3Jt86lKr4WNYp1Dc/RQ5I2iWyayZY1rU6y5mLxeOmrCAIZpd3JtAYy0mVXd2
         CeWJLnKy1ZyHMNnY1Qth1IWPX7GTR7GFZfwzyf5AhS10whcr4fPqONDdp63cRaJdaeop
         xoi9NTrZOceB3JEQaAxpE9IqMu/4//VeIaGNNLIVy27YcmWuXNY3p3fZ6pmmvcl4L9fb
         B7uQ==
X-Gm-Message-State: AOAM532i+auOJxfGPm9bt9klA3PWmuXzBSEmGuWorfk9bl+G5uKfnxxc
        z/5XLJOSpIkT5Muk2rXebHQ=
X-Google-Smtp-Source: ABdhPJy9/iQdnhueuYVirWTEPtLHoIRFi3yXpkgJ/UIwGqF1nwtJvIm4uGi7GU9WBxk9lbOShAaq/g==
X-Received: by 2002:a9d:7286:: with SMTP id t6mr1824738otj.6.1622318522751;
        Sat, 29 May 2021 13:02:02 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:02 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 01/34] dyndbg: avoid calling dyndbg_emit_prefix when it has no work
Date:   Sat, 29 May 2021 13:59:56 -0600
Message-Id: <20210529200029.205306-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
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

