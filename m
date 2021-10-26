Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98A43B42E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbhJZOdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbhJZOc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:32:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C487C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:30:31 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h193so14326860pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHTmw7YlwsetcQqUDZxwbA1uvypN4kSXs4ZQdaQ6gxg=;
        b=S6q6LADc3Sh2gXSWUEIdtwDJOL0Ex6ZKTF/BLKurCi+FdfS3+CTKDmaWVLrozIBU9z
         2+7StjQvBmIX5XS3E/AUXy6UeBCHHg63WxgUN2C3nua/ELsglgbGm4gh2QDQacyx27Sb
         ubV5b2j3aEhwIck7h6oh5X5l2qmvg4k3lKgGo5dj7bbhCaNCOcyoRjG6G8iyG+43jsKj
         B57aftcAsC0Bm7Kj0OS8Ti0w7f549Okk/OwEPUKR8dqjYTp3JLTXfFFavb6lzSXmOeJU
         b2vGhhSLvyluGw1pdV7rw/7DzM4lyfTFM0dfhzsOePCZyahTMfNQH1ptdCsMTji5K5Ai
         1rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHTmw7YlwsetcQqUDZxwbA1uvypN4kSXs4ZQdaQ6gxg=;
        b=GYSHoyZ//DqjewAF/8KdCNqY7ysfEDUlinqbycAqi+/LFBvcZFq1CQc+D9/4KbUj43
         eUW91zGABMGKlbBl6St0vshCDhmExq20tvqOIoSEiH5PbACrv/CdFZdOe5tp7QdJxAOV
         UV5wGS85CGA02zjAZ4RWEp1i6uZY4PnCUo1I/r5/O3EVtxu2y9WFoy19TWQAlK0eoAQX
         cI5iCSezkIfjx7gtceP+xmL9hG4LszaVOpfn+BcrzfP+yKUXjOgAeK7ExDle/8i6c3W9
         exWdMC3QaFPj42MbENF1Lq8y2MIke4SgLNjVOMtKblQHzEaLm76Y9s7exfv2Ox0T4uTT
         vCQA==
X-Gm-Message-State: AOAM533nhVSyaFDEaNvlzFvKJt5wzfgIi8b/pQZcTI/3WhaS0fPAnql2
        fEKO7GVFcuJkN8CNeS0wC4Wr5bmiGow=
X-Google-Smtp-Source: ABdhPJzBZFzkNSShaVC7R0SxChxqCftdRTdh9HnFy1uJO+KwYnHT7ItUZlqGj8P1lw1lqV9Z88Y44Q==
X-Received: by 2002:a05:6a00:b83:b0:47b:fbb3:9265 with SMTP id g3-20020a056a000b8300b0047bfbb39265mr11109254pfj.79.1635258631237;
        Tue, 26 Oct 2021 07:30:31 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id x9sm6185123pga.28.2021.10.26.07.30.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:30:30 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 20/50] x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
Date:   Tue, 26 Oct 2021 22:30:02 +0800
Message-Id: <20211026143032.18624-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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
index 1af28027a138..1ec87d9e685d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -323,6 +323,9 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry_body cfunc has_error_code:req
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	call	error_entry
 	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
 	ENCODE_FRAME_POINTER
@@ -975,8 +978,6 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
-- 
2.19.1.6.gb485710b

