Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A100C327371
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 18:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhB1RAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 12:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhB1RAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 12:00:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E787C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 08:59:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s8so17541199edd.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qr1mInad1mHd60s/UOLdChNop/NTHLYaNHSOHJUdlmo=;
        b=LpXYCLM0j+rXep2cIq0b1YzVUy2FnKhCNvFnsCd4PDfSOh4VNmif8h+6FSHSzq3HBP
         CLVQoCvySiFWu/gjeOANG25VKbh3nnM+3zyf0oE0k+F79ERen7FUZDVa8uqFyml/hbn+
         bx6YgjIfAs7ZvwuHPlSbJGRRZ5oOHGY/pX1TNSL17tZO/GoUqLbaAojVfHGTwM/eOber
         ASZqxkHvf2W2VRCQVoQ+wjk+GG2HjFLNM4PDS6LnkF4v0aKjqW9xCrula6/CQy78uy8Y
         SJ8jX179NhutIGWxP4tMMwBzqanQBpuKA915gkuR/RDqAEKOVijP0QnEkyqgaAps5Blv
         PvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qr1mInad1mHd60s/UOLdChNop/NTHLYaNHSOHJUdlmo=;
        b=T8tYp77Ka4fa+d6sD6ymZ9qH4ihHT3zgIgduqh0wQ/7JyzUiqyh+44EbNVNE1drO1H
         YFf98cNw8FBuyAFjfO/j5vz0PDPb3aD7Y+tclAEVo/gBaGNPQc8MgcMx7JFVFJACiBfw
         h+b7HMsMLMTHTMk+EK007KKNLqrzBPwKNFUwBeEkJ+jfyQZl2S2+6zLpY56DdDuvJaIt
         MfOdJA+JeT1vtoAQvppqEQyDdLzQsMBqaWD81GPt4sSjNM17rNF00XqvwMu9i6OjKjZx
         NUvCCYBKw/8i0TZLeiTOAUibypZ57TTqUvowD2mx969/XYNlnJHOwOdyMyJb1VO6kkYU
         NkHw==
X-Gm-Message-State: AOAM531CHBBPZ/2Wnf+YtNLfxyC8y4YeDUxpPD+dAL2YTRraYj2l/cfl
        vN2XOK5ZkoHBhVdteIbzAw==
X-Google-Smtp-Source: ABdhPJyCTJZz0pozZlob2zmGh5jlR3vbbJBpM0qwwscmt5Z//64N0IrUKbyykj9NXGLoyLeBYHI+Hw==
X-Received: by 2002:aa7:c456:: with SMTP id n22mr12563233edr.277.1614531558919;
        Sun, 28 Feb 2021 08:59:18 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.223])
        by smtp.gmail.com with ESMTPSA id g1sm7206482edh.31.2021.02.28.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 08:59:18 -0800 (PST)
Date:   Sun, 28 Feb 2021 19:59:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/11] pragma once: convert arch/arm/tools/gen-mach-types
Message-ID: <YDvL5H9BLnLYuI2q@localhost.localdomain>
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 72842f89ae91a4d02ea29604f87c373052bd3f64 Mon Sep 17 00:00:00 2001
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 9 Feb 2021 14:37:40 +0300
Subject: [PATCH 02/11] pragma once: convert arch/arm/tools/gen-mach-types

Generate arch/arm/include/generated/asm/mach-types.h without include
guard.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 arch/arm/tools/gen-mach-types | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/tools/gen-mach-types b/arch/arm/tools/gen-mach-types
index cbe1c33bb871..c28cd4b50f76 100644
--- a/arch/arm/tools/gen-mach-types
+++ b/arch/arm/tools/gen-mach-types
@@ -23,12 +23,11 @@ NF == 3 {
 
 
 END	{
+	  printf("#pragma once\n");
 	  printf("/*\n");
 	  printf(" * This was automagically generated from %s!\n", FILENAME);
 	  printf(" * Do NOT edit\n");
-	  printf(" */\n\n");
-	  printf("#ifndef __ASM_ARM_MACH_TYPE_H\n");
-	  printf("#define __ASM_ARM_MACH_TYPE_H\n\n");
+	  printf(" */\n");
 	  printf("#ifndef __ASSEMBLY__\n");
 	  printf("/* The type of machine we're running on */\n");
 	  printf("extern unsigned int __machine_arch_type;\n");
@@ -68,6 +67,5 @@ END	{
 
 	  printf("\n#ifndef machine_arch_type\n");
 	  printf("#define machine_arch_type\t__machine_arch_type\n");
-	  printf("#endif\n\n");
 	  printf("#endif\n");
 	}
-- 
2.29.2

