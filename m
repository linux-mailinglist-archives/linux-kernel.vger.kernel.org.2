Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0BC3B1012
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhFVW2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:28:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:18298 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhFVW2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:28:08 -0400
IronPort-SDR: oqycNp9X+xkFfmXQAKnyHauukT9+Y2wmgN9ymsgw2JPZO2pqvj+d+gNS6S93M2aTEpU6NisocY
 o1sQmoHUljyA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194459949"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="194459949"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:25:51 -0700
IronPort-SDR: 8h1ivEevCcvcvKasuE7E3vjioywbSQBgHnl3WN/kInbDe+bfu7cl3ImusDRpE/WuXGKVzyG1zG
 jirLmmK4LayQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="480949400"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2021 15:25:51 -0700
Subject: [RFC][PATCH 6/8] x86/fpu: update xstate size calculations for non-XSAVE-managed features
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 22 Jun 2021 15:25:06 -0700
References: <20210622222455.E901B5AC@viggo.jf.intel.com>
In-Reply-To: <20210622222455.E901B5AC@viggo.jf.intel.com>
Message-Id: <20210622222506.487B6DF3@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Now that PKRU will no longer be XSAVE-managed, it needs to be removed
from the XSAVE size calculations.  get_xsaves_size_no_independent()
currently masks independent supervisor features out of XSS, but PKRU
must be masked out of XCR0 instead.

Also, instead of recalculating XSS (and XCR0), just save and restore
them.  This will be more durable in case there are any future changes
to how they are calculated.  The way it is now, the values must be
recalculated exactly in two separate places.

The save/restore approach also makes the code more obvious.  For
instance, the old code does:

	/* Disable independent features. */
	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());

but the new code does:

	/* Disable independent features. */
	wrmsrl(MSR_IA32_XSS, old_xss & ~xfeatures_mask_independent());

The second is much more obviously correct and the comment could
probably even be removed; it's basically self-documenting.

There is a minor, temporary hack in here.  PKRU is currently not in
xfeatures_mask_fpstate(), even though it is allocated in the fpstate.
To avoid size mismatch warnings, hack it into XCR0 for the size
calculation.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---

 b/arch/x86/kernel/fpu/xstate.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff -puN arch/x86/kernel/fpu/xstate.c~xsave-checks arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~xsave-checks	2021-06-22 14:49:12.547051748 -0700
+++ b/arch/x86/kernel/fpu/xstate.c	2021-06-22 14:49:12.556051748 -0700
@@ -643,14 +643,26 @@ static unsigned int __init get_xsaves_si
  */
 static unsigned int __init get_xsaves_size_no_independent(void)
 {
-	u64 mask = xfeatures_mask_independent();
 	unsigned int size;
+	u64 xfeatures_in_xcr0;
+	u64 old_xss;
+	u64 old_xcr0;
 
-	if (!mask)
-		return get_xsaves_size();
+	/* Stash the old XSAVE control register values: */
+	rdmsrl(MSR_IA32_XSS, old_xss);
+	old_xcr0 = xgetbv(0);
 
 	/* Disable independent features. */
-	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
+	wrmsrl(MSR_IA32_XSS, old_xss & ~xfeatures_mask_independent());
+
+	/*
+	 * *Temporarily* (to be removed in a later patch), ennsure there
+	 * is still space for PKRU in the fpstate buffer even though it's
+	 * essentially unused.
+	 */
+	xfeatures_in_xcr0 = xfeatures_mask_fpstate() | XFEATURE_MASK_PKRU;
+	/* Disable user features which are not kept in the fpstate: */
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, old_xcr0 & xfeatures_in_xcr0);
 
 	/*
 	 * Ask the hardware what size is required of the buffer.
@@ -658,8 +670,9 @@ static unsigned int __init get_xsaves_si
 	 */
 	size = get_xsaves_size();
 
-	/* Re-enable independent features so XSAVES will work on them again. */
-	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);
+	/* Re-enable original features so XSAVES will work on them again. */
+	wrmsrl(MSR_IA32_XSS, old_xss);
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, old_xcr0);
 
 	return size;
 }
_
