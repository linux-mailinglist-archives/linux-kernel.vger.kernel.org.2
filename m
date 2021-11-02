Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9ED5443058
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhKBO2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhKBO2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:28:01 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0D1C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:25:26 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id y11so1929330oih.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JI0Ej4DOcNCkfUFyUyiO9iOW2E1mQQJnZ1aAxjyxxx0=;
        b=G0s1ihF1Vb837BAi0gTK/HC+mrAWRPu0SXZW/mcjnujgvWusG8nXqoL6Pl5npYLKhs
         oPAXBr42/xQn+i28PVjfmWhXrU+ZIiVPcf3F//Srkr+sYCnNkd2Z+563yUyJOun7kZML
         DaoI2myEc7wXqI5VZwCSs1rbiVZRBkSihAWb/kOyd9Pl4rgdUvWUR8OAtTZ11DMTn2iQ
         96dCaQe1dlZZ1E9MeQOXJpB4+bkJLNajYbtBN1IUCv74z02Kp6xxBfg7S6i4z8hj4X5K
         SWTxgA5lxR1GEMB7HgXSdjyfNgENQg9HsQ8/P4sVUWoI6Evb+PXRLFZSoDvyoYP3Y/Lz
         Dj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JI0Ej4DOcNCkfUFyUyiO9iOW2E1mQQJnZ1aAxjyxxx0=;
        b=iI+8BsRZT4OP4gpwGyefVy5SoER5z/UDVnxgPOsgiix3b7RNAad6nJevCEY1mTqkbi
         E8zax3xF/KZtdqx2WyRvO7Vr81G4+g6TtzyLmhLsYjX4KWa4zxM6oYWQLy1YoH8L4kgD
         b8Dx4/ptp3qI3MrXb7M7Z4V64nk71hMepExNKNb3VhXz/+hHK/5NRVWqJVKUEU9WOkLI
         wRRoV6Yke+maV7mRI+Bg18SNrt3t8JiqFuunw5uD3eJYFQUzQK08u8u0Sb+VrFBlxefR
         WHe/mQKu8F6Mk+eUPJJ50mYcb29EP/Xi/EDkXY3R51K6o3etMFgbwMVuDtskE227n+ni
         YkJQ==
X-Gm-Message-State: AOAM532S6qV9grZk7vLHdz1wcMib1R6PD7bEBtXP18zwSTYbo1Sbz9PP
        vn9mSE+tNy6WvawJ4B7GsTY=
X-Google-Smtp-Source: ABdhPJw9cfouxOlWal/eYiaELUw43TBUF4yOWjfQiYHWIiiLm+4ozYKx1XYVVnjUtAvqKaHLvmy80A==
X-Received: by 2002:a05:6808:1a92:: with SMTP id bm18mr5366743oib.0.1635863125513;
        Tue, 02 Nov 2021 07:25:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d10sm4869062ooj.24.2021.11.02.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:25:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [RESEND PATCH v2] string: uninline memcpy_and_pad
Date:   Tue,  2 Nov 2021 07:25:18 -0700
Message-Id: <20211102142518.3723655-1-linux@roeck-us.net>
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

