Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84D3ACED4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhFRP1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:27:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56732 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbhFRPXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:23:12 -0400
Message-Id: <20210618143451.217774510@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=88dRg3kAphcDYCyKUbz0ku2MO/LIcKQhueya46CMhW4=;
        b=clgM5JyKfgBE/0NZxkVDHoFNK67yEpc9Qo0A/y8Gbyk7HmsaT1K0Y/fom+A2eD7x+TcbTS
        4IUq7sv0DxEkk1w5AC5ZzR8B7kxXFJxKkLe8NHWL3g1cCVnB2/I/nCE2Ee0JFct8wrIX7v
        EvEVpzoUupNQiK/msQ9mjycpd3Tsh+iLx3M4mp1HJSI6l4ifzlyPpBpgdhFJHLI035KqFI
        t1Qe/93tPixwFxYTaXYeh5ScGUojEiGFTziDOwbqLbBqcTHiWfXGDyK0LJEjKUdFb6Hamt
        2BhnbEgdrTa8WzBbrEb62SMGR16Mpgs4holvshbq96z0QD6FbljEwrWZURJTCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=88dRg3kAphcDYCyKUbz0ku2MO/LIcKQhueya46CMhW4=;
        b=M4PvOM5ZfPkdrrbz80zW5L0qXm25vf0ANB5ylTgPBBM1A5/YZBhCgxUMgtUlDkGhCXFuEm
        CxMzZQnhBrd4L3Cg==
Date:   Fri, 18 Jun 2021 16:19:23 +0200
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
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V3 60/66] x86/fpu/signal: Remove the legacy alignment check
References: <20210618141823.161158090@linutronix.de>
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

