Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DAD403E7F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352011AbhIHRqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350263AbhIHRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:46:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2623FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q3so1782517plx.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YpcZY/wok6Tm8gHdnpmkHhJcSgAyfMAyEx/8/I9XcUs=;
        b=Jx5/Q/au3M6VS8hmE9us8ktN5ulC04/81YZOBI4qPEm9UW9X3f8wTp5j1qS1HVQ+hH
         hbEzYJboXew5CxJvdxMmxmNxfpTPMFyxIPVr6/3+Xta0Q1EaPJTWURxAp9F+/q6MVsiA
         IgdaFnh74IaLkOw71D9T8JtcLpZ8b5GiyuL8DOguAv4f/yjhOcS6vdPhyazEmejesk6t
         vmga/fNX34i8K/rzF0mk0I058wP7dzffvYQwTBvBSMPLRdqYlKlikvoCAYDI1DZ29nhz
         wDjUQPqahcQnUbfLWyR2EGmh7StefB4J0V0wR0w8d3yRELbiwyC3g3yCWCA2hBcB6Q31
         Zwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YpcZY/wok6Tm8gHdnpmkHhJcSgAyfMAyEx/8/I9XcUs=;
        b=kGL34ZC/EsCpthi8ZY35MEBRFCJyC7DDVBH5FKxoP/PfLsKOD7kQfj+ct3XWCN0FYM
         PFEH2EniPtjYuWYUSeYgVMcP4sIH8jmgVAnvwEP7tEhGhLArR6dhDjEoSAN7yE92P6Rm
         YuVzAoZNbNmPz1aKGAttvPhkwgAPfgpd5615CQeFXvg9llzbZeaFjeN/WueJvymgWG3I
         mmD0JsVaH7GCo1XGy0OOxNIvYRZ9SmLOz59SBOv9RbE3fOTvoq3Bu0d4hVTVxUEZxIWX
         vHKSjN8A68tBAj2zCFwLrxlpyLpiUD4h0dmEvv0xrlqYOEXqUNr0bKTRb+DwhS2qlzr0
         s0CQ==
X-Gm-Message-State: AOAM531FC0kujgjjXNi2XJiSH1b280mlVB37SKE+u5vQCkclXUNFvV/P
        EiRgnJfLzqyFfsVVd+Tsj+6oww==
X-Google-Smtp-Source: ABdhPJwScwgepcfikW8f2UbxgnPEpnsX89Jf1x0kp8szgGwmZ2fb7vGuQPhIeU7a/Nk9s/GoSe9t7A==
X-Received: by 2002:a17:90a:bd02:: with SMTP id y2mr5423105pjr.202.1631123140700;
        Wed, 08 Sep 2021 10:45:40 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:40 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 03/21] riscv: Extending cpufeature.c to detect V-extension
Date:   Thu,  9 Sep 2021 01:45:15 +0800
Message-Id: <0872babd785206d85216dab64546627d3021f3c1.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Current cpufeature.c doesn't support detecting V-extension, because
"rv64" also contain a 'v' letter and we need to skip it.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/uapi/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwcap.h b/arch/riscv/include/uapi/asm/hwcap.h
index 46dc3f5ee99f..c52bb7bbbabe 100644
--- a/arch/riscv/include/uapi/asm/hwcap.h
+++ b/arch/riscv/include/uapi/asm/hwcap.h
@@ -21,5 +21,6 @@
 #define COMPAT_HWCAP_ISA_F	(1 << ('F' - 'A'))
 #define COMPAT_HWCAP_ISA_D	(1 << ('D' - 'A'))
 #define COMPAT_HWCAP_ISA_C	(1 << ('C' - 'A'))
+#define COMPAT_HWCAP_ISA_V	(1 << ('V' - 'A'))
 
 #endif /* _UAPI_ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d959d207a40d..7069e55335d0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -73,6 +73,7 @@ void __init riscv_fill_hwcap(void)
 	isa2hwcap['f'] = isa2hwcap['F'] = COMPAT_HWCAP_ISA_F;
 	isa2hwcap['d'] = isa2hwcap['D'] = COMPAT_HWCAP_ISA_D;
 	isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
+	isa2hwcap['v'] = isa2hwcap['V'] = COMPAT_HWCAP_ISA_V;
 
 	elf_hwcap = 0;
 
-- 
2.31.1

