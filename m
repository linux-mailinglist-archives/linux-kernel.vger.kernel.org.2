Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6570F43B40B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhJZObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbhJZOau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:30:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4D1C061224
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v16so5073960ple.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hqSVKtYY8joyJkymwaNj/fS3ZI1plxGHSEK/zWKpCXw=;
        b=feIJMHBDi8/IDYwu14a7GD3UQHnRH3fll7oK4OvB3eXnncrFwmlsi44f2W9uWGCUnw
         qsFXl199k//V/IlwzCeFZty6jIRFiKuJ8sJAZaBbMLXPZ8+858/REkATkQGKjerwu9ci
         E0voktqaC8gdGLy6psdo/6FSQT1eXc+3NVjevgYbnWWsKP/mslnR+nqJvz/zas/2eyVl
         iC+oQGQHsB0wgMNGOstY5ElYDKwh96QECA+rz5WobhWo2Z0J0nwioMTxIMs3o+5vm8ep
         wlhKPpMPRw9t3B0HTyavhCZOzdWZd4ACedAuW9tOPmMV8MKTARBEyXTXC6ZZMf7cNmBK
         typQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqSVKtYY8joyJkymwaNj/fS3ZI1plxGHSEK/zWKpCXw=;
        b=j0SwEByxdj1FUblDdfVAvMgGa0HWJm5Qz5QpLG/sMMtuuQl3asCmiCVDWQBs/7QAKU
         Vd4DjK5nSoHSm/aZnN6VHY2Zuk2QQ9JxGTJOZroDbnp7oC5JInEWVzKIz6bW5nzb/FEw
         ldEIcYWvrUwM5YFFbbRvC+RYQlHPhnmo0/trHhYKKe+NnXbW+IC+bR+dkc+GkASNfDqW
         Ws0X/8g31RQ3fYIZYfQ8V+eqJM7Ca2zhL+BrMUJi4bOoaRXBVaCi9piWDhcR/N3XqcKK
         /cd0suav+XTgTHs6uW6oAYq6CEnJNKqwEEiL9VrA7KKa614V9H2RtZk/3Tf7a8n21X39
         I37w==
X-Gm-Message-State: AOAM5327XC7Ub5T17Egpflry9MPtQI8siXdSLoL7lstTaZ3OL3RzbxMj
        d3QqI1gC/g1Tnzugd3ibaU3aS75F7pk=
X-Google-Smtp-Source: ABdhPJwznEiLGCSl3YUNr42VEXylwieu3H6cxhDFaQP3QBRb7ypYnMZGkfavFvdkoI/uSfKoATwcXg==
X-Received: by 2002:a17:90b:2317:: with SMTP id mt23mr1604106pjb.53.1635258505932;
        Tue, 26 Oct 2021 07:28:25 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id w185sm22687481pfb.38.2021.10.26.07.28.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:28:25 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH V4 12/50] x86/traps: Move the declaration of native_irq_return_iret into proto.h
Date:   Tue, 26 Oct 2021 22:27:44 +0800
Message-Id: <20211026142824.18362-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The declaration of native_irq_return_iret is used in exc_double_fault()
only by now.  But it will be used in other place later, so the declaration
is moved to a header file for preparation.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/proto.h | 1 +
 arch/x86/kernel/traps.c      | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 8c5d1910a848..ee07b3cae213 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -13,6 +13,7 @@ void syscall_init(void);
 #ifdef CONFIG_X86_64
 void entry_SYSCALL_64(void);
 void entry_SYSCALL_64_safe_stack(void);
+extern unsigned char native_irq_return_iret[];
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 #endif
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 43e38aa302d5..95ac6a9e5ebc 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -359,8 +359,6 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 #endif
 
 #ifdef CONFIG_X86_ESPFIX64
-	extern unsigned char native_irq_return_iret[];
-
 	/*
 	 * If IRET takes a non-IST fault on the espfix64 stack, then we
 	 * end up promoting it to a doublefault.  In that case, take
-- 
2.19.1.6.gb485710b

