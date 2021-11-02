Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FF9442668
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 05:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhKBEdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 00:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKBEdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 00:33:07 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D17C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 21:30:32 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id o26-20020a4abe9a000000b002b74bffdef0so7006772oop.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 21:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q5B29hQzjMrMs8nN7SPdiKqKjScpJ832DxNf26q1Wco=;
        b=HZZuWHI13UQD9Wza9e1Atq7YO6rbIIhybqJXhIkRy3MsBtllHyeDwy5EY+phplxeMp
         772qvxf7YKA595lX9+M4xEn4sNop+31qd8fJiSpSi5ZK8EWixVwJG2BfAKZ2lJUSVd/J
         M6+FrD04PMCviklJUwgaYw7eLzkc65eCGY2kp4C6r2T5wjAxSo5453t7dFCLiWCJ4e4R
         DlP4jKwYWM7eREzwUgTsTcgChOOWm2y/DYYWrMfRv0pH8SdTEnKkEwSI/85FmIQUubgq
         uljBfy5vDfO/FHU7g9JVXziB2AoFXCp7svEXLjCV5y7IuXdOKo3jDsFAZEgCG/JcsWYG
         HACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Q5B29hQzjMrMs8nN7SPdiKqKjScpJ832DxNf26q1Wco=;
        b=jME2z49nzNg5q1JzNZhKn5/PmkLLGp0v+9rGW7Vka7Pl878ZS4nWTo/YEUXGFlqDe9
         htqB7JfJk6UwKCu4Y8SGZCvuberW0DMdH//g4cCC/z989tPLa3KKNQG7LX6TTDVlaxjf
         6mlDw7YH7YKHOFdC7XSZSneuj2iKkzvQudY1eRQ6Y/a2hnJW7pgOio+l5NQYPSPycdlb
         obQ/n7GZqkjYRCnwLI4Mu9YiiTtRLr+pXcR6bEK+95DX5lk+72e1OeF6MFtT0PmziiPU
         CiBfmmm9s4kZXKsD9QSECHc34/eztQkgbli0LJpXA3s2FvRu73BcaO3TrFmGbQQXkoLg
         /6Lg==
X-Gm-Message-State: AOAM532E7H4ucapXKpQwDeHLBLi8Y/NUpRigKF1TCUAkqoMa5++/wNok
        D8t74Ugo5NB5htb5eqg1WlOYEOTGOYs=
X-Google-Smtp-Source: ABdhPJxtNdy0Ao7oOs4Ka6mIY8aVJidserlDrENxOCoa0gssi3DnuFPjhip+Rr4VQSuenk/2c9uMnQ==
X-Received: by 2002:a05:6820:504:: with SMTP id m4mr16020617ooj.62.1635827431676;
        Mon, 01 Nov 2021 21:30:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x8sm4561273ota.75.2021.11.01.21.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 21:30:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] string: uninline memcpy_and_pad
Date:   Mon,  1 Nov 2021 21:30:24 -0700
Message-Id: <20211102043024.449478-1-linux@roeck-us.net>
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
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/string.h | 19 ++-----------------
 lib/string.c           | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 5e96d656be7a..d68097b4f600 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -262,23 +262,8 @@ void __write_overflow(void) __compiletime_error("detected write beyond size of o
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
  * str_has_prefix - Test if a string has a given prefix
diff --git a/lib/string.c b/lib/string.c
index b2de45a581f4..ff13d6d77a05 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -1165,3 +1165,22 @@ void fortify_panic(const char *name)
 	BUG();
 }
 EXPORT_SYMBOL(fortify_panic);
+
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
+	} else
+		memcpy(dest, src, dest_len);
+}
+EXPORT_SYMBOL(memcpy_and_pad);
-- 
2.33.0

