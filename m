Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E865845EB94
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377166AbhKZKci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377383AbhKZKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:30:36 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C34C0619EF
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:17:05 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u80so8478154pfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3k4gSJ33r79TSQiVuZoKLnQbBRVyUbIZwLYjfwd7qo=;
        b=YAuGyleOn3cBILgh9QROOqMwx1Bi4clROI8T7kXlUXscyiPOnSx0rrt4ylIZXh9ufB
         m/0JLkmXX/F4UEm5ARwb+dUuO6FgeUi6ieFJChKKxCplmP0yyWKGGG+sgomMOWvUNFDs
         6kY46D6RwvtCPm5P/80Hg5tdTLfklsGr8jiZfOi603xeaUxyfAPBlk/3pWkgoQ10ybTB
         wlE37QYIg+v33ojVxaZr6Di5Tapu97L942NhjP/y1IaGKNPIOmXERLHVEbSRvgCdMlhZ
         4aeEi7kH112aZH1YyBOfCFmZYPvJXbXT6u7s+icKHw2JWtMrEHFr458BWqBsSm2iSUKJ
         uC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3k4gSJ33r79TSQiVuZoKLnQbBRVyUbIZwLYjfwd7qo=;
        b=k54bMF0IbNOgDTGhz4GvQwNqqaYpWrD+DMpfsBLXxhnCGUOYhavAnrWYmScDDgPlRP
         6UwOFjHEufEoMAyEZufB6dMe21erR2qDrNz0QljKHhNfIkItrappPahU5OYxd4jaQ+DG
         xWARUitc4c1pRMlRBlqhddA66T5gCHVNERHLT3lTDcFh6sXitCXaf/P0Fw7zgb2uitM6
         79oFVbGF+1NJqLcSApV65lvu2vuTTkIez7jt+8ZLKZPgnKzKPNyrKQXUjzHVCixPh7bt
         YFg4/YBvi4mTOkd29k0oj1dVw9JPhRkBjy3aquB/wHOni5jdBeFkP+AMGn13Bg7pbgZ4
         4oGA==
X-Gm-Message-State: AOAM532lOwr3UBz6rfYUB6Pc2ry8TGg+HQb3RAb9/oycXWSNPHt2ipGH
        6piJqIKnw/qawnYMCEQZRoxz1ZCN6qc=
X-Google-Smtp-Source: ABdhPJzwgKiiullqVbRhS9xBYu7NPblZXgQ4ZRLW3k0MNwWUqXyty42lskZZArsaradI8Sd8bgWnyA==
X-Received: by 2002:a05:6a00:a24:b0:4a7:ea06:5e7e with SMTP id p36-20020a056a000a2400b004a7ea065e7emr13953929pfh.41.1637921824804;
        Fri, 26 Nov 2021 02:17:04 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id pg13sm5645831pjb.8.2021.11.26.02.17.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:17:04 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 48/49] x86/entry: Remove save_ret from PUSH_AND_CLEAR_REGS
Date:   Fri, 26 Nov 2021 18:12:08 +0800
Message-Id: <20211126101209.8613-49-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

PUSH_AND_CLEAR_REGS is never used with save_ret anymore.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index d42012fc694d..6f9de1c6da73 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -63,15 +63,9 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
-	.if \save_ret
-	pushq	%rsi		/* pt_regs->si */
-	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
-	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original return address) */
-	.else
+.macro PUSH_REGS rdx=%rdx rax=%rax
 	pushq   %rdi		/* pt_regs->di */
 	pushq   %rsi		/* pt_regs->si */
-	.endif
 	pushq	\rdx		/* pt_regs->dx */
 	pushq   %rcx		/* pt_regs->cx */
 	pushq   \rax		/* pt_regs->ax */
@@ -86,10 +80,6 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%r14		/* pt_regs->r14 */
 	pushq	%r15		/* pt_regs->r15 */
 	UNWIND_HINT_REGS
-
-	.if \save_ret
-	pushq	%rsi		/* return address on top of stack */
-	.endif
 .endm
 
 .macro CLEAR_REGS
@@ -114,8 +104,8 @@ For 32-bit we have the following conventions - kernel is built with
 
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
-	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
+	PUSH_REGS rdx=\rdx, rax=\rax
 	CLEAR_REGS
 .endm
 
-- 
2.19.1.6.gb485710b

