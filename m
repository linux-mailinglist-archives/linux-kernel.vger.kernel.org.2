Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E10D402FA3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346648AbhIGU0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:26:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45836 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346598AbhIGU0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:26:02 -0400
Message-ID: <20210907200848.757498280@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=U5xM49pdLb5dSGIBKozT2XtRlv1dw1hHJxy+JQJj3ek=;
        b=vdOb3B94uaQ6D5vdO4GrdIwN0ZNsKolr5RscJSoVIctxBh5ahZ+FSF9I6qCr8LOVc99mfi
        uJ5YAdG10jrCDYySW/O2X/64YdjlZGYCpSpj8d4mMOuO2NvTnefPjULtWbYBsiTPLMq0BY
        m44SnSfVzFzU8NsPJAvmUWiDq1n+YQnYkidqU7IALHznIsr+kzwDQxBX7Y+E64NotyX7B2
        /pwHWjCUFmgJAysWWIc1hMXEowrGc7xYWLwk/A3azwhEZPu4BVkN09UmyiW8CIjOGjRe7K
        q1CRbQodh+sLLOsRC7J5M8Pkmfj5wZjDHEljT3o5yw87RKrNNFuuACFmWWIE4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=U5xM49pdLb5dSGIBKozT2XtRlv1dw1hHJxy+JQJj3ek=;
        b=6yD10BSvdrg2eIj+CmXhyVQLEbHZLOvpe5csZEI3bOCa2CjviWb0apJWhv0V2+zv8gnpMR
        fdJjri/UoRtJfJDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 09/20] x86/extable: Remove EX_TYPE_FAULT from MCE safe fixups
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:24:54 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the MC safe copy and FPU have been converted to use the MCE safe
fixup types remove EX_TYPE_FAULT from the list of types which MCE considers
to be safe to be recovered in kernel.

This removes the SGX exception handling of ENCLS from the #MC safe
handling, but according to the SGX wizards the current SGX implementations
cannot survive #MC on ENCLS:

  https://lore.kernel.org/r/YS+upEmTfpZub3s9@google.com

The code relies on the trap number being stored if ENCLS raised an
exception. That's still working, but it does not longer trick the MCE code
to assume that #MC is handled correctly for ENCLS.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/cpu/mce/severity.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -277,7 +277,6 @@ static int error_context(struct mce *m,
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		fallthrough;
-	case EX_TYPE_FAULT:
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;

