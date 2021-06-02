Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2AA398658
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhFBKVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhFBKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:20:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE80C061763
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:18:00 -0700 (PDT)
Message-Id: <20210602101618.951757144@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622629079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=U3EXUQXIWt8Z7bf3sCDWIfygCwU+xyRyr6nZHBGoxuc=;
        b=mf45JTuiey6rgip/X00DVZiRcxISzSr+MVLuqdZ0gc7TjA4IpYp9N4eJqmXFKoEPBK4PAY
        xi3ca7eu99x0Fwdk7V8nS4v+jv6v8KyFmuDWoOlGpxscwlso6E9la7Pw/eqUK2PMF2Gpda
        rWA7rwlw3MocZrJQ1jURk017AOukYWUXjGyPVBG0gxW7snZSW/qv07MBEDwWfbITdOH5WR
        vgJYk96NPbUOpjXV1WIF75HEfXQfvgqwpa/sFbCmcz3L7KVAyBdrBqghS+M4uEKcscZ7Dx
        y5LRXxDWm+x7iui/gwN7rnmfrEcKMu15R5NNBiP0mAAlvDhSobLVD3O4IxDo5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622629079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=U3EXUQXIWt8Z7bf3sCDWIfygCwU+xyRyr6nZHBGoxuc=;
        b=lAv7WiabgOfgJj8nItT/TRW2/I61DrIfQAKFr4uxcD4pA7U6P6Vba6gpjxocrHh7kKumZz
        /gZLqjq6envNahBg==
Date:   Wed, 02 Jun 2021 11:55:49 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [patch 6/8] x86/fpu: Add address range checks to copy_user_to_xstate()
References: <20210602095543.149814064@linutronix.de>
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
@@ -1192,7 +1192,7 @@ int copy_user_to_xstate(struct xregs_sta
 	offset = offsetof(struct xregs_state, header);
 	size = sizeof(hdr);
 
-	if (__copy_from_user(&hdr, ubuf + offset, size))
+	if (copy_from_user(&hdr, ubuf + offset, size))
 		return -EFAULT;
 
 	if (validate_user_xstate_header(&hdr))
@@ -1207,7 +1207,7 @@ int copy_user_to_xstate(struct xregs_sta
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
-			if (__copy_from_user(dst, ubuf + offset, size))
+			if (copy_from_user(dst, ubuf + offset, size))
 				return -EFAULT;
 		}
 	}
@@ -1215,7 +1215,7 @@ int copy_user_to_xstate(struct xregs_sta
 	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
 		offset = offsetof(struct fxregs_state, mxcsr);
 		size = MXCSR_AND_FLAGS_SIZE;
-		if (__copy_from_user(&xsave->i387.mxcsr, ubuf + offset, size))
+		if (copy_from_user(&xsave->i387.mxcsr, ubuf + offset, size))
 			return -EFAULT;
 	}
 

