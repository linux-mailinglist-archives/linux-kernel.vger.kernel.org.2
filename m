Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDA845EB83
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377114AbhKZKaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377105AbhKZK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:28:04 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C24C061376
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:03 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s137so7765266pgs.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZsbg53lYImAQV+JHZZc0noyY1gHV9sh2C3zDggNJz0=;
        b=dmyuNyyT7C/UHUhm3jsINLu+mWvvx6v2y1PPcNnjwlhw+psoA6z+wzNq+tvmW3vY/r
         R7PVHjqCmARyr9JEg4eY6lk2YfDV/1qSMNWDLkSw3vq2PmavZwZYq0ecmMev4Qq7b3M2
         VGsr4hWfq+V96mVXKjNy4Z6xp6uwn/lFHuZ3w32S/5nCK5dPx3Xa5Z2mUwWXtS0TZ199
         a26nTuAQEdWvlfJMD1VmuORMkLPqODalFQFwOvss/qJO/z2JyXdmUrFOsa+XMZhHvciI
         tNpLa2g+2faMz4qQiAoPMd79kY/+7ndJGhax/xRPmwMVwFnMw4Cd7ZQKqi5crVryNDpB
         i6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZsbg53lYImAQV+JHZZc0noyY1gHV9sh2C3zDggNJz0=;
        b=EcFCN2UG75A9X/ThSV0dKRC61hv26gIqW+O+HtuldQy0Sl20PHo4dJO9UtAMrf+DsB
         ay8eWeceN7m6FubKUjvMsKPymOUJ9ZfX6WmRW+4O13M2QsOTZnD64cGnwjqIlpJxCL66
         /kioDHdh4rtmPCt+c3uu7TmGkRW+3QFgBMqwE1WHANhDE9Es6FDDC/S0JZNxPvR1SNbs
         oCYGsV4vbh6kNY+VSBFNeCFIN3rRe7eJZl1TaR4pJaNE6nf7jUnJVm5xhHdBdzK1RLJ5
         sFBun2v1sMd4Jw3Ri76T87Y8swVyvX3KNQJ9Ir50R9KqpaxpYEtqpcd6t7qZZtZjxZfU
         tm8w==
X-Gm-Message-State: AOAM530VCzLALrYPH0bhuMlN6aEEO1rMxozxSXsii7HItt/IPqYcOtMb
        N6yXHq1Q+2NJh4wh1SJba1FEqJQtikk=
X-Google-Smtp-Source: ABdhPJz8Uze34w4DNClzKAEyRYRqaZrWg3BMfCbBZYzF6EiUbgo2+/vt2yq8IeLdnemeR/fyfYp2nw==
X-Received: by 2002:a63:190b:: with SMTP id z11mr20439919pgl.414.1637921762797;
        Fri, 26 Nov 2021 02:16:02 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id h4sm1799500pfi.79.2021.11.26.02.16.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:16:02 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V6 39/49] x86/idtentry.h: Move the definitions *IDTENTRY_{MCE|DEBUG}* up
Date:   Fri, 26 Nov 2021 18:11:59 +0800
Message-Id: <20211126101209.8613-40-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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
index f274e4e2ca17..737fbbe19d84 100644
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

