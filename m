Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB2133897C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhCLJ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbhCLJ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:57:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1744DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:57:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so11846359wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z5Cepyi5kn4wd4FWddheSiToZBY6ONr0o29KGf5Ep/4=;
        b=ZPhPW46iOW6zgVG16Tssfvtlo0VFb/b7BiTO41lTOfqtnMCnKSBy4xNDCj6ybIhhCE
         lpYTCRzS3pxVIBV2AKxshk7HHNG35pyIR6cNs7MSCQRdnIDlPdd29vKS8+CZUYyYgWKM
         P4mJ1MkhbLdQjNeR5tWDZIEUw3u5+3H9eNwWag3Y+l6EbF8vTVunpZq/6HWh5weSQeTC
         q+wAi7w9nvM9tQgUh0npQr022ocjmZ3Pjh19VLfvTvgvx9qeNBTpv/s8RCfVmHVwvlCt
         SaV0dDqf3MB8BAcQFGQu7OyODP/cZDfyffgAacgPHhrK56NIM2nZgaRh8T/6XT2ASE6r
         TKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z5Cepyi5kn4wd4FWddheSiToZBY6ONr0o29KGf5Ep/4=;
        b=h1Lu4Ia/bs+lCKSJw4Zy+3O42RizaficjW85+nfEnBhAixKn3z9KWnB39urF1TP2At
         5+L296gg/cpLYnBvOnL5+MrFZu2yOPR8xBLQF+kq4qxpTTFA8vItK4lPuUP3OTejte3s
         06yW4XHNAvxlj5Yz5PARbRFV+b4VrvFRkWjoMl1Hl1/buRHz4Z1H2gOkVV23HT1PZcGi
         V5rIjoUUgTpwIKs9vl9Zfjiv6KjXZCHPxwKA6udkQxQnA+lZBirjE8fIKWUSS9Y/lhav
         Omh0nTd+OcEsS6RQ7pbbysC2CKwdydP45JIOdlOqHYnX7qhx1u/OogBPDzWeY3DocdNV
         /K0w==
X-Gm-Message-State: AOAM5308XWffcZfKfpJ6N3pZ1qkpX67Djr2ImbrO5cjBATmo3M3uUG2A
        hx1nwUNmmKPBWe/t+4jaJjUdUQ==
X-Google-Smtp-Source: ABdhPJy3VYnO3BJ25zKsGkueo1Aoa06gRHj1GRZznrPxCV/2vQSy85qzayRrJ1kZrJY54h8PGQEnTw==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr12381331wma.10.1615543047865;
        Fri, 12 Mar 2021 01:57:27 -0800 (PST)
Received: from debian-brgl.home (amarseille-656-1-4-167.w90-8.abo.wanadoo.fr. [90.8.158.167])
        by smtp.gmail.com with ESMTPSA id x13sm7031630wrt.75.2021.03.12.01.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:57:27 -0800 (PST)
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
Subject: [PATCH v4 06/11] lib: bitmap: order includes alphabetically
Date:   Fri, 12 Mar 2021 10:56:55 +0100
Message-Id: <20210312095700.16277-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312095700.16277-1-brgl@bgdev.pl>
References: <20210312095700.16277-1-brgl@bgdev.pl>
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

