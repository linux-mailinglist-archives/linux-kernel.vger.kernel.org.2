Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517C043C1F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhJ0FBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 01:01:18 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:47728
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230349AbhJ0FBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 01:01:16 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2BC613F19B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 04:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635310728;
        bh=OZLbG+qup29O7pa3I3sT9lWunjud959dueLBGLyt7Gg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=IMdq8wnNV8k/11/aeviaqlBActJziQGxwOuTl5ZpYTDx6m6Q4JqrTyLglGCyfsMpt
         OX1kwlsavjv/fw+LKoWYKhKuc0ZTXdiAdfKGaO8bLvqJBFiy6xYVNcGgxPUp660aG1
         WFySlvX5h6Jn7eiy8v2ACOa3QhKgFCrKmhXY+GBAlEYkBxOaSHp6DTL5IwWYf2YZGY
         yDnsozatXjU2gB6zkVsTXbbZ9SKps7KCdP1/t1NAb8KPPkCUtjw/w8Qyj8R3J8w9jo
         LI/KL6J4BvL+Pm/NtMQG1pga6Eu4rehT8ENBYYHcgubcsc3wLGq1hQdrkf79zh5b8R
         N22nTxTMYCkOA==
Received: by mail-wm1-f69.google.com with SMTP id l21-20020a05600c4f1500b0032cd163619cso622364wmq.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZLbG+qup29O7pa3I3sT9lWunjud959dueLBGLyt7Gg=;
        b=PZLsCgPyUBX5FAD1Gve88ogQy3rcFUVsHFPim6ibOTDCyn1p7VRMRKZj2pPYbmI4oh
         3aT2giyd3432iSF4fLCA59Nu0vV0RFwaxqYSlZBVHs1I2MXJySdu0Ncm5+OqAs++673b
         ATQadjneT+sej6+ATTqyM94McPFgb9aBrcr8536maWyGKwPwAOYiGf7rxfPieiGnS85Z
         b6R8MUROhFvi6lrMtuV00mu1MSRgFmXKTiXVt9XPGEIpuQPRBAFshUdCYIWJdFNu7NK7
         EqS850JnAnDXybnHd/HsKtz9D8l48AtMVknbq7ORXo7rvedHfFQVhSpQRMnSBVkfiTVP
         zGXw==
X-Gm-Message-State: AOAM530kswpAA84QHEPjokKCLhnUWF/6Z4Nil5D5NLR+IChy95CQyxE1
        3X1FrzIYStvutoy9ZGJD1wFFwawbYwGS1jZ+ixa+DSWbRGiVSi2OIZvxlH7+dkaSpwAD+qmnrze
        0OfrXih/TjauoQDSqoMgTcFWFlPgK0A5xFOFg+90Q5A==
X-Received: by 2002:a1c:e911:: with SMTP id q17mr3260839wmc.174.1635310727618;
        Tue, 26 Oct 2021 21:58:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwg7IteDGRbP/J7J7K13Z6DV5E7wAMFK7YSWsyBJTzgY5coRfA+N5jl6QLw37giV6SMkvlgDw==
X-Received: by 2002:a1c:e911:: with SMTP id q17mr3260825wmc.174.1635310727489;
        Tue, 26 Oct 2021 21:58:47 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id o1sm11775586wru.91.2021.10.26.21.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 21:58:47 -0700 (PDT)
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
Subject: [PATCH 1/2] riscv: Fix asan-stack clang build
Date:   Wed, 27 Oct 2021 06:58:42 +0200
Message-Id: <20211027045843.1770770-1-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
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
index c1abbc876e5b..79250b1ed54e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -162,6 +162,12 @@ config PAGE_OFFSET
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
index d7189c8714a9..8175e98b9073 100644
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

