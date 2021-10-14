Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E1E42D14F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhJNEA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 00:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhJNEA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 00:00:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7580FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:58:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so260713pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=olANUIywlItruKHUBTqm2ifABR6f8SPD3JP9WQXuSlE=;
        b=SfE4t5tfrew2RlGwv9Ij8H5Cg7PQh1nKhckjsVkZ5fFzk6Vy1wDKc7X/BT7ts62TXY
         YRXfIOkqKeRo65pq/Knz8rSMP1LJm+TVw5/nFu2G5KeYTISAy81h4cRmGRzx2VYrSYNT
         AAs8HpXc2tM1XsnFmFIm9teqOcEdBzDhYr/x/91lVeKfzvz5eTmAISVtgRU/HjVYzSUr
         HtGzmGDJXVNeJCQZaEdCxhdZtWhQerMrgFYjjTt6j3vOQ1t8E82LwxtCXJ95VmNaogtY
         wOZqbaZnmDBIChBAX2j8UJxPkeLfo9PBKmMvCpWwYxvtKZwp8oX0Sst7hhZBIVfKR3ZN
         LD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=olANUIywlItruKHUBTqm2ifABR6f8SPD3JP9WQXuSlE=;
        b=Nefk+pLyPXUgCkH7a4ZouWVzrvK7e8FFqBlGq30J98BYCifSzwL9xmNsq8eM8G3hFJ
         ZvOJcVssQIlkrxFuhG05rpG0mE3Em6LwBaQ0AOtRCXZTdJRyvvorIVC7MmJi3LmS+2wM
         VXAGtfe/n+aPXHGvhYyZf/U3NuTMXIahog005Y/7T2erR12DQy6CIUctliBiIpPT91Y8
         1DGtAoFFpiBB9vBQLy0UZkQbA+DDqh/92pIz/t4XGabvU84axUncU+G72DW3TqIiRLov
         h7BEjZ3e+au2BxUdyvoMt/aDqNyoyadwegU8yeikCsOeVvN8Rp5i3wfmehku8N3P9lC2
         sJWA==
X-Gm-Message-State: AOAM530LxwyXTr9qAH2kWTCTAnVctPpJd2Xdv8hLkR94KE8kIIGDVmTo
        b5WDyZewFGFZcuNN5qGQ9AZa7JVcdV8=
X-Google-Smtp-Source: ABdhPJz/ifN8evMbsv6uMLZ7HHXspGpUIIeHF5cPEawqe63ip2S5ww4doA9ZtPXFXw+pEVZGs+xaBA==
X-Received: by 2002:a17:902:64d6:b0:13e:a59e:332c with SMTP id y22-20020a17090264d600b0013ea59e332cmr2946474pli.30.1634183931899;
        Wed, 13 Oct 2021 20:58:51 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id v12sm902646pjd.9.2021.10.13.20.58.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:58:51 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>
Subject: [PATCH V3 45/49] x86/sev: Use C entry code
Date:   Thu, 14 Oct 2021 11:58:31 +0800
Message-Id: <20211014035836.18401-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE to emit C entry function and
use the function directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 22 +---------------------
 arch/x86/include/asm/idtentry.h |  1 +
 arch/x86/kernel/Makefile        |  1 +
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 58f33e86c6c8..48b4c320f5e7 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -528,28 +528,8 @@ SYM_CODE_START(\asmsym)
 
 	UNWIND_HINT_REGS
 
-	/*
-	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
-	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
-	 */
-	call	paranoid_entry
-
-	UNWIND_HINT_REGS
-
-	/* Update pt_regs */
-	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
-	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-
 	movq	%rsp, %rdi		/* pt_regs pointer */
-
-	call	kernel_\cfunc
-
-	/*
-	 * No need to switch back to the IST stack. The current stack is either
-	 * identical to the stack in the IRET frame or the VC fall-back stack,
-	 * so it is definitely mapped even with PTI enabled.
-	 */
-	call	paranoid_exit
+	call	ist_kernel_\cfunc
 	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 931b689f464c..84ce63f03c7f 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -426,6 +426,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
  */
 #define DEFINE_IDTENTRY_VC_KERNEL(func)				\
+	DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE(kernel_##func)	\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(kernel_##func)
 
 /**
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 28815c2e6cb2..9535d03aaa61 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -52,6 +52,7 @@ CFLAGS_head$(BITS).o	+= -fno-stack-protector
 CFLAGS_cc_platform.o	+= -fno-stack-protector
 CFLAGS_traps.o		+= -fno-stack-protector
 CFLAGS_nmi.o		+= -fno-stack-protector
+CFLAGS_sev.o		+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
-- 
2.19.1.6.gb485710b

