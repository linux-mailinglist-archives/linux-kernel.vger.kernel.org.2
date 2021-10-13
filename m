Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1542C049
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhJMMos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhJMMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:44:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F4C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=25CpRf+MDs6TpGnqPg2LQG77DWwYq5KOBT2rW1Xzan4=; b=Z0bzRMwY4wG8kohKlF9zmZ74tD
        HtWbVR0rDI6NN7LG279ZdCvNXiho9Omk1Bl3nlJgZ2fOGhweSpJHftHF22Lro+wxDohDp7OiqqIEb
        oApgmnPDYOZBdLAjyXvaowc5Wc09rPKikU7blDrahdi5Mlfrn9CXvtgNCq1HErHjNUP1OltzUI8W9
        fI4QWQDCQa0Z0d7proGsDBniaxjlceTShw3kZSXBBIMUYzRP6i7QdLkS3V6bhoutfCyF8i1Lmwk7s
        TO1IPVl742A5Nzq6a5BDef+5aqN6lS4xbDS7aIOZ4IJYbCkFbQVAHDMG/wbvda59Ea3XcUpNWGfIl
        pAXE+dNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1madYM-007QZR-82; Wed, 13 Oct 2021 12:40:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9CEC30072B;
        Wed, 13 Oct 2021 14:40:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9CE842083A874; Wed, 13 Oct 2021 14:40:13 +0200 (CEST)
Message-ID: <20211013122217.304265366@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 13 Oct 2021 14:22:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH 0/9] x86: Rewrite the retpoline rewrite logic
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches rewrite the way retpolines are rewritten. Currently objtool emits
alternative entries for most retpoline calls. However trying to extend that led
to trouble (ELF files are horrid).

Therefore completely overhaul this and have objtool emit a .retpoline_sites
section that lists all compiler generated retpoline thunk calls. Then the
kernel can do with them as it pleases.

Notably it will:

 - rewrite them to indirect instructions for !RETPOLINE
 - rewrite them to lfence; indirect; for RETPOLINE_AMD,
   where size allows (boo clang!)

Specifically, the !RETPOLINE case can now also deal with the clang-special
conditional-indirect-tail-call:

  Jcc __x86_indirect_thunk_\reg.

Finally, also update the x86 BPF jit to catch up to recent times and do these
same things.

All this should help improve performance by removing an indirection.

The series has been booted in kvm using 'debug-alternative spectre_v2=off' and
'debug-alternative spectre_v2=retpoline,amd' on a x86_64
defconfig+kvm_guest.config build. IOW, early days.

---
 arch/x86/include/asm/GEN-for-each-reg.h |  10 +-
 arch/x86/include/asm/alternative.h      |   1 +
 arch/x86/kernel/alternative.c           | 186 +++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/bugs.c              |   7 --
 arch/x86/kernel/module.c                |   9 +-
 arch/x86/kernel/vmlinux.lds.S           |  12 +++
 arch/x86/lib/retpoline.S                |  42 --------
 arch/x86/net/bpf_jit_comp.c             |  18 ++--
 tools/objtool/arch/x86/decode.c         | 126 +++++-----------------
 tools/objtool/elf.c                     |  84 ---------------
 tools/objtool/include/objtool/elf.h     |   1 -
 11 files changed, 246 insertions(+), 250 deletions(-)

