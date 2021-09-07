Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A54402F35
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346210AbhIGT5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346166AbhIGT51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65079C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:56:20 -0700 (PDT)
Message-ID: <20210907195003.990269162@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hh4i3aUe/x3yNILYS1K+Ms5S7OwNVMUJgDTF4ysAfds=;
        b=dQdDxk3Hon2+2IE+CBKPL2IsWuVYIIPrrhdc5q8RnAbV5/gMoyL8rrqeTgDSVoLa6fvbbe
        la4+Nc9RuyNHISsC/27lAmYr0qQ5cMHfjrRUQc5w1jW3cwm8vCcFQymt5eh+j+8X+VeNJx
        /4Jm8PlWJkDE33HoBUWtETIRruCfIdPOJw6/Sp/pyA5XDvgAgFovzlHPlZeOMmJH4pQnqr
        +KOjsLmw/ksqLObJlV0xz3gPTtGJ3Zsf8f1OXD72DMJvSp0h759mYNBO+kArAtnDrQ7X4r
        D1s9A9MV/VqFQOMaWoEdEcGiv1DNkAOaHF0bwiq9hJVAlJhpwoH8mQ+czRcH9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hh4i3aUe/x3yNILYS1K+Ms5S7OwNVMUJgDTF4ysAfds=;
        b=YeZZDa/QaXSJtv7AtuXHRt/XfV34G/5+ESR5eRbGPEqJoh8jgS0fYtld9uqPPIMw9WqSm5
        j9nQMtUsZUqlIgAA==
3Message-ID: <20210907193229.370353258@linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2 04/20] x86/mce: Get rid of stray semicolons
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Tue,  7 Sep 2021 21:56:18 +0200 (CEST)
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

