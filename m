Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9B344A846
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 09:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbhKII0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 03:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhKII0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:26:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A61C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 00:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BskLLYAxMsHNrt27wmNOvnmIq4JbKwajlWUOHywi+l8=; b=OErLNCCNk4j33BFfFIt6AwZOSV
        ExGneBQwEXTnz7HcpyMec4TQ7Ex445Le8OwhsPNZBPKpt7hxE0VRp6+ZNGGNIKUYZJd28tyLLrueL
        +pkqbhLpN8KfV0rw6tAIEieXBpBHaMl0QTajNGyYzTdjFAV7cAYEFX7B/vZ5/pXWYIZnq+JSLyXCe
        D/z6lKJ1xox9aTvkcCNYvUwW/K8tMgDUQpZDi+KpLDs2+7cjJVornG8YL+lFdVbcs8babgi93vD0J
        hEcAPc4rcP9Otc21w5F4F0K9/AEdZbo7LPWYbN1tiw0G6L81QGnwsWlSKwjoB31+w3ZGAg3+xZsDH
        vZWp45rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMPR-000rcf-BZ; Tue, 09 Nov 2021 08:23:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 949F830003C;
        Tue,  9 Nov 2021 09:23:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51379202CF482; Tue,  9 Nov 2021 09:23:13 +0100 (CET)
Date:   Tue, 9 Nov 2021 09:23:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net>
References: <20211105171023.989862879@infradead.org>
 <20211105171821.654356149@infradead.org>
 <20211108164711.mr2cqdcvedin2lvx@treble>
 <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
 <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 10:53:31AM -0800, Nick Desaulniers wrote:
> On Mon, Nov 8, 2021 at 10:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 08, 2021 at 08:47:11AM -0800, Josh Poimboeuf wrote:
> > > On Fri, Nov 05, 2021 at 06:10:43PM +0100, Peter Zijlstra wrote:
> > > > +static inline unsigned long load_unaligned_zeropad(const void *addr)
> > > > +{
> > > > +   unsigned long offset, data;
> > > > +   unsigned long ret;
> > > > +
> > > > +   asm_volatile_goto(
> > > > +           "1:     mov %[mem], %[ret]\n"
> > > > +
> > > > +           _ASM_EXTABLE(1b, %l[do_exception])
> > > > +
> > > > +           : [ret] "=&r" (ret)
> > > > +           : [mem] "m" (*(unsigned long *)addr)
> > > > +           : : do_exception);
> > > > +
> > > > +out:
> > > > +   return ret;
> > > > +
> > > > +do_exception: __cold;
> > >
> > > Clang doesn't approve of this label annotation:
> > >
> > > In file included from fs/dcache.c:186:
> > > ./arch/x86/include/asm/word-at-a-time.h:99:15: warning: '__cold__' attribute only applies to functions [-Wignored-attributes]
> > > do_exception: __cold;
> >
> > /me mutters something best left unsaid these days...
> >
> > Nick, how come?
> 
> Looks like https://bugs.llvm.org/show_bug.cgi?id=47487.

Indeed it does. So what do we do? Keep the attribute and ignore the warn
on clang for now? Even if techinically useless, I do like it's
descriptive nature.
