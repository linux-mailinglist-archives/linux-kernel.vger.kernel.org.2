Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30614189D2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhIZPOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhIZPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:13:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8445EC061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so8165296pjw.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S4ue3NgefxDFRceMXxNMt7Ea2gMF+JFHPVHubSzYepU=;
        b=QT2pyHgfSo2S0tYFyKYqnfD2yhxqM4YXxRdfRbd89s9XkHexMj2AXNSdJbP4Qjv/00
         N1ykNGiH5vHgNHvdb4jPoo4M6mVXtFTwdB+7hdEfsB3h4wZKkSDEzdGXeB4mTqn61vsd
         6AbfqJf6JA+OQXBgdf/Apunw5mdr3amWha5FLLGOLUzCsbNLwxEtZ1uYMJ/aQbQnpkjL
         5jHhpF09vxcj04eS6Pv/5aWWb4/o+Ij0IsIqkoDovMnThXXOR7MGvFOdna2TT8q8Md3q
         HxwCsasXVQdkV+mXKEvAqnnUyLsS4y8qunsatIBc+RTVlMavPkkvPkrtfampNWZ7u4Ck
         ggAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4ue3NgefxDFRceMXxNMt7Ea2gMF+JFHPVHubSzYepU=;
        b=xvHjyAb7Z0m3qzwV+jO2iHV1CMIDYtNdnd9o2VjWJz5dDiFbt2tosPZBichjADB8W9
         iTrKAIF+Lun4VAbgfjhXd7zIDJaCKsvFTfUjdLDoQYuaOqdJeNn/Vt3PBSrRa2pj0RcP
         fBSnkF2Fx10oO7S0TO/X/zxnOIH2yD9heD9RvjMq2ksDor3P4tjj4cYqLS+FWDqOsVmu
         i1UOEen4yuwX9BneNZ2UC9zOj4H6TC4YEC1WkjLeSXWRanFTXZK+ldJGHJwxxLnGl8eA
         aslG/P/SrJptCGyHwa0GnFalBHMlhW1MbFeLN4TIBNMCYq0si3M2oTYVbKiglFO8gkVG
         OS9Q==
X-Gm-Message-State: AOAM532STVl8zw+PkJut8QX+mnA83tLMBCg0Y4PycyaMt3rBA5jEWtho
        B6rhssdGze1/6bZIC25n//DsRc/9taXTqQ==
X-Google-Smtp-Source: ABdhPJzRtxQPje1csCDHw105wFlDJpLFMwIvr6r+0b5uYsdbFojJkdlWh+za+M5cF5rVQs7azKJNlw==
X-Received: by 2002:a17:902:da89:b0:13b:7d3d:59e9 with SMTP id j9-20020a170902da8900b0013b7d3d59e9mr18226324plx.41.1632669113933;
        Sun, 26 Sep 2021 08:11:53 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id e24sm14213303pfn.8.2021.09.26.08.11.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:11:53 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Travis <mike.travis@hpe.com>
Subject: [PATCH V2 29/41] x86/idtentry.h: Move the definitions *IDTENTRY_{MCE|DEBUG}* up
Date:   Sun, 26 Sep 2021 23:08:26 +0800
Message-Id: <20210926150838.197719-30-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
index babe530cfa77..49c0ebe374ae 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -358,6 +358,14 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
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
@@ -432,16 +440,6 @@ __visible noinstr void func(struct pt_regs *regs,			\
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

