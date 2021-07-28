Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859CA3D88A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhG1HQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhG1HQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:16:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C08C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:16:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso8639634pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=45WqfKtom6mMVDJZgU9anEiSV/dtOZcbAPcrsmgXp/Q=;
        b=FZlCmZkv/THnI53YoHYbLJNECMIOev++kpzCygpQUSY2TUVFIc97IlMwPUi5+xj9Qm
         fa2dEPpzvDRV5nNoGAb+UALPCBkSbWmH4RoOXiOqkL3yScwzkLg3XWPTTUQ+jPUA4Hd1
         c86UBFviCto/SzCpmh1vROarl2TyygxYBu3z0VhplHR4+kG9fduKGR0Z45W/snWImayl
         D3UlxOQjvm3tTYBjxGaEnY/X9nO0FI/6z/cQeLlyM4Q+qN2LRalIHLb3oiXD/tgjPKPB
         JW9p3orSmxJs50P/HTl5J0gFIdohXRBMS/1mFO8htV9Zqryj76Phe6f1cWG7w9fG8THL
         /Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=45WqfKtom6mMVDJZgU9anEiSV/dtOZcbAPcrsmgXp/Q=;
        b=O7TblMRTyyFBX2hKFdSODZ0DM6FDszP6Z38Thu6RzIiVo9QsmSlJq4FIbyBO9XVwfX
         y8vNS2TZG4V5nskUTIFuWDrHfPigwR4V9a3awyvO+wwm3RbqulMtlnP6Bqok/19DLb0U
         SzCvoRucCylTAdh4FhYx8kjmyKOs6OEzthjQQHegtlx4OL7xG9noEXDlOcspGhODwZH0
         OixNwndwHZirpU12Le5JQrc5Es1PyBn0LklzDptGx/zHMeuq2mvmWV52+s/Vm0PXO3Md
         7KO8+Yxxu9v/eBRicIbjVI9i+o7VVEbFJSdqiCMXYhK0Xx6lq6ZMhhDSGqtdUrY9hJPJ
         zZ4Q==
X-Gm-Message-State: AOAM532jvalTopG3iacQG9rOq+uJmbLX0HTF9dmGyTLDMr8N+4idnjKa
        n9QNwiUQ9+pKlOyKu9CnNdI=
X-Google-Smtp-Source: ABdhPJyC79iiS9JhjYhuuDKNm3YaFUJJiZxLSLj82BY0rnUqJ6UWBXZ9w002CvUgxJx3bvUJeWQ8VQ==
X-Received: by 2002:a63:1913:: with SMTP id z19mr26869690pgl.315.1627456576994;
        Wed, 28 Jul 2021 00:16:16 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.18])
        by smtp.gmail.com with ESMTPSA id x14sm6421695pfq.143.2021.07.28.00.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 00:16:16 -0700 (PDT)
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
Subject: [PATCH v2] riscv: fix the global name pfn_base confliction error
Date:   Wed, 28 Jul 2021 15:15:57 +0800
Message-Id: <20210728071557.400163-1-nek.in.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Lee <liguozhu@hisilicon.com>

RISCV uses a global variable pfn_base for page/pfn translation. But this
is a common name and will be used elsewhere. In those cases, the
page-pfn macros which refer to this name will be referred to the
local/input variable instead. (such as in vfio_pin_pages_remote). This
make everything wrong.

This patch changes the name from pfn_base to riscv_pfn_base to fix
this problem

Chagne from V1:
	use riscv_pfn_base instead of riscv_global_pfn_base.

Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
---
 arch/riscv/include/asm/page.h | 4 ++--
 arch/riscv/mm/init.c          | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index cca8764aed83..c690e83bde23 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -79,8 +79,8 @@ typedef struct page *pgtable_t;
 #endif
 
 #ifdef CONFIG_MMU
-extern unsigned long pfn_base;
-#define ARCH_PFN_OFFSET		(pfn_base)
+extern unsigned long riscv_pfn_base;
+#define ARCH_PFN_OFFSET		(riscv_pfn_base)
 #else
 #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
 #endif /* CONFIG_MMU */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index a14bf3910eec..788f12bb586b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -228,8 +228,8 @@ static struct pt_alloc_ops _pt_ops __initdata;
 #define pt_ops _pt_ops
 #endif
 
-unsigned long pfn_base __ro_after_init;
-EXPORT_SYMBOL(pfn_base);
+unsigned long riscv_pfn_base __ro_after_init;
+EXPORT_SYMBOL(riscv_pfn_base);
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
@@ -572,7 +572,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 #endif
 
-	pfn_base = PFN_DOWN(kernel_map.phys_addr);
+	riscv_pfn_base = PFN_DOWN(kernel_map.phys_addr);
 
 	/*
 	 * Enforce boot alignment requirements of RV32 and
-- 
2.25.1

