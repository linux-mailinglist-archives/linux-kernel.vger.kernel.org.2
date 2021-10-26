Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4E443B3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhJZOQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbhJZOQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:16:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27501C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:14:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so2385243pjl.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gaT9YXZ0xrDSNNAbM8v6pM4zbVQyGQBBagIJCWsl/6s=;
        b=JR5eRiW1RLfZq/tyB7Hjzkm/FV1RDwTPX189jyBEgX483U1u+Te/MQ46mIKagHIGD9
         s4H+f/tC15uHr1BtKshMChAIwwrVkTsVVkdiLCM9+xWn2gwD+AsdoFIIS/UzUSO2NZ8T
         QznfOcTt++nJjKSyCmHInEQ0lrME9y1Sup+F+1SVa0/qBGGqzTr8jW/Gx5CsQd+nJJWR
         SqtWcNUd5Lp3gRVT+CosQXjCzv3yk2O388EJmbHHRCG/YZVtqLncuRI43/kkUa6ogJVz
         2xoBGkpdYwfQ8uf+hlq8OlAG86G7KWYVjP7qRBGurV2ufq95dYwaY9+73SyPWGeAVPoX
         i03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gaT9YXZ0xrDSNNAbM8v6pM4zbVQyGQBBagIJCWsl/6s=;
        b=RmFlfKM//a7YmAttDN8S2OaMHM3g73vm1lq54FVw/gGCv7qkA8els7tCnSosogkQp7
         kqoR4rBcOWO3Qjfo+qIBH4i5U0jISoCaydYl1Y9PomlHPeeFi5uOl2VF5ylRE7fD6Yty
         xVMNsb3TvzewJ41t5YKgvoGv++eR31HFFqyPsWypb4d3NWzC2AjhuryaYyp+brqK1NNF
         1GSne2Q2nOWlvFLFC+r9VBoR4YQn0vbxYwjx6l54llkWJ8LCgbKzbxsbmcYYUDm/+IdK
         jTcS7dLg78+WEDavG92DUMuHgUrcaft3t44AGcpHYe/rE1gwB7hPgIEAbLTw9X5tOHyO
         Wi3g==
X-Gm-Message-State: AOAM532z9qSUcZXOYOxDVbux12jYqq56T4dxMf5D/hGZZHquFmflpu36
        X002LgV19JrmjTrakK5rSeRALCPsAQc=
X-Google-Smtp-Source: ABdhPJxvHVXzG81AduCjZwG99irAYpbUy3i+tBUvlH2oyFmXvdyKVQMrJb4x7AOxvKwuM7xh+xeMOw==
X-Received: by 2002:a17:902:7246:b0:138:a6ed:66cc with SMTP id c6-20020a170902724600b00138a6ed66ccmr23303181pll.22.1635257665594;
        Tue, 26 Oct 2021 07:14:25 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id g37sm2162407pgg.89.2021.10.26.07.14.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:14:25 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 02/50] x86/entry: Use the correct fence macro after swapgs in kernel CR3
Date:   Tue, 26 Oct 2021 22:13:32 +0800
Message-Id: <20211026141420.17138-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The commit c75890700455 ("x86/entry/64: Remove unneeded kernel CR3
switching") removes a CR3 write in the faulting path of load_gs_index.

But the path's FENCE_SWAPGS_USER_ENTRY has no fence operation if PTI
is enabled.  Rahter, it depends on the CR3 write of SWITCH_TO_KERNEL_CR3.
So the path should use FENCE_SWAPGS_KERNEL_ENTRY if SWITCH_TO_KERNEL_CR3
is removed.

Fixes: c75890700455 ("x86/entry/64: Remove unneeded kernel CR3 switching")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f98188e83ef..9d468c8877e2 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -994,11 +994,6 @@ SYM_CODE_START_LOCAL(error_entry)
 	pushq	%r12
 	ret
 
-.Lerror_entry_done_lfence:
-	FENCE_SWAPGS_KERNEL_ENTRY
-.Lerror_entry_done:
-	ret
-
 	/*
 	 * There are two places in the kernel that can potentially fault with
 	 * usergs. Handle them here.  B stepping K8s sometimes report a
@@ -1021,8 +1016,15 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
 	SWAPGS
-	FENCE_SWAPGS_USER_ENTRY
-	jmp .Lerror_entry_done
+
+	/*
+	 * The above code has no serializing instruction.  So do an lfence
+	 * to prevent GS speculation, regardless of whether it is kernel
+	 * gsbase or user gsbase.
+	 */
+.Lerror_entry_done_lfence:
+	FENCE_SWAPGS_KERNEL_ENTRY
+	ret
 
 .Lbstep_iret:
 	/* Fix truncated RIP */
-- 
2.19.1.6.gb485710b

