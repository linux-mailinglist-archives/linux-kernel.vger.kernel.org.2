Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C0A397830
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhFAQja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbhFAQj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:39:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB27C061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:37:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x73so4610085pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y1DhST/OMgdnNJAfMGxgCLqly6YSJ+wFzzj7zRegaUo=;
        b=sIXeqwbeYyDTEN+xuM9yLS+2tJgmKnCeXInZOiLQK6gv5h4rDlUAmDxC9v5a0TfXJg
         aUf/LwluyK9edY5fd3R1f9GeZMAUCch3EW6fclDvbPxprM6zQfjOmozvNjtuxXquJvsB
         WYvT/DTPAKD2suj+xzpa74VRq1qnz7f9Fz+ccWZOeNQXtMKXsAwLpKMfIW/kDHzlPK/B
         LlqDC9iMnar3O/DXGEqftChBBqfFshwerVI15ZTS+YBMsucmG9dAj5QrznVXf+H0vJtu
         OqFNZPDqBn7noZLH5IUmar7Nz1pPaf6dBPF1INb6EgAqVA2OviKBnXwK3sE81pXvTiTM
         bZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y1DhST/OMgdnNJAfMGxgCLqly6YSJ+wFzzj7zRegaUo=;
        b=uEqmcF9mqK7Y83QM/FhssebFWDL+r1eceoTl+n3LW5SZtbhpaJVYWqHSu+qaoKsVih
         U0oxj69rlc0EyZH4HowRcB07nNvhP199opmhW/B+a+nkYzVV+1fFUb2zV1Z6hR22aIi/
         BLmQ/Qt5JxoreQmCNvvYYYghAyYypv/AF25L4DUqbPjMNkxhl5ce0RYNUmyULcJHiXAU
         vDGhzaDCnYi5cDQCTLMw2WGi/v2NJvZSD/wkv2Ely1vwQZE5jz8v4yKKnFIztVley/4z
         83TVS8N7uOYI7qpRXiTw+FFO+62AIyQHkgu6mdVcHSNeTgcwx6Y6khAok+wb6z2CrxFy
         8AXQ==
X-Gm-Message-State: AOAM532adE83ynQaZR11u/OKVYjetpLS0yV9ak8jDxMX/vjOjBk4ZChM
        hWZKMXI0VFTU8/uu6DikB4ioakq0jZA=
X-Google-Smtp-Source: ABdhPJxWO1ynhnvd+YSPN9isxI+QqwBodCsUtygCLgOfo1wGrRLTjBOwgs9tiA2F626ZqAhm2DGJgA==
X-Received: by 2002:a63:6a8a:: with SMTP id f132mr11379316pgc.266.1622565466484;
        Tue, 01 Jun 2021 09:37:46 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id h63sm5036342pfe.104.2021.06.01.09.37.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:37:46 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH 4/4] x86/entry/nmi: unmask NMIs on userspace NMI when entry debugging
Date:   Tue,  1 Jun 2021 14:52:17 +0800
Message-Id: <20210601065217.23540-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210601065217.23540-1-jiangshanlai@gmail.com>
References: <20210601065217.23540-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f54e06139d4b..309e63f4f391 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1055,6 +1055,24 @@ SYM_CODE_START_LOCAL(error_return)
 	jmp	swapgs_restore_regs_and_return_to_usermode
 SYM_CODE_END(error_return)
 
+.macro debug_entry_unmask_NMIs
+#ifdef CONFIG_DEBUG_ENTRY
+	/*
+	 * For ease of testing, unmask NMIs right away.  Disabled by
+	 * default because IRET is very expensive.
+	 */
+	pushq	$0		/* SS */
+	pushq	%rsp		/* RSP (minus 8 because of the previous push) */
+	addq	$8, (%rsp)	/* Fix up RSP */
+	pushfq			/* RFLAGS */
+	pushq	$__KERNEL_CS	/* CS */
+	pushq	$1f		/* RIP */
+	iretq			/* continues with NMI unmasked */
+	UNWIND_HINT_IRET_REGS
+1:
+#endif
+.endm
+
 /*
  * Runs on exception stack.  Xen PV does not go through this path at all,
  * so we can use real assembly here.
@@ -1145,6 +1163,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 * At this point we no longer need to worry about stack damage
 	 * due to nesting -- we're done with the NMI stack.
 	 */
+	debug_entry_unmask_NMIs
 	pushq	$-1		/* pt_regs->orig_ax */
 	idtentry_body exc_nmi has_error_code=0
 
@@ -1286,22 +1305,7 @@ first_nmi:
 	UNWIND_HINT_IRET_REGS
 
 	/* Everything up to here is safe from nested NMIs */
-
-#ifdef CONFIG_DEBUG_ENTRY
-	/*
-	 * For ease of testing, unmask NMIs right away.  Disabled by
-	 * default because IRET is very expensive.
-	 */
-	pushq	$0		/* SS */
-	pushq	%rsp		/* RSP (minus 8 because of the previous push) */
-	addq	$8, (%rsp)	/* Fix up RSP */
-	pushfq			/* RFLAGS */
-	pushq	$__KERNEL_CS	/* CS */
-	pushq	$1f		/* RIP */
-	iretq			/* continues at repeat_nmi below */
-	UNWIND_HINT_IRET_REGS
-1:
-#endif
+	debug_entry_unmask_NMIs
 
 repeat_nmi:
 	/*
-- 
2.19.1.6.gb485710b

