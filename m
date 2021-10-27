Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C60C43C1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbhJ0FCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 01:02:16 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33060
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230349AbhJ0FCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 01:02:14 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1FB6C40277
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 04:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635310789;
        bh=LTVtpyKftoE0IH0g/BXOTfVkolo16F3nizMPYgvUIg8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=c1yrvb6RM5aoDZ7D5pEMLP2ieBb2cD0sHvRMkAiXJGIzQAm3xDgdaNUAvgyNsKSEm
         eYo9XDtPGsV+g8xB5RFyCkYkuOgAOVvPyPJM+Y+hKl3O1Tx2oa982/qwvoReEtd4pR
         sPBbxycUgUHN9AGe1H5vuVTbrk735Q1ekWwRTA/0TJdMv3kOKF4V0vQR3J5wbf3IAq
         Vyhkugrijtk1LRwF+lSut6SleKQrFiSC4eFtDVMZhveDfakGz1u7MaacxIIYlps0Vu
         h8ETJLhKVnFr2+z1D/R3XWKvZL7oR18uegrFNYETIySQlG6YZLx0gJB/1fTGmUuar8
         kHUwLqV761OsQ==
Received: by mail-wr1-f69.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso258517wrc.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTVtpyKftoE0IH0g/BXOTfVkolo16F3nizMPYgvUIg8=;
        b=oyf3unfRGMrP+QhmRlcCXFGKUYf/1jU8SbWngF9MUDBrYAWIyUW1iH+XVt/RnWlemP
         1Le9c4I/hYGzTY6s88T2gWxfbf6cFpszRItcegWRPvwADJ/qTiiZdVjVoeTOAC12hhpt
         m+RJ70k+yjc4OLjbJWvIqxKl2cwnYVrUWzpHvi3Ap1K2v0KSlDnKOF+2S7wX/kDaJT2D
         g4cDhUpPwhR4Ok1+Je/Y83kygGQl/8VXzGXOD4OqYxjO8yj3xfZvdufjMmA0ZBUcKkZ4
         SH/9VQ674I5T3UNiTxNfQe2vpVErUR7pHMxQt8z+AQjqROhn9OCLvkWSvrVp1J65ytB1
         GuhQ==
X-Gm-Message-State: AOAM5339F4jMHS8yNx7jTZc4qPmoBxXfVpsib7w1z98xpteGHjM1ytTG
        ma3bsqubKIm+oXY+OfoImQf2Zn5k3IN+lwioaq64g4VR4EBQSSTjVpqPXmPGoIy9EuaFen0TWTL
        aHD14TSvMGGjZtu13rFmSvljOVuatn30HQTFBNZcfRw==
X-Received: by 2002:a7b:ce93:: with SMTP id q19mr3460074wmj.98.1635310788755;
        Tue, 26 Oct 2021 21:59:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8O7sqkwoLrKnw5Xt6p5dLSckvr1ImPBad0sPPzwGeWPQZemV8X1dl0PrG0R5bBdfsawaeAA==
X-Received: by 2002:a7b:ce93:: with SMTP id q19mr3460062wmj.98.1635310788623;
        Tue, 26 Oct 2021 21:59:48 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id c15sm20432877wrs.19.2021.10.26.21.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 21:59:48 -0700 (PDT)
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
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH 2/2] riscv: Fix CONFIG_KASAN_STACK build
Date:   Wed, 27 Oct 2021 06:58:43 +0200
Message-Id: <20211027045843.1770770-2-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027045843.1770770-1-alexandre.ghiti@canonical.com>
References: <20211027045843.1770770-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that CONFIG_KASAN_SHADOW_OFFSET is correctly defined, the boot
hung while populating the shadow memory right after the call to
kasan_populate_early_shadow: when calling this function, all the shadow
memory is already populated with kasan_early_shadow_pte which has
PAGE_KERNEL protection.

kasan_populate_early_shadow write-protects the mapping of the range
of addresses passed in argument in zero_pte_populate, which actually
write-protects all the shadow memory mapping since
kasan_early_shadow_pte is used for all the shadow memory at this point.
And then when using memblock API to populate the shadow memory, the first
write access to the kernel stack triggers a trap.

We already manually populate all the shadow memory in kasan_early_init
and we write-protect kasan_early_shadow_pte at the end of kasan_init
which makes the call to kasan_populate_early_shadow superfluous so
we can remove it.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/kasan_init.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 8175e98b9073..8df937902630 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -175,13 +175,6 @@ void __init kasan_init(void)
 	phys_addr_t p_start, p_end;
 	u64 i;
 
-	/*
-	 * Populate all kernel virtual address space with kasan_early_shadow_page
-	 * except for the linear mapping and the modules/kernel/BPF mapping.
-	 */
-	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
-				    (void *)kasan_mem_to_shadow((void *)
-								VMEMMAP_END));
 	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
 		kasan_shallow_populate(
 			(void *)kasan_mem_to_shadow((void *)VMALLOC_START),
-- 
2.30.2

