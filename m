Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6B244C075
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhKJMBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhKJMBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:01:46 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC62C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:59 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso1472449pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ca+sb+meZwHAb+91W5mI2yDSsqaR+Wc14MEA+LhBOAY=;
        b=MqPElQbTSluatc93L4wJnAbqXZLz8PFKqKaiN8oGS/fcjxzU50yUJlynMSzUCeFBaL
         6o+xArIGPkV95kb17JcX5K0frQU6gd5zWxZrP4/Vv1aPRWPTWGeFSh5aKLhXG0I5jROi
         CDq5jHESuWzm5VTBkOvhilXdJXGRWJf/j3WrRkKrhP8hYQpXXiRZg22RsrgiBU66X3TI
         HN/L0k3Me3ek4l0I8SNoEaioEHuKrWGDCPaeaWMSqkg8TD67sBpX9G93mluIJXGp8oy3
         2NAkfaDbPmw3Arb2PIgcPpkI/W+qYwlU+nfea9VzqYye7Xf18x6PUIwiIcrqI7o0S80f
         nLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ca+sb+meZwHAb+91W5mI2yDSsqaR+Wc14MEA+LhBOAY=;
        b=f9T1WQ+TFgr8JayFgLBoYtnKx144ukOaLXGsk6o8mRJoqVT1PG2kRBGadT/OsJxypr
         ZZA2InF5cZ3VEFYmo2HT7J0uHT1doKyaX+BAq+xbholyXqM/dvB2/DmexIRDe6rPg8WQ
         pGFCvv2cEK9SndxC4kddRkhjF+ljjEtxgm7wsaZ0hnccINEDA0ulQHrfJZNqv1Iarf9Q
         Za6cv7c/Wcc6pz3SHXrs6736NBGV9eyRJd+I3g5US4fas8Jwjsr6Z/cpBwM7g5UiNXMN
         gk0XhhBkqeXWMtpUdb6oqDL45B6MnR7rr2Gxf+SJAXDxyEKVHEenNM4xepWfjMTAZa5v
         edyQ==
X-Gm-Message-State: AOAM5306bLa30ET54QzTDsA160swdsusfIdrLhEaFEStaT+gkE1+sQE4
        98OZaFcFcN2Hj6h7p3tP7sObQNqpAtQ=
X-Google-Smtp-Source: ABdhPJykLyRX89QCfC1xGhHW/x0Br0k0uAusDbK3iRYDUjXmQuhSuwEYmn0tFpmj3srvz9w0l+z+GQ==
X-Received: by 2002:a17:902:c713:b0:141:bbb2:1ec7 with SMTP id p19-20020a170902c71300b00141bbb21ec7mr15095341plp.57.1636545538886;
        Wed, 10 Nov 2021 03:58:58 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id v10sm10729488pfg.162.2021.11.10.03.58.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:58:58 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 14/50] x86/entry: Expose the address of .Lgs_change to entry64.c
Date:   Wed, 10 Nov 2021 19:57:00 +0800
Message-Id: <20211110115736.3776-15-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index fb977d958889..e7e56665daa2 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -733,6 +733,7 @@ _ASM_NOKPROBE(common_interrupt_return)
 SYM_FUNC_START(asm_load_gs_index)
 	FRAME_BEGIN
 	swapgs
+SYM_INNER_LABEL(asm_load_gs_index_gs_change, SYM_L_GLOBAL)
 .Lgs_change:
 	movl	%edi, %gs
 2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
@@ -1010,7 +1011,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	cmpq	$asm_load_gs_index_gs_change, RIP+8(%rsp)
 	jne	.Lerror_entry_done_lfence
 
 	/*
-- 
2.19.1.6.gb485710b

