Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF17842D101
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhJNDhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhJNDhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:37:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505E9C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa4so3771491pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/S68dED0oqdXmV2OAUfrDjaQRBNIHwjHMwtcgk7Ews=;
        b=hIAdrn9PVmbaB4oTLLtfydA+Qde7n8R1LmGkawekmus5tQ8NaNoZhS8Kgnf4xsr7Db
         KyFWI0kutfS2f7BDukmbpaZE2Dw6qhbNw2m3g/aOeHl2PHmxGo18PdaODvTyhzV/e74+
         /l64J4gsz8QQOgkZo80Xz54bycGIW0hU0i3vkkCHcXaIRYghlC2/vvwE/p1qlzZBiYez
         j9VaJDdGk5VfIiL3yx8lHymQToSBfHJy1hez9Tgh9Yh/VwR5aX/WSr6KYOfkgm34qdh1
         EkBPcZ3BKduW5og3syeaDYBsfsQ8fh0G9oUwB48SvSPkUrBIKemvaU2RxE7MAxEeyOv8
         hiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/S68dED0oqdXmV2OAUfrDjaQRBNIHwjHMwtcgk7Ews=;
        b=TVo4g3JiG0yeUzNM9rKffRzVUDDewE7gfODYajnPs/i9B/XwJmgahHXcGUEGupmRDO
         j59jZqk1uaoz8wQx4mVr9KA9XWQd1ELg9aJPA9Moh9CRkIac7baBRENePG+L0PHfh74Q
         21Klff1P1Bx3MmmxwEbE+KjVlCPSpTGX//cAvcAXEe3d2ak+zxVx19cW4AIf9CSiZkaD
         sajHb4UmSqg7t91TZ5aRbHhFVNBn9J1suaSBtjks7AQb1cbtdzhQ1BacEJaLjkwpftpV
         cZnx8Fm7CO3lSsx/5HNV5pcgiw5OPkpEvZkke03lCxv5ndsEessPmksR7/BpStBrKz2J
         o7hg==
X-Gm-Message-State: AOAM532g3gV0Lov20EMCSSI9Af+OERKYV6E/LVla7mi0WFeIbA0PUhJa
        WgqhMuRIxh2+GxialDBAUm8sC5eQzto=
X-Google-Smtp-Source: ABdhPJwvELwl5vnSqXnrzD+1GlU9tLDpePI806ow3BwmpS39LeWCa0erz7mhLx0vXk4D2b7l5QGIyQ==
X-Received: by 2002:a17:90b:4c11:: with SMTP id na17mr3663000pjb.105.1634182508712;
        Wed, 13 Oct 2021 20:35:08 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id y17sm824287pfi.206.2021.10.13.20.35.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:35:07 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH V3 12/49] x86/traps: Move the declaration of native_irq_return_iret into proto.h
Date:   Thu, 14 Oct 2021 11:33:35 +0800
Message-Id: <20211014033414.16321-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

