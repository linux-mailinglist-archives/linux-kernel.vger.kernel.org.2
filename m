Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA31D43B458
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbhJZOiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbhJZOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:38:38 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA54C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id r5so5889343pls.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1SrmVsVj/8riq8Zu11HU29nfsCt2CipbOtY3TsCm9Y=;
        b=FfyS8Ucs3QccfDKAHEcbld4gwnfXPKb4ahTobsIckda69/Z9xwaS3DcpgBU3xfk//Y
         FM3Lbhy5zmjYy5nCN/Qkxs2ScRYsVFk/gsrlFIS7KGbd7tEYQzPTksltUg4fth9q+Maz
         55Jq36PN6A3ZoAnuoaV988UIx419fNOigdzdMWx6odChtqoe0W5PyfSjfT+CLoEAiZiS
         jSSMt+zDeuo0A7JVsGX013FrKynBe4onuC8vNeGvBgcnc/TLeGGGeeSLoxvEC+Du6W1j
         2K0PT2euLiTBdenHCKTGkJEfUfRBekiaaIoEK0eLAYvY1l0/VtHSHhv4oClw19MILmDR
         LlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1SrmVsVj/8riq8Zu11HU29nfsCt2CipbOtY3TsCm9Y=;
        b=sJ0S624vZAubN/KDcv9vX2I60UQDkCqSrAssrnUbC4MCpmPOvIp8p2NNLi7BV1GgPu
         pDfVJ/oU8riRLXaSkF+134KT6Jb6pj7Ho2xl7QJqntQnOIK9KjeKPthqhOOpvTFroJH5
         0iwOtAaDNIl/1XdxYwSLyHd1wdnEgnpPXgWV1YM2DjQGNPv/iKX9OpTF4g8Q81ibXkI+
         /B8LNhSN9ripCXL9l1e457sdfAbEoYOd1lnQ9qjDZCC2wxBoFEbobupU6BImKfEma0Fl
         zqX5Y6qdCR8RaeU6iHyWZHtguo9kRmjSCdamK59KFt46tz4U7mxkqEFbEQVs9/UVdnvi
         l/0g==
X-Gm-Message-State: AOAM531qGHhJwSCmRKbpMa88QXUnBQkcFB7bZ2uyC56iVwDkjKhz0myj
        8hwLHVDvDUt7kTeY/c2ChTe39HXPtYA=
X-Google-Smtp-Source: ABdhPJyXLAtOvU5/f2ZjhOS8FaVrTKuT40KPvhbGanWqVTslnxbFIx9ER2h1Jm35WTLU+OO4pUu22Q==
X-Received: by 2002:a17:90a:ca90:: with SMTP id y16mr26807263pjt.222.1635258973736;
        Tue, 26 Oct 2021 07:36:13 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id g7sm18740883pgp.17.2021.10.26.07.36.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:36:13 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V4 38/50] x86/entry: Add a C macro to define the function body for IST in .entry.text
Date:   Tue, 26 Oct 2021 22:34:24 +0800
Message-Id: <20211026143436.19071-13-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Add DEFINE_IDTENTRY_IST_ETNRY() macro to define C code to implement
the ASM code which calls paranoid_entry(), cfunc(), paranoid_exit()
in series for IST exceptions without error code.

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/idtentry.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index cf41901227ed..0f615943a460 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -337,6 +337,20 @@ void ist_paranoid_exit(unsigned long cr3, unsigned long gsbase);
 	__visible noinstr void kernel_##func(struct pt_regs *regs, unsigned long error_code);	\
 	__visible noinstr void   user_##func(struct pt_regs *regs, unsigned long error_code)
 
+/**
+ * DEFINE_IDTENTRY_IST_ENTRY - Emit __entry_text code for IST entry points
+ * @func:	Function name of the entry point
+ */
+#define DEFINE_IDTENTRY_IST_ETNRY(func)					\
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

