Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5842D151
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhJNEB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 00:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhJNEBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 00:01:16 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43117C061753
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:59:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id v8so179551pfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3k4gSJ33r79TSQiVuZoKLnQbBRVyUbIZwLYjfwd7qo=;
        b=GlSLP8OqgIXrpiZ04cyzPLmmsn/AlssQ787nYJiJQnFgDOprnY642JOUa+rME6tM8n
         bEF51/knJnLpJV933YJluN3Co8SVwMcWBHHxRUFeHFEalSfMTqYf5dRa9BmAqvkE9zLf
         yKb1HFvp9xWwYbhhBtDbcYfpJ5U3kaHseggW+afD6k6kVK09tEIB0xmPKpK6a2HCuGH4
         xo3cWp1C0nSuoymq9Jlo7iMYU+JYhH9M0fQ08poJsqCorSZ098xiWCKdxxkwV73ekI3C
         BlGLA2hQsDBPa+sMhbnNLbiVP1Sn+SEmwW5pcoCCINtgkxIA+Io9PAV0Ct7NUUJekIvX
         D6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3k4gSJ33r79TSQiVuZoKLnQbBRVyUbIZwLYjfwd7qo=;
        b=nx4sxmKl2VuPC9WKyvVFdQhojzvbQiePM4F0bjs+FJwdJdme0ux5cMKRIHuZXXK+XI
         HyXoWbhmPPY+gp0M+IqGHykqVnWKH+7z90A8fPKsr/aCqMpMIQp7J+EWHUDBrNG/NXyo
         +DcVyxbFZpUvGZvLyqSbxa0+nddZB9DD/80mXrGmV2DULxbP0vTjhO1nfKCKOC1CSnC5
         hujme27O2x7OIwy/vlTlakZ1c65/ze9MYOGmql7OrPvA/STPhI3dGLO968FFqkbrVq9G
         R8pxRtvO+0c0iiq4dK0x4OCGqDTiE3XsNO+Pg6MGyCOPq0vStJEtstEcNuLWd8u7/oN0
         wQ1w==
X-Gm-Message-State: AOAM532n0LzyXsGvQQRMWRM2UxPTi031zwz5PVTGlryqPhLdOZWxD4Bg
        1t59GCpkaDJS0cEsrAigcGsqxOBydLE=
X-Google-Smtp-Source: ABdhPJzVBsRqDf/l6oY/KU4GeaB2EhmIhyIuQy4SdC6xu7lq4GZ232CC1Rk6i5BAwUjdfJd+QuzuHg==
X-Received: by 2002:a62:1d08:0:b0:44c:6f89:85ef with SMTP id d8-20020a621d08000000b0044c6f8985efmr3336220pfd.42.1634183951660;
        Wed, 13 Oct 2021 20:59:11 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id m186sm885042pfb.165.2021.10.13.20.59.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:59:11 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 48/49] x86/entry: Remove save_ret from PUSH_AND_CLEAR_REGS
Date:   Thu, 14 Oct 2021 11:58:34 +0800
Message-Id: <20211014035836.18401-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

