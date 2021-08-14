Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35CA3EBF1D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 02:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbhHNAym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 20:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbhHNAyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 20:54:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C990FC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 17:54:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so23186862pjn.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 17:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fUNG6uOos3dsrjJYJimcoDFsFANWNpCpQkwdUSaSVKY=;
        b=KuINU26HT5KK906xy9yX8ymq1myo0KAulOz4Zz31WJyvZKFlldaKK0+iGqtagvZ2NU
         40Yh8fF3BSKgU7U2wP/+F1PSBjC2WxM5NPTI7Umzjc5bJehjqR8R2+TSZI4Tty4BwrU4
         E14v6tvxN7rhJEp6Zlr4MOXw+5XoXJPWq3tYVuTQ711m0V59WNcFtmQPWiwWabmVLuaN
         bf3SyGOtrhzjPDZoksQ3W/d8ALvJPnB8eVBeKo02WMv4SdxhJitr/ZSv6nlrjwEXMuQm
         N7B+r5PldSw5m3X5H+N37V8m1/tt0AjRDxiiptQyjsKiV+OFSX40UmPZsp1QhJiJ7XKM
         32Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fUNG6uOos3dsrjJYJimcoDFsFANWNpCpQkwdUSaSVKY=;
        b=h8W94UEN6y00mMj99/4IjIBcL0LUK0DABvJCavYf5ifSrujeb2eB9/fpM2A4Q0OLv5
         lyl54LmNcPad/9nGxuK+4j9jNECIZ2H6vBNsu0YokvAsrh2THsOXQjlBgWHdSMVfdJjv
         n6hvShhVc7V1urN0z6rJQFjYmPd6tb+oVjchfFx0dK1H+m76qWLhO0neg0v/I5Y7V+a0
         PhzVut83Wh7q604s99sG6XjWPRtN8M3CRKsdZ6M1gK8Y8nrtqeNPdqea2f1xs2Sf+ZCm
         /chpCc/mQEIYKhWEJXRU4fdB87rnzDSbWKyFkeAoo567lWPArG5KFM0RM6+GMtdiWtyQ
         891g==
X-Gm-Message-State: AOAM532qgvX2UuIVRmgYYXOzlYUi87u+J0oYd7eP6wCroiuWw3r14AsA
        kR8FeHJdjKArOhnU+ilrE0Y=
X-Google-Smtp-Source: ABdhPJwC6RUfWAoOvTut5pTecnMprLXDxiYhWD8RgkJAvPVQ1F3m3PBlrUAwmBvhQ82QhvFE2uPx9g==
X-Received: by 2002:a62:8407:0:b029:39a:59dc:a237 with SMTP id k7-20020a6284070000b029039a59dca237mr5001182pfd.30.1628902453380;
        Fri, 13 Aug 2021 17:54:13 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id n35sm3930807pgb.90.2021.08.13.17.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 17:54:13 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] arm64: replace in_irq() with in_hardirq()
Date:   Sat, 14 Aug 2021 08:54:05 +0800
Message-Id: <20210814005405.2658-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 arch/arm64/include/asm/simd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index 89cba2622b79..6a75d7ecdcaa 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -37,7 +37,7 @@ static __must_check inline bool may_use_simd(void)
 	 */
 	return !WARN_ON(!system_capabilities_finalized()) &&
 	       system_supports_fpsimd() &&
-	       !in_irq() && !irqs_disabled() && !in_nmi() &&
+	       !in_hardirq() && !irqs_disabled() && !in_nmi() &&
 	       !this_cpu_read(fpsimd_context_busy);
 }
 
-- 
2.30.2

