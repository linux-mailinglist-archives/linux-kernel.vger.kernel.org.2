Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76644C07C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhKJMCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhKJMCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:02:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D3C06127A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:35 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h24so1387167pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36XClLZ06aeeubGT8B6C1WVEO+u7AKNM4KdddyrAuXk=;
        b=D9B0re7r6KLKargTngu3SiDpGNy664NXbQjhugUSFeR/GKJjXY+O0GM1TtgH+aQth8
         mBndXyeW34YTJCcpWAAQx4TsoPVL45CEHcPGWmUC6pIJJwIsOLo54E4bnwe49QzzJs3/
         sVSM2zOqvhdsA14ip/6fwqQzxPadqBlvYzAt/fxDjzeuPAUIB0500dMzjH0zkmUUZ3cy
         zIH73lRWzC727AWVVg1OIhZqorPaWQE4JzEipjn6R23RP+SFiG+SU/267miUZ8kvKkk+
         N9bWen5BOJboiPBAYvvvbV+2PZyv2HkiCF5hNxovEnPQHGZmnPwYg3uR3A/06+h+GkXn
         SlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36XClLZ06aeeubGT8B6C1WVEO+u7AKNM4KdddyrAuXk=;
        b=0fb9AKAS03Qrg6EVrHsuOFJtjPU8Bg9u+z3qbmhY5mGj5JulhRWSk+l7RAu47v/7NF
         D+ZWzXJefmwxf+HLJjY9gvgBB6Z1SZfdcR852O/C3EWU08zyDbH4ZLtIkYcN6BS94J0e
         rofWmWu0Laen+0dT3fsLMQsdv1Pd183LY4JX6Eq9dwlVIE+yk6Cyb53zq8A1l6S+lUuX
         QBoDRObPoRjB6SUg/hmPGtJYzTCHe0TQbq8Z7sI+ztWwLNH4YvhWx6jVmtO2rooR7yDt
         uIhOSd2U3bL5isBXzvK32qEli/ahk2F3klHRVWpu+LRj9G9dONU+ib8Sb2pg4kIwm86Z
         ZshQ==
X-Gm-Message-State: AOAM532PaFbWgEq1oiyScLBlD0AG6Ps5gzMKv872m/9k67hkTu5KSa7e
        LsjPAhCzotenyb+h4gruZvJJaT/5DQE=
X-Google-Smtp-Source: ABdhPJzuthFMt/1L48nb8bLhKmINUH7eQLDwgxgfCaTrf+4Yo0+kJaix+CNt7exko3beFMqpvyZw7g==
X-Received: by 2002:a17:902:e851:b0:142:19fe:982a with SMTP id t17-20020a170902e85100b0014219fe982amr14953010plg.13.1636545574677;
        Wed, 10 Nov 2021 03:59:34 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id m18sm6731405pfk.68.2021.11.10.03.59.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:59:34 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 20/50] x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
Date:   Wed, 10 Nov 2021 19:57:06 +0800
Message-Id: <20211110115736.3776-21-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Moving PUSH_AND_CLEAR_REGS out of error_entry doesn't change any
functionality.  It will enlarge the size:

size arch/x86/entry/entry_64.o.before:
   text	   data	    bss	    dec	    hex	filename
  17916	    384	      0	  18300	   477c	arch/x86/entry/entry_64.o

size --format=SysV arch/x86/entry/entry_64.o.before:
.entry.text                      5528      0
.orc_unwind                      6456      0
.orc_unwind_ip                   4304      0

size arch/x86/entry/entry_64.o.after:
   text	   data	    bss	    dec	    hex	filename
  26868	    384	      0	  27252	   6a74	arch/x86/entry/entry_64.o

size --format=SysV arch/x86/entry/entry_64.o.after:
.entry.text                      8200      0
.orc_unwind                     10224      0
.orc_unwind_ip                   6816      0

But .entry.text in x86_64 is 2M aligned, enlarging it to 8.2k doesn't
enlarge the final text size.

The tables .orc_unwind[_ip] are enlarged due to it adds many pushes.

It is prepared for converting the whole error_entry into C code.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3667317f6825..25c534b78eb7 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -322,6 +322,9 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry_body cfunc has_error_code:req
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	call	error_entry
 	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
 	ENCODE_FRAME_POINTER
@@ -976,8 +979,6 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
-- 
2.19.1.6.gb485710b

