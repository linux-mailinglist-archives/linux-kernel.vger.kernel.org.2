Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14739F990
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhFHOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbhFHOv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:51:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0586C061789
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 07:49:32 -0700 (PDT)
Message-Id: <20210608144346.140254130@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623163771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/dpFWpqc7GiTa/l9FUU4zdrT19DYvl6o13sS1WRz2bY=;
        b=RJpYdIv/Z0y8jNaiG9SQnY1Zmw6fia98fqdu/XOlgrm7mcuaXAago5n9r47Tnqa+FArN0Z
        uATZSNG6RS0okU8X5bmxZOgtbZfp3QfpLlfZdgX5yh91R2Mtk3D6KBraeYgxji8kEXijbx
        fZiOQ/T4PNtf3QxjmZk6PS133W2BY9ThQQCzsc3LtVm66NwcvpR1JShOb4fujPYqkYFDfo
        HHeP2aRcCa2a7tgFIKpWBuucpPsvSqL1SrPvpgJCxC+UQmWa06Hv9ya6SLK3k16FXtBurF
        TyH2NibFUUVMZv2hUDCfmlss4KYZ88HH+I+VMuWOS90nz6IWhy+mMHpxBwFWLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623163771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/dpFWpqc7GiTa/l9FUU4zdrT19DYvl6o13sS1WRz2bY=;
        b=1LL3+Djd27Jt/9jNWMV5Zdlma047UX5hFvnswYa54pP/IGzQEneRAouciUevk9twf463Qe
        b8CEVhvIwK2qslDg==
Date:   Tue, 08 Jun 2021 16:36:22 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com,
        Borislav Petkov <bp@suse.de>, Rik van Riel <riel@surriel.com>
Subject: [patch V3 5/6] x86/fpu: Add address range checks to copy_user_to_xstate()
References: <20210608143617.565868844@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

copy_user_to_xstate() uses __copy_from_user(), which provides a negligible
speedup.  Fortunately, both call sites are at least almost correct.
__fpu__restore_sig() checks access_ok() with a length of
xstate_sigframe_size() and ptrace regset access uses fpu_user_xstate_size.
These should be valid upper bounds on the length, so, at worst, this would
cause spurious failures and not accesses to kernel memory.

Nonetheless, this is far more fragile than necessary and none of these
callers are in a hotpath. 

Use copy_from_user() instead.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/xstate.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1190,7 +1190,7 @@ int copy_user_to_xstate(struct xregs_sta
 	offset = offsetof(struct xregs_state, header);
 	size = sizeof(hdr);
 
-	if (__copy_from_user(&hdr, ubuf + offset, size))
+	if (copy_from_user(&hdr, ubuf + offset, size))
 		return -EFAULT;
 
 	if (validate_user_xstate_header(&hdr))
@@ -1205,7 +1205,7 @@ int copy_user_to_xstate(struct xregs_sta
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
-			if (__copy_from_user(dst, ubuf + offset, size))
+			if (copy_from_user(dst, ubuf + offset, size))
 				return -EFAULT;
 		}
 	}
@@ -1213,7 +1213,7 @@ int copy_user_to_xstate(struct xregs_sta
 	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
 		offset = offsetof(struct fxregs_state, mxcsr);
 		size = MXCSR_AND_FLAGS_SIZE;
-		if (__copy_from_user(&xsave->i387.mxcsr, ubuf + offset, size))
+		if (copy_from_user(&xsave->i387.mxcsr, ubuf + offset, size))
 			return -EFAULT;
 	}
 

