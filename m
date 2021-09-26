Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7B4189CB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhIZPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhIZPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:13:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE10C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g2so9318133pfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQOljT5iYZLWjNODgPa9hT4NI2l6ST5zjcyHhhT6P7w=;
        b=AGQZrHBwtpD3quwQNnjukKSOIUw9RrbrELKgHZsD9Ps40VMO2iSLMI+xzILqo/+YFK
         4EYqzU2yvrRcEsBMrk21ur0M2uxXfalCabVn1ELUhHRoScL8ybmZ9VtfNJSV5wUTQRZN
         dJDDF9jOV3qXws8zR2xvNbKl+Nl93HCk2x2Tw2IXxUe8zpKe+fGVy/cZWYaSFv7gH6tt
         pDxgpGMcdl3iiOg4wx6dqfJO+HLtpBLfeoDZmQekpcxBRkqg10nTeGfoSijX328RsP+T
         aD7r3YATzHJWMIu801eJVoyTnSTAKXhzMXaDHeBByuHi97+5sZFC8fJx1/04k/YAmts2
         45aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQOljT5iYZLWjNODgPa9hT4NI2l6ST5zjcyHhhT6P7w=;
        b=4MNk5vc+VG97tzh+sXQgTBunO1DhFz1f4VHNrzg44QREs0nafRbh0aOqXoSLk+zMSQ
         U+V8zOX/DZ+NH9ix7PjGYNLav9OWwc7CIrU0QuMkzdyVRY7tLCIFswV8mj44V+CNg4AV
         9I/ljxPtddPE+9RjR3Hbk8XJb0fxOSrqeWpZL6Iy6XtsSscv9va/KNvUwkLPGKgw3Jsg
         prbiGO+HEM8gPJvLV9gjXoDKog0cJ9Kn9TAbxIx/eur7yigENSsDGAKHxQW9aR70ikdQ
         JuiKQZWVaFz4nu727dPogAxXNBaMvzIV6i5v7n/6OUtREQ6CKFdmyQiBfMoZ0vv5AJ1i
         LRaA==
X-Gm-Message-State: AOAM532tpQN2AOvswAOk3Zhu2SIz1izBEYA+Sa831A3/B07QLv9b357s
        03G1iOLPDa+pJj51U/KohAsTFeepz0ZDgw==
X-Google-Smtp-Source: ABdhPJz48z+bP6MbVEoLZ2GywxiMdB7lQamyUOYrcIDkgJoMDgmNIxq3KVyd6/18AVshvcSBJ3WqfQ==
X-Received: by 2002:a62:dd53:0:b0:445:9e38:4ab with SMTP id w80-20020a62dd53000000b004459e3804abmr19200235pff.41.1632669092548;
        Sun, 26 Sep 2021 08:11:32 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id s9sm14234428pfw.143.2021.09.26.08.11.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:11:32 -0700 (PDT)
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
Subject: [PATCH V2 26/41] x86/entry: Add a C macro to define the function body for IST in .entry.text
Date:   Sun, 26 Sep 2021 23:08:23 +0800
Message-Id: <20210926150838.197719-27-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
index b144ea05b859..b33e96e983c0 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -323,6 +323,20 @@ void ist_paranoid_exit(unsigned long cr3, unsigned long gsbase);
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

