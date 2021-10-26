Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14D43B463
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbhJZOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbhJZOjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:39:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A94C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so1888995pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4xTx9uXh+TQYumyL6QT72i8i7PX2Kdt0mjHDXtVPEA=;
        b=EHl3xDR/Fb6/fJhOsAJRVI2qJpmBLVwsoJ1H9u22ysEQ/TziqM4jI9BFVXSLooTZJT
         rDqlpf0aTNOpnlO83uSbuS6yznb1D+Nl47i8d7XKv8+bHs7ykwqyOBgby8movi5OsLsy
         IbyYofaQP1tmKinx4LCaXgaQZPlKipK1flTyjT8SfsEqOIehBjU7+DPFgv/vfG/xyceA
         5Nra1Flqwb/ybq1OgPoVBXLT7ycYUZqjkvxDKQKC6xAlbqSMIjjbBMgX9a8VWayJfxYa
         sXukEiSW7IZaY02OfX11SwqW/jbK4FF4XFrfGcbRNtDe9ZQbtMJTsaP3yiTT4fpftcQL
         LyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4xTx9uXh+TQYumyL6QT72i8i7PX2Kdt0mjHDXtVPEA=;
        b=oDHqy1K7EsbUR3O9+WWqoavS3+AlyD0aE44NhbtlV2Ig3Hm91Ms3yCNFiMC44ryyXW
         bKU70fS4VywpYAWWVTBEMbpcbVZ2+vBIb/wIio/fb+UvKQYvAsh8TzvoM47jCRYS7Qni
         wJokB4VKA0itxDcm+8oNJMNU5NN+PjaBkT/5Cvv4Gg8JxXS+XgGHGvjIPZht2GY5q4AJ
         GcKhhSwDEeDnHctT53NviokUiLhl/GfpizcyeaTqVrBKXih0zlxmUo1INI8aqpYAreFH
         qXIEWvsHPj0tZGpKwuwuSGJt4EdlgHidUfsuXPc0mKQpBFm/1/ulq4yEXgIr8yl9IXqe
         50Ew==
X-Gm-Message-State: AOAM530Oi23ayJHhkGGoLWtKxDFYjilIM2w+z7x08msI39Tpe40UZhMT
        FyKmRJOCjAPta278GYqpjbaVbSrW+b4=
X-Google-Smtp-Source: ABdhPJxmD7jEJXve5eYhp7Pkms8q049aq977cEo3SmTsBsq3O0zV19bUBTHxylnq4Ax6YhT//ao2Ow==
X-Received: by 2002:a17:90b:38c1:: with SMTP id nn1mr14104131pjb.83.1635259009244;
        Tue, 26 Oct 2021 07:36:49 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id p1sm10821685pfo.143.2021.10.26.07.36.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:36:48 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V4 43/50] x86/entry: Add a C macro to define the function body for IST in .entry.text with an error code
Date:   Tue, 26 Oct 2021 22:34:29 +0800
Message-Id: <20211026143436.19071-18-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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

