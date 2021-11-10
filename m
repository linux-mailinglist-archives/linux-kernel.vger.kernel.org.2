Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2713D44C0A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbhKJMEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhKJME1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:04:27 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F2C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c4so2480347pfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSMOaLCNtk/o+WFzKTv0c1sQNsc4OBhAou3DAsLaqHI=;
        b=QH+TNYu/B6ZwOmohwTLVvm3H/+0mNG7bwoQxccgJn4jMJ1UOpZwvMpXyMAhnfrBPgz
         YLIvHGZwsi75p6zA9W1LnWvIOPZ2pgtmjQU94QbQF+9zRiwgZ8icTK4ZWGTZlq8tM3Kf
         ZvdCDXy6Rzy/7rGwMq2/OdevX31o7lcqpxHYygtStBvn9s38g6FQgK0eU+ckcmDWrnGY
         A8vVu3oI9udgqBLpS4Sibprv4DfAd5/3EYX/+9zIfzB/rAizRFMfal97zc3kp9EwAnK/
         UaZrZyAsyLyuVd4EZAYNiY/eqvqLYgeXzA9dgy6gxd/h+RlAtyxftqL/eTy3FLfNFOHX
         ZZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSMOaLCNtk/o+WFzKTv0c1sQNsc4OBhAou3DAsLaqHI=;
        b=i9yRffjWb7wH5CJ/frt52ndRDhZwHPDSvMf5SS9u+Rxbav3TU3jXhukZDjPBaQzAbk
         LfiWpHyxxauPAC3oZLKpCn7mPntlcpdx8FR9+FHmvWyMBSpE4TeeA95E2lnqlj+Ij71Y
         z0huGJ0IROYGCo3RukwFysB4uvohhUh0BBcdZBs2gJ3JKdUmvZ2fn2jxsVvU11WXvs9J
         iKdfTRilJze4kW7HVdWofOX04D4qD3T7yShyN91FZvhEHSjQT5QnTZqZXJ5t6HNMxTrJ
         Y0IbpY87MzuZm9YHZcRV6GeFRgD54lZDbz7wcYkyFrrFNlzuibhVtu1yqReUbBDVCLcl
         ijmw==
X-Gm-Message-State: AOAM53081WIMGvDqwXC4qYCiIzB4YI64ixO8HFTSXP8D4pvDE8YizQU9
        kWil89NE9iXlFo5N8gQR3Xxr+5qunYQ=
X-Google-Smtp-Source: ABdhPJwBJ7y4iBuOmCmefHrtQpKI1feh6SxaQYeP3a2JW3OIjpaP89nUJzc/pFOFKtvlJUzHt10/vg==
X-Received: by 2002:a05:6a00:2ab:b0:49f:997e:23e2 with SMTP id q11-20020a056a0002ab00b0049f997e23e2mr15976817pfs.22.1636545699736;
        Wed, 10 Nov 2021 04:01:39 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id f19sm2913817pfc.122.2021.11.10.04.01.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:01:39 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V5 40/50] x86/idtentry.h: Move the definitions *IDTENTRY_{MCE|DEBUG}* up
Date:   Wed, 10 Nov 2021 19:57:26 +0800
Message-Id: <20211110115736.3776-41-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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

