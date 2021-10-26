Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F3343B3E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhJZOYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbhJZOYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:24:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59579C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:22:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n11so10445719plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aN3mTl3GmXayL34YiRI9EPb1zHUx04Qn7geFZIsIPWo=;
        b=nuDC4kmwXoFgxtX6OhtNynrhH0D2Iz4xLtwwaEMg9SjOboxZA6HrXTLSwP4OOpY9fw
         QctRGZh4l84oE25Zp5KnNP01CtbxXGJDrzKlOGT7VXZcVKUOZBMsCGVaIbbA116hJtb0
         mOmQdffRhijU2kzz15c+IL2Ja4AstxWpOot3xDDTUwAkBmctVzG+nuWM5QzZNBP69lpQ
         putqB+3vfDq1qxxhtREhhw1kUjVy0UgKh2M4UBe94YITbEr+Mzik1Xi9MGAe7vKuaRVn
         wTPXPwSPzsSKXnU7B1hnknPGIaBS5R304q/D5vO6ALjypwNav4+pNx77G07wY3R2KaSn
         a1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aN3mTl3GmXayL34YiRI9EPb1zHUx04Qn7geFZIsIPWo=;
        b=zPmRezMjxrlr0Ohm205WpuAn2OZ3m1nRZCQFqApIrP8gB4WRzxBbo990YIO3sdRJig
         lNZ1PUDrpIRZ570nqTyCKYjAzCOCdm8wkT0ikXu3y0GUh4hJYmjnY/kJyldWW3hu9TZf
         tBXdIo7VnXlmY67/XNZ4DMA+QB3IpViYhNn1DZQhEKOb6RvuFjdDmpA8uIMf3cNF62c2
         aO9w0zZiRhNB22knsMgjvDajHGLmIZQ9oyt5Ces712Kwd2kjqx/LCL8JA4ffpFpnj7fj
         MGVrgWGjOQ5kPI7wPtSAx5jQE8RtWKYQYn30UIq8qihn4crfX62Wky1s2NbejYEtdn+b
         +NNw==
X-Gm-Message-State: AOAM530wWABPeTrbZ4GNFh9C7BGjpdE77h7hlh076apaC7Q+GHRU2PHx
        AhWylxDtOX3m7uSvfhELzbS8fVdpRjg=
X-Google-Smtp-Source: ABdhPJw9o/gVFr8mbepu7rNHKifg+PEm9rnQLXwzVei5QREWVIUutyF02pEVpg/yv4OCwxpnIUWcgw==
X-Received: by 2002:a17:90b:4f90:: with SMTP id qe16mr30034314pjb.137.1635258132756;
        Tue, 26 Oct 2021 07:22:12 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id e12sm19925780pgv.82.2021.10.26.07.22.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:22:12 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V4 10/50] x86: Replace PTI_PGTABLE_SWITCH_BIT with PTI_USER_PGTABLE_BIT
Date:   Tue, 26 Oct 2021 22:20:18 +0800
Message-Id: <20211026142058.17702-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

They are the same in meaning and value.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/pgtable.h | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 65542106464b..c8909457574a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -5,6 +5,7 @@
 #include <linux/mem_encrypt.h>
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
+#include <asm/processor-flags.h>
 
 /*
  * Macro to mark a page protection value as UC-
@@ -1164,14 +1165,6 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 static inline int pgd_large(pgd_t pgd) { return 0; }
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-/*
- * All top-level PAGE_TABLE_ISOLATION page tables are order-1 pages
- * (8k-aligned and 8k in size).  The kernel one is at the beginning 4k and
- * the user one is in the last 4k.  To switch between them, you
- * just need to flip the 12th bit in their addresses.
- */
-#define PTI_PGTABLE_SWITCH_BIT	PAGE_SHIFT
-
 /*
  * This generates better code than the inline assembly in
  * __set_bit().
@@ -1193,12 +1186,12 @@ static inline void *ptr_clear_bit(void *ptr, int bit)
 
 static inline pgd_t *kernel_to_user_pgdp(pgd_t *pgdp)
 {
-	return ptr_set_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
+	return ptr_set_bit(pgdp, PTI_USER_PGTABLE_BIT);
 }
 
 static inline pgd_t *user_to_kernel_pgdp(pgd_t *pgdp)
 {
-	return ptr_clear_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
+	return ptr_clear_bit(pgdp, PTI_USER_PGTABLE_BIT);
 }
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
-- 
2.19.1.6.gb485710b

