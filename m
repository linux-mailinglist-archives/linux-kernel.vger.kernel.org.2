Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919553166F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhBJMmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhBJMjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:39:39 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB48C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:38:58 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t26so1156650pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mU2mc5ad6GePbH4sYA1Nh2eY3tg5115KkQxePABseE0=;
        b=WwhsfLIz9PglgmOP6ZXqxDFtIOqPCvju1rxZQIZhbX4bnHRaXwW40TeGoYMQtH2mPM
         JZvAkR+2Dc3wbb5QZ4dnRA2SSHRmUolaV9ln2KLHYcsMt6eEaJfGEojKhQmnyHRwAHd/
         ZemwPfr110fHRKS1i4tAEdN1IrB8J4RrWCDls72LjvrVxoh9G+Prt4HUTjjXfUjs3jrC
         adL72JteV9a8YQ67xUkvbjJfcGDYI6TuZTj8T3fu3AUF3eTOrBGXRhayThOVnogKEikd
         OZXAtfFKon7w+z78vkBIImmIFm6bARp+indkJJ4Jrtj3gj6Yb365T7fnoJ2Mrv0TNnwT
         CYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mU2mc5ad6GePbH4sYA1Nh2eY3tg5115KkQxePABseE0=;
        b=TqaWXs1x2GK00ZCTHMsC+7PgOvx0REatD0DYnDE9HIdpySVhhp+uI+l2Vzl53pwhYj
         +GOcL+lkaLXaRXsnUYxnmfbsqFRGDkDtTFN2Jz2rRWQwEfMm27sTAgAeEaKS7vA+F38l
         mPYoArvsT0eBH/kX+bk38wZ2tfpNANOY3+qxoBuzEIsPMGNYMvo5CnlexU3hd9PIuMr0
         OTthfhcGIivnYvH5PiuJX64TjHzLErhM/seS7Gu/a7enFFjGLvcsLadIOE4WiDZjMmKC
         oIdCtEpJC+Af3jVzc8x9YBDG2gQOQzRzNOxBvtk8vcXSlKY1HpirURGD9Z8k4g9dqhJZ
         MFBQ==
X-Gm-Message-State: AOAM531J3QTlvb3H87uPmqYeZg+gOkl6ugTqTZ9Mbl2iEfW4R2xg31VQ
        H4OiqDBLenQ31pv2BikN5+y05Ez3tRQ=
X-Google-Smtp-Source: ABdhPJxDOWKKqsKC2198l56Yq+8ZDM5pQy6yb7jXIQYFpFxd4tL5QdtSUC4jcRlX4Vs+y1PDGYmGPw==
X-Received: by 2002:a65:67cf:: with SMTP id b15mr2975277pgs.320.1612960738291;
        Wed, 10 Feb 2021 04:38:58 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id r4sm2218196pgp.16.2021.02.10.04.38.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 04:38:57 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Balbir Singh <sblbir@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V4 2/6] x86/entry/32: Use percpu instead of offset-calculation to get thread.sp0 in SWITCH_TO_KERNEL_STACK
Date:   Wed, 10 Feb 2021 21:39:13 +0800
Message-Id: <20210210133917.2414-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210210133917.2414-1-jiangshanlai@gmail.com>
References: <20210210133917.2414-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

TSS_entry2task_stack is used to refer to tss.sp1 which is a copy of
thread.sp0.

When TSS_entry2task_stack is used in SWITCH_TO_KERNEL_STACK, the CR3 is
already kernel CR3 and the kernel segments are loaded.

So it directly uses percpu to get tss.sp1(thread.sp0) instead of
the complicated offset-calculation via TSS_entry2task_stack.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_32.S | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index df8c017e6161..3b4d1a63d1f0 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -465,16 +465,11 @@
 	cmpl	$SIZEOF_entry_stack, %ecx
 	jae	.Lend_\@
 
-	/* Load stack pointer into %esi and %edi */
+	/* Load stack pointer into %esi */
 	movl	%esp, %esi
-	movl	%esi, %edi
-
-	/* Move %edi to the top of the entry stack */
-	andl	$(MASK_entry_stack), %edi
-	addl	$(SIZEOF_entry_stack), %edi
 
 	/* Load top of task-stack into %edi */
-	movl	TSS_entry2task_stack(%edi), %edi
+	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %edi
 
 	/* Special case - entry from kernel mode via entry stack */
 #ifdef CONFIG_VM86
-- 
2.19.1.6.gb485710b

