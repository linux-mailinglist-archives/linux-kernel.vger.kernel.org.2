Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABDA42D117
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJNDjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhJNDjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:39:07 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D64C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:37:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y7so4278418pfg.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kI2Rkw6YpdObl6e6myBHLkGBf0+xEZMNOZ2amlFD7c=;
        b=ANMi3TUC0FVYtQrIuMSeNmn4rHc5jXuQFzbXgGEWNd51JK3+7mz1e/w3uwpAtSGh8d
         9CoY/LSfBNdFHopjPtZhRKMiakUvyH5/DPCpuoWY4KdwPAEEOyahIBoohK6eRkkkYBc2
         F97LBzj97R48SEU2wwXN6s90Czwr5xIO5JQMzK/8y0kmVoyYAUrBKona3TOPbiYj/T/b
         +TjFQ8+plmX/0DueGcX6h8bvuHQvjuZj4kddOM5iXUz9901aAbUbtIyD3ovJ0Sfrxx74
         1OMPuRt8r3CyMqLIyO/efe/35qyvkJx9qybOm0+Go9GAXBkCIZz25nW5SF8qeyOtZsw8
         hnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kI2Rkw6YpdObl6e6myBHLkGBf0+xEZMNOZ2amlFD7c=;
        b=4ouYyNBLDz3+amXdXjpUipnrG/8+DKTdITSxaGehJmGmpkmLTadGrczfZPwvcS9Yae
         alTxrmW+MGJ0YMbQ+Xl5/O9ogdfmkh044jJ9DZ37LSygMVC6d9fF4dzvATW5szAUESSD
         Ja8POh2fj+H4Zd8f+Qml3cw6c5CeLMN9LmPyTzC9t9QkX1Qb6JNbVio6Wdtgd6RUOplD
         nLFwR0olDezu9ZgtMy/9OlGZ1nUJg69Ri9LEk+xW7AylDM/AsVXxX0f0rmsIyVGV9DlQ
         iB7ipPzcht0k96h+sROAHRDxdya3S44rQgABZq8mj3mbT2S0nmi/EPcm+YyFp7tQnVgA
         Lcbw==
X-Gm-Message-State: AOAM533JbkRTMbXhWyQCEKS2f/pBzDWW3til8iFFhzLhghBuGsUGGrZd
        aVY/sG//DeX3KA9pjdT5Q4m0ZKixql0=
X-Google-Smtp-Source: ABdhPJwDaKGixIdLIA5C4ijBjky/SjicBIIX9lp3qD+13VaLPIiAY1zD01RXqlQA3hnnPB+fFIQsYA==
X-Received: by 2002:a62:6543:0:b0:44c:61a0:555a with SMTP id z64-20020a626543000000b0044c61a0555amr3159627pfb.14.1634182622179;
        Wed, 13 Oct 2021 20:37:02 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id c12sm883785pgw.39.2021.10.13.20.37.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:37:01 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 30/49] x86/entry: move PUSH_AND_CLEAR_REGS out of paranoid_entry
Date:   Thu, 14 Oct 2021 11:33:53 +0800
Message-Id: <20211014033414.16321-25-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It is prepared for converting the whole paranoid_entry() into C code.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 8d873b778681..c9ee58e8e6d1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -323,9 +323,6 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry_body cfunc has_error_code:req
 
-	PUSH_AND_CLEAR_REGS
-	ENCODE_FRAME_POINTER
-
 	/*
 	 * Call error_entry and switch stack settled by sync_regs().
 	 *
@@ -404,6 +401,9 @@ SYM_CODE_START(\asmsym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	idtentry_body \cfunc \has_error_code
 
 _ASM_NOKPROBE(\asmsym)
@@ -456,11 +456,14 @@ SYM_CODE_START(\asmsym)
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
 	 * a normal entry.
 	 */
-	testb	$3, CS-ORIG_RAX(%rsp)
+	testb	$3, CS(%rsp)
 	jnz	.Lfrom_usermode_switch_stack_\@
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
@@ -511,11 +514,14 @@ SYM_CODE_START(\asmsym)
 	ASM_CLAC
 	cld
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
 	 * a normal entry.
 	 */
-	testb	$3, CS-ORIG_RAX(%rsp)
+	testb	$3, CS(%rsp)
 	jnz	.Lfrom_usermode_switch_stack_\@
 
 	/*
@@ -574,6 +580,9 @@ SYM_CODE_START(\asmsym)
 	ASM_CLAC
 	cld
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
 	UNWIND_HINT_REGS
@@ -886,8 +895,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
@@ -1307,6 +1314,9 @@ end_repeat_nmi:
 	 */
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	/*
 	 * Use paranoid_entry to handle SWAPGS and CR3.
 	 */
-- 
2.19.1.6.gb485710b

