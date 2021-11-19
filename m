Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D17A456E67
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 12:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhKSLky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 06:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbhKSLk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 06:40:27 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3B8C06175C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:23 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so7252558wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 03:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iFtlxVJvdAuPAc/EiXaKX93c7PUCpTaei7agxIgnYJ8=;
        b=Zc5rWcVIqkCO7Yz+KeRHDBOe4bJC3XSd2MPbKzgpISBffZLXFCqODY/6zQWEqtk5wL
         /1208WOUr7MCOiscwXxlYC01XgNLgJRxxpvEkV/k6mG5hKWgMO1UQe6c4k0cCHWMiEKz
         A9iH0cx6+qw35AOJWGLMDC0dHj4FOX+Fzi1LRj7BzeqsuyGTZSOkUJUV0zqD0GAw56Cb
         YYmxbsIi4p4qUvPkW2W6fmTTgn31tz0FjyIDRyUFkxgo7vbLolkOtLfzAjDIbxNUwzPR
         iXVuoL/MVkaN/5JL7ijuc7s9Bw2PqXbPhT21vJjuV3ojOm8ajZQrfK7NS7F2za88ByIE
         G9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFtlxVJvdAuPAc/EiXaKX93c7PUCpTaei7agxIgnYJ8=;
        b=v1RP87T02DtUedRGi9smasrMl3epqUJnPsfuc0wQ7AQGnUWovkcExF4Jp5LHtErwfs
         dAX6PQMiJkq2VPhw1SdOZBXuqz494iLFsCfxhSvGUTkWVlSf9vRvkAjKoZtmJ2uZMK5Y
         XbCkN37oijPPjya1bxSR2boQyuVXB94m1nj6yfQOjyQART73xj8WlUvl6nGsRj7pdylA
         k0vzJRBcVKdVw6bPrBTwBVr020s4LngSwghQta2XZ/JGt57GW9Hln/AT8b6XdBabrjf8
         5q+enNqHfrDyfC69YWs4eOJGvCdhWzg9nyOqpqfFk5aGIn76d4nhlYa0+mNgazq3wG3S
         apKg==
X-Gm-Message-State: AOAM531i0FUEZTW/TlNBJLCf3t0rlwG6G2Gvjoi4+cVZXNRctIZ4t3pV
        WkYPpII3SordLVp8m+Sppn5fhmlwIipBpg==
X-Google-Smtp-Source: ABdhPJyvyqjAuTnklfxHp4jsL7ty/miawNoL69KVS26mzJnIif88zZwGyFcYYtZixquFfICnBeLUaQ==
X-Received: by 2002:a1c:a5c7:: with SMTP id o190mr6094043wme.186.1637321841928;
        Fri, 19 Nov 2021 03:37:21 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id f15sm3361260wmg.30.2021.11.19.03.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 03:37:21 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>
Subject: [PATCH 14/17] include/linux/: Include a smaller header if just for NULL
Date:   Fri, 19 Nov 2021 12:36:42 +0100
Message-Id: <20211119113644.1600-15-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119113644.1600-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/extable.h     | 2 +-
 include/linux/string.h      | 2 +-
 include/linux/ucs2_string.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/extable.h b/include/linux/extable.h
index 4ab9e78f313b..7650a7adce76 100644
--- a/include/linux/extable.h
+++ b/include/linux/extable.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_EXTABLE_H
 #define _LINUX_EXTABLE_H
 
-#include <linux/stddef.h>	/* for NULL */
+#include <linux/NULL.h>
 #include <linux/types.h>
 
 struct module;
diff --git a/include/linux/string.h b/include/linux/string.h
index 2ddcd560659b..5a22a93c53f5 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -3,8 +3,8 @@
 #define _LINUX_STRING_H_
 
 #include <linux/compiler.h>	/* for inline */
+#include <linux/NULL.h>
 #include <linux/types.h>	/* for size_t */
-#include <linux/stddef.h>	/* for NULL */
 #include <linux/errno.h>	/* for E2BIG */
 #include <linux/offsetof.h>
 #include <linux/stdarg.h>
diff --git a/include/linux/ucs2_string.h b/include/linux/ucs2_string.h
index cf3ada3e820e..c05242de728e 100644
--- a/include/linux/ucs2_string.h
+++ b/include/linux/ucs2_string.h
@@ -2,8 +2,8 @@
 #ifndef _LINUX_UCS2_STRING_H_
 #define _LINUX_UCS2_STRING_H_
 
+#include <linux/NULL.h>
 #include <linux/types.h>	/* for size_t */
-#include <linux/stddef.h>	/* for NULL */
 
 typedef u16 ucs2_char_t;
 
-- 
2.33.1

