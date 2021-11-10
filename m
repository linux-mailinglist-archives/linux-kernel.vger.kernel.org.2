Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC444BE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhKJKTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbhKJKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A6CC061205
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+dU5EO3hst6mVf3NedC9Cb8mm5I1FPC3Tbk5qecEMJA=; b=DNYSZTAWZ+H5yHXmVRa8l4SE8O
        WaWyJTsJPxklB63d1PUWtVbOKxeY4olWevvpMgip+O1K1gV/XwvupSlW/NHXOK/qHDZHOC3VymnwE
        B7G7WVU5do23yM76SJh9ZImvihYwaArLREeFGOaPtN4mZR9Z2r2iUnfcClxvindAjIk4kJiJBZ/7v
        MdMpGdu0RpIogqgZwM8CqB/4cgLMcHF3qbBd8+pm0llBlPeEQLKMqqYclTLXI48EVDldYZ7Xkxhyn
        oOJ5AP666ViKdSiZ5hnho2UHoOKe1rRPnIf7NiKN82LKTBvEQLydTzis5Y4eqZ8UAhpuwHlVdbEEr
        HD9/6JpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeG-00FFpc-97; Wed, 10 Nov 2021 10:16:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7473C3000A3;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 591A820189CA9; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110100102.250793167@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 00/23] x86: Remove anonymous out-of-line fixups
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


Also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.extable


Changes since v1:

 - Dropped using __cold on labels, because clang. Also gcc doesn't actually
   generate different code with it. The intent was for the code to end up in
   .text.cold but that doesn't happen.
 - Fixed the vmread constraints to disallow %0 == %1.
 - Added a asm-goto-output variant to vmx's vmread implementation.
 - Audited Xen and FPU code and converted them from -1 to -EFAULT,
   as a concequence EX_TYPE_NEG_REG no longer exists.
 - Fixed the EX_DATA_*_MASK macros to include an explicit 'int' cast,
   such that FIELD_GET() will sign-extend the top field.

---
 arch/x86/entry/entry_32.S                  |  28 ++-----
 arch/x86/entry/entry_64.S                  |  13 ++-
 arch/x86/entry/vdso/vdso-layout.lds.S      |   1 -
 arch/x86/include/asm/asm.h                 |  33 ++++++++
 arch/x86/include/asm/extable.h             |   6 +-
 arch/x86/include/asm/extable_fixup_types.h |  50 ++++++++++--
 arch/x86/include/asm/futex.h               |  28 ++-----
 arch/x86/include/asm/insn-eval.h           |   2 +
 arch/x86/include/asm/msr.h                 |  26 ++----
 arch/x86/include/asm/segment.h             |   9 +--
 arch/x86/include/asm/sgx.h                 |  18 +++++
 arch/x86/include/asm/uaccess.h             |  39 ++++-----
 arch/x86/include/asm/word-at-a-time.h      |  66 ++++++++++-----
 arch/x86/include/asm/xen/page.h            |  14 +---
 arch/x86/kernel/cpu/sgx/encls.h            |  36 ++-------
 arch/x86/kernel/fpu/legacy.h               |   6 +-
 arch/x86/kernel/fpu/xstate.h               |   6 +-
 arch/x86/kernel/vmlinux.lds.S              |   1 -
 arch/x86/kvm/emulate.c                     |  16 +---
 arch/x86/kvm/vmx/vmx_ops.h                 |  43 +++++++---
 arch/x86/lib/checksum_32.S                 |  19 +----
 arch/x86/lib/copy_mc_64.S                  |  12 +--
 arch/x86/lib/copy_user_64.S                |  32 +++-----
 arch/x86/lib/insn-eval.c                   |  66 +++++++++------
 arch/x86/lib/mmx_32.c                      |  86 +++++++-------------
 arch/x86/lib/usercopy_32.c                 |  66 ++++++---------
 arch/x86/lib/usercopy_64.c                 |   8 +-
 arch/x86/mm/extable.c                      | 124 ++++++++++++++++++++++-------
 arch/x86/net/bpf_jit_comp.c                |   2 +-
 include/linux/bitfield.h                   |  19 ++++-
 tools/objtool/check.c                      |   8 +-
 31 files changed, 477 insertions(+), 406 deletions(-)

