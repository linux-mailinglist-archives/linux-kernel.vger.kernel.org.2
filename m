Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402C144C06A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhKJMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhKJMAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:00:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B2CC0613F5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:57:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gt5so1387817pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uyLPfAzs2DoYRMmcB7KZNzhGl4NvtcXg7b4XumBbQ08=;
        b=kYVjvoMYCJk2mMHPGYyKsqInZzDlr0d9JPBakLNjDcSBR6QWCOL5GSJ+upw8T3Zig3
         rta7n5H0+3y/3lSA+qz4i8H+qWxLyk4QxJNHEMt/8pHsEGNBkRD4r1myVtgMEfrx4aXf
         K41dGAFJMU8xSwk+qcgDEwKmZdMxNqw26y17t0JMVP9XwKjBMAOReuCp0phLbu5I1Sms
         6nGohfhajpgV7t7jI2vFXqs8mwrmQG3/W3uupjIupOXjNrmcrtc1OahJn/zSH6DBgfrN
         FPf9ioQq1n6VKztxXiJI1lwdxPEBFZ4LMIqI1aqjKLpdmO/TXBrS54DMWT4gVdoAiGHy
         tHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyLPfAzs2DoYRMmcB7KZNzhGl4NvtcXg7b4XumBbQ08=;
        b=7Dpm5KVTHHu2MhmejeTa7HwSYZ4PY4cV9D0QAvg9tPkSILPlAI8V0x+CKTDHMyaPpN
         ztR1vyfcdU9YlAHC6BdR/ddPJPew3A3hYLiM+HaH12FUawXkLq8400JOhclbA1GF+D7H
         6dlOBSu6Zg8iwdmEDSGxlaPgrau66rcZ6SPggjoHpZ6jyz5q0byYeKc9Vgx+YjHCY/gS
         jcsL70u5ZB84LNJva/0xKvKfsH96Zmqpp2FyYrRSgUwv6UdedZWlfY/auM1yF5XXhrtw
         oa8Vp4rRisHcbah8tq3uW7/wq07kNUTeE8/eTsv7PlemKIpGiKpQKLqzD1fA1qlkFDGl
         0Xww==
X-Gm-Message-State: AOAM5305pYnq0iMtxkg/kaFy8lLm2XnqJoqonau9LC1mKKbnGhMu2Sme
        11xJ317lx8ofkV++D711IGzuIXneXAo=
X-Google-Smtp-Source: ABdhPJwIPCoqcKyBxGmLDT10vT0yAJ89igbXjbMaRF970YCAWjSGbRuX+AxGKYJqRONwJI1TLxcpyQ==
X-Received: by 2002:a17:902:b084:b0:141:f5f8:1c5a with SMTP id p4-20020a170902b08400b00141f5f81c5amr15331009plr.40.1636545478908;
        Wed, 10 Nov 2021 03:57:58 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id rj6sm6264681pjb.0.2021.11.10.03.57.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:57:58 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 05/50] x86/entry: Use swapgs and native_iret directly in swapgs_restore_regs_and_return_to_usermode
Date:   Wed, 10 Nov 2021 19:56:51 +0800
Message-Id: <20211110115736.3776-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index ebcc17e1d7f1..fb977d958889 100644
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

