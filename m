Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1746734B92B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 20:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhC0TuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 15:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhC0Tto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 15:49:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E43C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 12:49:43 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j7so8886604wrd.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 12:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H97BsKqR23hJqrIfD56EXndKt8w/9T/UAs7wjOz5pxo=;
        b=pcwSshlSPC6XkTRT6YGjiWxwTF5UXe6Au8j4KZp3+sAvhcqqcKNT/qzsjl4w8DwYqO
         09EERJr4ohxE6coa3FfH2LDA+fbXA20/kY4F0Zho2kXXsMnWnrjunvO1iFaLeLofPtPB
         P9/Hz1ZNN9hWoyPy6ctQEey1LjTMnioDHzCr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H97BsKqR23hJqrIfD56EXndKt8w/9T/UAs7wjOz5pxo=;
        b=sMXKoQ6vfPDjF8ekaBua5SDwiF/7/Tl0MnMS0Q1lfKrqny+7FXQzz/qCO7YGYEA4RP
         LJUY9Qw3X1xTCeS8lH7o/u3hjJ/yb0h17HoJ/J6zRC2ekcXUM0b2/6N3VqEhQzjdQCWh
         hGVSDtl0kA6rtiDFVoI69ta7T4zW+P/8YGrck3gEASJzUrGYM7T5Ww5ygQmmxxHdyNc5
         GgOa5UcsMADJPetaR0thxaMkAVntbhJcZ2oOdFZoHXqlyZacQhtGRT0uorJlglMKTSZi
         uHclLRiSJf6YqQ6SggpgDg9T1bjI51OSsQObPlUA3placCmANVS6Z8e1/REEoLirY10n
         GarQ==
X-Gm-Message-State: AOAM531/f+VdVpnDF9eyl4uFNCxbGfrzgT4qrjQf8gydme6Wws87iurv
        HwcfU/CsG+JbI5I5Xqxr5n0nzQ==
X-Google-Smtp-Source: ABdhPJweHQ6okCQBrxq52NokylJeoCMpMHHUl8ucAl8Olj3qSRGGFdvGNgGsOtm5QERq3r9t1959hw==
X-Received: by 2002:adf:ee0a:: with SMTP id y10mr19809748wrn.177.1616874582438;
        Sat, 27 Mar 2021 12:49:42 -0700 (PDT)
Received: from lootbox.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id s83sm18410151wms.16.2021.03.27.12.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 12:49:42 -0700 (PDT)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] riscv: XIP: fix build for rv32
Date:   Sat, 27 Mar 2021 21:48:01 +0200
Message-Id: <20210327194800.23622-1-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32-bit RISC-V uses folded page tables by default, so we should
follow that in the XIP-specific part of init too.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/riscv/mm/init.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fe583c2aa5a2..8c0eeaae67a3 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -481,6 +481,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 
 #ifdef CONFIG_XIP_KERNEL
+#ifndef __PAGETABLE_PMD_FOLDED
 	create_pgd_mapping(trampoline_pg_dir, XIP_VIRT_ADDR_START,
 			   (uintptr_t)xip_pmd, PGDIR_SIZE, PAGE_TABLE);
 	for (va = XIP_VIRT_ADDR_START;
@@ -493,7 +494,16 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	create_pgd_mapping(early_pg_dir, XIP_VIRT_ADDR_START,
 			   (uintptr_t)xip_pmd, PGDIR_SIZE, PAGE_TABLE);
-#endif
+#else
+	for (va = XIP_VIRT_ADDR_START;
+	     va < XIP_VIRT_ADDR_START + xiprom_sz;
+	     va += map_size) {
+		create_pgd_mapping(early_pg_dir, va,
+				   xiprom + (va - XIP_VIRT_ADDR_START),
+				   map_size, PAGE_KERNEL_EXEC);
+	}
+#endif /* __PAGETABLE_PMD_FOLDED */
+#endif /* CONFIG_XIP_KERNEL */
 
 	/*
 	 * Setup early PGD covering entire kernel which will allows
-- 
2.29.2

