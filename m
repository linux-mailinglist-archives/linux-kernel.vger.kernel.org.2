Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4312A457E97
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbhKTNEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbhKTNE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:26 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A6EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d27so23200219wrb.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oiWSa88eBlZ2IsrfTEOdS6jktFHipDta61FarH7rzSc=;
        b=fSzUntzvSOKeJvZIza+Roo5ruvkhrHQWY99v0XgBjIIyq8s87gDFed1jUoIjDbW1my
         X72kr2wg9RC3fLE5RUPTG4pqectE4ccFMU7Cj107qPcQH2N7sHvgApmmlrQpBwyG1bbM
         4YcwJDQwp10LZITEEJnW9EB1j6xRBg+ICrGfMtNQkgbES9rmk2JiA8ZYRCabcqi8Qg5P
         lr013NcGVPXc/AGN5MIQeio9P+mmUYsScgPDTWHOWxjfP4do2u8aRF3aMgi03E40RYK3
         Jrsi6k3mH+6D1vGKXXlPlKi2nZfBofEA5UjP8D0jvwrUPLPl1OWjIJ89Aq0vXKMpp86s
         w39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiWSa88eBlZ2IsrfTEOdS6jktFHipDta61FarH7rzSc=;
        b=iEHMkB4LrWSk3Z6dfjmobEMWlnMtys0YFW2pkHFRBMFZJz8Ni3fq36uKOmtU0YXC2Z
         HWZHRqeyLMbP06NnUDsHuUB2X5yEZUU+uzDISUr+TVfqv9aipyGihVHwvkmJxVTQn/6B
         uC1q4pMpo3+WhqVUDYHxlCW6djAiZsZHdnod4E7WhOyvGxIQQQ8tjEkz4REnouif7dKg
         KBLStSRIpd9fejGEXCzLaujc2ejLrlWNVn9cFmq+5XP5HBGvVYxXNRswCxbsfes7m+/6
         S9BPoIEM6+OH57ZC03PY3CqGxcF1aLtnIA9K0ebADqHgk4j5ddRDRKaJYbeAI+dzWFXP
         IV8g==
X-Gm-Message-State: AOAM530GKEmrecpzgnsANuxVDmvPVn/9eJ7MhCWqgVZBAIcsSRwjsO1l
        9FsQO+sYmx3OUP/YXS2Rrm9Ys+I0QHHbOQ==
X-Google-Smtp-Source: ABdhPJw/YUCIjGFOylX2x7k8l+KcBnKFKWbEc+iOmFDhWBeocyclZGCGKZAHecrIsC8+/IJlGTJfVw==
X-Received: by 2002:a5d:4411:: with SMTP id z17mr17084076wrq.59.1637413281830;
        Sat, 20 Nov 2021 05:01:21 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:21 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 04/20] linux/stddef.h, linux/NULL.h: Split NULL into a separate header
Date:   Sat, 20 Nov 2021 14:00:47 +0100
Message-Id: <20211120130104.185699-5-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include <linux/NULL.h> from <linux/stddef.h> for compatibility.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/NULL.h   | 10 ++++++++++
 include/linux/stddef.h |  4 +---
 2 files changed, 11 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/NULL.h

diff --git a/include/linux/NULL.h b/include/linux/NULL.h
new file mode 100644
index 000000000000..f09d8baecc80
--- /dev/null
+++ b/include/linux/NULL.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NULL_H
+#define _LINUX_NULL_H
+
+
+#undef NULL
+#define NULL  ((void *)0)
+
+
+#endif  /* _LINUX_NULL_H */
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index c2e7e5051ef3..3f7ddcd5e0aa 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -5,14 +5,12 @@
 
 #include <uapi/linux/stddef.h>
 
+#include <linux/NULL.h>
 #include <linux/offsetof.h>
 #include <linux/offsetofend.h>
 #include <linux/sizeof_field.h>
 
 
-#undef NULL
-#define NULL ((void *)0)
-
 enum {
 	false	= 0,
 	true	= 1
-- 
2.33.1

