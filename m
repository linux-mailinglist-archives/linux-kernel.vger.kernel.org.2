Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D242743B44C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbhJZOhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbhJZOhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:37:47 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D3C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gn3so11129932pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kI2Rkw6YpdObl6e6myBHLkGBf0+xEZMNOZ2amlFD7c=;
        b=ALGd9F1OX0rjuViBgsYjqKwKO+0lKaZyL7NzupA7FUVWnKXfciN2bQXNM15S9GA25O
         jQJAWlrnMR3PBIZ2QYkhbbwG5qGx74jtmQb16MItXwrd8vgeYeLrX0pLjpaoUQdnohT+
         Tc/12HyhViR7CrN7yYePxJQEU9AjuUA9bLwQ37lomzsz/JYkeVJucnBwZ1C/6X4Uyl7Y
         ZgZbFkLxwJORTP0KqTVlDdhrgpBpRA07py/Yunzh6zff9TL5cGoxsZOWvptRdsBf4bvx
         t50rI0zdV7QNv/bsgYE7SzGlwU7YLJyzdN6vQCSA0Bu2atVJO75V6NqNUi4yhT5oQtGv
         +aig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kI2Rkw6YpdObl6e6myBHLkGBf0+xEZMNOZ2amlFD7c=;
        b=EIqJ04/jffY0NnAro+trkv6hr5Wi4aYIvXtO+jYIo/phI6ZWEsuVOyBCOjl77B8owU
         nzUCqR8MIgoxQVLOsdVYUiwE0ou4Tiz9x4fwRBtlcCIeLdk/07jy/XLliQWdHL9MPsv4
         rXJqZS2y2VOkzD1ZDbw0n2WWCYzyQl7wiZPXqZ2eAh5Bwdr/jptXHw5M2mQOj395QhRW
         nbMSut/zTl7zLDYuUBI+sWZ8f6asQzqLC3IwcGZjg5Ro7P3Qjs72vBFVhDccDHRr5IwK
         8hjQtsYSQ3URAmTeBdbMVR5X9IhUq8kiY614vQKNdKjIALh7ZK5q1AxJ024NAohnicVG
         TuxA==
X-Gm-Message-State: AOAM532GOuhmP+biKg4bn8C8pKch50sOunKFwsrCNNZKmYZSAREI1A98
        j0T/J/n30DDdQ+5TvuSarpRz3CnSbhw=
X-Google-Smtp-Source: ABdhPJxB73N3d94DgXy/VVd/eYVid4QocOzGkyK7JN0geKdkx3ZgrgWsk/F8uLuYTsZ6n+/q6LpWqA==
X-Received: by 2002:a17:903:234b:b0:140:4b5d:3051 with SMTP id c11-20020a170903234b00b001404b5d3051mr13851624plh.57.1635258923432;
        Tue, 26 Oct 2021 07:35:23 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id t8sm20612699pgk.66.2021.10.26.07.35.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:35:23 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 30/50] x86/entry: move PUSH_AND_CLEAR_REGS out of paranoid_entry
Date:   Tue, 26 Oct 2021 22:34:16 +0800
Message-Id: <20211026143436.19071-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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

