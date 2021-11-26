Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41EC45EB62
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353474AbhKZK21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239294AbhKZK0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:26:18 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EB2C0613F3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:15 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b13so6401406plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/sECo0GpgifEJ2MV3wheABZwv7jRSxT6iKt29SsZfcE=;
        b=Z0+Spa7B+BCqXcLfz0YGZbrC4jKq+xdxprwO07cbH7WKhUBh2ZtmgFkfVrXSG6ezCv
         ohZN+0gnQaMJWv/6k55oCm8cCDLI+s4rQ3C7b5dSx5PQeqa2E98+/rLNnXtvKP9Qh/Eh
         TcsSmlGb05SFhoDnI4iFDBn3E2gUSSW98mSScSziNdPHkBsxyl8htm1At0hcQ/IIV2Br
         23P6c61d4zGGO3Kd+E2lVNT2ayepvRMdQaecT5/VgK3JZ8a/KjC603wMb5joM6PMQonS
         Sbxt0eqOhZP8bhlePW9CIMyR621o909XXYnQIChNrwBo/tUALvfuM583Euq9eKrEWpFd
         36Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/sECo0GpgifEJ2MV3wheABZwv7jRSxT6iKt29SsZfcE=;
        b=35fHvKOagwBm9taKGL8sm2H8WthB3gtcxWyfVbOpPKjQpn+YjkkgppemTP8x6AZ82a
         3SQwc/QSa4YaIDYnJQONYpXcXC5WL68kJ5EYr9kQAWSFnzm1opM/ADjxVPPbqbJfGxJr
         DEJmoAQKywx5Cd5jGue+HelXP8sJIfUK2grtqchyK89UZyblSvHnsmzOMawWlDPpGxTH
         TyjEtwV7eUhwQcF/ZruLkcXUnlwf8sUHxeACOWtfY3H0ReRjwte52wi1gj5LSMZGwch+
         MftYP/gcfPeGGGn2lTmNOys2YYqPYYo4qboh73sjqYIDp8JFdh9RRhdo/ZskDfCGTjgO
         9Y3Q==
X-Gm-Message-State: AOAM531ZVaDjzPHmZ43gAJoQ8gKY67dx1vlFtgzRhMmc7MsDfE9TwgKk
        6/jDDCLd3137sTIhzv8K8F4EenKd53Q=
X-Google-Smtp-Source: ABdhPJxhCfFzGpJeUBI0jehJ+XzbHvcgJ03uSVcU70la5hCPgW42/9kIeQqi0cuBVJXdzEx0runZmA==
X-Received: by 2002:a17:902:7d96:b0:142:87dc:7dd3 with SMTP id a22-20020a1709027d9600b0014287dc7dd3mr35974897plm.11.1637921655027;
        Fri, 26 Nov 2021 02:14:15 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id mq14sm11741862pjb.54.2021.11.26.02.14.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:14:14 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 22/49] x86/entry: Convert SWAPGS to swapgs in error_entry()
Date:   Fri, 26 Nov 2021 18:11:42 +0800
Message-Id: <20211126101209.8613-23-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

XENPV doesn't use error_entry() anymore, so the pv-aware SWAPGS can be
changed to native swapgs.

It is prepared for later patch to convert error_entry() to C code, which
uses native_swapgs() directly.  Converting SWAPGS to swapgs in ASM
error_entry first to ensure the later patch has zero semantic change.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c09e5a4dfbbf..4d88cd0c46c6 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -994,7 +994,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We entered from user mode or we're pretending to have entered
 	 * from user mode due to an IRET fault.
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
@@ -1026,7 +1026,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * gsbase and proceed.  We'll fix up the exception and land in
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
-	SWAPGS
+	swapgs
 
 	/*
 	 * The above code has no serializing instruction.  So do an lfence
@@ -1048,7 +1048,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We came from an IRET to user mode, so we have user
 	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
-- 
2.19.1.6.gb485710b

