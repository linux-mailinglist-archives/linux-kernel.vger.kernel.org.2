Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EED42D144
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhJNDxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhJNDw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:52:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9207BC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:50:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id g5so3242835plg.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSMOaLCNtk/o+WFzKTv0c1sQNsc4OBhAou3DAsLaqHI=;
        b=BJvnJLlsqNVf4Vmd/4samWFpp+CC1m2x9FUsilnsidX1mYFELKJ1cVa0OU9CsZvlIg
         Zsf5L62YXMQ1MZrol1EjHkz8/hGhWYRPL3az7P7HmPQ/L6bHz76cIu1DfKg29NwGeE4I
         RCv2i5JJG4BrXoCoV9kxd5X1oeQiyMZoypJsegKQWKv+1KYAhea8UUxmjrmLDHBDX2DH
         m776HJ2WsYWYHUbhr4wkECNmEi6WOvDTFZ5mUR8OqWU8X1YJl2FXFPLgBdchHHd95i7j
         mbHBwc+ZRCIcSIBfBAVRh0kvHkK+KZqFmlnN2o4M2SBF55YzZl/fybmp8FxK67KIe/yA
         Vv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSMOaLCNtk/o+WFzKTv0c1sQNsc4OBhAou3DAsLaqHI=;
        b=frMr3ttv0HvFSYNlLAsJmU5GtZwscw+/faTsWFyp7Ov34yAdJO+IKJpNYsrJRVBSGT
         evw8pMkJk5SCvDlrUiuIl7v63Bf3bJsw/1rI6Z3sH2o+1c7R5IMT61OlqtEdRoAPjCrc
         BNKgx0unljyTAiJ6HbLL5+RRzRzyldWQDFruBOKKJo7uCoIVpy0Ie1Rt13erDh57CVGq
         6bfIlhFYitligYQvZUgBAsIcmdNTlCAJCym5cB/NkrV6YFN7MSaFhkrQrlabbxiiJG2Z
         9qEBaMEVZYErWpz6kEusu6CSYcO83Z/HdMkPykSaPsqPesN1SqkUSSTw34olg1kaG3fX
         3rKA==
X-Gm-Message-State: AOAM5322EWHfCw+UWkH0pxPwuv35g/K1EIHbfPOnAomxebL7VgjMjL8Y
        1B1L43om135ZDZ3/juAFv024E+Jc44A=
X-Google-Smtp-Source: ABdhPJx/t45wtEzVqKzsO64gj3zrOpLDLnSMc26w/TfclBH4+xRSEuXYw8NGbEHHF0+0c2014UBopw==
X-Received: by 2002:a17:90a:de16:: with SMTP id m22mr17931740pjv.38.1634183454988;
        Wed, 13 Oct 2021 20:50:54 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id a27sm883983pfl.20.2021.10.13.20.50.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:50:54 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V3 39/49] x86/idtentry.h: Move the definitions *IDTENTRY_{MCE|DEBUG}* up
Date:   Thu, 14 Oct 2021 11:50:16 +0800
Message-Id: <20211014035027.17681-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Move them closer to the related definitions and reduce a #ifdef entry.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/idtentry.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index d0fd32288442..b9a6750dbba2 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -372,6 +372,14 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
 #define DEFINE_IDTENTRY_NOIST(func)					\
 	DEFINE_IDTENTRY_RAW(noist_##func)
 
+#define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_MCE_USER	DEFINE_IDTENTRY_NOIST
+
+#define DECLARE_IDTENTRY_DEBUG		DECLARE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
+#define DEFINE_IDTENTRY_DEBUG_USER	DEFINE_IDTENTRY_NOIST
+
 /**
  * DECLARE_IDTENTRY_DF - Declare functions for double fault
  * @vector:	Vector number (ignored for C)
@@ -446,16 +454,6 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_RAW
 #define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
 
-#ifdef CONFIG_X86_64
-#define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
-#define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
-#define DEFINE_IDTENTRY_MCE_USER	DEFINE_IDTENTRY_NOIST
-
-#define DECLARE_IDTENTRY_DEBUG		DECLARE_IDTENTRY_IST
-#define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
-#define DEFINE_IDTENTRY_DEBUG_USER	DEFINE_IDTENTRY_NOIST
-#endif
-
 #else /* !__ASSEMBLY__ */
 
 /*
-- 
2.19.1.6.gb485710b

