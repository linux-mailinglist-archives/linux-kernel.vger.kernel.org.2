Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BEB45EB5F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376770AbhKZK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376760AbhKZK0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:26:12 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9CFC0613F1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:09 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so9564974pjc.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1BGZRfXfMSY4o4kXP4qoPOMxY6wXNm1SmD8FQmrwJoE=;
        b=QAeHO0nKtumssCDIX5lZbS27AMG401Tv9XidV7o3suOGOAMxbL25Zcz9OzQYJua2xV
         qdVma7GDLp+Sf6EQwfUQAfFnYle5zVnQcE6yEgz52fjE6Zt4cVLBSaM3uTXsmsFcbTmG
         8JvTrEc1Vd0Rh5vwszWUVdo8CudZaGkdYLzkT2GrhPnw1SgYwx0ESU4wbHxU/xmfDDCK
         6JdyIL4XI/cWyGL/4KRhnRUNE4WVAR94uTW1RUWHWuspw9yJP4m0ihcad3rfKKd8ssJs
         a2R4lOl0xp340zSNtQZ4YQtFxyH45t4Uf28UNBHgMkjmJ4uBD4/6f69W28VZUnDJHn7P
         KpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BGZRfXfMSY4o4kXP4qoPOMxY6wXNm1SmD8FQmrwJoE=;
        b=DuXnvubOUfF3gfrN74Y4r1qx4hEIR3D7glmErL9+ftQIZLIXPfkfj4Of15gf5nW8O8
         eo6c6Ab7ncSGmNizkV3sbxXbGe4IHegnV4CM5FZrwQ++QlHxKWZXpjNYAgdZ27zEGD3Y
         F3ReWtjei2gSbsbYfyl+AkIH7SfD8Wuew0RtXEM/xl5zhqwKyYaPd1UvAaQtdVnHi8Kp
         NhCicgGKdo9ba4j7LdM72WK+UaOhnbr8o5x356fsGvNCL1cQfAfvUBrOcRxsnIx+1aqX
         9oI5R2EHp5coD4mMse2nfxUkcATx51kkm9WJyzmiL0IS6iSOqdFnLaMx73WlSgWFgzds
         Aztw==
X-Gm-Message-State: AOAM532QFENu25BDvxR9xAf6B5mDsbcWyjt3qWGEsjuNt5z41/6ZrI7f
        ijNxkiVMfvFh4nI3pP44VF5Ipiaa+kY=
X-Google-Smtp-Source: ABdhPJxn8Z9OXUYYQbfZbnYuIwDGsupK6eUQMq2gPeATLyaShdIWZZnAHOjegx3aIV1mko9Jmk5A/g==
X-Received: by 2002:a17:90a:fe87:: with SMTP id co7mr14512495pjb.21.1637921649196;
        Fri, 26 Nov 2021 02:14:09 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id a2sm4719057pgn.20.2021.11.26.02.14.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:14:08 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 21/49] x86/entry: Don't call error_entry for XENPV
Date:   Fri, 26 Nov 2021 18:11:41 +0800
Message-Id: <20211126101209.8613-22-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

When in XENPV, it is already in the task stack, and it can't fault
at native_irq_return_iret nor asm_load_gs_index_gs_change since
XENPV uses its own pvops for iret and load_gs_index().  And it
doesn't need to switch CR3.  So it can skip invoking error_entry().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 09bd77e49249..c09e5a4dfbbf 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -325,8 +325,17 @@ SYM_CODE_END(ret_from_fork)
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
-	call	error_entry
-	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
+	/*
+	 * Call error_entry and switch stack settled by sync_regs().
+	 *
+	 * When in XENPV, it is already in the task stack, and it can't fault
+	 * at native_irq_return_iret nor asm_load_gs_index_gs_change since
+	 * XENPV uses its own pvops for iret and load_gs_index().  And it
+	 * doesn't need to switch CR3.  So it can skip invoking error_entry().
+	 */
+	ALTERNATIVE "call error_entry; movq %rax, %rsp", \
+		"", X86_FEATURE_XENPV
+
 	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
-- 
2.19.1.6.gb485710b

