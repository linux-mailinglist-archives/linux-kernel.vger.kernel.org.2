Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB89E44C06F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhKJMBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhKJMBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:01:20 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA3BC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:32 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so235753pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aN3mTl3GmXayL34YiRI9EPb1zHUx04Qn7geFZIsIPWo=;
        b=ayQKvNrD8r7rXO/Km02i4hTIwWBQHpBBrHk9koqyvqOL21H9wXfGHmcRuAs3zaGD7p
         Drh9YnPUcNpZ3KbgUhUuJMoK7mvwJbQ05K844aQ484GksrB5H7phAJfceZGFoBPxnjlB
         kd35LuGZbyqYKPBEdilMZcZ1Fgqv8tLhSSU3FblX3PHAtjrxndj9CxEno0P8aRUB1DKF
         +QEmpZD6z/s9n19kDKUR91JGQ3p+9OqaPAQrQbPYOnD2bp82e78/BqkH0niBYglXpAXh
         9DKirJNZ6URBP58ZKtlYPqlmr3gGOU4WoOxqTvw51hCoPIxsCUYfrZdGZRQPbAkiVg78
         Ug4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aN3mTl3GmXayL34YiRI9EPb1zHUx04Qn7geFZIsIPWo=;
        b=L8+XvMIr7imbU7g3oryiqJrWHcOeJ7wyxeVPych7hsK/WsoVBrehZl7aY6XkCn5uNL
         NAYULHtrpYM5I0DDNBfiYA3nTyWGEZannUr93hQPQLRYcGmF8b3hlyfhR2tkr36Dmp1N
         E3wa67cEoLZMmUXwEKMeuWWxAiCSxK398n48JsmZ7ePxOlMz6H8Hlf8nIz41CaAU2yO+
         /n5U2c344BPQ+EKAGG+Yaa6P55TuRyRAz5TNjr1Z+NlarYrPbJzxSH9CkrYxz4xbYN2h
         3rl8+uRodiPgQUzB9DdgILu3P9V/sn00YCh/aXmOMmjerqbVYAAc/aNuWy8TCUSuduK0
         0Mmg==
X-Gm-Message-State: AOAM532yF49xG7+G7+c+mDtKTgttOiqPCafufjHtcegCT73i1qbi8P4q
        paNK/yj89vkpMpKzvORGiwMzvS8N/N0=
X-Google-Smtp-Source: ABdhPJxzHY/ftSisT5GAyR3H+wOpYJuE40yYEGlzJ6JDDOIMlQlz1FUuKhSyCmQCLCTSxcMvslwt5w==
X-Received: by 2002:a17:90a:1649:: with SMTP id x9mr15963899pje.70.1636545512369;
        Wed, 10 Nov 2021 03:58:32 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id k20sm24598268pfc.83.2021.11.10.03.58.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:58:32 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V5 10/50] x86: Replace PTI_PGTABLE_SWITCH_BIT with PTI_USER_PGTABLE_BIT
Date:   Wed, 10 Nov 2021 19:56:56 +0800
Message-Id: <20211110115736.3776-11-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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

