Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA5A443054
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhKBO1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhKBO1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:27:11 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA2AC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:24:36 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id t7-20020a4aadc7000000b002b8733ab498so7464658oon.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JI0Ej4DOcNCkfUFyUyiO9iOW2E1mQQJnZ1aAxjyxxx0=;
        b=a7nMNY8e7XhoAQX6x5gKIFRopgM4d9faZSm2ckKytem4akNvEDG00LCf5uPAk5l9D9
         mKZPEQTqVcERalHxJbqIxhi3NkP1QHIJp1Ss/Snz9Uq53V5EXbeLKGWZk0Ho8Yc3AM0p
         rWPEstz+QirAEkluGjoE7mWnvQ1K/bNYgR2X9jkrdE68dJzsKrCGaW2uHHmgyhzpZ6Qe
         /LMXoybczXQKIuhKfb0miuj9cXredGiLGScvFeSjZeriFb+VaUXw2Qi9hFVwWv8yYeAZ
         qsXAX6iPfU/Wn2IjqB7UqYXtOJUA6aALah8zTZWVCNrJ8/2M5BHPzoRujj91UZMeAKmv
         NzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JI0Ej4DOcNCkfUFyUyiO9iOW2E1mQQJnZ1aAxjyxxx0=;
        b=4IXOHpVN480XBZTp83+S4v0U/QCiiw+608Zj/7XokvXxDL8j3T9olTJGalyFJcSo6w
         c46APe6ZVpvBZpN9tBJXmKTOXJ40U+9obB1lmjFOt8hyk2rn9Ti9qPFTE4PLFU7Zsnkn
         0GKniZamfnPfuRvD/TXhnZZixO9CKgjpY/YR3f8VQPwLmDAvdDIN/IXFtLqEOmgvNUax
         GxNEp4vv44qRNHSX8ybB+VpgrcLNqKBJrP6SyeIGKaMfVNiVIVQAOZPtO7+uae6THoc8
         9LXZi6s/s7xalG0PQYEebCzs2CUi0M0gaewU01YELo5Fc4qo/qd2PPKd3pm9bHYbMv6Y
         Y+Jg==
X-Gm-Message-State: AOAM533gWdiEBTl6cvTtWEUA2wjbVVXS6iRJCuUmmNeRPGSq+VILuOJx
        W2GjYRcGnwAIUYUkcSqlDIkzvQwauOA=
X-Google-Smtp-Source: ABdhPJxatjbHrHxxBgFnrFEk6R0/L4G01foHF2xYaS3i+PSPbBdZUu3DNQpgFaJRlp5n7Wc3mB+KUA==
X-Received: by 2002:a4a:6412:: with SMTP id o18mr24923792ooc.79.1635863075966;
        Tue, 02 Nov 2021 07:24:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t12sm3744026oiw.39.2021.11.02.07.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:24:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH] string: uninline memcpy_and_pad
Date:   Tue,  2 Nov 2021 07:24:20 -0700
Message-Id: <20211102142420.3723616-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building m68k:allmodconfig, recent versions of gcc generate the
following error if the length of UTS_RELEASE is less than 8 bytes.

In function 'memcpy_and_pad',
    inlined from 'nvmet_execute_disc_identify' at
    	drivers/nvme/target/discovery.c:268:2:
arch/m68k/include/asm/string.h:72:25: error:
	'__builtin_memcpy' reading 8 bytes from a region of size 7

Discussions around the problem suggest that this only happens if an
architecture does not provide strlen(), if -ffreestanding is provided as
compiler option, and if CONFIG_FORTIFY_SOURCE=n. All of this is the case
for m68k. The exact reasons are unknown, but seem to be related to the
ability of the compiler to evaluate the return value of strlen() and
the resulting execution flow in memcpy_and_pad(). It would be possible
to work around the problem by using sizeof(UTS_RELEASE) instead of
strlen(UTS_RELEASE), but that would only postpone the problem until the
function is called in a similar way. Uninline memcpy_and_pad() instead
to solve the problem for good.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Moved to lib/string_helpers.c
    Balanced { } in if/else statement to make checkpatch happy
    Added Reviewed-by: /Acked-by: tags

 include/linux/string.h | 19 ++-----------------
 lib/string_helpers.c   | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 5a36608144a9..b6572aeca2f5 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -253,23 +253,8 @@ static inline const char *kbasename(const char *path)
 #include <linux/fortify-string.h>
 #endif
 
-/**
- * memcpy_and_pad - Copy one buffer to another with padding
- * @dest: Where to copy to
- * @dest_len: The destination buffer size
- * @src: Where to copy from
- * @count: The number of bytes to copy
- * @pad: Character to use for padding if space is left in destination.
- */
-static inline void memcpy_and_pad(void *dest, size_t dest_len,
-				  const void *src, size_t count, int pad)
-{
-	if (dest_len > count) {
-		memcpy(dest, src, count);
-		memset(dest + count, pad,  dest_len - count);
-	} else
-		memcpy(dest, src, dest_len);
-}
+void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
+		    int pad);
 
 /**
  * memset_after - Set a value after a struct member to the end of a struct
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index faa9d8e4e2c5..d5d008f5b1d9 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -883,6 +883,26 @@ char *strreplace(char *s, char old, char new)
 }
 EXPORT_SYMBOL(strreplace);
 
+/**
+ * memcpy_and_pad - Copy one buffer to another with padding
+ * @dest: Where to copy to
+ * @dest_len: The destination buffer size
+ * @src: Where to copy from
+ * @count: The number of bytes to copy
+ * @pad: Character to use for padding if space is left in destination.
+ */
+void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
+		    int pad)
+{
+	if (dest_len > count) {
+		memcpy(dest, src, count);
+		memset(dest + count, pad,  dest_len - count);
+	} else {
+		memcpy(dest, src, dest_len);
+	}
+}
+EXPORT_SYMBOL(memcpy_and_pad);
+
 #ifdef CONFIG_FORTIFY_SOURCE
 void fortify_panic(const char *name)
 {
-- 
2.33.0

