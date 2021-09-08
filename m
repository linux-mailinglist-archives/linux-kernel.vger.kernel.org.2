Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892E1403AAD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351812AbhIHNbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:31:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51108 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351432AbhIHNad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:33 -0400
Message-ID: <20210908132525.445255957@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=U5xM49pdLb5dSGIBKozT2XtRlv1dw1hHJxy+JQJj3ek=;
        b=4rnjx2AETuzm9KWxuP9ioQpX7gYlczGVQ9C8YNC1z1linRjkrADimzYnjihSFRNjqQY1LG
        uAeuu25CFzRzSLgQkEn226a4TceLcsGMMhLuiB5FDVxEWUfdZPq0abxntaaw6odyFn9FN9
        F2U96SGnJ1hVHU6221Ic6HglfxQFXe6douzgadJ6Y5YTsvnGPhC2Dn7nWA2r/Zb/bMpJNB
        1w2ISL/x17yIaQurbr7Y8T0wztTM6hPFZWTsxgNNbmvvQUVt5DuBsEgS9QxFdU3xWnIsOQ
        Ek6UfZuIX6qandaZbNPDo87xzPACOQAAkZcIFeuWz+xrHnzrn8Gkp4pFJQe0nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=U5xM49pdLb5dSGIBKozT2XtRlv1dw1hHJxy+JQJj3ek=;
        b=lDTRldDbiKB4VzlA6MMkpnJ8mPKnyYhWjjkVPwBnZVGJE2u0W7ZXBMznUVbajLLm4IBc3o
        XtmkQUKNdmp1dLAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 09/20] x86/extable: Remove EX_TYPE_FAULT from MCE safe fixups
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:24 +0200 (CEST)
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

