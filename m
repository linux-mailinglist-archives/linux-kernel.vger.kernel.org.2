Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E625F4189BA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhIZPLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhIZPLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:11:04 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D856BC061604
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s16so13479036pfk.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/S68dED0oqdXmV2OAUfrDjaQRBNIHwjHMwtcgk7Ews=;
        b=lpRoO1nvGHZXCD97kcwlthOy1FD3D8T4XqXzwtvu9J+n5r+TuRcnob9JzjqvMlIxNX
         w3o9yhpCwiYBBFvLIHQOJId2PJqeJEhCvs6yMEE4gWhsBu8gNeJLc9sd+xxp1Ugv55qI
         9jWv/QDwahtNoU47l4YMev+sq1dsgIltJmRmU9IKRDRvSPOWoHxULm7mkPMAQovRrqf0
         osV7c2FCgCwjPGcQ+DCb+Xe2Lx0eRlL5UqicsuGfWwF35cZ9Ts8VTM7PKqxQenFDRC+V
         I68fm0gZUE1jQJSeJzeAV+knve1cfuG5eBvxrt/i+2FrvdMPiaoAOFlgQCPmRFsalkx8
         2jCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/S68dED0oqdXmV2OAUfrDjaQRBNIHwjHMwtcgk7Ews=;
        b=m73adhi8pEc/XZPV1SK3sMvJoNcF8Cw+2xomyCgRDNXJOGzauAPxCEqT3d7mSbwPWi
         vl68+LoBmpLT+WYq/Z4koZ42cDVzrUahJ26/0TdCTfBitd6+HU4FDFwm7id/ib9q0buF
         0rdflbzTTx/Aivp0dkWRihvIJeKIFlBCNash3OYNqp6+B9hjUCLIe/d6jsKknDa5kMyc
         Xipa6ZL3p2/l5z+PtR7eFmaXhnH4W9aavc16pQLy+LqYL9e+E9eRdZ3ouYpnGj5mSHPp
         dh5lquyARkkOINes/5Radaxi+JpVFeLFXSkoqGTUJoPPC8c2WnhxX8LXu1OZvQhZ2Pb9
         r0Ug==
X-Gm-Message-State: AOAM5331+ulqh1dYrdVtao7CGOYSPoOuvaP9lIKvQDDbiUnv1G8uSCf7
        qfVo0xHkV3C90tv3oyDAKDgPFKy8OOgs8A==
X-Google-Smtp-Source: ABdhPJz512/fI8gneVJTqHWpIrymbvXA1Km+P8mW1pX3VEIKpZTKWPnuVLqByfRYB7bOmdJ5qNHJVA==
X-Received: by 2002:a63:215c:: with SMTP id s28mr12600515pgm.99.1632668967280;
        Sun, 26 Sep 2021 08:09:27 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id n12sm6566420pff.166.2021.09.26.08.09.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:09:26 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH V2 07/41] x86/traps: Move the declaration of native_irq_return_iret into proto.h
Date:   Sun, 26 Sep 2021 23:08:04 +0800
Message-Id: <20210926150838.197719-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
index cc6de3a01293..cf852b5e347f 100644
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

