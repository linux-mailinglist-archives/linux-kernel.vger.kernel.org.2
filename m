Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D444B36D024
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 03:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbhD1BBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 21:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbhD1BBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 21:01:44 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F97C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 18:00:57 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r3so8084981oic.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 18:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1a7cDty5/5/STaW3arW/8eTDRIZYTAxcJezj1s2vgS8=;
        b=YvBmU5K6pH2TLUlTIQhZVHucbH5D3wrbDfvO/WRIrTti1pVU0cDNpPnEoV4VfO7dJW
         /q6PFVvHCiwjewGHuiugeMmvYTB0CTT7SHEG9F8kQOaTLdeKDfED67IDgf1SrDtwK3oK
         mEN/WkZo5KAr4utt9mZ+uiI8q24rslUFtgfwaKJknC+cMWNnXrQR3Ky3zAjHRNk/n85o
         z/bIdsG9k+Z6NFzAy6z0HdfwiDyAEZ97IvAtdC/RsMfKiJmij+a8S1yvRW9Fu3fZvb7a
         2UhD7dzIXqH/NLVAKdf5azboPsNCq3J39b8q13tkvgBMwOEIRc8e1VgMf4158VX0S5zw
         EZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1a7cDty5/5/STaW3arW/8eTDRIZYTAxcJezj1s2vgS8=;
        b=KV/vdoRUhT/Vo5UeuWdKP++10q7is3WFoLuYUQy0K9QCIb3v7CoMYMCjQ2GuNbJ7+e
         NSN4RFg2KeSj4FRMz/ACYOLbjbJKIGkhGKbwvqxNHmHFImIhxmeU3XT0o2lq7vali9qx
         9cfkr+gfMT5HdQuguLXtYN7gyiu6tuNvis1fAcn87ebDwP6118DiFnVfT+0y1T1ICRNc
         0yj0VMz+3Viu5xksXjvEEb9vDUR+RjpQ9DIcqO6Tk9OdAXO7sHWFsAYK5iagXeU9GpAk
         olyQOGqlPk5DGtu5JGSZv4o2JyFT5mWiCxXs+UrU3v6tdj61bHbNoTXI8lNA0D1meZH9
         Nuog==
X-Gm-Message-State: AOAM531hnco4CX7RvlukOruLla2TyQKvY1l8k4lBIW8YD+qpf16QsJWW
        jLt/jOiT+/vHWHoBfeyNIyk=
X-Google-Smtp-Source: ABdhPJzYNjYAZnR6ciywvOAFkdK2hSd/1RK1bPxFyiSNg5EZ2DIhjUjGIbU6W2sYE5S9hXLcezugbg==
X-Received: by 2002:a05:6808:2d0:: with SMTP id a16mr9756810oid.116.1619571657128;
        Tue, 27 Apr 2021 18:00:57 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id 34sm339004otf.38.2021.04.27.18.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 18:00:56 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 1/2] dyndbg: avoid calling dyndbg_emit_prefix when it has no work
Date:   Tue, 27 Apr 2021 19:00:30 -0600
Message-Id: <20210428010031.571623-2-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210428010031.571623-1-jim.cromie@gmail.com>
References: <20210428010031.571623-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap function in a static-inline one, which checks flags to avoid
calling the function unnecessarily.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 9 +++++++++
 lib/dynamic_debug.c           | 9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a57ee75342cf..173535e725f7 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,6 +32,15 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+
+#define _DPRINTK_FLAGS_INCL_ANYSITE		\
+	(_DPRINTK_FLAGS_INCL_MODNAME		\
+	 | _DPRINTK_FLAGS_INCL_FUNCNAME		\
+	 | _DPRINTK_FLAGS_INCL_LINENO)
+#define _DPRINTK_FLAGS_INCL_ANY			\
+	(_DPRINTK_FLAGS_INCL_ANYSITE		\
+	 | _DPRINTK_FLAGS_INCL_TID)
+
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c70d6347afa2..613293896e47 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -586,7 +586,7 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
+static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
@@ -618,6 +618,13 @@ static char *dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
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
-- 
2.30.2

