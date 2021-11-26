Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A145EB5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377049AbhKZK1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376704AbhKZKZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:25:25 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74160C0613B7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:58 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id o14so6390266plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYs+fGrG7SMtCiyyfsH9HIdgtcop8w5k/fNljYQzMtQ=;
        b=dlzxHmBlpVKdAWtCWpXcol+47qPTTm8KL5fd1NDTvpku3ZiWUFXEYvBVNJNz8Qz8nH
         NtAn2l3apJULdVLPQ9eQG6dZo7u1Z7u5MxFnRPE5mf1E5eKPY7pFSQFcOP4ydxVpAwyE
         rAgRW7indxe1lVWhzq/2EvlVDoinzuYa1LzCYUHWjeYd6dhn4JyMYRYvTGGY2LMpUCjH
         oUKC2D9MGTq/VtRtVs+Syv1yb4dAMjr5xs8Am6HWe1FwCp/tgaf+5q5VAb2Aw5xJl0Yx
         yBk5iq5MPvHQqS1a6fdQqFKhBODWSiJhgZpdhbfmvd7ViSDOvVpwOEHNmXN4ucz0wLcj
         pa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYs+fGrG7SMtCiyyfsH9HIdgtcop8w5k/fNljYQzMtQ=;
        b=ZhtcDuVsrCcoqxgK7pLQbwOYtZZJaS0ZVo/T/XFmDoQsXN2mJiQyq0Er+1fMcyC/3E
         heATJ3pT78EILwmyup99Z+rTQxa/zQXdj56EwRe5myMly53fJW5OiXSM7c8OwLigiwA+
         bWe7vtFxaPnvsRzYE6hI/K7HQ8Dek70JkV178fDofxBNkybxE25zw0VjCJ3/U0Y+N5f9
         rm7rD2vRLl+GQHn8KWTYN3u40hvn6NlBvrtUOxdk7hKa6qbC51EAb/6dMD49y3MGu2ai
         QdaB25tF2Bw0WgN+EloVc3TGYHqR9I3Xop13mmPtT2LS6TcYPo6YhlFBj2o64nhVT134
         esNQ==
X-Gm-Message-State: AOAM532np63+fjHW1ldOZeJPB5BDLF2JQPrfrKxKgDJOe2HPamyroIrX
        yntmQEsF+ehtDjJtbgSVI/CWjEkmOYI=
X-Google-Smtp-Source: ABdhPJyeXe5TBorTkSRXutz9ZFXxeAwyqpHFudSrGuYTu98scGxJj7Sm7wSF6/J0BFJqpHj5ynuHRA==
X-Received: by 2002:a17:902:ec8f:b0:142:11aa:3974 with SMTP id x15-20020a170902ec8f00b0014211aa3974mr37305460plg.30.1637921637846;
        Fri, 26 Nov 2021 02:13:57 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id d7sm7044066pfj.91.2021.11.26.02.13.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:13:57 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 19/49] x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
Date:   Fri, 26 Nov 2021 18:11:39 +0800
Message-Id: <20211126101209.8613-20-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Moving PUSH_AND_CLEAR_REGS out of error_entry doesn't change any
functionality.  It will enlarge the size:

size arch/x86/entry/entry_64.o.before:
   text	   data	    bss	    dec	    hex	filename
  17916	    384	      0	  18300	   477c	arch/x86/entry/entry_64.o

size --format=SysV arch/x86/entry/entry_64.o.before:
.entry.text                      5528      0
.orc_unwind                      6456      0
.orc_unwind_ip                   4304      0

size arch/x86/entry/entry_64.o.after:
   text	   data	    bss	    dec	    hex	filename
  26868	    384	      0	  27252	   6a74	arch/x86/entry/entry_64.o

size --format=SysV arch/x86/entry/entry_64.o.after:
.entry.text                      8200      0
.orc_unwind                     10224      0
.orc_unwind_ip                   6816      0

But .entry.text in x86_64 is 2M aligned, enlarging it to 8.2k doesn't
enlarge the final text size.

The tables .orc_unwind[_ip] are enlarged due to it adds many pushes.

It is prepared for converting the whole error_entry into C code.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e5d69604322d..4781ffbe39ba 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -322,6 +322,9 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry_body cfunc has_error_code:req
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	call	error_entry
 	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
 	ENCODE_FRAME_POINTER
@@ -973,8 +976,6 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
-- 
2.19.1.6.gb485710b

