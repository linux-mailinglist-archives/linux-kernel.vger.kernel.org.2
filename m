Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6E6403AA2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351477AbhIHNbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:31:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51038 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349441AbhIHNaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:25 -0400
Message-ID: <20210908132525.154428878@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Hh4i3aUe/x3yNILYS1K+Ms5S7OwNVMUJgDTF4ysAfds=;
        b=ep/xvumdnIVETKqlbalxhkBFG8TKzlg9ySQyJgBlAUuaiJRlZ+TBnLle+RXvbfb3wOetvQ
        3DyogM2gr6u488LZ79Q99LpHmPkkY7ExBJjCu8/sLgs3cvO2h1cAGUouVRqvHSpI6UWXFw
        JIjWlb8wauxOQFNS9bvgp7cdtbc56x1eo0B0dwVQoi7oCCURCD3NWCOKJwV/QI5bT5O6Km
        PaaLpGNnBlja3/mYiAJ1nA/2hC6H/Ds7g/weBrVFERpEIVix1WniNZeSXJ2pJY7lGCOxeb
        Rk+33V7JLc6p2o101AbUorDzieB5nYZERsx5y+g01NZ9ssEje42V2WepFdponw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Hh4i3aUe/x3yNILYS1K+Ms5S7OwNVMUJgDTF4ysAfds=;
        b=JJVeGU910YJrRY+VUSEw2Ffr2oQVgZzlc3VOBdIW0po3rE06QxJx1BkBy/el86B7zdbfpi
        QZmwVROCmFHM2MBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 04/20] x86/mce: Get rid of stray semicolons
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:16 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and the random number of tabs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/cpu/mce/internal.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -61,7 +61,7 @@ static inline void cmci_disable_bank(int
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
 static inline void intel_clear_lmce(void) { }
-static inline bool intel_filter_mce(struct mce *m) { return false; };
+static inline bool intel_filter_mce(struct mce *m) { return false; }
 #endif
 
 void mce_timer_kick(unsigned long interval);
@@ -183,7 +183,7 @@ extern bool filter_mce(struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
 #else
-static inline bool amd_filter_mce(struct mce *m)			{ return false; };
+static inline bool amd_filter_mce(struct mce *m) { return false; }
 #endif
 
 __visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,

