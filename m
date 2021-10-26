Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D3943B456
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbhJZOij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbhJZOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:38:24 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8292BC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:00 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 75so14348640pga.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xgcpn0sj7FfHs3grUIB/GsB37XdxDBQFdzWwlsVwhkI=;
        b=QPrAkr/Kwq2UeeOe6BOADHtbk/Yn9ZJ2VbDjpWQkG5B5A5u9C658fxY8AyYFdlIZxf
         jJYGMJ5OUQ/xx2Jyjozf/jSnuilq2UhEraDmQucojAQBzF/ZUU3Bi8uF/5uqFqJ3Ad/l
         1iXzG4Vu3Kz64ag/3kNhMX5+qKcF2/OJOiNyG4f809KEEpEeLIhFBML+RKfjCMnCsa0t
         7iBFRbLb4fnqzyB42DmBozXfgsMLKhnTJqAEB71rVBW2WRKw90zJUJyttRrCMrqz1jkK
         WuEoN9RvW5YlWS7R1v4JuQn+BzKbnoCmraJr+5SzzHsoxpEesgTIKTKIF2W5T3ffUTU4
         LrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xgcpn0sj7FfHs3grUIB/GsB37XdxDBQFdzWwlsVwhkI=;
        b=b4BmBYx9P1XBo1fooFqEwbpZeY8gCRQM92/sUjJ7n+KmdXBB9XvfcD86SsQn9G6Oai
         nCMrrst/ktCKhdwb5op9HIy/7meB4uZ0oQehGF4paZc6rLo4b4s0/KUkOXAyTfaM1YGX
         D8FhRJjHE9pabBDZsSqohCuwtxNWfXU58mJeACXdBrhVPAxopbSbe9C8MyCpf0D1vTXm
         V1CSBVJqT8bJuxE+Cu7skfPrpmuuqoUByYxEyuYXZ6kCpVmGHZRjubSkOFB92XyXywfR
         3YwGBKYANRx13nH8MvKs2JvG5QSdlvX+Rm4/4Qlzpveutuam3ZKQyGRdsKxKwnvPZROc
         UmrA==
X-Gm-Message-State: AOAM532lZjAszUhpmRKcId/nyc6y+xchbLFbFIclpMZSRnyMGRMNwg37
        BfKCewj/lt93WlC/rXWckVD5fXNoPE8=
X-Google-Smtp-Source: ABdhPJxw8cz77Ix2NiOztgvxQl1WfUDIDhQAg3HQSoFuaxgqA8ne//DIWT7Hh/vJI2RPLCvX88d/wg==
X-Received: by 2002:a05:6a00:1686:b0:44d:50e:de9e with SMTP id k6-20020a056a00168600b0044d050ede9emr26357370pfc.4.1635258959919;
        Tue, 26 Oct 2021 07:35:59 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id n7sm23672163pfd.37.2021.10.26.07.35.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:35:59 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V4 36/50] x86/entry: Implement the C version ist_paranoid_entry()
Date:   Tue, 26 Oct 2021 22:34:22 +0800
Message-Id: <20211026143436.19071-11-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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
index 448b9947ed9c..14005122f94b 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -274,3 +274,40 @@ static __always_inline unsigned long ist_switch_to_kernel_gsbase(void)
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

