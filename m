Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88CB42D103
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhJNDhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhJNDh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:37:26 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11DEC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 66so4231532pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVUwb6qJNDu/CeEak3yLPHW/+QDV/ly9Tbge8nu9b0Q=;
        b=I3Pc/7xrRSAJof/Y6kZ2jg9OfrgjxgwpJF2PBudltow/yLg9gut3g6eC0L+HPyy3Ct
         r3PemgbBShA/bl/Xka0TRjitf+k2gdiZwJDJClABY+DBVwsUUAGbEHspqH8cFa9qMHS1
         9oPZt37vDbgKx5XM/IESz6oF/33SXNh/PEtcKubMAPWjKmiij77ykGLrTXcWItpHSbcC
         9p/KNPRM3ZE9GGnRnEOgKZKjKUVf2tzS0W+mV78mpP4YoohNofxQmrvozgF1fGZEHq+6
         W6Ov7L+2R6OjdCi26ZPgVJ2CrBWB3BvEkxiAbBM3YrGEyqvuEYY5gad24lxRLBKgFuZi
         4NDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVUwb6qJNDu/CeEak3yLPHW/+QDV/ly9Tbge8nu9b0Q=;
        b=piptN+D2A9oT5st+IWN+e9R+ImoBu/irld6HKHYEv6ZENtHjgGt3fj/wJFnjux74ia
         0vXNuYH9ZSGZjffaQbR7kBRvC28eJfDOV6etNXmtr5sbCrVt88Y5gF/fjM3indlLADiO
         +09eodiZEtMGZqSnya5CXWEgwVTmXpnewIdOCK9F3Z6WJBOMRnMuqz+5ONAkWNkk8awP
         s8aJP/urbJzPoYXsQKuhUlO5q40/hsiXfQ4iFKahoD7swp8s8N3rh7fhWaimjTcQWIqz
         hHd5DavWH5/c3KeXCBuZ8krS9581J4tyzbjba4Mvmp4j7pxAk0Xg2+CiIFAscPT22ZaG
         mIXg==
X-Gm-Message-State: AOAM530gqBUzZUhmPObjSktLBIP3SeIauN3khOKCDRbpeBspyQg6vb6s
        uqMIJEHqtEAwymOwfEwtKDoYIO0bZ8M=
X-Google-Smtp-Source: ABdhPJyqT4pmAh/FSryUysYzoM39unqI6eIHzKMEm1bRUa0cMmD1VyFIamAFgtg8gLCyXEGuNHKgWA==
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id l14-20020a056a00140e00b00444b07751efmr2785654pfu.61.1634182522019;
        Wed, 13 Oct 2021 20:35:22 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id s52sm840489pfw.4.2021.10.13.20.35.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:35:21 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 14/49] x86/entry: Expose the address of .Lgs_change to entry64.c
Date:   Thu, 14 Oct 2021 11:33:37 +0800
Message-Id: <20211014033414.16321-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

