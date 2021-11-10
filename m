Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A56B44C071
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhKJMBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbhKJMBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:01:34 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA91AC0613F5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:47 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so1653476pjl.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UIAQf/v+Gm6IDzvx6v/1Jo9jQlIxe2wA7oheP/2fom0=;
        b=LcHz73I6qzzd6pLZOauE4hAcnR2BdsyRSRHJVq5VHAf20VHb31auVuvRQca0b3DncD
         ue5DIH86q2cnoo+mOPVBbe7sl5mb/XlbmYY7jn7amk571UwvuSXYJDXANXK5vZo+7A7h
         bnpTLIkOiAZ2WqY3R2gh5FkIeNRDvg+i0mqWtjfnTVVdcwmBrF3uSG4OirmHe0lALdIo
         kqlNv3/i5SiNhvcAeFDKImZsYn11j+5nzvlBTvf8L15CGY2CK0uY3uq0b5bivhRpOdct
         D3A97jMPbSUhv9AcTPKuXEyX3Z6EpErXeNILxDSTCRTdUeVf0G82D+GA0RO7Sbd2dXuh
         9OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UIAQf/v+Gm6IDzvx6v/1Jo9jQlIxe2wA7oheP/2fom0=;
        b=SX6AkfDnkIan3ThjA4gMk50ympt1Qf58HnteKsun/brs8QskplLNmoC9Kr7rVQnbad
         E1vGO0m5HhrUOhAQrlLAxPFD5e5Vb5zkBMb+JY4jUotGPkcOPaqvnOjFp9Va/VONhhKb
         fhRc2gZkJbSyBbQtsrIBXXw0qtPJ0RObpai03WfuTO5pI740NCuAEoc/UcLwXtk3Q+h8
         vU5xew2pL2x5tw7o2GiGCcw8i4HLEpDzGNj9KLxCekA5sEt9by1BZSA+hVxhbMmDBEdd
         ZvTUkZnPdIPaqnMTK6vB1um7fC/5Op03bxDCylkOKOt1L8D5OkHzeH8WEXupzKmI0OnA
         dkiA==
X-Gm-Message-State: AOAM531NWUYeH0SLGvyKi5cQGJUMsFcF2Z4v6luBA6tqEYzcnmtxfCWg
        ud0LDVptUeZ5MkDvR+6SrW5A9CIVjOc=
X-Google-Smtp-Source: ABdhPJymR23pHi5pAdWI/3qLAUZSFfYb/+fk84+GNNGdcgV6J/ddiIcEm8K73YfKuA2rOy2nhVA+lw==
X-Received: by 2002:a17:902:934c:b0:13d:c685:229b with SMTP id g12-20020a170902934c00b0013dc685229bmr14895935plp.25.1636545527065;
        Wed, 10 Nov 2021 03:58:47 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id u22sm15529356pfi.187.2021.11.10.03.58.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:58:46 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH V5 12/50] x86/traps: Move the declaration of native_irq_return_iret into proto.h
Date:   Wed, 10 Nov 2021 19:56:58 +0800
Message-Id: <20211110115736.3776-13-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index feed36d44d04..33ae276c8b34 100644
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
index c9d566dcf89a..1be5c1edad6b 100644
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

