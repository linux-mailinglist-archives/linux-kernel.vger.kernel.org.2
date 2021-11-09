Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A2844B325
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 20:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243139AbhKITZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 14:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243085AbhKITZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 14:25:45 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963D2C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 11:22:58 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f18so30012lfv.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 11:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTeGZJ5mCEP4rjaH1FR8eh9LQWGeT0lMm93y8GL6qQU=;
        b=KYUZPzk79CL7IB5cxgxe+oyXu8tTR4QYFh/RAouy55tSIsoGKu/Em/uStLj5KeIitd
         oWKfrzvMkJl9XjMKv+QsasHpxhIQOYAZ7UqO4slJkaojhak3i/B4dwiW4d5WZr2A4T9u
         NX8W3Z1gE05y38dlN8sO4gQU3H8cmLQMmvPM20scTKNujsbxEt1XkMrZyoH1Kxl7e03i
         vtd3R4P5aetnjnPgccdg+GUYbFDQ6R5kmU9vh60Jb6JTGCRFPGm/pVCAGhiTmMMxCwQh
         g63HbMGK11hGzoW59AcoLpmdXFDdLHn1OApA2TOzrwpObpf3O2iFW2fcvZLyC0yVYKKy
         Wo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTeGZJ5mCEP4rjaH1FR8eh9LQWGeT0lMm93y8GL6qQU=;
        b=QuXKc29OUWtlHJUBTtJmQ7Qf4CDHdVsz1Xz/BqC0ffkF4dbrrES7Q0qdp+Fu3uhG28
         JrIuOlMPR2Q9ZnPHLcID5QKGkuhAwBztFD0gVideO2jT9IlVRA1kS64YrsbhWwr66L6m
         kU5a4T3fi92RukxX1FNkFdE0geNWqXRZF7yk5W9wg3rC14IGHUZ6M6dydZwn9qIgX2aI
         6axv1LgEqBoDcQx1TlUd4snrQGrAO47CJCcxH3PT10AqjBlxlcsVpZThwyi5VEOf8MDV
         RUCt22KweQ6mxyvocA5cybgFoPrinwg7pWuXRwohikASxJ6AnQMRDjAJBHYYsVP0voQP
         WG0w==
X-Gm-Message-State: AOAM531oL3XiA/lKWDSIFDS4rEBY95JB/PDfmi2+hZ82tQpYFhT7oVtP
        k5BSoy5h+ZxFy/7K3vnd6vuserew1/7lW6T1cUhHTA==
X-Google-Smtp-Source: ABdhPJylHbV2oaQ8BSowMNroa4gOdHnQhkBc7u8+pVLQMQJRf4F9ImXqeA/yFRdelgv/l1AGFYNJllL+D1eSGJg/7xE=
X-Received: by 2002:ac2:4d19:: with SMTP id r25mr8818387lfi.82.1636485776718;
 Tue, 09 Nov 2021 11:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20211105171023.989862879@infradead.org> <20211105171821.654356149@infradead.org>
 <20211108164711.mr2cqdcvedin2lvx@treble> <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
 <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com> <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net>
In-Reply-To: <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Nov 2021 11:22:44 -0800
Message-ID: <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
To:     Peter Zijlstra <peterz@infradead.org>,
        Bill Wendling <morbo@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz, llvm@lists.linux.dev,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 12:23 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 08, 2021 at 10:53:31AM -0800, Nick Desaulniers wrote:
> > On Mon, Nov 8, 2021 at 10:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Nov 08, 2021 at 08:47:11AM -0800, Josh Poimboeuf wrote:
> > > > On Fri, Nov 05, 2021 at 06:10:43PM +0100, Peter Zijlstra wrote:
> > > > > +static inline unsigned long load_unaligned_zeropad(const void *addr)
> > > > > +{
> > > > > +   unsigned long offset, data;
> > > > > +   unsigned long ret;
> > > > > +
> > > > > +   asm_volatile_goto(
> > > > > +           "1:     mov %[mem], %[ret]\n"
> > > > > +
> > > > > +           _ASM_EXTABLE(1b, %l[do_exception])
> > > > > +
> > > > > +           : [ret] "=&r" (ret)
> > > > > +           : [mem] "m" (*(unsigned long *)addr)
> > > > > +           : : do_exception);
> > > > > +
> > > > > +out:
> > > > > +   return ret;
> > > > > +
> > > > > +do_exception: __cold;
> > > >
> > > > Clang doesn't approve of this label annotation:
> > > >
> > > > In file included from fs/dcache.c:186:
> > > > ./arch/x86/include/asm/word-at-a-time.h:99:15: warning: '__cold__' attribute only applies to functions [-Wignored-attributes]
> > > > do_exception: __cold;
> > >
> > > /me mutters something best left unsaid these days...
> > >
> > > Nick, how come?
> >
> > Looks like https://bugs.llvm.org/show_bug.cgi?id=47487.
>
> Indeed it does. So what do we do? Keep the attribute and ignore the warn
> on clang for now? Even if techinically useless, I do like it's
> descriptive nature.

I think the feature of label-attributes is generally useful, for asm
goto (without outputs) and probably computed-goto, so I think we
should implement support for these in clang.  I suspect the machinery
for hot/cold labels was added to clang and LLVM before asm goto was;
LLVM likely has all the machinery needed and we probably just need to
relax or adjust clang's semantic analysis of where the attribute may
occur.

With the above patch, we'd still have issues though with released
versions of clang, and -Werror would complicate things further.

I think the use of this feature (label-attributes) here isn't
necessary though; because of the use of outputs, the "fallthrough"
basic block needs to be placed immediately after the basic block
terminated by the asm goto, at least in LLVM.  Was different ordering
of basic blocks observed with GCC without this label attribute?

_Without_ outputs, I can see being able to specify which target of an
asm-goto with multiple labels is relatively hot as useful, but _with_
outputs I suspect specifying the indirect targets as cold provides
little to no utility.  Unless the cold attribute is helping move
("shrink-wrap"?) the basic block to a whole other section
(.text.cold.)?
-- 
Thanks,
~Nick Desaulniers
