Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7123B100E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFVW2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:28:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:42834 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230013AbhFVW2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:28:00 -0400
IronPort-SDR: Mjd6RI1Z939a88c7zpL0wVqiTZT2Ltkbn1DpDpE51qhC22sUMR1awEHYdw1NZMM6Ykh+b4AmAl
 0GrjmKUesj7Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="205326073"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="205326073"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:25:44 -0700
IronPort-SDR: l/2YXcZIURD4o4Mz8p7B9GgFYO6mzupeXtmpv8/Lii3Yi7ndbLUqPRyV4pM9pjUFP/Z5jhG50m
 6atJVNRTCPfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="444756931"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 22 Jun 2021 15:25:43 -0700
Subject: [RFC][PATCH 2/8] x86/fpu: hook up PKRU into signal user ABIs
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 22 Jun 2021 15:24:59 -0700
References: <20210622222455.E901B5AC@viggo.jf.intel.com>
In-Reply-To: <20210622222455.E901B5AC@viggo.jf.intel.com>
Message-Id: <20210622222459.9C76B034@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

One nice thing about having PKRU be XSAVE-managed is that it gets naturally
exposed into the XSAVE-using ABIs.  Now that XSAVE will not be used to
manage PKRU, these ABIs need to be manually enabled to deal with PKRU.

For signals (the restore_hwregs_from_user() path), it's quite
straightforward.  restore_hwregs_from_user() will update PKRU in from
the user signal buffer.  Ensure that PKRU is shuffled into the thread
storage.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---

 b/arch/x86/kernel/fpu/signal.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff -puN arch/x86/kernel/fpu/signal.c~fpu-sig-stash-pkru arch/x86/kernel/fpu/signal.c
--- a/arch/x86/kernel/fpu/signal.c~fpu-sig-stash-pkru	2021-06-22 14:49:07.899051760 -0700
+++ b/arch/x86/kernel/fpu/signal.c	2021-06-22 14:49:07.903051760 -0700
@@ -233,6 +233,13 @@ static int restore_hwregs_from_user(void
 
 		if (!ret && unlikely(init_bv))
 			os_xrstor(&init_fpstate.xsave, init_bv);
+
+		/*
+		 * PKRU may have been modified by XRSTOR,
+		 * save the possibly updated value:
+		 */
+		current->thread.pkru = read_pkru();
+
 		return ret;
 	} else if (use_fxsr()) {
 		return fxrstor_from_user_sigframe(buf);
_
