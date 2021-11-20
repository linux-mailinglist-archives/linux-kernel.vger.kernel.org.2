Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB9457E9B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbhKTNEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbhKTNEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:32 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904E7C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:28 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso9670673wmf.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BM0C03VFWB/OwafjME70Ckqrmee1fP8frj4fXiJjeWw=;
        b=V4vOZji4v6eV4KFh8f3u/yOGpX/psDdDTLgCtqpscHYaDJ91n3gisEjp2WWvNEmMeu
         ZfnyUjiX9OwG5IHJukq1KNj/SX+o5eJkNj7W9S+/RgRYULDV87WTU7I3s6mFGXJ08+6Y
         FCVIwK0eBNw6WcJe3/9TeInKgAgg/hWxje1YJgLnBhJ2djE1jbEwgu+6yfUQsgeSjjZM
         7Z4uRLYREVmLoeOpEM0ljpASJtJchZ9UY1cglfVD+yjG41mMyHAzV7Yg9dsUQxKaZeRS
         +vuzDRp47rHiE26DeAiae9+CyVy9rC5G1yPc7e1q85MMSVbfAxKHrzFTNG5Z2XSOrfoG
         BPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BM0C03VFWB/OwafjME70Ckqrmee1fP8frj4fXiJjeWw=;
        b=swFomTGHL/UmqdhAsdajKYRWMJLt4sESxcYLt2FUkdz26qDkOG87f3Vml4SW09rF41
         djb8hwiiMC92ZZtMifx74+KBFtQ/1h9lqnfixxP8EGaqcXCFf5qbSxHRkVbLZXqqhtC5
         IAVqIOCXo2mZ2oBSzPjIFlGT9jnG2UAfm0oKsjG2AyidvQ4fEGdsqlzifYyn+N5nlDci
         dqFayELQNxnPiEZ20Qky7c6gpz3v3j+DoTMT8w4Ft6tBt+gCWGyI2R8Fhcwhoywhs6ld
         AGBfZ91bOHejiM6pduvjCO68J/0nnWaMPULZDKVoCzxZRZBOZcQzwGjYybmchOshjeqL
         yS+A==
X-Gm-Message-State: AOAM530nSoltIY6MhEi9UrJhRN70dpOxefaIFQyg1yZu2bxqkP898GRT
        ZNu7Io1mwrZKBmFKrUDOBbvV9rL35z1vuA==
X-Google-Smtp-Source: ABdhPJyTz1MJEEy0nTKJFxygfMy3gS2/h7rmKBqLev+35ce1srThTtWEnjmaliJm7QRtgDAMRrNzkg==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr9666868wmb.174.1637413287252;
        Sat, 20 Nov 2021 05:01:27 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.26
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
Subject: [PATCH v2 10/20] linux/container_of.h: Remove unnecessary cast
Date:   Sat, 20 Nov 2021 14:00:53 +0100
Message-Id: <20211120130104.185699-11-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casts are dangerous.
Moreover, (almost) everything converts to 'void *' implicitly,
with the exception of pointers to const.

Change the temporary to be const,
and therefore allow implicit conversion from everything.
Since we don't modify it,
this also adds safety.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/container_of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index d1a66e72d246..682a2a606ee9 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -17,7 +17,7 @@
  *
  */
 #define container_of(ptr, type, member) ({				\
-	void *__mptr = (void *)(ptr);					\
+	const void *__mptr = (ptr);					\
 	static_assert(__same_type(*(ptr), memberof(type, member)) ||	\
 		      __same_type(*(ptr), void),			\
 		      "pointer type mismatch in container_of()");	\
-- 
2.33.1

