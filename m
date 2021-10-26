Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C9443B40E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhJZObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbhJZObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:31:03 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CA4C061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:39 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 83so8088745pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVUwb6qJNDu/CeEak3yLPHW/+QDV/ly9Tbge8nu9b0Q=;
        b=fLeLVsAbEKbSu/pW6wu8oLLi+Tq6/oN/NUkxkREUp1Ikt9h9uUgzizrL6JnO9JIgpJ
         r8tnABUaG71gGGkJk2/OTkrxmRZ5k5KTglp4YCHX7dclrp7HyrMvTF5atqIEbF1oYB6K
         eJRFr7KkumPHNnJgKGk6SJqD+cu0kFli8M7ISjPUbDVYkcRmw6ebIIngEzHo8VIH/y4k
         bBYLdBJ35LbE7HYXQ3kQGhPcS4qdWOK9vYCn0tTkaKSEV1KeMLJZziD2hF9vlXPZiKmb
         PDIfn5UQxGnLCwNTPMdWd06ZTUEpXPLlmPxfpKwh1fe7sKQhT5Ux5N3BOSugtoTEN+OB
         L3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVUwb6qJNDu/CeEak3yLPHW/+QDV/ly9Tbge8nu9b0Q=;
        b=PTDQOrdowninn4W+ZDCuZ3xN4DmLXoBCdGISn/Hq8EGcK02pIitZAVRn60A62eaw6n
         uLzl5RUq7X4XGLUVp9n7UyC56/OftKrB1zPmDf+YiIX9qIKNA2vcPxbs0n+tXIuBBDXz
         qbZeNNCWfippqKbW47tXSpLLYr/HJXT0kdsQNtgrVf5MzhkHZk6gV6pafxuRZUmT7dHO
         ne0kTMV6WnlV94Wo606kUyu1yajq17fdMdl3bgnIvIFTleuMXmJg0RuFonTsCNuJ1Tuh
         cYDBkfomrTuJUMJd7xopAQxWs5Rrd32v3DQ2D97/fCSh8O268SJMTkm6g0rzODFq/OFi
         yF5A==
X-Gm-Message-State: AOAM531K2IQgJlgdKGWz5Ndg0jg2/+rFkcbLla9Ikya2ZXi/NQaEmFSC
        YALU8DpYMh93Zx4PT99sacoT/zQ3JQw=
X-Google-Smtp-Source: ABdhPJxbHHFZoetxSmMzAhPk8qZs2CO/bhPeyAABQ9ly+NkQrPO5FWL4xCAMsV9BKsmH5EdgsJ5uxg==
X-Received: by 2002:a63:7506:: with SMTP id q6mr19083570pgc.349.1635258518629;
        Tue, 26 Oct 2021 07:28:38 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id m15sm1102915pjf.49.2021.10.26.07.28.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:28:38 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 14/50] x86/entry: Expose the address of .Lgs_change to entry64.c
Date:   Tue, 26 Oct 2021 22:27:46 +0800
Message-Id: <20211026142824.18362-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The address of .Lgs_change will be used in traps.c in later patch when
some entry code is implemented in entry64.c.  So the address of .Lgs_change
is exposed to traps.c for preparation.

The label .Lgs_change is still needed in ASM code for extable due to it
can not use asm_load_gs_index_gs_change.  Otherwise:

	warning: objtool: __ex_table+0x0: don't know how to handle
	non-section reloc symbol asm_load_gs_index_gs_change

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c  | 2 ++
 arch/x86/entry/entry_64.S | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

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
index c8f7b740a9f1..daaeeb8acd22 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -731,6 +731,7 @@ _ASM_NOKPROBE(common_interrupt_return)
 SYM_FUNC_START(asm_load_gs_index)
 	FRAME_BEGIN
 	swapgs
+SYM_INNER_LABEL(asm_load_gs_index_gs_change, SYM_L_GLOBAL)
 .Lgs_change:
 	movl	%edi, %gs
 2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
@@ -1009,7 +1010,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	cmpq	$asm_load_gs_index_gs_change, RIP+8(%rsp)
 	jne	.Lerror_entry_done_lfence
 
 	/*
-- 
2.19.1.6.gb485710b

