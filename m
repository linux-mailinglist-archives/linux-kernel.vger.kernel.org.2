Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE8D457E9E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbhKTNEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbhKTNEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:33 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B68C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:30 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t30so23118627wra.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZHQtZLBSeGGfLR9u9dhHwQrham8V5I33M1q5ZdOscw=;
        b=F/BtnKI7pXkVqHkvRGf/s8Yxn6cNiU08oAGoPXbrZYrf5DJ8MtN9kqfrRCzXhbuXIm
         4FcfBMk9H9FCpOaEU2vIMSlA05qSq9ZKfvXB8FIj6JXGU/1+vNmAQpLeKNVjuAPUl/IY
         +U3qWjAX8dIKT81yXq4e4KAAVxVwCx7HWSsUWPZvvZDsmtQI4559HyagO/PMyjb35dMY
         zU81l6YD9GBICELtjtYQBqbfzR73e7aG0etmlb4MNckTicLZjulxxrKBjE+ocnwotdtv
         qjT4GXOzyH6T/GKN4suIcx0VgPmz9w3mhCWHq9z88BxwQty64+Dv/BcA0hV1ju8oKLbP
         9u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZHQtZLBSeGGfLR9u9dhHwQrham8V5I33M1q5ZdOscw=;
        b=nSRyiIF59jogA410KKWKhXlR74R9i/ZL5FFTHoAcv4TS1tRz7KloDFcFILtwCPEcXj
         mIAEAqS1QTS9zhowJWCAGhXbF7KI325KMy5n+oRGoJB4T9t4X8ZN6Qclkb5fuU4cBoTt
         Ezjgi7cb4EI/CqFcZgHCUWgTEhMVAWALJw8NFBR/EQlneAcAvu3uDC4ywv3L7qFd5Xfg
         9jfblbamAasj606yzC/tOWZ4ugvVtxvPs/5NaYk4cLEWAQKHxqilMAMF9Oltfzm1HN7E
         LSc60Lr8rA3PHM1jbSxlKxttgGsjkWMK4eZgQQ5fCgOOwQbxgacx30cO0wp1lauEZw4/
         xBXg==
X-Gm-Message-State: AOAM533vfp42KzL4IxEmBFYrPjKUZNnMa4azVa3Prudf6NWaPfuIcHX1
        MXfkguwq4OOXcCKfsYDZD8eNZWS+AFdONQ==
X-Google-Smtp-Source: ABdhPJzwORhqOjAb1QRp9oi95O0ZrmwnUWoWW5QICeSZ7ko+R5m5dHGbricHvU+YIId1Hjj8TE2jQw==
X-Received: by 2002:adf:f551:: with SMTP id j17mr17749806wrp.392.1637413288140;
        Sat, 20 Nov 2021 05:01:28 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:27 -0800 (PST)
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
Subject: [PATCH v2 11/20] linux/container_of.h: Cosmetic
Date:   Sat, 20 Nov 2021 14:00:54 +0100
Message-Id: <20211120130104.185699-12-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place braces in a ({}) expression
similarly to how a function would have them.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/container_of.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 682a2a606ee9..3a31b6874944 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -16,12 +16,16 @@
  * @member:	the name of the member within the struct.
  *
  */
-#define container_of(ptr, type, member) ({				\
+#define container_of(ptr, type, member)  (				\
+{									\
 	const void *__mptr = (ptr);					\
+									\
 	static_assert(__same_type(*(ptr), memberof(type, member)) ||	\
 		      __same_type(*(ptr), void),			\
 		      "pointer type mismatch in container_of()");	\
-	((type *)(__mptr - offsetof(type, member))); })
+	((type *)(__mptr - offsetof(type, member)));			\
+}									\
+)
 
 /**
  * container_of_safe - cast a member of a structure out to the containing structure
-- 
2.33.1

