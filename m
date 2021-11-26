Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344AF45EB8A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376882AbhKZKbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377238AbhKZK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:29:19 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1012C0619DF
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:24 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id o4so8454321pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ati8q/LBZzDODk8RGw1XQap3HyVh8p9LlNnhait1s/w=;
        b=PM1IBoamIcYoeP4OWRO/EnMYTaJcbYLSAW8g/GoJp3Yb5OExP0D9d5Ws9Q60F6dI7f
         L0CO8WuB77XLmcMKDks284Z1YWHfx0MSkN9TWLRtuZEEu97Bsf/xKUdyPsGsQSwbPlR4
         6vmBmjG3BhecKINMPTNxY3lcLVOS3SxeLrZFRry8nKC5WHKZce+BeJj6b4sEmnoqqJmi
         ZZg4rlRcwxXlcWfC5P7FtFepo6ACYjBsWiRqWUnRQVpZMu3VISUjSygr2Qj9wkydeaAy
         65Y/C2lclnpNBPaULYYfJNSWgmmUYhBgF9uoHWM2kVC3B58yIDLP1V4gR6pRxh3J4OTc
         6q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ati8q/LBZzDODk8RGw1XQap3HyVh8p9LlNnhait1s/w=;
        b=aqgLKnTzC7NT+00BN5cxS7YxPXpNDiGGLjUKS5Ba9v6EnDNA0/aiw1CdDmlrXPxoya
         TZQ7GxBzygLEUxn3zXp1PL1ALqpISkmH/s/dbs1chEz+zryqmPNs3hyHCnjc2Km6fHDU
         zIPTknNalvFSZ8mgjH9IcswME3z0HfdpY5aJURDSaH10mJ3iiftprSydH2hCim4jc6g3
         VH6yRHo7gCRy5R9ruVYLaC3j8+zgkmR1U1b2wIvE96jquyjW65THhaSpeNbysyzlxPes
         PWv9HzNyP/+HahlohXgl1VGQ4+gwselcQAD7C2mnXJdyb8HNBgHHMxNC5yI9Tx9TRY3R
         /Y7w==
X-Gm-Message-State: AOAM533j++eCot29ZZHWvMTwz8CYd7v4KjZrs7ss6xTjda1wd1BNLaQT
        XBW4hkDXBD73lFHPa6Xjep7HEj0bvEI=
X-Google-Smtp-Source: ABdhPJyXqRiwSM753sQj3Okr+QjfJS/VMany0tmek9lRDpEi9OoH0TobvHWc8ArCdmrWJS+nAe7pQw==
X-Received: by 2002:a63:155:: with SMTP id 82mr6699495pgb.485.1637921784177;
        Fri, 26 Nov 2021 02:16:24 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id o134sm5931322pfg.1.2021.11.26.02.16.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:16:23 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V6 42/49] x86/entry: Add a C macro to define the function body for IST in .entry.text with an error code
Date:   Fri, 26 Nov 2021 18:12:02 +0800
Message-Id: <20211126101209.8613-43-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Add DEFINE_IDTENTRY_IST_ENTRY_ERRORCODE() macro to define C code to
implement the ASM code which calls paranoid_entry(), modify orig_ax,
cfunc(), paranoid_exit() in series for IST exceptions with an error code.

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/idtentry.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b65cb61aafdc..46b2ef021992 100644
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
+#define DEFINE_IDTENTRY_IST_ENTRY_ERRORCODE(func)			\
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

