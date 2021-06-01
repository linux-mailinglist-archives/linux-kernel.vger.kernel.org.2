Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9DA39782F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhFAQjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhFAQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:39:22 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7206C061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:37:40 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 133so6099711pgf.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yMTAZuDW2H2M7nToM7//9afS1Om7U60tJgUi/NDXyhk=;
        b=PWbbbgJBvILK77NXu+WxKc2c2FT8m09eAeJX2+jXt+rr5QdCAqDw9LgC6rQMhY3HW5
         BLPuN9v5ihpix8lKgy1n16qzAMhl3Sk2LQ57SU3GAYLKzA7Lqlf3w0W6Bna46IJZY7kH
         JrKi0h27rmmj7mqjz3/4YTOKWcPgMLuoZrbSTa3cqvFSGQXEAyFadbT+MpPMbwh7EPeh
         qWsD/eKi49Sqng+g5jb8xidnjj2FyBe3ZyD8qitnPheGUzUxSYKTlhrpNyPZCkC0TNBl
         c+8NSM6GLJL5ce/3wEz7uvRTdeC0XckZWSJq6JGlURvgNh2eULPxkia+tbqzPNRx6j8g
         MM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yMTAZuDW2H2M7nToM7//9afS1Om7U60tJgUi/NDXyhk=;
        b=We/sNj+xNApQiTi9R15HnkIXtcoX9WRzgCvwrD/QpLVxUJ1B2gIs4PIVVwvfr2jqHd
         w1GX4FNq6PPTuFbDgVZ2viaXk3Du3ltgNDpx2aygcFUBEThy3+6AZ9/kVkEeWqOUtBwJ
         rL5LrR75MNi9HB1Qxk8SOt4au1Z+SvLLzooi/EjcuJMy7GDNTKFrFuRqSu8926ZkxY3c
         c+LUhIzM1jFfztk/CE+y1+5N+0zE87OzgblXh+AZgtllCnV9r5nbJMNP6IxR2eW6QVjJ
         dpQzXFrLujvt8VHa+4YFAbRkOe9iv8etBizFKnFr5HH/C8l95Ai0JgAPR2MdJ1VkJnmg
         KKAQ==
X-Gm-Message-State: AOAM5307l9PjClB0s2zztDElGlhQ1nFe7y/TY4j64/AC88B8yDflQKlv
        1Ame67rvRdZ5JulYZmQNPTBHsWU+hL4=
X-Google-Smtp-Source: ABdhPJxAWh/xCro/C+deBY3uE/99UF1tgBDVHs5MVao/LVDYREorBoBERt/h6qVmX774HxxnmcLhbw==
X-Received: by 2002:a05:6a00:b51:b029:2d5:874a:6bd7 with SMTP id p17-20020a056a000b51b02902d5874a6bd7mr22924704pfo.6.1622565460324;
        Tue, 01 Jun 2021 09:37:40 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id d18sm14800160pgm.93.2021.06.01.09.37.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:37:39 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH 3/4] x86/entry: Remove parameter rdx from macro PUSH_AND_CLEAR_REGS and PUSH_REGS
Date:   Tue,  1 Jun 2021 14:52:16 +0800
Message-Id: <20210601065217.23540-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210601065217.23540-1-jiangshanlai@gmail.com>
References: <20210601065217.23540-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

There is no caller using parameter rdx.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a4c061fb7c6e..d63fcc09e722 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -63,7 +63,7 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
+.macro PUSH_REGS rax=%rax save_ret=0
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
@@ -72,7 +72,7 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq   %rdi		/* pt_regs->di */
 	pushq   %rsi		/* pt_regs->si */
 	.endif
-	pushq	\rdx		/* pt_regs->dx */
+	pushq	%rdx		/* pt_regs->dx */
 	pushq   %rcx		/* pt_regs->cx */
 	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
@@ -114,8 +114,8 @@ For 32-bit we have the following conventions - kernel is built with
 
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
-	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
+.macro PUSH_AND_CLEAR_REGS rax=%rax save_ret=0
+	PUSH_REGS rax=\rax, save_ret=\save_ret
 	CLEAR_REGS
 .endm
 
-- 
2.19.1.6.gb485710b

