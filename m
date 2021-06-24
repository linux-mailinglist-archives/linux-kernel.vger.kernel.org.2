Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0893B3252
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhFXPLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFXPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:11:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2137DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 08:09:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624547359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FTPlyZZs2FifZdWVdfP+4lRr0rUdIdp2WuY312j4FxU=;
        b=dWm5bAU5Yi8VXV54HsAgewZPVFT1A7YVHCbV8escPtdtiL1VVZWIA18mVnbFPDYVLD7edG
        9D7bj6UUVO4hYYLjMGnN6vblJK5vQnLrbWqHVRmjgf9owdzP2OdM4I0/X0Xtx6kk+5RKPI
        AZphiR61J3EEm3MoyDzsFJKw0xLnEwNyctZPnU54B9rQDD8AvwzOADDdvXtQdNKN8GOXxf
        fDLyXAo7la+xnow8i5DiG821HY1wG1njpHeCmyhoo1pDtEbaHt8iicEu5quS2AB3CA/FyY
        +9vKU1aFpVYr9cMjrnrw1U9rLDjImj8CpJ3kskayGx47TvFRkS5od3U5svXqtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624547359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FTPlyZZs2FifZdWVdfP+4lRr0rUdIdp2WuY312j4FxU=;
        b=aMFOn1Si3DEwaZA2o/cCytSgjlbAzhjoympaByADi3+VuzjxGevC84wyC75t5/gq33jUu+
        93n1ZubSIGJKpIDA==
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
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH] x86/fpu/xstate: Clear xstate header in copy_xstate_to_uabi_buf() again
In-Reply-To: <20210623121452.805327286@linutronix.de>
References: <20210623120127.327154589@linutronix.de> <20210623121452.805327286@linutronix.de>
Date:   Thu, 24 Jun 2021 17:09:18 +0200
Message-ID: <875yy3wb8h.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change which made copy_xstate_to_uabi_buf() usable for
[x]fpregs_get() removed the zeroing of the header which means the
header, which is copied to user space later, contains except for the
xfeatures member random stack content.

Add the memset() back to zero it before usage.

Fixes: eb6f51723f03 ("x86/fpu: Make copy_xstate_to_kernel() usable for [x]fpregs_get()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
Changelog summary: I'm a moron.
---
 arch/x86/kernel/fpu/xstate.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -982,6 +982,7 @@ void copy_xstate_to_uabi_buf(struct memb
 	unsigned int zerofrom;
 	int i;
 
+	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
 
 	/* Mask out the feature bits depending on copy mode */
