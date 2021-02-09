Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B879315BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhBJBOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbhBIWYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:24:35 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ECFC061A27
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 14:21:28 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c11so507978pfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 14:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYkm21PyuwLiZr93Ib+DbHMt5X8AQ+yDGADxOTkV6ao=;
        b=X0HTeNld4k5XIuctg1B1GOGvxcx4NEnYnA8h4L/q2atjOPVLuj/eE+RilL/8wOUzLZ
         zsWELRztBNJBPuNMAwNZjn7uO4pBK+Rw9H0t/aWQSImDro78vAJBYg6TK34h1qnSqt/D
         ls1CqRIfPIGC5GQl1GwBPXTEPT8whjPe4FyIv1Fy5yucyNRG5Rtp6euNjHDHsOIaR/f3
         cwr4ikpuJGnH6zZXWhimiqeR4X78mbOfShYsVydzJylibTn1auAoNjztsJIqpEoJ4c/f
         F046qyp2FZuCm8nnVBkTS30bKT+32EzMk5SjQSmzACalavr8G5821FdE5OlNnaL+hW1E
         JxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYkm21PyuwLiZr93Ib+DbHMt5X8AQ+yDGADxOTkV6ao=;
        b=bK/V4ap/cj1/iCprPLirMZ3RaqvPLxEm2LzwmW5wTWSb0zQo5JKsb4yy6IKce2b+c1
         DJpttDywYj9DGfz5bct7cmWvf7n6t6Sik6uriydq8bn5dqRzLIETMCGptinPH1g6uQTq
         L3XQaR8EUocbMuWALHVcaQMD085xyXgLPIWaBBHawdKtza2ty0t9KFWoXN2nrKC2rVwZ
         MZ3///7NSXh37dafhkH4WxI7hMz6WNNJh7NiiO6IkznlDg+myzY5/YbzcFDqFC/csKVw
         z+wUz9ZjsK4Nxb85TXNfdItAWyeGcyw17Yyg4rwSP/TR3syvBsPOcd0iTM7Ih7g7TE5r
         yzmA==
X-Gm-Message-State: AOAM531DfGowe52ARfGdX0gJ6RfO3/GkReEUijHw+DicZCZJ3Azm7GFB
        ITaJHtIzrubO3zY+5Vl1XaA=
X-Google-Smtp-Source: ABdhPJxCezaqlQMfXnyzfHJdTeSqVEwyG4BWoM9i3x0ej+aJQG43cusjn4HUglWMONj4HKmhD5/LCg==
X-Received: by 2002:aa7:888a:0:b029:1d8:49a3:563b with SMTP id z10-20020aa7888a0000b02901d849a3563bmr98263pfe.74.1612909287922;
        Tue, 09 Feb 2021 14:21:27 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id v9sm58601pju.33.2021.02.09.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:21:27 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v5 8/8] x86/mm/tlb: Remove unnecessary uses of the inline keyword
Date:   Tue,  9 Feb 2021 14:16:53 -0800
Message-Id: <20210209221653.614098-9-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209221653.614098-1-namit@vmware.com>
References: <20210209221653.614098-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

The compiler is smart enough without these hints.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/tlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 98d212518f67..4cc28c624d1f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -316,7 +316,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	local_irq_restore(flags);
 }
 
-static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
+static unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
 	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
@@ -882,7 +882,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct flush_tlb_info, flush_tlb_info);
 static DEFINE_PER_CPU(unsigned int, flush_tlb_info_idx);
 #endif
 
-static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
+static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 			unsigned long start, unsigned long end,
 			unsigned int stride_shift, bool freed_tables,
 			u64 new_tlb_gen)
@@ -909,7 +909,7 @@ static inline struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	return info;
 }
 
-static inline void put_flush_tlb_info(void)
+static void put_flush_tlb_info(void)
 {
 #ifdef CONFIG_DEBUG_VM
 	/* Complete reentrency prevention checks */
-- 
2.25.1

