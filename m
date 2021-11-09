Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F96344B464
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244840AbhKIVCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 16:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244824AbhKIVCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 16:02:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282FFC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 12:59:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b15so1663758edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 12:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nwv0m4xMy6rcDly9b4tseviIYMgTp7EhMlAQy6WgOQc=;
        b=qZN5FaaXj1NUIsjheR/aiScazy+Ks9pFqXnSCCgWTFwzutNN4kfqcfZW01K0BDByzp
         nodUmozoObp5Q0vvlGH0lVfhPH3cFQwybcpLbHSEotlYUSnucYKlKg3guDe25Qdf1RoD
         ClqYqb7d5a7a6JkML54o4yYxu8WhnxN9Mo4nWpb2jwMn+Lg9vDdJMkU8rmxyPrqP+AUH
         NV2QsHgjYgEV25ST8OddmLA9DM5v+3RTApzbGJsq2ERe+NlsDpgvFvgrdJY6dymCGKtD
         U0UXEgP1D+txm1+0TyJYj5kK7QaHcP7/NHTqeL7NnsVM1EF6Y3VNfr68fiU100zeni6I
         KpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nwv0m4xMy6rcDly9b4tseviIYMgTp7EhMlAQy6WgOQc=;
        b=GzMu7oforCceJ+EdIA/9uLoiWooxAK97jNqz/JTyrFuwCv2zkRGGZtDgq5zZzAICCm
         MuPNbBZbqh8CkvXD4SqWViQN2ptKxXNSd+IxnACm6s2D7Lx+lJJbDETXVu+LuXJi/DvP
         oe12O2J8jMmgRVjL2CLhr2900lIf2A8fqDsEuqepvxUpvHXwxI+l1Z5/J/ieggd9mwsZ
         z9R+W7DCn6KY6hZ80uorL8+htZUtpjfXzxdCqF3v642011LnIleKQfSi5sTFmMQfM2/l
         weGyOvOQQjJWtMmU45O7DZe7zu3pN4rRg26PS9eac5b3GhgxfZSC57s1qBp8vswnxS5x
         P1Sw==
X-Gm-Message-State: AOAM531ysLRgkWvTNMDFj01Wi/nDSDluLgwvJmFUTFzwSjIKosxaJaI3
        Q6M8V64w+eQnOyQC8E58KSpmG3nbku2e0S/W3Fxs
X-Google-Smtp-Source: ABdhPJxw+7uaX1WL/f3bKWUKLvm246qDutbruCLff6B+k7UyD7B0Z1pF/46X4lS+MuapuHcpyd3nAdjbEeL7BynuKZw=
X-Received: by 2002:a17:906:4fcd:: with SMTP id i13mr14262201ejw.472.1636491563429;
 Tue, 09 Nov 2021 12:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20211105171023.989862879@infradead.org> <20211105171821.654356149@infradead.org>
 <20211108164711.mr2cqdcvedin2lvx@treble> <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
 <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com>
 <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net> <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
In-Reply-To: <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 9 Nov 2021 12:59:12 -0800
Message-ID: <CAGG=3QVecQroYbJ05AGk2f0pe=QOtWuZHyQowzG0i7os8E9fdg@mail.gmail.com>
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz, llvm@lists.linux.dev,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 11:22 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Nov 9, 2021 at 12:23 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 08, 2021 at 10:53:31AM -0800, Nick Desaulniers wrote:
> > > On Mon, Nov 8, 2021 at 10:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Mon, Nov 08, 2021 at 08:47:11AM -0800, Josh Poimboeuf wrote:
> > > > > On Fri, Nov 05, 2021 at 06:10:43PM +0100, Peter Zijlstra wrote:
> > > > > > +static inline unsigned long load_unaligned_zeropad(const void *addr)
> > > > > > +{
> > > > > > +   unsigned long offset, data;
> > > > > > +   unsigned long ret;
> > > > > > +
> > > > > > +   asm_volatile_goto(
> > > > > > +           "1:     mov %[mem], %[ret]\n"
> > > > > > +
> > > > > > +           _ASM_EXTABLE(1b, %l[do_exception])
> > > > > > +
> > > > > > +           : [ret] "=&r" (ret)
> > > > > > +           : [mem] "m" (*(unsigned long *)addr)
> > > > > > +           : : do_exception);
> > > > > > +
> > > > > > +out:
> > > > > > +   return ret;
> > > > > > +
> > > > > > +do_exception: __cold;
> > > > >
> > > > > Clang doesn't approve of this label annotation:
> > > > >
> > > > > In file included from fs/dcache.c:186:
> > > > > ./arch/x86/include/asm/word-at-a-time.h:99:15: warning: '__cold__' attribute only applies to functions [-Wignored-attributes]
> > > > > do_exception: __cold;
> > > >
> > > > /me mutters something best left unsaid these days...
> > > >
> > > > Nick, how come?
> > >
> > > Looks like https://bugs.llvm.org/show_bug.cgi?id=47487.
> >
> > Indeed it does. So what do we do? Keep the attribute and ignore the warn
> > on clang for now? Even if techinically useless, I do like it's
> > descriptive nature.
>
> I think the feature of label-attributes is generally useful, for asm
> goto (without outputs) and probably computed-goto, so I think we
> should implement support for these in clang.  I suspect the machinery
> for hot/cold labels was added to clang and LLVM before asm goto was;
> LLVM likely has all the machinery needed and we probably just need to
> relax or adjust clang's semantic analysis of where the attribute may
> occur.
>
> With the above patch, we'd still have issues though with released
> versions of clang, and -Werror would complicate things further.
>
> I think the use of this feature (label-attributes) here isn't
> necessary though; because of the use of outputs, the "fallthrough"
> basic block needs to be placed immediately after the basic block
> terminated by the asm goto, at least in LLVM.  Was different ordering
> of basic blocks observed with GCC without this label attribute?
>
> _Without_ outputs, I can see being able to specify which target of an
> asm-goto with multiple labels is relatively hot as useful, but _with_
> outputs I suspect specifying the indirect targets as cold provides
> little to no utility.  Unless the cold attribute is helping move
> ("shrink-wrap"?) the basic block to a whole other section
> (.text.cold.)?

Adding attributes to labels shouldn't be difficult, as you mention. In
the case of cold/hot, it's adjusting some of the metadata that already
exists on some basic blocks. It might be enough to allow the normal
block placement algorithms to move the hot and cold blocks around for
us. The question becomes how many attributes does GCC allow on labels?

-bw
