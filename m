Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFDA396ED7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhFAIY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhFAIY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:24:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ACDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 01:23:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z26so6816186pfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XPon/VEE0qLCET88/RPvHjiwrxNQBGueNzocEA/cF5k=;
        b=RTvG/7NDK3vK8bDYhJ2mP+1FTMDhtDZDrXYZBSswpPe+znBdl/VpIgucb962ZZWxNQ
         7epNdgzvqwBc6zIVeR9kT9/x9CGNcDqNPenfluVPNU8T/F5Y0vqo6oFp8qGSbmSzFxex
         KXXw9Pv1R2F0H63pOTXzfnR9cNAaFny1VqFqrvJ2l47Op27Yf47aS/+9kvWFqlRupcsE
         lCDMjyOY2D/pzk+lhX7PravemRzEYHxvElHEPKv8QvSPBCvYukpaiSpfdi1gXMdoMfwO
         Ru4qK2yFVrsuHbxtIcqxR3E89RKMvZTIkTf8xtfPJMjxdRyXm5fSNK3GMDmVlr8BmNx4
         Vr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XPon/VEE0qLCET88/RPvHjiwrxNQBGueNzocEA/cF5k=;
        b=lD3vnpN8Jh+VL5y5O+HPVI2vt3kqBRLa7wDdBFC4PkYirJ2ggmBu+DeBjsfumxr18X
         IsCV2eGcEpe71EfRodLZFRZ7aAjSAJ3pkHHdue0eSZgPrdjMIH5HlnD/TPZGWYZeLHI1
         hKLvFIqdaSAL4yZfshJfTmSv3K6TvninIWAU/Oi7U8s50gDsQJhKaNhhR1rNbIV1u+T5
         KSQWuBmbLPHxrhLQVzlgHy8C7q0zBdfLHH0qTT7ixN91kTfVAFwNL6U6HuxYpMUAeAhF
         LLjcdAbBP5lUqmZt+Ty6NPdi2k8AHvLfGBxcg7gtDkugByU7fFH4D81SctntDa+sxiuk
         gyOw==
X-Gm-Message-State: AOAM531rjt9oxR6oEPcrdCClcMBX/cqW5ugrMHa6rGvNVcEnyCqg5P2U
        MfpUkbV3NU3rf2pCsbRXsSSo/NQ2rUY=
X-Google-Smtp-Source: ABdhPJyWUbTh3xgmSIrXJYv1iCWjSR2KkkfERvpZZubusBCbM+w4RhmUU3GEcVxSAfVZmjq6UsB8Vw==
X-Received: by 2002:a62:92cd:0:b029:28f:29e6:449 with SMTP id o196-20020a6292cd0000b029028f29e60449mr21016257pfd.75.1622535793927;
        Tue, 01 Jun 2021 01:23:13 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id k13sm12647563pfg.31.2021.06.01.01.23.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:23:13 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] x86/entry: Replace idtentry_enter/exit() to irqentry_enter/exit() in the comments
Date:   Tue,  1 Jun 2021 06:37:58 +0800
Message-Id: <20210531223805.25870-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Since the commit bdcd178ada90 ("x86/entry: Use generic interrupt
entry/exit code") and the commit a27a0a55495c ("x86/entry: Cleanup
idtentry_enter/exit") used irqentry_enter/exit() to replace
idtentry_enter/exit(), there is no idtentry_enter/exit() in the code.
But there are some idtentry_enter/exit() still in the comments and
they need to be cleanup.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index c03a18cac78e..33d011ee1ef8 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -128,7 +128,7 @@ static __always_inline void __##func(struct pt_regs *regs,		\
  * body with a pair of curly brackets.
  *
  * Contrary to DEFINE_IDTENTRY() this does not invoke the
- * idtentry_enter/exit() helpers before and after the body invocation. This
+ * irqentry_enter/exit() helpers before and after the body invocation. This
  * needs to be done in the body itself if applicable. Use if extra work
  * is required before the enter/exit() helpers are invoked.
  */
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 562854c60808..c29cd755c9b6 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -142,7 +142,7 @@
  * saved register to be safe vs. the irq_enter_rcu() call because the
  * clobbers already prevent the compiler from storing it in a callee
  * clobbered register. As the compiler has to preserve @regs for the final
- * call to idtentry_exit() anyway, it's likely that it does not cause extra
+ * call to irqentry_exit() anyway, it's likely that it does not cause extra
  * effort for this asm magic.
  */
 #define ASM_CALL_SYSVEC							\
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6140ed..3c6a1c9c4ca6 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -445,7 +445,7 @@ typedef struct irqentry_state {
  * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
  * would not be possible.
  *
- * Returns: An opaque object that must be passed to idtentry_exit()
+ * Returns: An opaque object that must be passed to irqentry_exit()
  */
 irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
 
-- 
2.19.1.6.gb485710b

