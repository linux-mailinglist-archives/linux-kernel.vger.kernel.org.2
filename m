Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D963B1A23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhFWMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhFWM3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:29:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C1C0611C1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:48 -0700 (PDT)
Message-Id: <20210623121457.184149902@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2xnDEzfuK4uA75KaGYXgp4SlvM471XICWsK27G9NzOU=;
        b=nKxwHizubZz8cOnpWmQQjK6mk2nKoZlwKrF7v2Pt4f43c0XxGzoRZt8xTuz/swXrveM87E
        KmE8z0Wa0kaFnS98BJ7uX79O8yDOaTY00IOil73PgpT7nSSqijfbckf10XZ1mH+VORIF4i
        gyEXShQa9vv452wk+liJ1fMlD7LVQnA5f+c2FXvxitysZwrIo1rsTU+omw8mev6wfo29vf
        glpjBp9COdyspANZOUt7JDfIy8L1SgLubtn7UCTgPwixS/sMJzGURjL3gFtpwl1rF+ICeQ
        XZlilfLzIQOU3D9vV1aAaHIXdKoA+c4R0Mf5BZHvrtV1oVxPYt1Hn9gKacoewg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2xnDEzfuK4uA75KaGYXgp4SlvM471XICWsK27G9NzOU=;
        b=4icO2c0GrGJMk5so9UvMcgTZhXTPDKBuSkNmdLixBu1wLNWeA0CQwYm1Hfz6CGaqQRrWxq
        gnUxayjQNhujuoCQ==
Date:   Wed, 23 Jun 2021 14:02:26 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 59/65] x86/fpu/signal: Remove the legacy alignment check
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking for the XSTATE buffer being 64 byte aligned and if not deciding
just to restore the FXSR state is daft.

If user space provides an unaligned math frame and has the extended state
magic set in the FX software reserved bytes, then it really can keep the
pieces.

If the frame is unaligned and the FX software magic is not set, then
fx_only is already set and the restore will use fxrstor.

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/fpu/signal.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -306,9 +306,6 @@ static int __fpu_restore_sig(void __user
 		}
 	}
 
-	if ((unsigned long)buf_fx % 64)
-		fx_only = 1;
-
 	if (!ia32_fxstate) {
 		/*
 		 * Attempt to restore the FPU registers directly from user

