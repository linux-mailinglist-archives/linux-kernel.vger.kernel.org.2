Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA643F66B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 07:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhJ2FEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 01:04:02 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35380
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhJ2FEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 01:04:01 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 71A3D3F176
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635483692;
        bh=e3b9czu737yTY5HxipcQc4ldTFaXsWhzUIsobScJLNg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=v36YWjIpshGN28LmZTMlYTchrfEpRmm8zy7WhCu9jg6STXdT8AXsobUn6iJAdoQYV
         vhhAvKyVfCWIwbH4PAdv3Fp4BIOONErrO0dQsThVJpHRdwb4Uv8R0UzB/NfRyjTLql
         SK0Homo8QO0fvFdLy/PcgnSECPLPu1IV1c4ZkOq4w4/k4dkWVdmBmMO90fGOFgjzaY
         2B8R/2t/dS3tsrY0DmDxaHsN6NC6nFdE1wz8GFKxZr9VzzqV/5VjQhNRX6Y1EwP5rX
         w4miUWbHiVzY9OZzsY5uFz/2dYfiaLw+2K0YIG3DVPSIjeFp6XOmJvJJxmnyEw7CjV
         1Zs2Ko5tI9aPA==
Received: by mail-wm1-f72.google.com with SMTP id i15-20020a05600c354f00b0032cda87b22cso1843101wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 22:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3b9czu737yTY5HxipcQc4ldTFaXsWhzUIsobScJLNg=;
        b=fdD7uybmByVZDY59HVSVJAOIes995oe6cOCn3yUYYBlGdYSdP82F+HfUc2mfcvbiyq
         s4rYaLpDNir62HwlPWk98EZw/0N8MVbRUeoR7sRT6brqLFm9Y7NU7dfwhmYU/2KwoySq
         UbehIVNYqA2FBQ8F4iXJDGimPZcO+tsKmrV+mY8R+FY3eB4aQak5u2sDddxIEMa1moWP
         qQq3Indk+uC/nII9miCcF5yC6b1K4yunAQcm8DhwfikWYS3TYrLpntPBpDMxd+iAmyT8
         dZO+BUm2LziUA/+/pw7b1UzwC3zAPw1rn7k07nVMOvNexXCqmYA08LU3CmHhOfPAlJ1I
         y6Yg==
X-Gm-Message-State: AOAM530LAK4Wl4+1zWMof9ZpMrJSHTZhqKAkUltU5J73FxYCqbrS5sg9
        z01QeKek2WMF0SJ78srOWu1Ii+1bpR/zQnEQjViudnW1JptOwDXq3bxwcAJUM+eWysSeS5YcMBm
        g5mk6aD3fykA/CnKWxxUFok9c2oLVvvEIH77682Olkg==
X-Received: by 2002:a05:6000:18c7:: with SMTP id w7mr11163978wrq.411.1635483692206;
        Thu, 28 Oct 2021 22:01:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy45uLdWITkTDkf90WKQstb5F5keb7gLh0VcPQewoIS+qMfoL4pR4HNkg5Z76EZjhtB6K3l1A==
X-Received: by 2002:a05:6000:18c7:: with SMTP id w7mr11163947wrq.411.1635483692049;
        Thu, 28 Oct 2021 22:01:32 -0700 (PDT)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id g7sm6260959wrd.81.2021.10.28.22.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 22:01:31 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 2/2] riscv: Fix asan-stack clang build
Date:   Fri, 29 Oct 2021 06:59:27 +0200
Message-Id: <20211029045927.72933-3-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029045927.72933-1-alexandre.ghiti@canonical.com>
References: <20211029045927.72933-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan reported that because KASAN_SHADOW_OFFSET was not defined in
Kconfig, it prevents asan-stack from getting disabled with clang even
when CONFIG_KASAN_STACK is disabled: fix this by defining the
corresponding config.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/Kconfig             | 6 ++++++
 arch/riscv/include/asm/kasan.h | 3 +--
 arch/riscv/mm/kasan_init.c     | 3 +++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c3f3fd583e04..6d5b63bd4bd9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -163,6 +163,12 @@ config PAGE_OFFSET
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
 
+config KASAN_SHADOW_OFFSET
+	hex
+	depends on KASAN_GENERIC
+	default 0xdfffffc800000000 if 64BIT
+	default 0xffffffff if 32BIT
+
 config ARCH_FLATMEM_ENABLE
 	def_bool !NUMA
 
diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
index a2b3d9cdbc86..b00f503ec124 100644
--- a/arch/riscv/include/asm/kasan.h
+++ b/arch/riscv/include/asm/kasan.h
@@ -30,8 +30,7 @@
 #define KASAN_SHADOW_SIZE	(UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
 #define KASAN_SHADOW_START	KERN_VIRT_START
 #define KASAN_SHADOW_END	(KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
-#define KASAN_SHADOW_OFFSET	(KASAN_SHADOW_END - (1ULL << \
-					(64 - KASAN_SHADOW_SCALE_SHIFT)))
+#define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 
 void kasan_init(void);
 asmlinkage void kasan_early_init(void);
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 89a8376ce44e..54294f83513d 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -17,6 +17,9 @@ asmlinkage void __init kasan_early_init(void)
 	uintptr_t i;
 	pgd_t *pgd = early_pg_dir + pgd_index(KASAN_SHADOW_START);
 
+	BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
+		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
+
 	for (i = 0; i < PTRS_PER_PTE; ++i)
 		set_pte(kasan_early_shadow_pte + i,
 			mk_pte(virt_to_page(kasan_early_shadow_page),
-- 
2.30.2

