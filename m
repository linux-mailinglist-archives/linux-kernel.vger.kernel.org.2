Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE4D3FCC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbhHaRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240521AbhHaRvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:51:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86533C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:50:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 18so15568551pfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUrF26utaK6QlvwJTQlC+8MKVIPt1G5KPSdp8ILkinw=;
        b=IT1tOKpM3tzKzdwcq4+QdiLVqZaPtI0k8pZ7BXrvxhQyWRlWmw0o4bdQKVbCraOs/c
         YstseVNxtfG0etEMXB7FA1GaRxtGg996NZi2B3jH6l0BghIlsoOHjWnDGl6l2Z+0B4bX
         agacct0IQ243W9L227kvslN+ZHdTpLWTho+yamCLZHZAU4HyxPs5cyz8sU+Lt4dp5UYd
         Znj3t9yWFXidputKDRW4ElueNk8aanU7SHmYRArKzBpa1koxJ7wOC4gdZs035TlmzhZ3
         hzieFByGOKrSWqCmspMDFbXHhIqVHZA8z/KTEr7mTOCiS3rEbqCnCSWp2t+O8mrUfa2X
         HlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUrF26utaK6QlvwJTQlC+8MKVIPt1G5KPSdp8ILkinw=;
        b=nrB2QaU7+EuiU2atTLbenTWqJYmQkzADGjXZNW4jRSuPaTveTAEqyvSHBHL0hBHYZL
         HA6ueDAcpE4o3kS0/b2zOHbk6aQE/Y7gHWJitSAU34XFS0s/yPKxxm43WVCHj039U759
         E1WiNlgTP1PqU6RZ8FNETjUvMArSaWjHp1EXdfx4C/NeQk5TQOWHDEN1kPbeRxwBytsa
         eyD4zBhKQ8nj0h81yVuzizkn/7kHygnhVMeueJy4U3/ZvgLUp20XmoEgYLV9wHNyLzO+
         xpPlS53R5CML+iRAxxZK9tVpMPcmBNEjKh+YeNdbyj61dqFou0u88YJsCm1HZjS8V3sv
         VKIQ==
X-Gm-Message-State: AOAM530BM/CuYHzKUw+9i0gWPRYGHDIi6QXad34pnj39xUe4++YsbjEW
        YcH5rI+SEAP5SkzWSheNgX4emHbszWo=
X-Google-Smtp-Source: ABdhPJw7q5ef37dOoti5BBYdrD6V19mOpU0lFHPrpmjQP9zoItPZbe1NDs5G9eCR5G2v1gpTt+v3Qw==
X-Received: by 2002:a62:8305:0:b0:3f6:72a:92ee with SMTP id h5-20020a628305000000b003f6072a92eemr21970263pfe.19.1630432251933;
        Tue, 31 Aug 2021 10:50:51 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id g37sm20363549pgl.94.2021.08.31.10.50.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:50:51 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 04/24] x86/entry: Expose the address of .Lgs_change to traps.c
Date:   Wed,  1 Sep 2021 01:50:05 +0800
Message-Id: <20210831175025.27570-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The address of .Lgs_change will be used in traps.c in later patch when
some entry code is implemented in traps.c.  So the address of .Lgs_change
is exposed to traps.c for preparation.

The label .Lgs_change is still needed in ASM code for extable.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 3 ++-
 arch/x86/entry/traps.c    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e38a4cf795d9..9164e85b36b8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -729,6 +729,7 @@ _ASM_NOKPROBE(common_interrupt_return)
 SYM_FUNC_START(asm_load_gs_index)
 	FRAME_BEGIN
 	swapgs
+SYM_INNER_LABEL(asm_load_gs_index_gs_change, SYM_L_GLOBAL)
 .Lgs_change:
 	movl	%edi, %gs
 2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
@@ -1011,7 +1012,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	cmpq	$asm_load_gs_index_gs_change, RIP+8(%rsp)
 	jne	.Lerror_entry_done_lfence
 
 	/*
diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index 7869343473b7..f71db7934f90 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -67,6 +67,7 @@
 #include <asm/proto.h>
 
 extern unsigned char native_irq_return_iret[];
+extern unsigned char asm_load_gs_index_gs_change[];
 
 #else
 #include <asm/processor-flags.h>
-- 
2.19.1.6.gb485710b

