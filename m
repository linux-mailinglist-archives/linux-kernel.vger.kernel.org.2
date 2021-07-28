Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57543D8822
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhG1Gnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbhG1Gnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:43:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF06C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:43:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso8531965pjq.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXtLcU7ZZXSLfEipJ8pAe0QEMbslZL2rwJBJ8YIF008=;
        b=g5gbqDNWJZ5bkczxky3WiMyckf/lVdH6GlS3KSYFICuEPW2stf7K310+7qoTubMV3D
         PX5N309Va0Nx9sql53M1KxOSlKQelL9v75jYgLQDnqw+OV7B8gFG2rbTxccrMxGDd210
         jYDNuoJKHdsP8KYf17LSmZRh3/X73ALtJWBDXDSx3Ggod41mDM6/sGMXziYe/1yEddXh
         lIINH9ZdOf+ek+zxYTSU3p6HlTWGh+RNaO5zvp3r3K0ahoP1otsrY3QifDmA1NpCVYCq
         pXA+BNJQaYW7VAPcJEO1CT8ffrqdaStAhtsDj0QCJ0NK0nvtHREbO6pSZPj0CjzJBBds
         ktXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXtLcU7ZZXSLfEipJ8pAe0QEMbslZL2rwJBJ8YIF008=;
        b=ePl4LPSvIXsa8JIKPoY/DrQsEV7UJ3sgoa2zIbcNy94K8c/+OSjWMoLTACqlkNPRuG
         kKz03EbKboAgNnXQFwIZSz9hJWEUixP1nbq4fhWIFUFjNrKbsOvNDg0Gm44ZxxjCfHAJ
         m/8JX6kzcTnbjeSt1IAFW+7ZW3+gkpl5tNqPeHjo3PPS3NtMgWprGyYDR0pJdo1OfKwB
         bau1OrxmuomM5ui1yftb5MyY4hEYoXz6y3tagbAD1JtKiy58CiQeBpjgKlZcpTHw/cmh
         NWRX9cgzeC8HvL5R8xMBs1vNqTnYaJ/irnfuOtg6VBHTSS4aaZGKI0MipTimm99diY5p
         r0tg==
X-Gm-Message-State: AOAM532OQqDi4r6zTDz4iF1nMruhmEKyO2K0BFmXIvLWTEgIAWcWUprq
        AWWu9VbxVh6TXjnbEOr5qls=
X-Google-Smtp-Source: ABdhPJxXOQhIGJO08AI11C7dx+vcyYR925UbeiKGQJ3EO+wsrkg6qxSqrxrlhcivHuIrIiFT/COixQ==
X-Received: by 2002:aa7:948c:0:b029:328:8e56:aefd with SMTP id z12-20020aa7948c0000b02903288e56aefdmr26899199pfk.19.1627454618717;
        Tue, 27 Jul 2021 23:43:38 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.50])
        by smtp.gmail.com with ESMTPSA id x9sm6088034pfd.100.2021.07.27.23.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 23:43:38 -0700 (PDT)
From:   Kenneth Lee <nek.in.cn@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     guohanjun@huawei.com, wangzhou1@hisilicon.com
Subject: [PATCH] riscv: fix the global name pfn_base confliction error
Date:   Wed, 28 Jul 2021 14:43:18 +0800
Message-Id: <20210728064318.375747-1-nek.in.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

RISCV use a global variable pfn_base for page/pfn translation. But this
is a common name and will be used elsewhere. In those case,
the page-pfn macro which refer this name will refer to the local/input
variable of those function (such as in vfio_pin_pages_remote). This make
everything wrong.

This patch change the name from pfn_base to riscv_global_pfn_base to fix
this problem

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
---
 arch/riscv/include/asm/page.h | 4 ++--
 arch/riscv/mm/init.c          | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index cca8764aed83..8711e415f37c 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -79,8 +79,8 @@ typedef struct page *pgtable_t;
 #endif
 
 #ifdef CONFIG_MMU
-extern unsigned long pfn_base;
-#define ARCH_PFN_OFFSET		(pfn_base)
+extern unsigned long riscv_global_pfn_base;
+#define ARCH_PFN_OFFSET		(riscv_global_pfn_base)
 #else
 #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
 #endif /* CONFIG_MMU */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index a14bf3910eec..2ce4e9a46ca0 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -228,8 +228,8 @@ static struct pt_alloc_ops _pt_ops __initdata;
 #define pt_ops _pt_ops
 #endif
 
-unsigned long pfn_base __ro_after_init;
-EXPORT_SYMBOL(pfn_base);
+unsigned long riscv_global_pfn_base __ro_after_init;
+EXPORT_SYMBOL(riscv_global_pfn_base);
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
@@ -572,7 +572,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 #endif
 
-	pfn_base = PFN_DOWN(kernel_map.phys_addr);
+	riscv_global_pfn_base = PFN_DOWN(kernel_map.phys_addr);
 
 	/*
 	 * Enforce boot alignment requirements of RV32 and
-- 
2.25.1

