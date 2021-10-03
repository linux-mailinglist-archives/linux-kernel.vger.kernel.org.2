Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ECB420388
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 21:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhJCTMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 15:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhJCTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 15:12:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C90C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 12:10:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i4so62798984lfv.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdrFUv4MJhSYnTwW7FieR5I+UW7WAn8vEjCCBBzPFn0=;
        b=ACmnvGRojodPlQTW4VdzIJip0rrYahMQUY7hRB6fIioy+TQlXtTmVerLmSOj5FSeAH
         tasPXIFb6jhU+OK8S5pnaGMzPi65WkBY1ajRiq7OXNGXCV3wWSKNrNraE8I65cd2Y063
         5knhoueIWAAKBH2Q7SbXSG970nQS8TdBubWK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdrFUv4MJhSYnTwW7FieR5I+UW7WAn8vEjCCBBzPFn0=;
        b=6883ZF/9c2hBVZhL9EVeFnR0EUfoULwtpMF2/Z11cU3qiS5oosJg1Y/RJtJBtf+gTM
         SEvGCeAyrbcucIRX65aPAFi9haCdavL4+jUg0VuVmlppYN/bVxps5AWnDhfTmFqviCMQ
         uzr1j6Wsoqwc+rYrFH/GeqDdMCxKhLDnexEC+/SwC06CRRx1iGcOBl0wZ3fXZIx4ajCz
         wr5Nye+wZT9eOPCMvUIAd59i2LCC9yhOK49nMFGKn8Y+PflUpWaMY7DjL4cNx8cmN1mt
         kgyC9YY1zdjJ22wVsAieXumZz6wxp8U7vtHsKQ40telS7AjM8WMeYE36RvKuzTks/Ipx
         GGtw==
X-Gm-Message-State: AOAM532tLKv95vRku68EWMjjIy7MSpkNDEgwP49ND1T3LwdSuYTbBrwC
        k7Gg8K6hAHwKOmv1a2JjifUC5qRC4ucu1ZNc
X-Google-Smtp-Source: ABdhPJyR49jjyRdeYNqgrxJwb+J+tejDk/CUbePYwP7iSzETzH55mBw8LuM9r9UnLE5DiXzYscKH2w==
X-Received: by 2002:a05:6512:304b:: with SMTP id b11mr9994931lfb.190.1633288257056;
        Sun, 03 Oct 2021 12:10:57 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id d10sm1392834lfk.179.2021.10.03.12.10.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 12:10:55 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u18so62567008lfd.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 12:10:54 -0700 (PDT)
X-Received: by 2002:a05:6512:12c4:: with SMTP id p4mr10648009lfg.280.1633288253969;
 Sun, 03 Oct 2021 12:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <YVl7RR5NcbPyiXgO@zn.tnic> <CAHk-=wh9JzLmwAqA2+cA=Y4x_TYNBZv_OM4eSEDFPF8V_GAPug@mail.gmail.com>
 <CAHk-=wiZwq-0LknKhXN4M+T8jbxn_2i9mcKpO+OaBSSq_Eh7tg@mail.gmail.com>
In-Reply-To: <CAHk-=wiZwq-0LknKhXN4M+T8jbxn_2i9mcKpO+OaBSSq_Eh7tg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Oct 2021 12:10:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtJ532TqnLN+CLqZJXx=MWHjQqi0-fR8PSQ-nGZ_iMvg@mail.gmail.com>
Message-ID: <CAHk-=wjtJ532TqnLN+CLqZJXx=MWHjQqi0-fR8PSQ-nGZ_iMvg@mail.gmail.com>
Subject: Re: [GIT PULL] objtool/urgent for v5.15-rc4
To:     Borislav Petkov <bp@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to myself just to add more proper people to the cc.

I'm also wondering how I could possibly be the only person who saw the warning.

I don't think I am, and I think that people who signed off on commit
24ff65257375 ("objtool: Teach get_alt_entry() about more relocation
types") and claimed to have "tested" it, clearly didn't actually do
so.

PeterZ/Josh/Nathan: see the thread at

   https://lore.kernel.org/lkml/CAHk-=wiZwq-0LknKhXN4M+T8jbxn_2i9mcKpO+OaBSSq_Eh7tg@mail.gmail.com/

if you need more context, but I suspect you can figure it out just
from this email too.

              Linus

On Sun, Oct 3, 2021 at 12:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Oct 3, 2021 at 11:38 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Looking at the kvm code, that kvm_fastop_exception thing is some funky sh*t.
> >
> > I _think_ the problem is that 'kvm_fastop_exception' is done with bare
> > asm at the top-level and that triggers some odd interaction with other
> > section data, but I really don't know.
>
> No, it's the fact that it is marked as a global function (why?) that
> it then causes problems.
>
> Now, I don't actually see why it would cause problems (the same way I
> don't see why it's marked global). But removing that
>
>      ".global kvm_fastop_exception \n"
>
> works.
>
> I suspect it makes the linker do the relocation for us before objtool
> runs, because now that it's a local name, there is no worry about
> multiply defined symbols of the same name or anything like that.
>
> I also suspect that the reason for the warning is that the symbol type
> has never been declared, so it's not marked as a STT_FUNC in the
> relocation information.
>
> So independently of this kvm_fastop_exception issue, I'd suggest the
> attached patch for objtool to make the warning more informative for
> people who try to debug this.
>
> So I have a fix ("remove the global declaration"), but I really don't
> like how random this is.
>
> I also tried to instead keep the symbol global, and just mark
> kvm_fastop_exception as a function (and add the proper size
> annotation), but that only causes more objtool warnings for the
> (generated asm) functions that *use* that symbol. Because they also
> don't seem to be properly annotated.
>
> Again, removing the global annotation works around the problem, but
> the real underlying issue does seem to be that "funky sh*t" going on
> in arch/x86/kvm/emulate.c.
>
> So I'd like more people to look at this.
>
> In the meantime, I think the exception handling for kvm
> divide/multiply emulation is badly broken right now. Hmm?
>
>                 Linus
