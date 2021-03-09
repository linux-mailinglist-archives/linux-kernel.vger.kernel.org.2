Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8653333088
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 22:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhCIVAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 16:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhCIU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:59:39 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AF3C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 12:59:39 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id y124-20020a1c32820000b029010c93864955so8124983wmy.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 12:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z5Cepyi5kn4wd4FWddheSiToZBY6ONr0o29KGf5Ep/4=;
        b=FXoeK8pn7/bXwIkDmDTwdjVh7uXQLo/AGBs/r8JIhOCGq0Ytp4GqAEu/Siww4WuqD4
         ajA/2B7afZT5v/SQG01tiGUiwgKGV5AyLhDQZmVKxWIGqGjpg/6jcPGuWxIRH9jHDZ6I
         rhJn4GmbbWKBpqu91tB7B61FIeaROPWMPRQCMmMFMFHuNqYYfFmXEAdGSmQFETQByBIY
         FUaES4hpJkpy1y0UhgNaTmccj4yfHJ7bHzjh7zRSH/ebV/OGIi1ZWswzDlbAlAgb36fU
         f9zTvmHCNqxxtM+2nXW4UJEk/MwSNUpmPxq497HvCdavd8cOODvfbgPqlfJ4zQFZgdyD
         8S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5Cepyi5kn4wd4FWddheSiToZBY6ONr0o29KGf5Ep/4=;
        b=jxmZaeSzJsQJj2V7dSfX1e5K7ibWiF1mdMTgGu+ghuQrxFTLfULTYcE3OPuoGdk6BB
         YwAeyDrbN0OJePOJLEnQ9Ze6VZ6ix1SMGMWp9ro110+xvZOVGSnlUhtIx7ojpi8Ifjdf
         nIKtrCUb9PTZQrJXI41IqVAjUFMlILH7bieV7OGsZ+HwQU7BdJwGz+ZVj4TF3lVPRqXS
         PjSH3pYV3QGOXMLjyJfUUbswOeqzM0jPZHRESpCmAgN6GfnJwb/QpOxeCNLB1p9botWo
         EhnZqKH7/T3qS7AlIYH3daBBEa+qvNw8LgA7bYNkowTrUpDuG7d54k8d1NgcqdHfMVfQ
         CKnQ==
X-Gm-Message-State: AOAM530tkDfha7cyliC3VGd2JsNgwtLGX/pDbnZKn7me6VgOZIWMZTL2
        QR8ac0+cHQLG+KPJ9b67Q1Wq0g==
X-Google-Smtp-Source: ABdhPJyImU/76uTvFHR22HNq1CjEupG6hD+pTOB9kEZ0oUpMwPkyYvd9LBO/0LbdX2Ynalo7Ab6YLw==
X-Received: by 2002:a1c:7fd8:: with SMTP id a207mr5943463wmd.40.1615323578115;
        Tue, 09 Mar 2021 12:59:38 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id j6sm5501305wmq.16.2021.03.09.12.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 12:59:37 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 06/11] lib: bitmap: order includes alphabetically
Date:   Tue,  9 Mar 2021 21:59:16 +0100
Message-Id: <20210309205921.15992-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309205921.15992-1-brgl@bgdev.pl>
References: <20210309205921.15992-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

For better readability and maintenance: order the includes in bitmap
source files alphabetically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bitmap.h | 4 ++--
 lib/bitmap.c           | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 6939a8983026..3282db97e06c 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -4,10 +4,10 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/types.h>
 #include <linux/bitops.h>
-#include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
 
 /*
  * bitmaps provide bit arrays that consume one or more unsigned
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 75006c4036e9..78f70d9007ad 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -3,17 +3,18 @@
  * lib/bitmap.c
  * Helper functions for bitmap.h.
  */
-#include <linux/export.h>
-#include <linux/thread_info.h>
-#include <linux/ctype.h>
-#include <linux/errno.h>
+
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
+#include <linux/ctype.h>
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/thread_info.h>
 #include <linux/uaccess.h>
 
 #include <asm/page.h>
-- 
2.30.1

