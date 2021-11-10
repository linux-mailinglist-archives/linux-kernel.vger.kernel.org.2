Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48D644C0A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhKJMFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhKJMEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:04:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1331C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:02 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so1455660pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4xTx9uXh+TQYumyL6QT72i8i7PX2Kdt0mjHDXtVPEA=;
        b=HPJkl8HZlDnv20xyJ9NJJSZU+cF+0eftu8W+yw+E7oHwDN36ZEOYsJ8cb1hGXd7aRd
         84ZG4IKUApnnxBTT6MUXJSTvM6pS+6dVkC3iuolwKv9yEpVJ7n70H1xAiUp79bxCyKtB
         NJFeUfeDYsqAi5+Ln4zUN78kQfkmy+y0ybTV8u6Xz7S9DbaMfXc+GpuSPzIg/wch299L
         JxTsCfHHuc/iaA5pxI6beTKdJO9i2+uTcMKPwvcvo/04vg5tx0ON2EV57KCZ9MQfCIn3
         R2lhKbGvwbk1ineuaNrhQrmNC79rZrFAPkucDxoeYiz9d12puU6dyHAwDeRTU6uQhXT8
         h7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4xTx9uXh+TQYumyL6QT72i8i7PX2Kdt0mjHDXtVPEA=;
        b=eSj8hETxjmfczIKA3frM09/AQHLOIzmDOvU/jLrgsHD8a321SLf5wj08gDxg4eRB8t
         RPIS3wDM1JpBRIeD/silcafF2aR55OtItzW8VAqgnTJhNFTvU0qKFYQZWydrsO+Ol4vJ
         6vgVKlab05jTTpfA+514olfjtzI/bsZAA/a9g2eRonTkSEXr2A7apbP3vBxCibygsNO1
         kZSi0VcsGSfHrljSPA11WaReX71yQXcxelpGGptwNBsbhPQjPqo9Fxh5pD5CsLzgczBd
         evuMW1+XDkhhCQIkn5t20HRotqjr9FvdVnFiUH9TzzYsi78r/PWUcQlqXZFKc3TlB4JQ
         hAKQ==
X-Gm-Message-State: AOAM532pofbQ+Nyg4EprBo1Hc6M3GiRjGyqj+xhL5fXd3blyb72kzxvU
        o7Gu7HO22slUpaiWrSjtbnk6mJSX4+k=
X-Google-Smtp-Source: ABdhPJyqF996yd/yop9/BRSegVK0t3MhQUxXFcdm7S90xOb0/ZBfJhaODAaRwE5WMCbNFU2ttO0QpA==
X-Received: by 2002:a17:90a:2fc7:: with SMTP id n7mr16072915pjm.141.1636545721896;
        Wed, 10 Nov 2021 04:02:01 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id l1sm18104706pgt.39.2021.11.10.04.02.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:02:01 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V5 43/50] x86/entry: Add a C macro to define the function body for IST in .entry.text with an error code
Date:   Wed, 10 Nov 2021 19:57:29 +0800
Message-Id: <20211110115736.3776-44-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Add DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE() macro to define C code to
implement the ASM code which calls paranoid_entry(), modify orig_ax,
cfunc(), paranoid_exit() in series for IST exceptions with an error code.

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/idtentry.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 57636844b0fd..c57606948433 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -351,6 +351,22 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
 	ist_paranoid_exit(cr3, gsbase);					\
 }
 
+/**
+ * DEFINE_IDTENTRY_IST_ENTRY_ERRORCODE - Emit __entry_text code for IST
+ *					 entry points with an error code
+ * @func:	Function name of the entry point
+ */
+#define DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE(func)			\
+__visible __entry_text void ist_##func(struct pt_regs *regs)		\
+{									\
+	unsigned long cr3, gsbase, error_code = regs->orig_ax;		\
+									\
+	ist_paranoid_entry(&cr3, &gsbase);				\
+	regs->orig_ax = -1;	/* no syscall to restart */		\
+	func(regs, error_code);						\
+	ist_paranoid_exit(cr3, gsbase);					\
+}
+
 /**
  * DEFINE_IDTENTRY_IST - Emit code for IST entry points
  * @func:	Function name of the entry point
-- 
2.19.1.6.gb485710b

