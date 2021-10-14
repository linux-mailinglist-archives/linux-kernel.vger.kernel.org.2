Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072E442D0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJNDQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhJNDQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:16:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6972C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:14:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k23-20020a17090a591700b001976d2db364so3777189pji.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gaT9YXZ0xrDSNNAbM8v6pM4zbVQyGQBBagIJCWsl/6s=;
        b=gYbR9eInenl/RxwXdit7Q5demTnTvKIX6ikAkjCmaJKqHNZjGdCHf+DpYjg0jh+K0J
         YKCTl8C2xCCnF4Kcm2fAxPO4dU4uBsb/rbC8zPGojRDLOaIAA4jxxpd59htZhIEw2tkb
         GJ0zwYKWuSs3kw03ob+4bgWVUlr+PGHGKrM3a/FNd6wKY/lzn7aiVXh/gFiQw1SJpWv4
         cr3ifn+rhALbB3ufGihVpm8p0b+TQDfeYYtR6SvNcQ8PtvCtQpTc27NmkzbhqGQKHDtj
         aVhYKe9OWW1TQ45k3ZMYeIOWezdABY7LPAMfwPKTC8RiU0kCj5DvtionLzNlO+nUmUeW
         3z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gaT9YXZ0xrDSNNAbM8v6pM4zbVQyGQBBagIJCWsl/6s=;
        b=xuVoJAhDjjuCXj3dKXWWH4P2ShZN5QsuwiL6A38IKliV9udvru/xJN1atZf/PeU0dF
         jVoDkRWehk45+s3fQEpd4SLtTF3Rx0mMCP6KdU5tbghU4jXThY86xhO092iMFGny2HQ2
         g0aUMay6iTKASGzSJtBCldee2HxFMFUZqnbCv+1vNeOiZjjMDFtT/kD0IF5kiVEsZu9F
         9bF9ff6qlTJPtVxXTx3XsoeLVQXvB7PUE7n2WHithftVNBr//CdLqau533kf1yCum4J0
         vYKWEkOOOhHNJKPk0Xgcl7P3mFSy4mY0ZBFxgdfXElPdwH1QcBLSvrR7Yp95m6GKDQ0C
         5RnQ==
X-Gm-Message-State: AOAM532sd/phJ+/ZxqRQ+kIp6fAjZlqpeKmruKLy0fhTy8MGhr/UildB
        iJJ2BbUlRh07AjPIZOlc5a/75SW6IbM=
X-Google-Smtp-Source: ABdhPJyi1xKVyvGRsyjxp5087hMjIWpSQ0DoTw+/LtGZbn/0+LfuMP0tL7az9oZjjYUgyaxKutXswQ==
X-Received: by 2002:a17:90b:4ad2:: with SMTP id mh18mr3527126pjb.18.1634181281190;
        Wed, 13 Oct 2021 20:14:41 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id i12sm806174pfo.126.2021.10.13.20.14.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:14:40 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 02/49] x86/entry: Use the correct fence macro after swapgs in kernel CR3
Date:   Thu, 14 Oct 2021 11:13:25 +0800
Message-Id: <20211014031413.14471-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

