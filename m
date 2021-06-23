Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556D53B19E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhFWM0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:26:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36406 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhFWM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:02 -0400
Message-Id: <20210623121452.120741557@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=PNXAB1DnDnyL1GTBuJIqwadxQuJx7h6oBO7+UdmwpTs=;
        b=4uWb61FX4KC/JKQ3reaQUR01bLmbswiEUc41w8cpu6JKjGVJt17UwbExF6hqxN8ZupjypF
        oNnuTBMWUjDcQXn9S/IvJRgk21oxyNlLhftinz2ck/PrQwgusVTPY37JQJGdL8Tov8cNOr
        VFuQ8z9deF8j7lVHKIowCQ1JO/hKts2gYpVfouxpkE5HCwbVESm7pZKQVy4Y92Mf6tH4jW
        7WZPpS/ZU98YyfIK2LAmHeIy51n/HlUNOcfPfItejgSdBNH/RJCN8k6TVNgefNc/dKJoC7
        rMmfR4a6Ejrfstea+ECTZ4oqxgIXoC5vy2SAUtGfl81FAMg3mpzr+QIhreLd9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=PNXAB1DnDnyL1GTBuJIqwadxQuJx7h6oBO7+UdmwpTs=;
        b=RUxkMcpvv/6sTDlofdXLU9OjrdZqxEnlW1krXI3LFJq2/FldeLDvoDyAfZrOMBEaknSvxk
        6qFZF6Zi88kGaWCw==
Date:   Wed, 23 Jun 2021 14:01:35 +0200
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
Subject: [patch V4 08/65] x86/fpu: Limit xstate copy size in xstateregs_set()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the count argument is larger than the xstate size, this will happily
copy beyond the end of xstate.

Fixes: 91c3dba7dbc1 ("x86/fpu/xstate: Fix PTRACE frames for XSAVES")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/fpu/regset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -117,7 +117,7 @@ int xstateregs_set(struct task_struct *t
 	/*
 	 * A whole standard-format XSAVE buffer is needed:
 	 */
-	if ((pos != 0) || (count < fpu_user_xstate_size))
+	if (pos != 0 || count != fpu_user_xstate_size)
 		return -EFAULT;
 
 	xsave = &fpu->state.xsave;

