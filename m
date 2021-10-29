Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7320D43F669
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 07:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhJ2FDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 01:03:06 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48558
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhJ2FDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 01:03:05 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3AC223F1A0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635483635;
        bh=fVrxR6rs0QgNgX/0Rgh0R5Yk7RWIkh0KqpodnVxs5fE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=inQ2bNo6lFjOLhfNcZ72I19brqriKf9Mpe7Wk/XmDtSNecxTA7vond9mHn0cSWaGx
         3y1FZicCArIVsVK5gC52qYW3agqmuROvKkQTZv+jbkq4FtFiDV/ZW4mkz51MGxqaVp
         eKeKYg3akmp7ZaEKDRZMZnosVw2UV5AlXyrjGnL0Hty//GEfkKqZAEnHhmpco9/bQo
         xcc1gjpTejmWM+rlEVfwEwrLonSNESOY3VesCf+pCQnA06F1QsBUyfG0O9Std4ePz1
         S86lZJzQL5ajbOyFwEmqcA/Kde+jN9zm7Gv3vJmPp5KPrS4g3LfEKCjRgigNiX2Lcc
         aSOqnG3k6vgDQ==
Received: by mail-wm1-f72.google.com with SMTP id o22-20020a1c7516000000b0030d6f9c7f5fso3013047wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 22:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVrxR6rs0QgNgX/0Rgh0R5Yk7RWIkh0KqpodnVxs5fE=;
        b=W4h/Rrxk3+sT96rBI4yQCb4aEzuW8Vt91ZVyisttTVLh1K73I0jzw9eoyfcinKU22b
         Yy6/bA1ZSKUA3qTvCB9R+rus6axqafTH/DEp1myc77ncR0EuiGI9vEt/VlHeLdeg3M7O
         jKzlHOAdFEMALMbZ2YhULJfyB7VhujUpF1CzoyJjJUadeHowpOErI9lgqPUyEKYgAjpG
         18G0c6shdSrCQX6T2V5RH4MWty1KRFPSQfpR90m4LaDdQnm+B9XR4X7jIjdaNuMixBLH
         WP0oFmr3YWrK21g9opP7v7KiIcLyMNj1IqWc6dqXzADm1xGmOEelez5esSJMWVeCumVb
         dIhg==
X-Gm-Message-State: AOAM533ILHuugQwAm2s/uPXMdYUpzWsu3aKiTnXwrW2w1H2Mq+N7XHsC
        79WYxqti4v4Hy+RkBQgGbR2lVK7VhwunVA0oWHdHRowbuJgQnx42S2NEzWZcPw70sCjsB14sndg
        TeqdkAzXbGf4+GC5aKNtqEWovVYTa56a6XIowvvrzZg==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr11818529wri.279.1635483631173;
        Thu, 28 Oct 2021 22:00:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVcMpOtY2oarkcGRWdba9hc9bb3yVUoAEIjsLxk+hc+TjKojuTqQUEEMBKdf1WYqhz7f/cXw==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr11818509wri.279.1635483630964;
        Thu, 28 Oct 2021 22:00:30 -0700 (PDT)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id d9sm712512wre.52.2021.10.28.22.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 22:00:30 -0700 (PDT)
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
Subject: [PATCH v2 1/2] riscv: Do not re-populate shadow memory with kasan_populate_early_shadow
Date:   Fri, 29 Oct 2021 06:59:26 +0200
Message-Id: <20211029045927.72933-2-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029045927.72933-1-alexandre.ghiti@canonical.com>
References: <20211029045927.72933-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling this function, all the shadow memory is already populated
with kasan_early_shadow_pte which has PAGE_KERNEL protection.
kasan_populate_early_shadow write-protects the mapping of the range
of addresses passed in argument in zero_pte_populate, which actually
write-protects all the shadow memory mapping since kasan_early_shadow_pte
is used for all the shadow memory at this point. And then when using
memblock API to populate the shadow memory, the first write access to the
kernel stack triggers a trap. This becomes visible with the next commit
that contains a fix for asan-stack.

We already manually populate all the shadow memory in kasan_early_init
and we write-protect kasan_early_shadow_pte at the end of kasan_init
which makes the calls to kasan_populate_early_shadow superfluous so
we can remove them.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/kasan_init.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index d7189c8714a9..89a8376ce44e 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -172,21 +172,10 @@ void __init kasan_init(void)
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
 			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
-	else
-		kasan_populate_early_shadow(
-			(void *)kasan_mem_to_shadow((void *)VMALLOC_START),
-			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
 
 	/* Populate the linear mapping */
 	for_each_mem_range(i, &p_start, &p_end) {
-- 
2.30.2

