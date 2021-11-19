Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256E6456E60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhKSLke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbhKSLkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:19 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B3AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:17 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n29so17588266wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+9nzWUvvcgEzEhafkWz2zZTkmKS7i1sb5UkaSuxFExo=;
        b=AcTCkA76yyKxaE98mNiMgvJHn2sm66tNUrBwcjEhlCwP4R4i+sXnaXyAl09khnKfnS
         PBrnxMfmpXPi6psy1lqDPI9FWMdLCWiA8mI6rCaYsYWXJ8nunw4kO48evYCDJ5FYR78S
         2DMYq25a4lrAeiZvApN41bRE47bnYXgF8z4xhudK/5M/8NXNDpycQAq3XYWp8xPITIgN
         YTAYVNIj4DB+lKb1xb/s4a71AiKzI5vmEHhnpFFBSSmwxJ3NeG1zyBtf9LwtHXXk5q2S
         rhUlwau1wdhiyABCrct2fPTqqPYwafVxBxAK/Q1VGTbUbnR2vmOQwI8cD5OZnSu8HEQ7
         wErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+9nzWUvvcgEzEhafkWz2zZTkmKS7i1sb5UkaSuxFExo=;
        b=7IFv3fiRqSLxp8bffyEFDm2YsL4kRo1kH2XTPnlgfdT9P8xlENIQ2pHrsVrqc5xgNz
         tSVepp4DUCP8sepR80gZMFERur3AhTI58jab47HF79h+WQd8SYtGgi4hTk3KIvHxltId
         73Mdx4OGNzz7fcXJmtZqjH2kjvJMa0R9U4gQzLPiKNE+oxzrv1/slVPL+w+HMySbRZUN
         TDPlbr7jCcd9yfaHF1+bPPRanzYnKo0vcnQ9IlfI5dunPVdBqkJmLHuZ5CjwNjYewyVY
         pKt3j8jopLsOO1c/oDibxXqnjZNQmu7BJJendOUNGv78Vp71zReHLJ+zJ7K0ygzngEPZ
         0OqA==
X-Gm-Message-State: AOAM531xCiO/gkYnc4Hdh3DF0CatvB6yUZvFjRWleuJ2iRJnAAir4LVt
        NEmPltKPdwbYkjWQ97Pnj+nUUWaUaXtsNg==
X-Google-Smtp-Source: ABdhPJyn9iRuHyXSjTp4roUEOEBgX8w6+A34on9M5Ir3HLR9oPe82Qp7vzG1ZBvjvdOhCAaJnG6U4w==
X-Received: by 2002:a05:6000:1a88:: with SMTP id f8mr6555506wry.54.1637321836209;
        Fri, 19 Nov 2021 03:37:16 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:15 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 07/17] linux/NULL.h: Move NULL to a separate header
Date:   Fri, 19 Nov 2021 12:36:35 +0100
Message-Id: <20211119113644.1600-8-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Touching files so used for the kernel,
forces 'make' to recompile most of the kernel.

Having those definitions in more granular files
helps avoid recompiling so much of the kernel.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/NULL.h     | 10 ++++++++++
 include/linux/memberof.h |  2 ++
 include/linux/stddef.h   |  3 +--
 3 files changed, 13 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/NULL.h

diff --git a/include/linux/NULL.h b/include/linux/NULL.h
new file mode 100644
index 000000000000..628eacaf598a
--- /dev/null
+++ b/include/linux/NULL.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NULL_H
+#define _LINUX_NULL_H
+
+
+#undef NULL
+#define NULL ((void *)0)
+
+
+#endif  /* _LINUX_NULL_H */
diff --git a/include/linux/memberof.h b/include/linux/memberof.h
index 3853c91d1fb2..6c5eb70bc60f 100644
--- a/include/linux/memberof.h
+++ b/include/linux/memberof.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_MEMBEROF_H
 #define _LINUX_MEMBEROF_H
 
+#include <linux/NULL.h>
+
 
 #define memberof(T, m)   (((T *) NULL)->m)
 
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index ca507bd5f808..0fbbaa83a9d8 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -3,9 +3,8 @@
 #define _LINUX_STDDEF_H
 
 #include <uapi/linux/stddef.h>
+#include <linux/NULL.h>
 
-#undef NULL
-#define NULL ((void *)0)
 
 enum {
 	false	= 0,
-- 
2.33.1

