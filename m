Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2D33FCC98
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbhHaRwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240594AbhHaRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:52:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FDBC061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q3so11103542plx.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38nwv9e4lDhBRSjTJVZvVVyWbROiW4aiQ7X31SY8/RE=;
        b=LiQp13yL4k9LYJaAiga+sdsDvVYd3359RydS5P7owE6xptYBISsFXJuarzhCAnqYcd
         VsLEvLx9BS2V4LArOmTk3wTWidZGdZCTH1IQBqdlhTCMYe08nfbPZS2z7vK0KYlP5MW3
         i8QqJOl2MkKW6vgXxJzfkPZ8R9t2/OSh7qt2Hj6zmUBmODT96TSy/abt/UJ3SLWNld/i
         Zfl3ORXcXCdezLn/hs4qVCHj5aUVUMN3R3TS3+ka5JuZ2NGH4uoS784oN5WDDza8vm6/
         azJ94gwgdz4e819Na4C+jxcvUw6QZhchGjH1p5LBhzy4OOQRTZPg9CUO7Ic0HWYr/4CT
         ScCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38nwv9e4lDhBRSjTJVZvVVyWbROiW4aiQ7X31SY8/RE=;
        b=SCzPm9OyXrK0fFnsV7wBjlQNU8UkYsdTLbP/WDFoomFNSN+EHUq+OH3D0/5ZGojOUd
         3uNFnFixKu4VEBmGY6DICmQu92e9WVcOw1MfpCcCBCZyD8p5+Q9XSxjSrKllw6mhXX7o
         cH/31pswCdoImT4bxmRjqw6nz6v6/k0MDD2zEHRS83JCvA4zaMQY0SHauDUAv6liwG1I
         UYFSinySXMaeDrwLJTuF1XgCmEeOed2+2Tl/Cu5veSTijgW6HAR08Xwbz+DXJ5TSNQLV
         ZXx8hUKD+5B9HAnGwm9yX849Rlv6CgPHV4dQ30z1pt/slQn8rIpoP1OMMIR2xpBmcHeC
         5NSQ==
X-Gm-Message-State: AOAM53298D9YPhqdaN6oGZXbnQeIk+fmQU7YgiuASbLX2hD+NlfnWJwl
        Sd8I/FtOkY5e4Uf8kOXoQENvdOUvjko=
X-Google-Smtp-Source: ABdhPJzpV9W7MTDIqAJzwHcTG9kNetlqMJ5Ud1fPfs73Biz6ZYkUU2oVm7RCSJyOIob+DG+fJQxzaw==
X-Received: by 2002:a17:902:c40d:b0:138:e2f9:6c96 with SMTP id k13-20020a170902c40d00b00138e2f96c96mr5851878plk.74.1630432303886;
        Tue, 31 Aug 2021 10:51:43 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id e8sm22701948pgg.31.2021.08.31.10.51.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:51:43 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 12/24] x86/traps: Reconstruct pt_regs on task stack directly in fixup_bad_iret()
Date:   Wed,  1 Sep 2021 01:50:13 +0800
Message-Id: <20210831175025.27570-13-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

In current code for handing bad iret, pt_regs is moved several times.
	Reconstruct pt_regs from bad_regs onto a tmp
	Copy tmp pt_regs onto entry stack
	Copy the pt_regs on the entry stack to the task stack in sync_regs().

This patch directly reconstructs pt_regs from bad_regs onto the task stack.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/traps.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index b8fdf6a9682f..ab9866b650e7 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -740,25 +740,28 @@ struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs)
 	/*
 	 * This is called from entry_64.S early in handling a fault
 	 * caused by a bad iret to user mode.  To handle the fault
-	 * correctly, we want to move our stack frame to where it would
-	 * be had we entered directly on the entry stack (rather than
-	 * just below the IRET frame) and we want to pretend that the
-	 * exception came from the IRET target.
+	 * correctly, we want to pretend that the exception came from
+	 * the IRET target (userspace) and reconstruct the orginal
+	 * pt_regs from the bad regs on the task stack and switch to
+	 * the task stack to handle it.  The actual stack switch is
+	 * done in entry_64.S
 	 */
-	struct pt_regs tmp, *new_stack =
-		(struct pt_regs *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
-
-	/* Copy the IRET target to the temporary storage. */
-	__memcpy(&tmp.ip, (void *)bad_regs->sp, 5*8);
+	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
 
-	/* Copy the remainder of the stack from the current stack. */
-	__memcpy(&tmp, bad_regs, offsetof(struct pt_regs, ip));
+	/*
+	 * Copy the IRET target to the task pt_regs.  This fault caused
+	 * by a bad iret on native_irq_return_iret which is not used by
+	 * XENPV, so the bad_regs->sp and bad_regs are in the CPU ENTRY
+	 * AREA and they must not overlap with the task pt_regs and
+	 * we can safely use __memcpy().
+	 */
+	__memcpy(&regs->ip, (void *)bad_regs->sp, 5*8);
 
-	/* Update the entry stack */
-	__memcpy(new_stack, &tmp, sizeof(tmp));
+	/* Copy the remainder of the pt_regs from the bad_regs. */
+	__memcpy(regs, bad_regs, offsetof(struct pt_regs, ip));
 
-	BUG_ON(!user_mode(new_stack));
-	return new_stack;
+	BUG_ON(!user_mode(regs));
+	return regs;
 }
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
@@ -861,7 +864,7 @@ struct pt_regs *do_error_entry(struct pt_regs *eregs)
 		 * pt_regs as if we faulted immediately after IRET and put
 		 * pt_regs onto the real task stack.
 		 */
-		return sync_regs(fixup_bad_iret(eregs));
+		return fixup_bad_iret(eregs);
 	}
 
 	/*
-- 
2.19.1.6.gb485710b

