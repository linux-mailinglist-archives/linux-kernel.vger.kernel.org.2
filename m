Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E5F43B45B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbhJZOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbhJZOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:38:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B67DC061225
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id v16so5090508ple.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSMOaLCNtk/o+WFzKTv0c1sQNsc4OBhAou3DAsLaqHI=;
        b=aprZsu8WAh22t3Ncf40YmcqnfCVeSPu7hHeB6mcG3V4EDmFRA4c5tjUp4U8W1Dhu2Q
         mBRLb0sLC/DsG0at6pe/HOZx4qpUHKdAZMacX9dXdLcmWfLOkX0yLiyiT/mSO63fJNNT
         EXn2FxfXPKKJWHBhEcAjfABAujYmxQb2nn6Q0T6Hll4aSmDr27ztlMC9vngVlr/pREqo
         mUhwY8O2pFWcxK7l2nyLEwLEicKnQyzEOyGbKQ8oYtmQAKxgOg4gG+9oOcmLNIZY0hAQ
         csFtwLp6N/WmwSCTlDbDn4BLQ1PVxbPNjHi716KzFVn+0zyFuODpeKBXJ3FlZiKs09kg
         xwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSMOaLCNtk/o+WFzKTv0c1sQNsc4OBhAou3DAsLaqHI=;
        b=UTBsRdqi9l47FdMBs744qTuLl6SqKhLrVxgMHh1pttAV9+YX7fuiMs4GkMq4dPtQZx
         aronJAkelF7yps5yXjPv9Yv5Fpbb4HcGs5/PEOmb33B7u2jKE76mkQEbCOc/a9EFnEWv
         BfZaM8eQoq4DPfPZKT5/qSFMOk6gt5o1PS0brfMlF1CuQ9CPPa7B/gzGv7IWYA1+5oel
         +JYw1m2vSHdAaRZOEDIcvfFP6nXDSJBCIm80PwzQugUgRDQEqmvd55KV957on+NGh2jW
         kfhhzc6yjZ/OTumJ3qOF1pFa/QgN5AosmAsThSObdgpAoSEs7oebvFLQpY6nUERhEfHe
         rpGQ==
X-Gm-Message-State: AOAM533idIWmk4wIDi05cCV7STv2PddlkdTx71tGrCEnpTecK/Tdt8Uk
        BfVJpt91cAP+L0n5RXPLwUPzpTK5rIg=
X-Google-Smtp-Source: ABdhPJy3qJF7CN4jhNVFA4vE3iUCVcZGuh/w3GyPsqFc6evvqQp65Aq88dl3eSgMHR/yNVgxpLhx7A==
X-Received: by 2002:a17:90a:6b4d:: with SMTP id x13mr43780473pjl.208.1635258987523;
        Tue, 26 Oct 2021 07:36:27 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id d71sm19152590pga.67.2021.10.26.07.36.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:36:27 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V4 40/50] x86/idtentry.h: Move the definitions *IDTENTRY_{MCE|DEBUG}* up
Date:   Tue, 26 Oct 2021 22:34:26 +0800
Message-Id: <20211026143436.19071-15-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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

