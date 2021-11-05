Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3564467B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhKERWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhKERWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:22:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC8DC061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6/N/TJCSOrn8IpQwBu9aix8SzHF76Hp/mWbvCJp+zwQ=; b=BwrxzmGIkUDYY66zNlVFlMeFjX
        4DRv64a3A6f7aXOImmrzn/LPO/61S/xqtJ8cQl7SVNYIBkCQFeldEMdORvlYvoxIodMWpdVA3Ma0K
        MmXm9d07n8SHMCBPhZVas6AgKUjfCW3vRDxHr9zycmEJH5iNojydByn0Fp83Am3nXaEzEctgrI33V
        srbTXFNHvoWkHwRHBP1QM6BgCiGjz3R8P5es/h8rIJX3y/SP56Qe3jFAgava90CIgF6krn/wFdl6d
        ItZVAdPmSme6BO+6h45ZGNVXGgrF7I7nbajm8nEOpT+fiy8fm9Hq25XH7K7ULLp5jiyHJMx0eIBmk
        78qv8E7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sX-00ENAN-Oz; Fri, 05 Nov 2021 17:19:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 569BF300388;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 35A882032195B; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171023.989862879@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 00/22] x86: Remove anonymous out-of-line fixups
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


This time things have been build tested for both i386 and x86_64
(defconfig,allyesconfig) and boot tested x86_64 and even started a guest inside
of that.

Also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.extable

Changes since RFC:

 - rebase to origin/master
 - Fixup missing mmx prefetch and use 3DNOWPREFETCH feature
 - renamed POP_SEG to POP_ZERO, changed size, added comment
 - added found to extable_type_reg voodoo
 - used insn-eval.c copy of pt_regs indexing
 - renamed exception_table_entry::type to ::data
 - renamed macro magic
 - removed ltype from __get_user_asm()
 - dropped ftrace patch
 - simpler kvm patch
 - rewrote all of load_unaligned_zeropad()
 - removed .fixup from objtool

---
 arch/x86/entry/entry_32.S                  |  28 ++-----
 arch/x86/entry/entry_64.S                  |  13 ++-
 arch/x86/entry/vdso/vdso-layout.lds.S      |   1 -
 arch/x86/include/asm/asm.h                 |  33 ++++++++
 arch/x86/include/asm/extable.h             |   6 +-
 arch/x86/include/asm/extable_fixup_types.h |  46 +++++++++--
 arch/x86/include/asm/futex.h               |  28 ++-----
 arch/x86/include/asm/insn-eval.h           |   2 +
 arch/x86/include/asm/msr.h                 |  26 ++----
 arch/x86/include/asm/segment.h             |   9 +--
 arch/x86/include/asm/sgx.h                 |  18 +++++
 arch/x86/include/asm/uaccess.h             |  39 ++++-----
 arch/x86/include/asm/word-at-a-time.h      |  67 +++++++++++-----
 arch/x86/include/asm/xen/page.h            |  12 +--
 arch/x86/kernel/cpu/sgx/encls.h            |  36 ++-------
 arch/x86/kernel/fpu/legacy.h               |   6 +-
 arch/x86/kernel/fpu/xstate.h               |   6 +-
 arch/x86/kernel/vmlinux.lds.S              |   1 -
 arch/x86/kvm/emulate.c                     |  16 +---
 arch/x86/kvm/vmx/vmx_ops.h                 |  14 ++--
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
 31 files changed, 445 insertions(+), 404 deletions(-)

