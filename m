Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6329C42D10E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhJNDiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhJNDiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:38:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A96C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c4so3210304pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NquEC0oc8qAgKVZRz/dm1+f35RYA3XM4ByaTUaAorok=;
        b=iyLC03mlp3mqVDYSuQ7SRvtOHJUOLGmTQqDjhrQkweAtGOGrV575TkogdFvjlOUSEx
         Dcl6Y6Lu+WdgtqkCtN442y2e9tdRgthO2vwe7CzhCioXC2WPlJJ92n4+Sxy0S0mQ/lct
         Zb+Bp7YNWuSXucJP14RGr071b9BxAT9PcrlUZfF6pL2qNVSZXvqIVP6DMWYDCtzUF3Su
         W4QBkvHcXfYLgJOQ39D1pXgBkzMJ/Oq1ydYwpRCVIhOePLVCl9oXgYB8rOLQ4fvQetKh
         Vy2+BxRM6lzuj2efNzhXV5sCoE6Z9MjXuMLYcoIRqd29hrXY/FbeiZFqWKrXEud+sMUw
         lNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NquEC0oc8qAgKVZRz/dm1+f35RYA3XM4ByaTUaAorok=;
        b=M7N00KHZoM+Fnk3tLIxBY+JasZVgryiGgdRrf/OYmt1vAY4bDZFWVBVwQogxVqdDGL
         HtrAEdlyVrjTqefZQZdM2yHX8p65NgJYpE4y1TzC5R+Do5IjzuAg9skBnz3vcDFe+0SA
         l0eOpZMo0r2e8SGTKMQnFfjh8PwKP8xZhbTUhSypO6ycBGaZWmV65P/ADJ8WvUBV2VZ+
         1vcgeXCNZ6/a24j/gbtWYJcILRpVlCAwKs2nfUg1SKwZxCUpAkwqJcv9bNGquOnHw1f5
         C2xmAkPqFzmGu4ifoWE7WFs3PXRBzsA5a3wlzxPnqqq36THkFHipfFoWBaObcnLXcQaX
         kKtA==
X-Gm-Message-State: AOAM533IpYQhk0OGbnDhAvmfj+MhQbjJkqFs6Uu6AtDkLTGiexensEq6
        FzhsLiRT+VxAvfFm7Bn928dB6YisglI=
X-Google-Smtp-Source: ABdhPJyd3wxCMmRpreYAvOygZrOI49YZNR5ajTdRfX5NM0NdIqR9p7Nl8ZWCj0jtjlVCrhCS26lp6g==
X-Received: by 2002:a17:90a:db51:: with SMTP id u17mr17829323pjx.171.1634182570274;
        Wed, 13 Oct 2021 20:36:10 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id d18sm917143pgk.24.2021.10.13.20.36.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:36:10 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 22/49] x86/entry: Don't call error_entry for XENPV
Date:   Thu, 14 Oct 2021 11:33:45 +0800
Message-Id: <20211014033414.16321-17-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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
index 52a08c4a0171..9bad620553c8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -326,8 +326,17 @@ SYM_CODE_END(ret_from_fork)
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

