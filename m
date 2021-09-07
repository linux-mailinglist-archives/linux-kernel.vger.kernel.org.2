Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268C7402F9E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346566AbhIGU0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:26:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45754 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346502AbhIGUZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:25:54 -0400
Message-ID: <20210907200848.471344869@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Hh4i3aUe/x3yNILYS1K+Ms5S7OwNVMUJgDTF4ysAfds=;
        b=UdLx19NZeq2PiiXZwlPCliEBjrZMDyvfw3Usb6L64djaVH+rL7ctu7t1cKNBEnXMGTUaeR
        A4CBg6JvQT5uX+wkyFy5xKaqaCMWYGpx8D4OLP9GYfAmMqVy+ZWpjx54iMOd+lQQY2Khc5
        NibtwkdlB8WrLbBG0BWjsnfydkKA0FkUiKcAKGbqmy5S/rPvudzY9NZlpju7i2ruoyYuQi
        3z82itOBJXI0oBZ7uoFzLmeT5cGQbstOZmFGDgido1tZWCFNeyjrigISVyn/c7nIcClkKi
        fTWUyurH8q0C9NU259JU+vLTp8iswsZ+1/JqIWqxtbDRO6oUUdVKB/MqS4tG2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Hh4i3aUe/x3yNILYS1K+Ms5S7OwNVMUJgDTF4ysAfds=;
        b=nMXO/X9UDB2L2e5V5ZkacItD296wYa6mkdArwVBay9cWXhcR3XTYX3a5QOO8s+DAKs1xNE
        nqyA+Y4I3lbh/FDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 04/20] x86/mce: Get rid of stray semicolons
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:24:46 +0200 (CEST)
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

