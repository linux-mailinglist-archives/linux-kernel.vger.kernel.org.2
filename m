Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1A343B431
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbhJZOdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbhJZOdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:33:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A760C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:30:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id t184so14549370pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NquEC0oc8qAgKVZRz/dm1+f35RYA3XM4ByaTUaAorok=;
        b=Kg1ymFDRZxwrj2Xbp+PfPILSwFO0XLIH656yvwz2AgqQjsMuzGFZsZ83ttpWFfJ0R+
         nxcaUuUiaQAZtbIhuWF5oxZok1vJtb9TbhXtir38Y/jXAebB88GiMB8olfu0OOMp5W7O
         ug9DIHntq876f/DFwiSyWoGmNteLqzihNOJtaHMigaKEVmPUYjRHj2VzCei+459jnp2z
         vwIQt+oyzdqXGb8ZQ079+3xwcFfw6HlLO9eEk4ACyuFTKk8hHwSsCbt3fF3khFBdwk5G
         +XFz2FotpT6wq8KyWuFktDn5eC8yI22FhpiCC/0LdRo7uM88bvptvlzj/8pYKoZn8whu
         tDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NquEC0oc8qAgKVZRz/dm1+f35RYA3XM4ByaTUaAorok=;
        b=wjsH4xjFfXm33eA/PuLIPmEijydYoGFp0c12VLLdpGWfkpDbpeOVWMH75FAjvQhrVk
         rOlN/bM8ztm4TtvnmMKgfvX307BCpZzElOY2gANNgHmBqDh/+nOTqtowYcQvtosjSTrb
         0aXr+2coZFImL8CcXXMHS+8qhaCg/eHniv0feI1j9kvS8SCtgcwxp1Glod0fQtsJBVow
         obfYYgmZrxv94N0vtmQ9I0xZq2XqaIsHjcBAXZ280Yo1Nd6JwhhN8TiFJfxdc9lQqajR
         ZKNA1vL6peQ4abz9W3vtzYIISvTb4zx780tm+hqXlCXOpN52gsOR6tLK/Lddxdsl1EvU
         q6gg==
X-Gm-Message-State: AOAM5336yHwOd4dkSuNIeGoCV8yu+B0zF2vCKPi1+CffGBg3vhrhKQ8k
        HoM5ckwhMNhgh4j7nQrfPKerBSRGVus=
X-Google-Smtp-Source: ABdhPJxMki/vC5GM4sUYaoso1OQo3LdcNm7B+9xOTw8IPIyBZWfpNCmpwTKeJYT0rgzcGU15WAccZA==
X-Received: by 2002:a63:8ac7:: with SMTP id y190mr11124582pgd.55.1635258643611;
        Tue, 26 Oct 2021 07:30:43 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id il17sm1085323pjb.52.2021.10.26.07.30.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:30:42 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 22/50] x86/entry: Don't call error_entry for XENPV
Date:   Tue, 26 Oct 2021 22:30:04 +0800
Message-Id: <20211026143032.18624-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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

