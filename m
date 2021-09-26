Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B014189BB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhIZPL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhIZPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:11:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EF1C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:41 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s11so15242176pgr.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOdWJCw3tVCAFZkNrIUjy/G15qNxwBzWh+jwkoZvbqY=;
        b=T6Mgdu6NXsd6XBCofA5+QFKjeHQM11wV8G1IdfMBNttOmD2pyVjsZkoYxUH9fNNYZA
         FQ1SCk3wDOowM+mIQBo+C0oNRXeaJ+8nX7jLR0rj0CstFm8S9j72IPwQr3M77sdYY4//
         FAgHAWyWaBlEjUVnwR64ub6IoGXsPPh/+wf3JMquzA+X+zF5GJHruv+Pfs3s5BH2Z2HS
         h66W8tHScpN+8TkNB1+UoYiluHizKfqUbU07O4wcO2i3Ssrs4gzNrMjUwVy8sVnu5SLz
         0msNHh9btHW5q77RbCwBv8Uzn1ihM+Ht0cxPWbG220iiojps3Nq+EWLdaL7oHM83UT8r
         TPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOdWJCw3tVCAFZkNrIUjy/G15qNxwBzWh+jwkoZvbqY=;
        b=zxW+HSsW1Xag/yvZlgYIo0wanUCH/tZ1iN62cdB+kMZNQLFvw6NpPaGngZ7izuJp7I
         hEQOMrmHNQ5/jG0KW9+sixtnUSuCMVU4VCIQ0gFH2ZIlKH77bfeUyrDknm7I6NJLm0Vv
         phHHd8VKIWDo85wNo1AQzkU9WrX9v8Ucxzjto+6fRQXiwdKCl6GkMrTxVvd2TyrM1was
         96qjkRknLq34WxrCHJ6QQCSgEd64ujNufIBZaiawB2+80+pEWMBWOd82WBWxVBTtfp6g
         o5e01LC31vecOGKV3kBSgCF9zzFKUHNifXHkQxzmdIpbUwZCr30utHKuCoTYnzLR1YSo
         4A2g==
X-Gm-Message-State: AOAM531dlQm2Ml8TvHsBqnNuYLHVKrdcDDv3X42IMR4YYkfcA/cwnq2B
        k3sCuQctSQiStmoMAbjcySqwNwGrC5dHGw==
X-Google-Smtp-Source: ABdhPJxpQraPgk5DwC+uEWmzuOm66s8PTMYftElSAn/1h1qJ1dIvlWQQKQquDpMnO2sgYWtAZVOK/w==
X-Received: by 2002:a65:6251:: with SMTP id q17mr12816678pgv.416.1632668980583;
        Sun, 26 Sep 2021 08:09:40 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id c22sm13479077pja.10.2021.09.26.08.09.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:09:40 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 09/41] x86/entry: Expose the address of .Lgs_change to entry64.c
Date:   Sun, 26 Sep 2021 23:08:06 +0800
Message-Id: <20210926150838.197719-10-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
index 3a6d70367940..7272266a3726 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -9,3 +9,5 @@
  * is PTI user CR3 or both.
  */
 #include <asm/traps.h>
+
+extern unsigned char asm_load_gs_index_gs_change[];
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 95d85b16710b..291732f571a7 100644
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
@@ -1006,7 +1007,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	cmpq	$asm_load_gs_index_gs_change, RIP+8(%rsp)
 	jne	.Lerror_entry_done_lfence
 
 	/*
-- 
2.19.1.6.gb485710b

