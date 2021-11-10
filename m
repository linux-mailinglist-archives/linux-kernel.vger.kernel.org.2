Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55F444C07E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhKJMCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhKJMCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:02:33 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A29C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:46 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id b68so2430234pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9SEfT4DE6G7poVIoOZ/2F9cmvyRyv0Yaov7+rhnIBU=;
        b=FvzZqtoRPuJ96HdFxbZ070TPkPA+N1wyesrajcAp0bpBz3qAo1/NW0LsvlFj/Foeda
         yKrtnY81VzdKwMapF+7CmSlCMuy4+wNSqLwVcE9G0A/8Umq6IpNF6jblYJWjYH+hiHWo
         /RCktA1dtQsRH5y7HXPI/dro6xp5qW6NUg2Xq0RKSp4ND0XIvixzq4kdL0CGD9hQURRW
         b9DcEDN9jspMVkU1Jymg2JTv+qs1UgClt7TvWUXtjNzdIkECry4Nff0/oJzhloXqhCAO
         3/a0UZuDWlSGdHoQEBcDB0vlAJ93vYZQ3aJidmoUe8h7r8h/zX90TwXSunryDuJSxvty
         lGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9SEfT4DE6G7poVIoOZ/2F9cmvyRyv0Yaov7+rhnIBU=;
        b=ymATt/cGOwupfZiqT/jM3Kerdmdg4N0t4RZ4MKUe5PJ5cRP+PZDR6Et0Y1eYCvvS+R
         0erJkTLRFaz5fr7Dm3FX7IV8WQVKDNGX9H4rYGtToswZKSHdwLDYR/dC87zhf2qkKBqW
         RZvrma/Pfhfuw3F+rxGpqxm9bw5HJyu52K5h/Vkzim+ZePVSJ9UkTEOssbS5HTXugfQe
         DAWdpsPG3B2gSkGJgfek/EnnvPbU+VgZeep/w7K5edSX4kXpAU/nqtUdl+T81vTfKKGI
         WkVRDWl/Xd5RYeT7IiCSihI61yP4G23wHyRJJJYaUPAG6nr5notvtGTDvhkUvk/Ss2Ke
         dBEg==
X-Gm-Message-State: AOAM530/0QqtxIWB9PYZ6StOeoq5MNuhdDQQogvl6r9TNSE5BKQAl3pu
        JPGgyxp9cILmBDp7Qwg2weiKzU6uaMI=
X-Google-Smtp-Source: ABdhPJzKjAa9q/y1ix1CgtDel8UNShHIygeqPwUrb2lFZocBDmhzy7lE2r0hp04rUGUQB9+wXg4nxA==
X-Received: by 2002:a63:ff04:: with SMTP id k4mr11188732pgi.309.1636545585915;
        Wed, 10 Nov 2021 03:59:45 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id lw1sm6007564pjb.38.2021.11.10.03.59.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:59:45 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 22/50] x86/entry: Don't call error_entry for XENPV
Date:   Wed, 10 Nov 2021 19:57:08 +0800
Message-Id: <20211110115736.3776-23-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index 74c82fb01d36..2f3883d92536 100644
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

