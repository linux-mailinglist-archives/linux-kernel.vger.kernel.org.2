Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B524457D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhKDRD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhKDRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:03:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6126C061205
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DwoMpHGjdQb598azbBWqeqDTuF2F/75/Ij32BwQVCmI=; b=tcXPvIlgpcKWyPQRsILeGpmBUa
        ul9/AYUOZZfUjMyjAE5CI8h1lzQ9WAkhxdhz8B5K+18acxNG13q6fUyaTciLfBvwUECtJLlUAb1PI
        cw1VHjNzvQVLLJwnABWpPnKN0ywM3NQRnOgEl1tQDWpV41nVCYCNtk++LgxPsCNZxN7Q1nFfOgHsU
        FhU9joyqvAkMUCBCy4oOgdp6+aQpJNjmb1l0xI2no7I9sKMEpwJdPf4wRLftiVVMFfwC888wq02tK
        xXjjsVliUKTEyIZ9R8MoTCGecALAMzcVrar62K90vpGREmeQvFcR11wAYnRjSMppF7N7bQwGo7qC1
        6Ls1lYCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2V-0060FF-LR; Thu, 04 Nov 2021 16:57:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32D633005CB;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0C28A2DD49FB3; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104164729.226550532@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 00/22] x86: Remove anonymous out-of-line fixups
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Direct counterpart to the arm64 series from Mark:

  https://lkml.kernel.org/r/20211019160219.5202-1-mark.rutland@arm.com

Since he already put it rather well:

"We recently realised that out-of-line extable fixups cause a number of problems
for backtracing (mattering both for developers and for RELIABLE_STACKTRACE and
LIVEPATCH). Dmitry spotted a confusing backtrace, which we identified was due
to problems with unwinding fixups, as summarized in:

  https://lore.kernel.org/linux-arm-kernel/20210927171812.GB9201@C02TD0UTHF1T.local/

The gist is that while backtracing through a fixup, the fixup gets symbolized
as an offset from the nearest prior symbol (which happens to be
`__entry_tramp_text_end`), and we the backtrace misses the function that was
being fixed up (because the fixup handling adjusts the PC, then the fixup does
a direct branch back to the original function). We can't reliably map from an
arbitrary PC in the fixup text back to the original function.

The way we create fixups is a bit unfortunate: most fixups are generated from
common templates, and only differ in register to be poked and the address to
branch back to, leading to redundant copies of the same logic that must pollute
Since the fixups are all written in assembly, and duplicated for each fixup
site, we can only perform very simple fixups, and can't handle any complex
triage that we might need for some exceptions (e.g. MTE faults)."



So far these patches have only been compile tested on x86_64
(defconfig,allyesconfig) and boot tested in kvm (defconfig) -- realy early
days.

Enjoy..

---
 arch/x86/entry/entry_32.S                  |  28 ++---
 arch/x86/entry/entry_64.S                  |  13 ++-
 arch/x86/entry/vdso/vdso-layout.lds.S      |   1 -
 arch/x86/include/asm/asm.h                 |  27 +++++
 arch/x86/include/asm/extable_fixup_types.h |  44 ++++++--
 arch/x86/include/asm/futex.h               |  28 ++---
 arch/x86/include/asm/msr.h                 |  26 ++---
 arch/x86/include/asm/segment.h             |   9 +-
 arch/x86/include/asm/sgx.h                 |  18 ++++
 arch/x86/include/asm/uaccess.h             |  35 +++---
 arch/x86/include/asm/word-at-a-time.h      |  29 ++---
 arch/x86/include/asm/xen/page.h            |  12 +--
 arch/x86/kernel/cpu/sgx/encls.h            |  36 +------
 arch/x86/kernel/fpu/legacy.h               |   6 +-
 arch/x86/kernel/fpu/xstate.h               |   6 +-
 arch/x86/kernel/ftrace.c                   |   9 +-
 arch/x86/kernel/vmlinux.lds.S              |   1 -
 arch/x86/kvm/emulate.c                     |  14 +--
 arch/x86/kvm/vmx/vmx_ops.h                 |  14 ++-
 arch/x86/lib/checksum_32.S                 |  19 +---
 arch/x86/lib/copy_mc_64.S                  |  12 +--
 arch/x86/lib/copy_user_64.S                |  32 ++----
 arch/x86/lib/mmx_32.c                      |  83 +++++----------
 arch/x86/lib/usercopy_32.c                 |  66 +++++-------
 arch/x86/lib/usercopy_64.c                 |   8 +-
 arch/x86/mm/extable.c                      | 166 ++++++++++++++++++++++++-----
 include/linux/bitfield.h                   |  19 +++-
 27 files changed, 385 insertions(+), 376 deletions(-)

