Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB0945EB42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376779AbhKZK0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353193AbhKZKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:24:18 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8290C061759
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:19 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r5so7707565pgi.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KSlJ8ApfnYlBHR8LZgSRA4R/jhsKNtbRZzOyZLSvRxM=;
        b=marh0O7OipiMPZeZ2RBq8F/JVesVjQB7tMgK5CKt0LIIHJQtIt6sDJq4y15xHrzadh
         LIQ/eXxKMBUPxRP6AckZmjHhyY/p2/x/963YKoc+vCt2PC3YHTtZwZMWD8gLs8SaOfyA
         PgRMhlnGpuQU0sK3qi1AX3wgkZgAJ0c9UcR7KElZhx0tEgiDhrj1Ur7XmT+RMNjZm4it
         pEKyYkv/QB0XwpBWvqQgARWNLR9F4MPCfmq2eNcITso4yt99Y9SMmNCYetlYjBXYmTal
         Jo4UnPvOP4rgR593gwt+XRA40VqtwU0EzVw8CGPxA+g0Vmg0ogU9AqapxoURjQxQHKjx
         mCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KSlJ8ApfnYlBHR8LZgSRA4R/jhsKNtbRZzOyZLSvRxM=;
        b=OsF075KjP/9g3OPWnuxMmCfyW0nutf7vkYFqwM8IwJz37VLVGLwPR7rc5sAPtTZiZq
         iYVFpNz6qqpPIATWOogZPSpr1k1Lin33REUiQVp3+HBewfblLwpprmS4UFZNpdCzokV6
         lXEnuHz74JidzOR8JujN4J21Lj8W2fDtLhCF4PxvwCXPr/li+xUZmNdV+Qp1l+uKR5P1
         jAeU8uqHZLeA/1GCfl630rUxGJ5V5OUYhDLWQmuYL1Wb2EMELDVWWVBS1qok1QD+MPPq
         WvMgt5ds/79QLhj8khkOdpkMurVYJaHZPfv04bxqE2lgraJfpVlkAy1hv5p/pZ8c3g0g
         d/oA==
X-Gm-Message-State: AOAM532JYB/o0i0tIg/YOe9j9EPcrcJDsLAzQmb+M3P7i+yYGbNfR8OJ
        +cEoDYLAHs0KUUESy9y+El/9FI4m3fE=
X-Google-Smtp-Source: ABdhPJyNSmnIL0sanJAX2LwMdjENpxfkIcEXALcGiJbHYAcvKB87RYmZirPi4R3mQjbZxkrWNKsCuQ==
X-Received: by 2002:a63:6c8a:: with SMTP id h132mr20678771pgc.85.1637921539148;
        Fri, 26 Nov 2021 02:12:19 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id w1sm6236194pfg.11.2021.11.26.02.12.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:12:18 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 04/49] x86/entry: Use swapgs and native_iret directly in swapgs_restore_regs_and_return_to_usermode
Date:   Fri, 26 Nov 2021 18:11:24 +0800
Message-Id: <20211126101209.8613-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

swapgs_restore_regs_and_return_to_usermode() is used in native code
(non-xenpv) only now, so it doesn't need the PV-aware SWAPGS and
INTERRUPT_RETURN.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 68e697acefac..44774cc5bcc9 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -608,8 +608,8 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 
 	/* Restore RDI. */
 	popq	%rdi
-	SWAPGS
-	INTERRUPT_RETURN
+	swapgs
+	jmp	native_iret
 
 
 SYM_INNER_LABEL(restore_regs_and_return_to_kernel, SYM_L_GLOBAL)
-- 
2.19.1.6.gb485710b

