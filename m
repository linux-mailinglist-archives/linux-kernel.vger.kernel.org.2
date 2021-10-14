Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB7E42D140
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJNDwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNDwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:52:46 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27ADC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:50:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v20so3218860plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1SrmVsVj/8riq8Zu11HU29nfsCt2CipbOtY3TsCm9Y=;
        b=FV0YrC7La1bXdGFUIvX7TREvaFrIXqgG72vOLvhUXaq8HCxwaeWbDghKU8kms5LgRp
         P85N+rfl5lTnLBYno5QsFKh2Tpz4xD43k80sE1Nw6revYEGNZe/QWzvrt/js1S7C//Im
         R60TUvSKd3/VGTeqbNxVKUJkmrqZ2D35mPYn6gbUmduFk+sCuW8om0EztRtuxh1lpc5M
         0G4py6++CK+YF1qfFRadxoYOXzjFS+lNsYtoOaRUP1ulcoPbFkjI4JNarTgHOg1RxBmX
         tv2kkdU8O/SHlVrZNAC2SB+W1/dSqnRfcsiRUJvggWLMyLhqOS1GobPHQMY5ZQc8S11o
         atUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1SrmVsVj/8riq8Zu11HU29nfsCt2CipbOtY3TsCm9Y=;
        b=P6f3BGpWHDIlp0Ajl4FCk5ERK55wOOlAZb9kzVc33/QnDNq7EQm+YqXoqWu3+pDaw8
         LIsjttTi0yqDJbCzXSDzcNcV87tEdrd2FrNMkhX6twidVQCj1PVOsqO8dw39s7xR6dvo
         dGBCIu4JOQrEiV2DizvwP3DQnZcgsnn9xTpvPTV8p3wlrPcj56YrI3FLaLnD8z+A79lC
         nRivPRay+Ko3VIqRNB2mUmFKwOQb/R69iLIEwUeidTmQ2btBKYLF/0mAQ2to7b9+zjRe
         fvLVGcGi4RFGGmcC2mMG58CwsuUtFh5vGrFOwpe8QGJHQ4SUFwf5J5CJDY6Lx9JsSn43
         tBWg==
X-Gm-Message-State: AOAM5332s4kRjbYLy5UpkxkrQOkhStV9y405QcQy136MGZMXRzwvVwjW
        2XP4hPgXB+n4saUeqtiW+zHDGOBMejQ=
X-Google-Smtp-Source: ABdhPJx66VNuhC5d2moMstLItG5MEDRVQsi5pB9+F4xdPCu6U+oaUnozSLTKYTunhZ3aY0kMwZ+Rkw==
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr18053622pjr.137.1634183441296;
        Wed, 13 Oct 2021 20:50:41 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id i8sm876067pfo.117.2021.10.13.20.50.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:50:41 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V3 37/49] x86/entry: Add a C macro to define the function body for IST in .entry.text
Date:   Thu, 14 Oct 2021 11:50:14 +0800
Message-Id: <20211014035027.17681-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

