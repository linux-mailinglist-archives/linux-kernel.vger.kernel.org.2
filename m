Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7543242D120
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhJNDon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhJNDnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:43:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBA5C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:41:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i76so2139175pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uKNvVQ6CjLjkusQqsZ94xWd5Ds6mJwvJCMcrOnvil24=;
        b=J4zPbRGCtQ1rSy1irQqwZ2TMpvhFvCAvhV3hlfE7k5zUVQOScoyyFsgft7sljwpqFx
         J971B7tHjycDDmfNMqATnl7WzSXAVv7DPVNKVAfTcWRiSJyzjCiq0Jhac2IsvWKRvAc9
         lS4NHqI7ncUZPtUTDdTekYdCKhcnKvzZAT2fNEpMOdZWobUP7vsU8R9Ra+jvErP1E1qk
         YigtrvuKwLCNetL+hM22C7pA72K0W/dGwJcQROIx3jKp4oFUcwqG6d9TtT8m7Xj+/QGs
         EwzuUSIfxCQsONa+B4+4d537dY8jLCaxo80TobLNIB5Djh9tL3E5V32rHEurfrM/aBf/
         zHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKNvVQ6CjLjkusQqsZ94xWd5Ds6mJwvJCMcrOnvil24=;
        b=25TjpaEyXnwpEvk3u0H/BSwxOyXUn34FxB6xmWL4hRFv/GXpyJx8Td3WYYmetnOLst
         M826lZ6rMIx8KwXXWJt4x+v8WKHLpOMX6sjFDu4F4OSRlOIk51Tx3NowgI4KVf5/A7GX
         j14/eyu+Kt1xmH1psA4+fclegNBmzNewCjLBmiEk7AY6xW8DqOtRNOQyf2JF9wrJ0aHg
         yaTqb8EMHJwTmdhpMff8apbuZq4+JGM/EWF4avZfVVbWwxnDbTZubG/kkGgcY1sZsgK0
         Aa/qoQQwrnDo/1MEwvfaF+P9E9tmK3JNP6GMcXMTF9pvEL7y536wnTOARCN5NgUCWgqK
         I9OQ==
X-Gm-Message-State: AOAM531Z4FVSREKlMYi4+QMWjJPvCxzHd6Uuo2aptpAPjmeas1FrQOfJ
        UKoRJldG+StCIo4jHf+tAPhDSSkZdbM=
X-Google-Smtp-Source: ABdhPJykp7BfeXmB5/+lvwOD0HkP6OpK3eynCNcn8UThO/DuM/vp5vozjRKF1Kwv/9H6t5XHMWj49A==
X-Received: by 2002:a62:2c82:0:b0:44d:71c3:8a3 with SMTP id s124-20020a622c82000000b0044d71c308a3mr3245710pfs.84.1634182900537;
        Wed, 13 Oct 2021 20:41:40 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id 63sm833631pfv.192.2021.10.13.20.41.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:41:40 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V3 35/49] x86/entry: Implement the C version ist_paranoid_entry()
Date:   Thu, 14 Oct 2021 11:41:07 +0800
Message-Id: <20211014034121.17025-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It implements the whole ASM version paranoid_entry().

No functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c        | 37 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/idtentry.h |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 06f7476d78b4..8e1474ece7f9 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -288,3 +288,40 @@ static __always_inline unsigned long ist_switch_to_kernel_gsbase(void)
 	/* SWAPGS required on exit */
 	return 0;
 }
+
+/*
+ * Switch and save CR3 in *@cr3 if PTI enabled. Return GSBASE related
+ * information in *@gsbase depending on the availability of the FSGSBASE
+ * instructions:
+ *
+ * FSGSBASE	*@gsbase
+ *     N        0 -> SWAPGS on exit
+ *              1 -> no SWAPGS on exit
+ *
+ *     Y        GSBASE value at entry, must be restored in ist_paranoid_exit
+ */
+__visible __entry_text
+void ist_paranoid_entry(unsigned long *cr3, unsigned long *gsbase)
+{
+	/*
+	 * Always stash CR3 in *@cr3.  This value will be restored,
+	 * verbatim, at exit.  Needed if ist_paranoid_entry interrupted
+	 * another entry that already switched to the user CR3 value
+	 * but has not yet returned to userspace.
+	 *
+	 * This is also why CS (stashed in the "iret frame" by the
+	 * hardware at entry) can not be used: this may be a return
+	 * to kernel code, but with a user CR3 value.
+	 *
+	 * Switching CR3 does not depend on kernel GSBASE so it can
+	 * be done before switching to the kernel GSBASE. This is
+	 * required for FSGSBASE because the kernel GSBASE has to
+	 * be retrieved from a kernel internal table.
+	 */
+	*cr3 = ist_switch_to_kernel_cr3();
+
+	barrier();
+
+	/* Handle GSBASE, store the return value in *@gsbase for exit. */
+	*gsbase = ist_switch_to_kernel_gsbase();
+}
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 49fabc3e3f0d..f6efa21ec242 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -307,6 +307,9 @@ static __always_inline void __##func(struct pt_regs *regs)
 	DECLARE_IDTENTRY(vector, func)
 
 #ifdef CONFIG_X86_64
+__visible __entry_text
+void ist_paranoid_entry(unsigned long *cr3, unsigned long *gsbase);
+
 /**
  * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
  * @vector:	Vector number (ignored for C)
-- 
2.19.1.6.gb485710b

