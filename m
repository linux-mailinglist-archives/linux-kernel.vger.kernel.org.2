Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8DC44C0A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhKJMEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKJMEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:04:14 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4068C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:26 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 200so2082406pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1SrmVsVj/8riq8Zu11HU29nfsCt2CipbOtY3TsCm9Y=;
        b=LT/90z8YJ/QbWW07QUH+vjcl+3wdr1fYB0bZS1zbG3ZRt8JjbgRcpThMkJyUswMVEv
         KfSph25OpOfKWM0S6YRr5sE7YUioq876SEiw8L2/e1HRHwrYYQGCHb6SaBErmsQEk3Lk
         qfRw0f11nn2AUG0HEHcGphIievu66ghWtrde3d9+H3iK5eCH4+w00+/mTaBkxzF2v6gc
         ZCeplsy0S1XYHb74F7KRJk+EAFj66+PLoaY4isgllyHUnTw1qC2JQsgMdav2YKEE1E8r
         E9LDo0UxcMsxJGvlyaGz3WqW0V5xwHJ8+dVGvJjIQfNL6vrNyABZhQJb8uZJ7rgZ0g65
         NWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1SrmVsVj/8riq8Zu11HU29nfsCt2CipbOtY3TsCm9Y=;
        b=L91k6OTGXEcT1vu0xcPjShFIC36bZevwU7WAqjdzt1uZHNmIzK9cx7dCrY5NWGMIQY
         PC/dmWTIxo8RlBt1MwlE01B1PZfA4kbB8WNRaPspfsrfgsu//GBQOFtUiJOyL57AUpXl
         zeNv13x2OEuW7gvApr1+ou+rypIVyBV/EC+fX7B2uPv8yczKhoYWlVWqFzPnjogQbdIm
         tKjlbUENT5mi7WG3nlgzLKKTlARrfHbDonmdqQQN1tmPBWEXk5cYXTxCOZOoFqaucfCz
         OxaxnC85c++p1duVuBTl0yGSwVe0sQXtJJhI79S67ak6T6cMrN/+Q6/0JGsLchiEG2zg
         thTg==
X-Gm-Message-State: AOAM531OPVuf/1VwHX526qNb5P8LQD8Wf93ByYraD8T+Zwo+ehtPeGlm
        jPk2rwt7+EEhAXN3aUIsEopNNhm0Iqc=
X-Google-Smtp-Source: ABdhPJxhancTxZaxoNMmP/MKO/uA8biazVDsm5kc9jlFdKgq6Kni7hotoO8Jlezp/8gpxRxyYuQVrQ==
X-Received: by 2002:a65:5589:: with SMTP id j9mr11275200pgs.291.1636545686306;
        Wed, 10 Nov 2021 04:01:26 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id 145sm22090839pfx.87.2021.11.10.04.01.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:01:25 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V5 38/50] x86/entry: Add a C macro to define the function body for IST in .entry.text
Date:   Wed, 10 Nov 2021 19:57:24 +0800
Message-Id: <20211110115736.3776-39-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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

