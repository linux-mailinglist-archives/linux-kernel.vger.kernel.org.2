Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E42B45EB80
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376754AbhKZK36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376933AbhKZK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:27:23 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105C9C061374
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:48 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y8so6394485plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MTylYqTpUPKdvJU9nhot1nsKbpNBCgMpvWseEkFbNEc=;
        b=q7Oy2zGOoyyqW+KEKndZw2bmr9VRIealpkNLDOMdEr5COAtp9SwvFhtpYvx4t/GtLM
         iwo7tUAtZU6Nm7C5fHz6ljBHacrUhuo5upmSF4LvauJ/a9JOF1E1zKPUTZqWlzv/CGeO
         f+bBfUwrYUNIuRQN+EzdcUH3lrZB7hQkX/192szwHP8/JIsf9qtDh56bNgcVG2nGYPXj
         74py7bT98oatxtAcinwLKlZpWcIB7cajY639OYX0DrptuNnMuIG8pdqgGqQ4Qgf3kzqt
         5JDCdptUXMJZijQdzY1qwKqdB52Db5/e7QXVUvyT8LH45lEBOB48SInfLHsjRpMHDsZY
         AAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MTylYqTpUPKdvJU9nhot1nsKbpNBCgMpvWseEkFbNEc=;
        b=HFNudDowrWYmo2GljS2Kb3Tw2irMtB7z+6I1S2n+cvdDmn5gMxSZba/qnd695ZTOgr
         eUI8f/UcWoHUlfzAphCDU+EWs4yxCvOLUdLCj5fpDftREOfGxrvJLVNa5Ww1fgiuBD2o
         JWPA5EIDxMn9sIdkIGTjWhMDpo3lTzsBUPmMYLEiBzMuE8yuU6bjyXeFH/nWA4CTqr9E
         gEzcqvQllfqVZlcwyUD+tLBl2aLOArrxKkLPhiEmugE7ux0HlKdCKa6vco8g0CEaHLij
         FBnIqBV4umtZXfFGnK0cVTC/MT+qsOTnfyc1YeF/7hjX+WfI3ufBsNQhaKoYyNfeU375
         brEg==
X-Gm-Message-State: AOAM531y6jeh6szPFhK8dUyt+XAh71i7zcHhdxYG/puq7MZtk/2qQLr1
        voKMnp/+lQJmUkkquwhi7Raf0rUS/us=
X-Google-Smtp-Source: ABdhPJzSB/FrYTOF97bSQaJ3hXvXjpjqCM7Xjq35GmHyUdGM4Yd7qnjtR6cdwpyqd82ipceMLMvG/A==
X-Received: by 2002:a17:90b:3e85:: with SMTP id rj5mr14634403pjb.172.1637921747481;
        Fri, 26 Nov 2021 02:15:47 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id b4sm6648381pfl.60.2021.11.26.02.15.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:15:47 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V6 37/49] x86/entry: Add a C macro to define the function body for IST in .entry.text
Date:   Fri, 26 Nov 2021 18:11:57 +0800
Message-Id: <20211126101209.8613-38-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Add DEFINE_IDTENTRY_IST_ENTRY() macro to define C code to implement
the ASM code which calls paranoid_entry(), cfunc(), paranoid_exit()
in series for IST exceptions without error code.

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/idtentry.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index cf41901227ed..7b17ffa43e10 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -337,6 +337,20 @@ void ist_paranoid_exit(unsigned long cr3, unsigned long gsbase);
 	__visible noinstr void kernel_##func(struct pt_regs *regs, unsigned long error_code);	\
 	__visible noinstr void   user_##func(struct pt_regs *regs, unsigned long error_code)
 
+/**
+ * DEFINE_IDTENTRY_IST_ENTRY - Emit __entry_text code for IST entry points
+ * @func:	Function name of the entry point
+ */
+#define DEFINE_IDTENTRY_IST_ENTRY(func)					\
+__visible __entry_text void ist_##func(struct pt_regs *regs)		\
+{									\
+	unsigned long cr3, gsbase;					\
+									\
+	ist_paranoid_entry(&cr3, &gsbase);				\
+	func(regs);							\
+	ist_paranoid_exit(cr3, gsbase);					\
+}
+
 /**
  * DEFINE_IDTENTRY_IST - Emit code for IST entry points
  * @func:	Function name of the entry point
-- 
2.19.1.6.gb485710b

