Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E878042D0FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhJNDg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhJNDg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:36:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1603C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:34:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s136so1001982pgs.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aN3mTl3GmXayL34YiRI9EPb1zHUx04Qn7geFZIsIPWo=;
        b=o7WLQulpBr8VTJcEqCx7QaimFEgJfg/Mnw/3+TxvMAXxNfi50IeDFGxl5pgNjrQQp/
         xadJaraHsbN7pJZTJvyOUFfwsrh3wwbFwQpa/J8v/UnT9U+Do1fa0LiyOiKS2KPLpFb2
         YSGXoehkt6K6LqL+H5NWXUdL70ZEMGFiPkuCvJWV4xpP2CqMw9aEQpQxncGO1Rf8jAAZ
         zNm3UlcelyrlYFhR6ITKzmlRO+mXZYNN5e7Zsn26enUkaccx6urEqQngQLcjbrppq/l9
         mDpFo7uoGNcainpk7W8TgVJXLPgaV0q6B0GPFjCaqAlSbhMitkVe3JoY2da4QRSXckf4
         YqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aN3mTl3GmXayL34YiRI9EPb1zHUx04Qn7geFZIsIPWo=;
        b=ibQfepRzd+ww589BoHlLDNG9LMK2PT5aFwyaZRf3bUsRphRUrwkl6LZSuezhzfW38u
         HqrSbCNg0gn0GdCVHfcu+42PdJ4M4DxpTcSlrRp7nyLOVf55M9oX6tKTFK6SSrAwme37
         Ngify5/yv+iYcF4Y5Qz7SDVCnxn3hOrfCS1aVYwv2tsWwBnnQ+jbmRY41mst8eAx1n7G
         DXJG5mC6NW0jF9O2xvqgNQQ5m0cvJ8koJi0Jwe4NR+mnqDOrivIeT0f3/nqOAMAbEI5T
         L/mZ1Xz0nw0fMxZza9Y4TxB7GXUY1jyQVWBunv9566A+9RWeYoWm6nHAFuIp/CuB5eFY
         6nRA==
X-Gm-Message-State: AOAM532HMaerkWH/JcHUzqd2Iuo17a6XLxSXvCStsvagi9cDRupTAKqK
        toYpc2nVy3OCBVTIQCdI8hfyNEPMuEk=
X-Google-Smtp-Source: ABdhPJz67pm8aVjdKjGuuc6Z2N+bKhNTycN3w8g2h6vfV2G0+gOlOtc7NWLKh+XXvARwuZtuaFFSKg==
X-Received: by 2002:a62:b50d:0:b0:44b:b81f:a956 with SMTP id y13-20020a62b50d000000b0044bb81fa956mr3156163pfe.27.1634182493027;
        Wed, 13 Oct 2021 20:34:53 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id il17sm841852pjb.52.2021.10.13.20.34.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:34:52 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH V3 10/49] x86: Replace PTI_PGTABLE_SWITCH_BIT with PTI_USER_PGTABLE_BIT
Date:   Thu, 14 Oct 2021 11:33:33 +0800
Message-Id: <20211014033414.16321-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

