Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214BA45EB76
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376966AbhKZK33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhKZK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:27:19 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774E3C0613BE
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id np3so6884180pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/VEIBCWf8eZkwgfgrE3MrvMN5GhRK8VB75123ohWZZA=;
        b=eElYR9FIoYC4k7nepDMnlD8KXYhooin2jIeIq+LecZPvsQOs4HQOwBSBOMXUlF+Wu7
         Kkpq143HxO947bHo+F4dx96+1S6pqtFmpOHEMsmINOzbOxikP1avlMj9ExOyxxB8tPmP
         2zkfvgai4ruJ5Iy/uuH6y9SW1b7aCcBEpQTEEERuYZyFVjKUdj+5ZzrW6wR6hcVCwWms
         Yj91eYLqlt/x1T7gly0sdhPVO/4W41sM21LKqfifgtFdGYeN0k867OkiPPz50jEp1Apq
         jbe7A73mB/pURnyPInDC9ARh28sPPb/Pd2t9jhqcJpOBzium+UUIO19pFYHQzqWTYVst
         hYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VEIBCWf8eZkwgfgrE3MrvMN5GhRK8VB75123ohWZZA=;
        b=Lv7qjK0EbrooB+PErSXFCLSRQAZzl/8Yo2Fz7GM/plq+RZKQkx8HXPCNzYjpO1QOyW
         nUrLZC77J8aXnaub0Lnh11islgcUVsQDx54wFlKo/7HarJrkrNankgRpNMlqeYm5AfLU
         A8eT9wgkyGnZPyjnEZp5FcYp1n+hvEvn78Cp14925QBbdi13ELfO/lI9WSrqSDZ0D6o3
         Ao+KYU1jvG5WAWLvxf7/+T8wyXu8SxmgDOSJJCMxaMcLGl5HoHqCSm7mPXtZ+zUWtbPI
         UAquUpMu2RFvTYEn1f6u3p+7szlC/L5AEyvmDXD0tSrJmXdL38lM4+g5VE4OG0HVaD/L
         asDw==
X-Gm-Message-State: AOAM532HfgfgEdDkEWvZIm1bwltBcgj/6cfe/uq7fDM3tjbouQReLwZf
        ixdscTp81PSwYQ64skqveT6UTkWqSwU=
X-Google-Smtp-Source: ABdhPJzbAyEzMjjiPfFSFzcyozJ/57ipjdYGNm6nbhzBxAD6Rhrz+WZmu6KYoaxUnjlYAKpLE2KhdQ==
X-Received: by 2002:a17:90b:3ec6:: with SMTP id rm6mr14385832pjb.94.1637921709922;
        Fri, 26 Nov 2021 02:15:09 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id m184sm4542744pga.61.2021.11.26.02.15.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:15:09 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 31/49] x86/entry: Skip CR3 write when the saved CR3 is kernel CR3 in RESTORE_CR3
Date:   Fri, 26 Nov 2021 18:11:51 +0800
Message-Id: <20211126101209.8613-32-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When the original CR3 is kernel CR3, paranoid_entry() hasn't changed
the CR3, so the CR3 doesn't need to restored when paranoid_exit() in
the this case.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 996b041e92d2..9065c31d2875 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -231,14 +231,11 @@ For 32-bit we have the following conventions - kernel is built with
 .macro RESTORE_CR3 scratch_reg:req save_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
 
-	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
-
-	/*
-	 * KERNEL pages can always resume with NOFLUSH as we do
-	 * explicit flushes.
-	 */
+	/* No need to restore when the saved CR3 is kernel CR3. */
 	bt	$PTI_USER_PGTABLE_BIT, \save_reg
-	jnc	.Lnoflush_\@
+	jnc	.Lend_\@
+
+	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
 
 	/*
 	 * Check if there's a pending flush for the user ASID we're
@@ -256,10 +253,6 @@ For 32-bit we have the following conventions - kernel is built with
 	SET_NOFLUSH_BIT \save_reg
 
 .Lwrcr3_\@:
-	/*
-	 * The CR3 write could be avoided when not changing its value,
-	 * but would require a CR3 read *and* a scratch register.
-	 */
 	movq	\save_reg, %cr3
 .Lend_\@:
 .endm
-- 
2.19.1.6.gb485710b

