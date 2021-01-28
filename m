Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C918306DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhA1G7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 01:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhA1G7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 01:59:09 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B34C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 22:58:29 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id u67so3403844pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 22:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o59VmeBiIuFDw0ib/euYCaS+FPmTbZ3Wy7mxU6VxEFA=;
        b=XRYOapf4k9neRcuuyZn8wIKySdlonzN/xJZFW3n060szEbe9KMqd84pXm10LkyRu2b
         5FlaEzhKCdrPjm+Bjigdi+kkbMgVUp/8grReOSLAY/3TNhBGQJZfj9Kik8lXL9qSon6Q
         H3PkKOxCO+Uok+Jw4awch4Yp1ZO/2vB3pA2uSn7yobtIh2belY6RLtM2s7n55vIBUfod
         A0IqwnxcXk3LtcPh5sVmAku451HpUahZQvbZdIKaalckY+1Z4vN3avgnwJh3+A43h6AH
         JL1EoM0oKZ2jrywiktCP9WCms/qy/ai7kGN/+Q4hq8Iac0UUUdux8+9OIM6rpIg1a/MQ
         wXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o59VmeBiIuFDw0ib/euYCaS+FPmTbZ3Wy7mxU6VxEFA=;
        b=PszPOdul/GdoQ6B3JfW6eGtt/3yW5zLvfpjM2APRXmLUt+Tc90y9oV7JHI7AVGJHia
         sJlyYfoJqUx2d8e7gZnbnDotyVtYewCmNgExJcuV9mXKo6PQgjc1+fKeEUyNsGgaGP9h
         mERyt6+B3uXZ1PM5sADOVBCZiX36xHxNqhEgYXg7WgbzCuxA0aXpf9x12qUmSXDSVGzG
         OmqXJA6fxsO1kSXYUtpygMxJaP0gIz+vwo+8JKNwVypaCRJIPw8lYAV08Zi9UtqbggY1
         meiPK3F2/B20Wy/4uQCtzRPedX/ftnIkwWpTgLIoxv80AginmwQhDsNWxg0uU+A1OSP/
         bXsg==
X-Gm-Message-State: AOAM532TIgeoiLF+MhNSTyQ9nmEblJoZvAmbkd41qzjCgfOP6VZj82ig
        1j6nkMEaGqJACLdYIGnwezG0L1YBVakdNRe0
X-Google-Smtp-Source: ABdhPJzdTZpj9coUjBT9+GTgAYnlZj14z4o+uN6Kd/zambD35i7Gejr1ZOV8+GuuUqbSj6Y8MeYLlw==
X-Received: by 2002:a05:6a00:2281:b029:1bb:15d2:3b9f with SMTP id f1-20020a056a002281b02901bb15d23b9fmr14295810pfe.25.1611817109179;
        Wed, 27 Jan 2021 22:58:29 -0800 (PST)
Received: from bj04616pcu01.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id y12sm4515750pfp.166.2021.01.27.22.58.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 22:58:28 -0800 (PST)
From:   Candle Sun <candlesea@gmail.com>
To:     keescook@chromium.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        candle.sun@unisoc.com, David.Laight@aculab.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v3] lkdtm: fix memory copy size for WRITE_KERN
Date:   Thu, 28 Jan 2021 14:57:39 +0800
Message-Id: <20210128065739.14124-1-candlesea@gmail.com>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Candle Sun <candle.sun@unisoc.com>

Though do_overwritten() follows do_nothing() in source code, the final
memory address order is determined by the compiler. We can't always
assume address of do_overwritten() is bigger than do_nothing(). At least
the Clang we are using places do_overwritten() before do_nothing() in the
object. This causes the copy size in lkdtm_WRITE_KERN() is *really* big
and WRITE_KERN test on ARM32 arch will fail.

Get absolute value of the address subtraction for memcpy() size.

Signed-off-by: Candle Sun <candle.sun@unisoc.com>
---
Changes in v3:
- Clean some typo.
- Remove one comment line.
Changes in v2:
- Use abs() in place of address comparison.
---
 drivers/misc/lkdtm/perms.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 2dede2ef658f..c9227e08f97f 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -31,13 +31,12 @@ static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
  * This just returns to the caller. It is designed to be copied into
  * non-executable memory regions.
  */
-static void do_nothing(void)
+static noinline void do_nothing(void)
 {
 	return;
 }
 
-/* Must immediately follow do_nothing for size calculuations to work out. */
-static void do_overwritten(void)
+static noinline void do_overwritten(void)
 {
 	pr_info("do_overwritten wasn't overwritten!\n");
 	return;
@@ -113,7 +112,7 @@ void lkdtm_WRITE_KERN(void)
 	size_t size;
 	volatile unsigned char *ptr;
 
-	size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
+	size = (size_t)abs((uintptr_t)do_overwritten - (uintptr_t)do_nothing);
 	ptr = (unsigned char *)do_overwritten;
 
 	pr_info("attempting bad %zu byte write at %px\n", size, ptr);
-- 
2.17.0

