Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7FB45EB4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376892AbhKZK1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhKZKZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:25:15 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013BEC061763
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:55 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u11so6393644plf.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aN3mTl3GmXayL34YiRI9EPb1zHUx04Qn7geFZIsIPWo=;
        b=drgEGQN6VgOiHGuyvy1fT/Oh6DyTtCrrgm3L1TsTDTS7mp4hRbQPlZiG3UULUJxOiK
         lFJ8iZ71zbPAlXbt9ON5/ra/XuTvmIaSTNZq0xRMVPLDa7j1SZnglbJ3VoHO9qN1kKFg
         fRrEZondTrBrRtnsbRVxwSahtVrw9ewWYOBag4kxIXHDosYi/kFK9xDk9m5n5ChxbJtk
         5e60j1QfM61zo1ioSY5mm58UefViVXqvwBOg3RaCuLAU7nkpGrUrnQmy5JMgZewyW3dt
         n1jTxT4yvbBZ1k+7sumM34YZzjBM6MMIW1fh6v+GMb2oa73adY8QugrJUmsDkznUO5bB
         S2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aN3mTl3GmXayL34YiRI9EPb1zHUx04Qn7geFZIsIPWo=;
        b=ARkyJkX3jOZmMo2kju4W4kwT8fzRJB70iWhyd5Jxc/cpFTbKoIN6eFGBgvEH+p3WJb
         ZYieQ8owFc4+sebJWzfWMLAX/wxCL4cJCL5RLJOmzWBpkD/GXiDYZkrthLH5ecEvitm3
         R63GAVxJuLaT6429sWC2EZT/0ODX4aum1mN9hpv+Y5nBVmo7uMKQ4GYMmetGutLwK5uK
         YOXVpirHc1vrj8demLe6zpj7yOclbdhAEKywbpQGBmtmozBDXo46mPMDk0aL+ykBhWZV
         vMJ+LpTffwSWgCy3Lk++jn3ASuLsDdc7r2HKqPx23fbErR9MiqUDKY/lkWALLmdkumtn
         j25Q==
X-Gm-Message-State: AOAM532ySEobCUTbigjXFhjzjhIpucLGw55y4uObJGsdtlpQho6PL3sQ
        EdpXiNZCV3fKDhW3GvbZcUk5zq8WJqk=
X-Google-Smtp-Source: ABdhPJz6LV1y76XcEDhud/62qdgzOguuAA76v4QF154jGmCp3fjJDpBEaU8eWDTcm8qazRE2JbRn9w==
X-Received: by 2002:a17:902:d34d:b0:143:c927:dc48 with SMTP id l13-20020a170902d34d00b00143c927dc48mr37464188plk.71.1637921574446;
        Fri, 26 Nov 2021 02:12:54 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id u22sm6977551pfk.148.2021.11.26.02.12.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:12:54 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V6 09/49] x86: Replace PTI_PGTABLE_SWITCH_BIT with PTI_USER_PGTABLE_BIT
Date:   Fri, 26 Nov 2021 18:11:29 +0800
Message-Id: <20211126101209.8613-10-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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

