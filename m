Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93B94189D7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhIZPOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhIZPNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:13:54 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF469C06176C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:16 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w14so13439527pfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YGlRbQoGPxqfCX6tbwh49INJZF23MkdoRL5Dn/IEzO4=;
        b=BBpEWXMyuSPiJoR2YMAA5svwL0vb3rNwjUmMPnI9VyPjE9BwVIA4utfw+gpizb6JEH
         LmMeE7Qabuu1ZMOLaFe4KJrFsTteyvBmhSdrBm7IS/j8yfmrL3RA0sVRPasuAy6R+rho
         zko+fgzYz3TPNt8NrogGbnPqUEAEhjgWjw1R7lRZJKxp/6SbgYsJWQal5/cETd4ps0vH
         1n1tJD3YQnVjtMc9aG90Wrrdk3fOWyYdmOoxApRyXU5Wf4Wmea8AvueOxTvkDJR7Hi4Q
         c/HLTo+fypHChlo8atxC/KusMjFqFuoPOHN3al587vbyISM81NVYG8GZ6KcY8AGVifo5
         oTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YGlRbQoGPxqfCX6tbwh49INJZF23MkdoRL5Dn/IEzO4=;
        b=csohogxWBu+VoFmdD+CBFRfvc0fL4jeX3jwxvrorpJO/jC4LE2xTxJqo28UpTBRPUo
         t99jzPou1N7wa115KG0nqlrKLMpE6DaX1dbEK0TXUX5RFUgemu08EmY8tULE2gcVCVDo
         QVI9vashONr7PCh3UFVQzl23gw2ZeMfCfaJulzDe0npHKxRtSzBm9OWNZtm+n5Na9vq0
         sgaC5jTQjJp77PyVtvmuOiSVZ/N96AXIwXieddfWxysTEEav2oMG7kPO25X+LKiYLFwP
         su0aJavPpg7YCpSELiVAcU/DVpq26/lC0ib6l6Ruqj+5/vu5yFmtxAYzEHXsewd/MJHI
         byDg==
X-Gm-Message-State: AOAM533eXj9yKrvw5TsMWZnp04qNUKwUtMBtY38JmXjwJpkfP6H4N+0Y
        xl/o6trL9Jr3IdtZTudoaYkLUoWvQRzqPw==
X-Google-Smtp-Source: ABdhPJzKCkZIMBp8eJx3MEjZPnyE908ZrawYKhImyikebrLdTzq3TauK+0O07BDPpjZcn9ADSW3fTA==
X-Received: by 2002:aa7:9e0f:0:b0:445:636b:3305 with SMTP id y15-20020aa79e0f000000b00445636b3305mr19008768pfq.38.1632669136329;
        Sun, 26 Sep 2021 08:12:16 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id q6sm606319pjd.26.2021.09.26.08.12.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:12:16 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Travis <mike.travis@hpe.com>
Subject: [PATCH V2 32/41] x86/nmi: Use C entry code
Date:   Sun, 26 Sep 2021 23:08:29 +0800
Message-Id: <20210926150838.197719-33-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ETNRY to emit C entry function and use the function
directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 17 ++---------------
 arch/x86/include/asm/idtentry.h |  5 ++++-
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0ba788bb9857..72a1610bb540 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1271,21 +1271,8 @@ end_repeat_nmi:
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
-	/*
-	 * Use paranoid_entry to handle SWAPGS and CR3.
-	 */
-	call	paranoid_entry
-	UNWIND_HINT_REGS
-
-	movq	%rsp, %rdi
-	movq	$-1, %rsi
-	call	exc_nmi
-
-	/*
-	 * Use paranoid_exit to handle SWAPGS and CR3, but no need to use
-	 * restore_regs_and_return_to_kernel as we must handle nested NMI.
-	 */
-	call	paranoid_exit
+	movq	%rsp, %rdi		/* pt_regs pointer */
+	call	ist_exc_nmi
 
 	POP_REGS
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 49c0ebe374ae..c99c58bc179a 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -358,6 +358,8 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
 #define DEFINE_IDTENTRY_NOIST(func)					\
 	DEFINE_IDTENTRY_RAW(noist_##func)
 
+#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_IST
+
 #define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE_USER	DEFINE_IDTENTRY_NOIST
@@ -407,6 +409,8 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
 
 #else	/* CONFIG_X86_64 */
 
+#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
+
 /**
  * DECLARE_IDTENTRY_DF - Declare functions for double fault 32bit variant
  * @vector:	Vector number (ignored for C)
@@ -438,7 +442,6 @@ __visible noinstr void func(struct pt_regs *regs,			\
 
 /* C-Code mapping */
 #define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_RAW
-#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
 
 #else /* !__ASSEMBLY__ */
 
-- 
2.19.1.6.gb485710b

