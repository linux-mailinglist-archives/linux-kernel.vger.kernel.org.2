Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A545F11B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354119AbhKZP4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:56:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52042 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354201AbhKZPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:54:42 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 10:54:42 EST
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E655F622B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8C9C93056;
        Fri, 26 Nov 2021 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637941587;
        bh=b4Kjpba7B4xdXA8ajrnoUEksRT03kaVzqIxfFUFKJXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKZG9ESne8pWqAxsEJ+5ZAaDepKcPTxEnLNpkf26h/dHGDVxqRy8MZGaLybxpjiwk
         jvMQF2fyGTLzM1X9np+lB6lEoEav71s+JcOXkj69cT1CX0CfsAis+lpSTL+dFpkBY6
         VYO5Pqmf8z1ToJtsT+aB0TNqjFjvIzKiayn06F0PVKsjjMpqQUSYMcKqoZlKJZJKVF
         75Ab/iZg7aD0I7lbFnNRiusm3pj89RspCjLZGmjsQTAT36bF56gzajhzb+GtW5aaan
         WIJSZeNKiHCRmXQrOW+WXW5nDBUIBJb7LGGiVCTuMKNtAErKL5r6QEAUzDzZnLmh2N
         96VfjGqO4hq5g==
Date:   Fri, 26 Nov 2021 08:46:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anders Roxell <anders.roxell@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: mm: radix_tlb: rearrange the if-else block
Message-ID: <YaEBTbjGyUBmISGK@archlinux-ax161>
References: <20211125154406.470082-1-anders.roxell@linaro.org>
 <6b1e51a8-2f4d-2024-df90-a35c926d7a30@csgroup.eu>
 <CAK8P3a0n_n+PnfYmAdS9923yheLqYXRp8=65hKf9abLCRAX8ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a0n_n+PnfYmAdS9923yheLqYXRp8=65hKf9abLCRAX8ig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 02:59:29PM +0100, Arnd Bergmann wrote:
> On Fri, Nov 26, 2021 at 2:43 PM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> > Le 25/11/2021 à 16:44, Anders Roxell a écrit :
> > Can't you fix CLANG instead :) ?
> >
> > Or just add an else to the IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) that
> > sets hstart and hend to 0 ?
> 
> That doesn't sound any less risky than duplicating the code, it can lead to
> incorrect changes just as easily if a patch ends up actually flushing at the
> wrong address, and the compiler fails to complain because of the bogus
> initialization.
> 
> > Or just put hstart and hend calculation outside the IS_ENABLED() ? After
> > all GCC should drop the calculation when not used.
> 
> I like this one. I'm still unsure how clang can get so confused about whether
> the variables are initialized or not, usually it handles this much better than
> gcc. My best guess is that one of the memory clobbers makes it conclude
> that 'hflush' can be true when it gets written to by an inline asm.

As far as I am aware, clang's analysis does not evaluate variables when
generating a control flow graph and using that for static analysis:

https://godbolt.org/z/PdGxoq9j7

Based on the control flow graph, it knows that hstart and hend are
uninitialized because IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) gets
expanded to 0 by the preprocessor but it does not seem like it can piece
together that hflush's value of false is only changed to true under the
now 'if (0) {' branch, meaning that all the calls to __tlbiel_va_range()
never get evaluated. That may or may not be easy to fix in clang but we
run into issues like this so infrequently.

At any rate, the below diff works for me.

Cheers,
Nathan

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 7724af19ed7e..156a631df976 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -1174,12 +1174,10 @@ static inline void __radix__flush_tlb_range(struct mm_struct *mm,
 		bool hflush = false;
 		unsigned long hstart, hend;
 
-		if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-			hstart = (start + PMD_SIZE - 1) & PMD_MASK;
-			hend = end & PMD_MASK;
-			if (hstart < hend)
-				hflush = true;
-		}
+		hstart = (start + PMD_SIZE - 1) & PMD_MASK;
+		hend = end & PMD_MASK;
+		if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hstart < hend)
+			hflush = true;
 
 		if (type == FLUSH_TYPE_LOCAL) {
 			asm volatile("ptesync": : :"memory");
