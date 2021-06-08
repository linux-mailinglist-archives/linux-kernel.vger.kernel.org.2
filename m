Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD37A39F98C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhFHOv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhFHOvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:51:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0A0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 07:49:27 -0700 (PDT)
Message-Id: <20210608144345.611833074@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623163766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CBEz8EtGB1j5/hXrPA9GuF+DD9wd49Octi/TMCaU+ls=;
        b=vJTAVmzXju4pvmwTvuEh3+39OuCk3w9KmAsR4T5QGg5Y1zt1TyinoxCOToa8IhfGs+Nevj
        zfsLuCdm+AcQusVUyNTzzU7oI6FMNPouP3qs1vRa814wC/7r2sgQbyt0DF6JfRgBfoLdl0
        4w5UYDxpXtQXzjbN/NkdzpE016pmpJ8oiS0hJb7gbyOY/HzdpAgyj75OcozXweVmBnBTPz
        bkwCUnhJPqWReWZwPrwRbFuMWpsewsKt1vP1D0bqy1PjXqtEYEUnTpcFA15TjEjYtfF8GL
        N0CSnhcAWc4ueb0BliyUO6UKWyRI7Mmp4D/J8Z6PbzeA1wkwEMcucwW35du8/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623163766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CBEz8EtGB1j5/hXrPA9GuF+DD9wd49Octi/TMCaU+ls=;
        b=KFz6wEr5lpG8JdVbaeCqoXr2/xWDCdpJ3JTP5/hSJJQU59Ti601q5iRID8JVchB7m/I0mR
        skDyfvBqPyydC+CA==
Date:   Tue, 08 Jun 2021 16:36:18 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Rik van Riel <riel@surriel.com>
Subject: [patch V3 1/6] x86/fpu: Prevent state corruption in __fpu__restore_sig()
References: <20210608143617.565868844@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The non-compacted slowpath uses __copy_from_user() and copies the entire
user buffer into the kernel buffer, verbatim.  This means that the kernel
buffer may now contain entirely invalid state on which XRSTOR will #GP.
validate_user_xstate_header() can detect some of that corruption, but that
leaves the onus on callers to clear the buffer.

Prior to XSAVES support it was possible just to reinitialize the buffer,
completely, but with supervisor states that is not longer possible as the
buffer clearing code split got it backwards. Fixing that is possible, but
not corrupting the state in the first place is more robust.

Avoid corruption of the kernel XSAVE buffer by using copy_user_to_xstate()
which validates the XSAVE header contents before copying the actual states
to the kernel. copy_user_to_xstate() was previously only called for
compacted-format kernel buffers, but it works for both compacted and
non-compacted forms.

Using it for the non-compacted form is slower because of multiple
__copy_from_user() operations, but that cost is less important than robust
code in an already slow path.

[ Changelog polished by Dave Hansen ]

Fixes: b860eb8dce59 ("x86/fpu/xstate: Define new functions for clearing fpregs and xstates")
Reported-by: syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: stable@vger.kernel.org
---
V2: Removed the make validate_user_xstate_header() static hunks (Borislav)
---
 arch/x86/kernel/fpu/signal.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -405,14 +405,7 @@ static int __fpu__restore_sig(void __use
 	if (use_xsave() && !fx_only) {
 		u64 init_bv = xfeatures_mask_user() & ~user_xfeatures;
 
-		if (using_compacted_format()) {
-			ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
-		} else {
-			ret = __copy_from_user(&fpu->state.xsave, buf_fx, state_size);
-
-			if (!ret && state_size > offsetof(struct xregs_state, header))
-				ret = validate_user_xstate_header(&fpu->state.xsave.header);
-		}
+		ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
 		if (ret)
 			goto err_out;
 

