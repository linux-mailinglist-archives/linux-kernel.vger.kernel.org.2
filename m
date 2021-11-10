Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FD744C0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhKJMF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhKJMFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:05:10 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC11C061210
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:10 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id x7so1349617pjn.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGQkFZFv6iLNz+AgBObU8TJtLC36Dblt2PWOGF4W7Pg=;
        b=BrS4fSag2QQCMFojWTA3l5c+58cqLDYdKs4buMW/r03nEA7QSMmnKN6YLprVcUEnMv
         Tbr3Owu5B6HJFxNJqLUO2b0aCzpBc/Vh/vaH9cm3znUTiDHPnrnbHcGk2dYdZQiUwbzH
         QKRDxP/0bG6tt6X8KFkTGrHLKR3Pe4iaxQfqYYIjHb23US4SI6MKRoxw+togNuE5w09N
         w7UnrWUeL6fIMDTY/SbQ6820VqB0kHW9cw2h/qkUepiv1Ko5j07BAtmq9ju14FldmhTG
         bJIHjZxVlM5gBS8JmGJ4N8egqrUY92d5rZHAqnFMSH4mBlaCfOeAnt8PEvZf0FowB5In
         9Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGQkFZFv6iLNz+AgBObU8TJtLC36Dblt2PWOGF4W7Pg=;
        b=yoLoOzAPKfep292l5hgauVH6F/gYcUNAwQgCLU1LR6VEH9ibZREAgNpeuU3rCr2LBt
         ZsIhLdffVEFsHM8R+6qRkcVPvVKEM4ePW1I7hScvX+dxlGPkmPEV7qUV4dA8/HY/9dby
         gsy4YhbWLJPx5MVdeaD3/umuVfBolfi+8G2ZKptWx7WEz7naWuHwzIJrNRBechq6Guxr
         oXsGBXWexHAbWdd5kpte2MFJGSL+IhpxsvOKiWvqetRkQfmbCNJB4rVgNTmJkhf38gPP
         J9ckGaGL2KwOP/XC/pGQpq09Z2Th8bOwQiWUAGo2wN5D3LvzdryXcFGwj4idR/2PXHbc
         wV5Q==
X-Gm-Message-State: AOAM530gA/WL4xPJPK9dNbFllLnCcvFUUF6J83FiT7INaVTm3vXqkdoN
        d9QFrJe4uyFoHm9rHV3g++pDKjHdbvY=
X-Google-Smtp-Source: ABdhPJylr/0MEtJ2P+7sRDpE3uMpLqPreDUDpLoKlIEDGVnRWkOW6Z60y+iRBL9n2cwtALAIpikgXQ==
X-Received: by 2002:a17:90a:fe1:: with SMTP id 88mr16498797pjz.24.1636545728455;
        Wed, 10 Nov 2021 04:02:08 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id gc22sm5361279pjb.57.2021.11.10.04.02.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:02:08 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V5 44/50] x86/doublefault: Use C entry code
Date:   Wed, 10 Nov 2021 19:57:30 +0800
Message-Id: <20211110115736.3776-45-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE to emit C entry function and
use the function directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S       | 12 ++----------
 arch/x86/include/asm/idtentry.h |  1 +
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c4cc47519a11..9def3d2cedb7 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -574,16 +574,8 @@ SYM_CODE_START(\asmsym)
 	PUSH_AND_CLEAR_REGS
 	ENCODE_FRAME_POINTER
 
-	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
-	call	paranoid_entry
-	UNWIND_HINT_REGS
-
-	movq	%rsp, %rdi		/* pt_regs pointer into first argument */
-	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
-	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
-	call	\cfunc
-
-	call	paranoid_exit
+	movq	%rsp, %rdi		/* pt_regs pointer */
+	call	ist_\cfunc
 	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index c57606948433..931b689f464c 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -415,6 +415,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
  * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
  */
 #define DEFINE_IDTENTRY_DF(func)					\
+	DEFINE_IDTENTRY_IST_ETNRY_ERRORCODE(func)			\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
 
 /**
-- 
2.19.1.6.gb485710b

