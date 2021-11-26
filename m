Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C579845EB53
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376957AbhKZK10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbhKZKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:25:19 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92E9C0613E0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v23so6870064pjr.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UIAQf/v+Gm6IDzvx6v/1Jo9jQlIxe2wA7oheP/2fom0=;
        b=jV6d0cFiyHaebqkW+nRU+5vMj0xX29B0ZGOK+e3kd7pTCUWG9zu/Fu8oZu6rDpSoIE
         oPQZYG7umFEeF1Sr1O9DM2zfrIOopQtrxgwSx+/BEyfKjotuTZei2J6erFbPiLEBPfMi
         q7+ugy8SvislGSfj8+GKruw9eXl9qOwm/bOpMw2+KNnYxepsZV8xsG9b6ZRhB3Dyq0Yj
         pxDTFWirO8UdOrSx5xdz0bBH9qU+JH1RWqybTlkxL2VajJECEFSwM2+/hMTxUUdtXyrB
         hfAKHg1Gkh2Qg93Tj503QGy/2b3p2FhySi4Zj2JXe7jWxc0TlVCvxU1HwcJQMlPD7ZuL
         u8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UIAQf/v+Gm6IDzvx6v/1Jo9jQlIxe2wA7oheP/2fom0=;
        b=7JU2CKF387jl2GF5Uyin3Jd8qwo5lvD1UfoYF5Wvyowkx6V1N53/DBd60uSpFZRjRY
         nnmwRYNfHAg/vI1eqBzJS/ntW3X1hOGz9CtNS+nVkcO8M+lKPU3kwSlrt3vtbsEbIddL
         Vt7eRekmA6ay8w5/n6jGNCnp8eVolzZuiZiDVlLOuhWSWuHzHhZkpmvQ8ILxAxuhip8W
         GaSn5T5SPg/OZhlwK13DRmBGPDlibvf85qNWtdqTgm5d99V22UkNcrYIGa/aCDuBXfpD
         9y1G0l3lSDy7028gFAvgqsL++vSDZFmaPTOmm1HAPcJ0Ql/srQIynQl5tU1fdHD6ftjt
         kg+g==
X-Gm-Message-State: AOAM530atCIa3rawVOnCQ5UBwVvWga0KO0ySMr7GL/lRM9cSx2LBajnu
        aIA2tgIEiEL7vea3EcpvU0PHbjul7sY=
X-Google-Smtp-Source: ABdhPJwbsGCt/tJgBZkdlhz7vgKMGX508tCT0Bl834cYV+lnvbGW3Hbd1jTdDEt8biQ+26Q0t1t/OQ==
X-Received: by 2002:a17:902:904b:b0:143:73ff:eb7d with SMTP id w11-20020a170902904b00b0014373ffeb7dmr36170293plz.85.1637921589319;
        Fri, 26 Nov 2021 02:13:09 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id d20sm6733199pfl.88.2021.11.26.02.13.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:13:08 -0800 (PST)
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
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH V6 11/49] x86/traps: Move the declaration of native_irq_return_iret into proto.h
Date:   Fri, 26 Nov 2021 18:11:31 +0800
Message-Id: <20211126101209.8613-12-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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

