Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E99F30604C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhA0Pz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbhA0Pdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:33:43 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F218C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:33:03 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w18so1403132pfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BlAqhwi52CDU/L4m2USiDoxymFbBrES3zkm124j7yww=;
        b=FjqepHQ/sgq1FCRIabGe68voPUd4OwvwrmBvr1u8hzsckboo+31Hz0fPErZanzdsKT
         dCXHkyOa8gLmLaU5m24RCMjNmdwKP97wESsWPKjuZ5RU8cNWtNGvwzgAF50aqgcmBn0N
         aUxZSpGgyBJ51lRc8gJDiBlZEwajESfmX6HLZP5VuI5VNw7K+FaN24+bdv039n8JbcSm
         +Ck/0u1Keejy0JUGiK0uYgqS6lpoenqoxDPbdNaNLHVdFPzqGj6coFlO/oIS2ElqhuKa
         iwCm0c/oBRAM7D3o9vm5V2d5rkmI9kuxE7dyZFZmW2nrn+NPSjzH9JMp44MSprz636U0
         V9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlAqhwi52CDU/L4m2USiDoxymFbBrES3zkm124j7yww=;
        b=rBk3FrH8sxnYnG3Onv0tjPN7D2D9C8tr/PhnxBrfiE3ukZbMPAS0w7hf3xmJsr+EZK
         xzFYcQWmpjs+tAOnbrgwRRib6HiTsOqF27IgqChxAUANvfmUxgxen7hnQCir/C5LkD8X
         n0S8AHXHsLuWusM91+aVsSahcwXrpNy8GzK5d1WYiwgOSHLemkOjnZ6Tte7wiQuFYH8v
         GBC+P8C2x43aTPJnkKLr5iwWwADsv3RsfDPJnQwPABWgpsRXr5ZCMfGa2rOSJIvJRdS8
         2HdvYFZr30uQu7E0EWPzsf0cPabyqY34dvPwWN5OB5gtEmrkgASDE7mIqbeIJOR4CPq6
         /fFA==
X-Gm-Message-State: AOAM531qz+aM4DKnZFcxOXQKA813F1pAfdw04nsxPVG2CtGNPn0Iwr8h
        9StyNE3+lYsyopnghhvyfFzUPF+PdMPgK/nO
X-Google-Smtp-Source: ABdhPJy5RAw+undZ46u8lqsssixKJUW8pdLYYhCOeJTv1Q+6fSmP7FRip1zcwg4lfm/LHXwXDBr2Zw==
X-Received: by 2002:a62:36c3:0:b029:1b9:e110:e126 with SMTP id d186-20020a6236c30000b02901b9e110e126mr11110102pfa.64.1611761582420;
        Wed, 27 Jan 2021 07:33:02 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id u26sm2825374pfm.61.2021.01.27.07.33.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 07:33:01 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
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
Subject: [PATCH V3 2/6] x86_32: use percpu instead of offset-calculation to get thread.sp0 when SWITCH_TO_KERNEL_STACK
Date:   Thu, 28 Jan 2021 00:32:18 +0800
Message-Id: <20210127163231.12709-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210127163231.12709-1-jiangshanlai@gmail.com>
References: <20210127163231.12709-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

TSS_entry2task_stack is used to refer to tss.sp1 which is stored the value
of thread.sp0.

At the code where TSS_entry2task_stack is used in SWITCH_TO_KERNEL_STACK,
the CR3 is already kernel CR3 and kernel segments is loaded.

So we can directly use the percpu to get tss.sp1(thread.sp0) instead of
the complex offset-calculation.

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

