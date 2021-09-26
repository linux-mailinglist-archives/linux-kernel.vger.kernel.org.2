Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D14189D8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhIZPOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhIZPOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:14:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC262C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 145so13391770pfz.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcMVDXsubEww6vVVgpsCOvOr71UoFt/ay5rxrrtuKU8=;
        b=VoF5h2jD8+kJwHLop4ugItzz3WpJJtBArMpHv31oBzs1OqJr5+1XDrXeFx02Vc+EDP
         GFn7+5Gea1j+1pJDz7I78/blSrQomwaJWSX4fbTphk6lAx8T9pKmk6mtvOFHXGRjUILb
         8FgcCJa7ouWBwdhenwrHVH9KDst6uf2BXj+6ILUaO0iV9xM3hDLxe1k+fmXS93JaH7YU
         2j5KgBh33D9HFjHT/p8orjnxeNTDlnDdcQCSOBOnP5WVNW2eUZeHwkHFRbbL9AdUuk2X
         4HwyvSxbFgI/cBuY/ivizgtegn7jKn4Sb5XcFFkbfQhM+n0N/ng3lWrjyeDsdPLdp//L
         NsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcMVDXsubEww6vVVgpsCOvOr71UoFt/ay5rxrrtuKU8=;
        b=bYFFssronOoDm5afZ0S6SqpKIpmcd2jfNUcM9TlnZy7zdjwS8Zf023IQTffBtkxkuY
         u8Djx68TfdCvhDvsvf3xRUbn5mg5vpaTW4US/ibJ7H44klaXcY9M/dtEOfuctAArTsfy
         sxt6ObCHOl3/mwG9aCAEOj6JxkjHwVCIb4TsQRzN6AMEYgR70o/WTSvnW+3CjTld05sH
         mHbdw+akpAeRJUyYv7aLU+S1wt0fz5nymxIovY9EHMTQ3B8LBSQzed2oyavUEQildobZ
         ee6MpSn6sHITtGGvL0HEzSsBjf8UnnaOJASnMgGLKL4gIyDzUAYSFFYz028mJO6qXAGx
         93Hw==
X-Gm-Message-State: AOAM532xwsPnSH57XiFic+csJ29ycsWPjDGYaSP5scuzAyOU8neeYEQL
        Ms4yM21p2mdxD9VsTsqoIZRlABHk4jPFHw==
X-Google-Smtp-Source: ABdhPJzBpraEX5FFjGrM0FZ10GpoC1lBjUbfqjRdhSC63Vyl51cIHmQhMEEj1dvFW+KOX/ETPgisDw==
X-Received: by 2002:aa7:9841:0:b0:439:c4cb:fe9a with SMTP id n1-20020aa79841000000b00439c4cbfe9amr19362565pfq.13.1632669144035;
        Sun, 26 Sep 2021 08:12:24 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id m20sm15835871pgc.25.2021.09.26.08.12.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:12:23 -0700 (PDT)
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
Subject: [PATCH V2 33/41] x86/entry: Add a C macro to define the function body for IST in .entry.text with an error code
Date:   Sun, 26 Sep 2021 23:08:30 +0800
Message-Id: <20210926150838.197719-34-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
index c99c58bc179a..7935b0abc65d 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -337,6 +337,22 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
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

