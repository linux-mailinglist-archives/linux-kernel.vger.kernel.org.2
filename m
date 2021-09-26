Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391164189DD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhIZPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhIZPOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:14:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71649C061604
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so1750802pjv.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KEJJz2T5XJUHjaaqgZWXNPnalc2jIRUW1sX3rvY/v14=;
        b=VURdbquTLQv0XRVjDCqMLGCbok0XKIkDqtp1rapaE4qQ/IORdPIBMeYM8DzoCFhH+V
         gAr6ydSBBhyAzg3oWHg1Mtv7KlPPmk1qrQxowSV4eMWeNwGUwFxZTKsSRUV/W4GRICXC
         /1iY/w4UTNsfAh8oFo8EItStz8RhLjVVZK6bJtGu8BFS1PqZgNId3DL2+VdbEyW0M5VH
         UkxvpbrTn6wO0GX+2aq8T82T5ojJjQSorRKLHowilkWWsbbcDNMUTHRUSFr6Uv2sSXKt
         MVtsahOeP9ihvVBqa8aZ3JnLrws49VD3nNNHch8jHFrJpsIB3nFMTi7M/Vqc/tN/AC03
         Uwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KEJJz2T5XJUHjaaqgZWXNPnalc2jIRUW1sX3rvY/v14=;
        b=MKztlrayVMPDZh1zSv+r7IK/ApMr43Kt0jnwuKwTBwS5WsBL42rNJfVU+wa9oWpv9X
         BAUXUdZnaZqCS/y6Ofet7RUvq04oTO84pLnOC41juGbZdacgTvv3GBaurBsK5pE/lsfI
         SuUxnGU5sCCfi0/hwwzWVbjtVNKHRLQhoh5UiMMRzvnZPp2tqtroK1gw+XhWoYI3sZH8
         u+/b49tm3gVsQ/uSu/1RWqZHpSRZPljuKJUhCsI7G9tdlB7Q337LFu4XvjjbkKOsc3bP
         ShcTqxF/XAu4NFD5UDue8ylQDnWF610k9+L+02DazFUzt2YSNTTpCFOQB68xtK3C5/Wn
         lLwQ==
X-Gm-Message-State: AOAM533Mcwcu/7nx6Q2J7frKx4dHA28CCzcQBLhdeJ0C5sEnsFZDaq0S
        BqO2MuCeOxOd/WW7vaoa5dNggDQtLCM4sA==
X-Google-Smtp-Source: ABdhPJzk72xx6chmr/bnxP3geD5sPG33v87ILpUYQEtLc/IJrlf6QiPYfHfZhkBkuIVHT1Z+9dl5qQ==
X-Received: by 2002:a17:902:be0c:b0:13e:2b53:d3 with SMTP id r12-20020a170902be0c00b0013e2b5300d3mr753077pls.86.1632669174862;
        Sun, 26 Sep 2021 08:12:54 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id i27sm14445841pfq.184.2021.09.26.08.12.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:12:54 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Travis <mike.travis@hpe.com>
Subject: [PATCH V2 37/41] x86/sev: Use C entry code
Date:   Sun, 26 Sep 2021 23:08:34 +0800
Message-Id: <20210926150838.197719-38-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE to emit C entry function and
use the function directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 22 +---------------------
 arch/x86/include/asm/idtentry.h |  1 +
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 8871f8ccf117..63cafeeaf27d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -498,28 +498,8 @@ SYM_CODE_START(\asmsym)
 
 	UNWIND_HINT_REGS
 
-	/*
-	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
-	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
-	 */
-	call	paranoid_entry
-
-	UNWIND_HINT_REGS
-
-	/* Update pt_regs */
-	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
-	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-
 	movq	%rsp, %rdi		/* pt_regs pointer */
-
-	call	kernel_\cfunc
-
-	/*
-	 * No need to switch back to the IST stack. The current stack is either
-	 * identical to the stack in the IRET frame or the VC fall-back stack,
-	 * so it is definitely mapped even with PTI enabled.
-	 */
-	call	paranoid_exit
+	call	ist_kernel_\cfunc
 	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 99e1ae3f5c7d..c8837bb3991f 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -412,6 +412,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
  */
 #define DEFINE_IDTENTRY_VC_KERNEL(func)				\
+	DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE(kernel_##func)	\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(kernel_##func)
 
 /**
-- 
2.19.1.6.gb485710b

