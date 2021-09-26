Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005CF4189C9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhIZPNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhIZPNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:13:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B101C06176E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so10024967pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qa8PI7kufv6K7r7Cn3mq0m02wOTWMpTeiRX4OzPgmPM=;
        b=B+Eu/BB9Z+BoUE4b56FVzQZ7xF/GJ5pN/ZvYibIjXlsEaUWMxON3kNDFKYwzLsxxio
         ymcLmONeuzbyRZYmTWqvSvIvSFBRY8vzbz5r93sVd+eLRqRVRbAGlIsFct4QabBnheuw
         ZwRk0A2FrThK2sgcs7LbUqn2s3X80upp84gCeikHboSOMzqXfeaCPvQ62e3n2VomhSYL
         kreamIycz9wF4mifwM2p8J/UXppsLe2lD66Kuc9y42DrrOsSMRoWx4cQGucYxVe715wE
         /yvNn+QcWd4TnV3LUZ47JBBskg6c9WFvJq25FLvK5zJVD4T65+LQ41nsxmDw+sGawVeC
         eT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qa8PI7kufv6K7r7Cn3mq0m02wOTWMpTeiRX4OzPgmPM=;
        b=wRnaXY0vX86zpjliNNysLK7IIyzLGfdtZsozOal+uu6BiWrBeonTPSVXf68qdwBgyI
         x9ZHHaRcM7GjJJ28EMJNr0nWnp/SCGFEFvp4k1DTbyyeSAo9tfGHcSL/RM10UJy9q9qI
         AkMxzjzz7Oi3hQ03Zdl8Cw/qhSFhA6P8ELhth5Rf6uDcDJhwR2QKy4AVD5amWBiDDbwI
         94t2tteLJAm7f5JfH84/eOmMszdPMnzHkKHY1laAhNPuhFJkfEnis189sTQJV89JiwGU
         /5tJLjLYq6fzjYtgQLtodkfkDRn57O5V7a9+/Hcs3thNNkLd/eie9HfudnadTNrZ5G85
         Qu8A==
X-Gm-Message-State: AOAM530uWyyMsD0wNCFCUGkirpY3/I+PgB7DuUtnvIunDTbgtHU09qtg
        ROTVpZGFNyHNPSRi8elo58HiYO2xedpsTA==
X-Google-Smtp-Source: ABdhPJw2725/rN+eDLFSwvWandK9w5xSCibzI0V/zWQfzYSPIz5GwFX2zoFfGhltNOnO71PPAUdozA==
X-Received: by 2002:a17:90a:e386:: with SMTP id b6mr13733045pjz.97.1632669085380;
        Sun, 26 Sep 2021 08:11:25 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id c23sm15541231pgb.74.2021.09.26.08.11.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:11:25 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Travis <mike.travis@hpe.com>
Subject: [PATCH V2 25/41] x86/entry: Implement the C version ist_paranoid_exit()
Date:   Sun, 26 Sep 2021 23:08:22 +0800
Message-Id: <20210926150838.197719-26-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It implements the whole ASM version paranoid_exit().

No functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c        | 40 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/idtentry.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 67f13aebd948..017a7f94e3a4 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -312,3 +312,43 @@ void ist_paranoid_entry(unsigned long *cr3, unsigned long *gsbase)
 	/* Handle GSBASE, store the return value in *@gsbase for exit. */
 	*gsbase = ist_switch_to_kernel_gsbase();
 }
+
+/*
+ * "Paranoid" exit path from exception stack.  This is invoked
+ * only on return from IST interrupts that came from kernel space.
+ *
+ * We may be returning to very strange contexts (e.g. very early
+ * in syscall entry), so checking for preemption here would
+ * be complicated.  Fortunately, there's no good reason to try
+ * to handle preemption here.
+ */
+__visible __entry_text
+void ist_paranoid_exit(unsigned long cr3, unsigned long gsbase)
+{
+	/*
+	 * Restore CR3 at first, it can use kernel GSBASE.
+	 */
+	ist_restore_cr3(cr3);
+
+	barrier();
+
+	/*
+	 * Handle the three GSBASE cases.
+	 *
+	 * @gsbase contains the GSBASE related information depending
+	 * on the availability of the FSGSBASE instructions:
+	 *
+	 * FSGSBASE	@gsbase
+	 *     N        0 -> SWAPGS on exit
+	 *              1 -> no SWAPGS on exit
+	 *
+	 *     Y        User space GSBASE, must be restored unconditionally
+	 */
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		wrgsbase(gsbase);
+		return;
+	}
+
+	if (gsbase)
+		native_swapgs();
+}
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index fa8d73cfd8d6..b144ea05b859 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -295,6 +295,8 @@ static __always_inline void __##func(struct pt_regs *regs)
 #ifdef CONFIG_X86_64
 __visible __entry_text
 void ist_paranoid_entry(unsigned long *cr3, unsigned long *gsbase);
+__visible __entry_text
+void ist_paranoid_exit(unsigned long cr3, unsigned long gsbase);
 
 /**
  * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
-- 
2.19.1.6.gb485710b

