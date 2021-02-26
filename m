Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DE3325FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhBZJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhBZJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:23:26 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D704BC06178C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:22:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id l12so10102703edt.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5J2u/RuThY09aoFuopTwJD+nrXnstG5Ldy/11ueD3Yc=;
        b=DKMIkkrL7p7nvufrnq0hq03/Mmas+FpsR07zPSKqB9rbl8FpXOHSQevd1eaSGVkh4r
         Tgq7r8A5FPzDsw3tJrhKf0RqU8M6zWpx6NVb3ODUvvVCe6OSoj0T/dUSzHxv+pGdI52C
         hU4aWsTDzCqdqe/kiakHd34FBmMKdj/Vkxvw6o2GepoYxwrJ9stzxmAJSbhj5J7XzT3J
         41SWFsNBsFh11Rg4og7tavD/eT44Okp5pQl4zzah2GljkeD5wuhM+77DmjbwS1tRbQqJ
         aTyQKvycaKIFyHGAfV0C9+EHrRFhO5GNKxpQuSUBBchVogV9M1Uyul5xkcO4EWvJK3f1
         9evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5J2u/RuThY09aoFuopTwJD+nrXnstG5Ldy/11ueD3Yc=;
        b=inmlKlr+Jt9/jr0NBrPP+r5jFXQuxu1uavzXBYDGiRBn3GIjmOYn6g9qQJjR3fdt8t
         tMrrZjxug/72tX8SrCIAjcTG8CiETJyP5nTrIagDMKan09zTOchXMg756eYKIiltOgjq
         y7N4tVBpmnlQlkGNYZid88BhA5lYfa9gSoIyXtdH360rkPUfsr67lgquzaI1eFUBF+iA
         U+g9wuqOCS3oRWZm6axiixqbgBych3ENsU74VoCrqkP/E3FgMeoE8khQiulqjD8SKNkp
         VEoBytHVEO8LeE4XGR2sC4uFyiicbOmvP13k0FamDKapcOUUtBDqqoOmTPQgyvgEMQpa
         PM+g==
X-Gm-Message-State: AOAM532p5XFIP2y7DY0gawXjYg7YUBzu9dxe08Ml9Q/YzLrsNay1lyhH
        09VDvGuL3HGDtyLV2Y/u7iM=
X-Google-Smtp-Source: ABdhPJz8OPdPTmro+Z9yv9pr9/qb/BHD9rDP8oKOl3LV7fYY7r22BD384HFvmpb5zNjxguowhqIhDg==
X-Received: by 2002:a05:6402:30b9:: with SMTP id df25mr2286768edb.136.1614331364534;
        Fri, 26 Feb 2021 01:22:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b14f:9a2a:80ff:1887])
        by smtp.gmail.com with ESMTPSA id 14sm4876416ejy.11.2021.02.26.01.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 01:22:43 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] sparse: can do constant folding of __builtin_bswap*()
Date:   Fri, 26 Feb 2021 10:22:36 +0100
Message-Id: <20210226092236.99369-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse can do constant folding of __builtin_bswap*() since 2017.
Also, a much recent version of Sparse is needed anyway, see
commit 6ec4476ac825 ("Raise gcc version requirement to 4.9").

So, remove the comment about sparse not being yet able to constant
fold __builtin_bswap*() and remove the corresponding test of __CHECKER__.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/compiler-gcc.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 74c6c0486eed..d1016cc6798a 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -95,15 +95,11 @@
  */
 #define asm_volatile_goto(x...)	do { asm goto(x); asm (""); } while (0)
 
-/*
- * sparse (__CHECKER__) pretends to be gcc, but can't do constant
- * folding in __builtin_bswap*() (yet), so don't set these for it.
- */
-#if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP) && !defined(__CHECKER__)
+#if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP)
 #define __HAVE_BUILTIN_BSWAP32__
 #define __HAVE_BUILTIN_BSWAP64__
 #define __HAVE_BUILTIN_BSWAP16__
-#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP && !__CHECKER__ */
+#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP */
 
 #if GCC_VERSION >= 70000
 #define KASAN_ABI_VERSION 5
-- 
2.30.0

