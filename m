Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F7945EB54
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376713AbhKZK13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbhKZKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:25:19 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D369C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:22 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z6so8477269pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hfOJkuEUuvye8xM8dXxAlfqQmVjS9qSI90fDUiJCto8=;
        b=VrQpOWDxLrvKwDNwYw4FLzf1IY+FUCKdpvT+ALFYvu4Yru33uioC36B7HrfsMT/fgl
         uAtcLyDvhxah7j5J1fAHoVIjO7QqK0UNByQe2Uc3tzxvf0dwHaiJJlEyeFSmM/UEh7Bn
         k2B1BaJDRIv53ZUGuaq09lJ6fIh0rkM4y8RzVdryxcZkx9zQfCg9TnwbCTvcQjm12BrD
         BjZtrpBIxrxP7X+JlZgVr7vMITxXlitEeBTfLkyL52msaESndTo0TrnigCGZ1srJ2wsw
         dTkNCXCUMCI3L3IQM+foLL/TsI4ZaLoMMXQ+Vkeexv0rwdsOQ6R45yOfjw2YlD/g77m0
         eCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hfOJkuEUuvye8xM8dXxAlfqQmVjS9qSI90fDUiJCto8=;
        b=lK1Rzip6KMhKVEIohGVpnAxhhEIxgu/Yehujwnu56ojccNOtXn1JH4quXNs85N0Lja
         tpm/YRA5Jl9QbajQawyEtErXLUeIdlKAUHZjlBaDhCtQlBPU081gfChUx2yJycb6ZMrH
         +K7iyc+NxYQpx3E4nhUCnDaHjWCcdkoqAz1gTktU2knl+uOm4mtEZpFsJF9gxeDY3TKX
         0NRzF+ySlrXJ4hn7NOjgtrbmvMWHQakTEDN/EQG5UCseliOQgfcAwKTGfEZI83AnXUFp
         4dfhg1/ZtZi41MyTtxTdE7dY2sTp+R8blkCAnXNoQM3oQ28eRLOJts2yDbTQqCYr/UoR
         GEXQ==
X-Gm-Message-State: AOAM5319VzHmamwbQSwtQfmSnAnHlDiEMYyVYjBk1RWnPGVcEG6HFm5+
        oNGMpQuaHZq8KjcAj9EV6qFwtXqC9ds=
X-Google-Smtp-Source: ABdhPJxim2nt9mjjJHsPs/ZQndlxH3cov1SNteL+hnaExNXdGTz5wJu+ShIvGgIA7594HbgDHUhGNQ==
X-Received: by 2002:a05:6a00:1946:b0:492:64f1:61b5 with SMTP id s6-20020a056a00194600b0049264f161b5mr20365179pfk.52.1637921601493;
        Fri, 26 Nov 2021 02:13:21 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id s38sm3845086pfg.17.2021.11.26.02.13.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:13:21 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 13/49] x86/entry: Expose the address of .Lgs_change to entry64.c
Date:   Fri, 26 Nov 2021 18:11:33 +0800
Message-Id: <20211126101209.8613-14-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The address of .Lgs_change will be used in traps.c in later patch when
some entry code is implemented in entry64.c.  So the address of .Lgs_change
is exposed to traps.c for preparation.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c  | 2 ++
 arch/x86/entry/entry_64.S | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 762595603ce7..9813a30dbadb 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -12,3 +12,5 @@
  * is PTI user CR3 or both.
  */
 #include <asm/traps.h>
+
+extern unsigned char asm_load_gs_index_gs_change[];
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 44774cc5bcc9..5db0196835cd 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -733,7 +733,7 @@ _ASM_NOKPROBE(common_interrupt_return)
 SYM_FUNC_START(asm_load_gs_index)
 	FRAME_BEGIN
 	swapgs
-.Lgs_change:
+SYM_INNER_LABEL(asm_load_gs_index_gs_change, SYM_L_GLOBAL)
 	movl	%edi, %gs
 2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
 	swapgs
@@ -742,7 +742,7 @@ SYM_FUNC_START(asm_load_gs_index)
 SYM_FUNC_END(asm_load_gs_index)
 EXPORT_SYMBOL(asm_load_gs_index)
 
-	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
+	_ASM_EXTABLE(asm_load_gs_index_gs_change, .Lbad_gs)
 	.section .fixup, "ax"
 	/* running with kernelgs */
 SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
@@ -1008,7 +1008,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	cmpq	$asm_load_gs_index_gs_change, RIP+8(%rsp)
 	jne	.Lerror_entry_done_lfence
 
 	/*
-- 
2.19.1.6.gb485710b

