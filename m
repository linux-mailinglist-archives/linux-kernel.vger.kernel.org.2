Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF00436E89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 01:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhJUXxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 19:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhJUXxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 19:53:38 -0400
Received: from mail-pj1-x1062.google.com (mail-pj1-x1062.google.com [IPv6:2607:f8b0:4864:20::1062])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A208C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 16:51:22 -0700 (PDT)
Received: by mail-pj1-x1062.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso1756960pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 16:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=e+PTcSOFwWEcq9oTy0sMRAqods1g3LEj7JCe2Z0YjmU=;
        b=fD20K/bzrSOrlgwg2/WZa+Cv5Xi0ixxyRpZlwjLmHPaIDphjsp5fdsPWA9xqKMprqx
         SnrfYCkUQV0TgDq5GTjGoHcrkLyLeQIg9XwcxEZPAD+pr6qIjOyKiduROFv8jgpoReMt
         vA0diYhgnTV5bKVYcQ3BN2zxETtRolMVAfJ/W8PfjeeotS4xYpn+UvsxO2FC/CzGsXSG
         nIgtaTQ3plRv4LvzmBVMQf/WQS7yAzpH+k0pcn3ZM9EOjedHtZX5cH5asaPSyXRQqpGE
         edVL3sx8ypOH3/rjAgmhVv7VzMPeYNJYuNoLGMhw5cRtZFnwGp1I7GWULu19Q9Cz8Bjf
         1wDg==
X-Gm-Message-State: AOAM533kmXik8FPpMpDH8xbUpRk1pdzjdmbBiEL2IN5Y/9oUL9fvkdRc
        ImsJ5XL32ew/d+pClfCo/OCdpNGBOZC0pF07xtXai1EGzo0PGw==
X-Google-Smtp-Source: ABdhPJyWM5Qt3VWCHhC1sRS0+ZRBdCUO33D/8UHYsGIiq7h6xdI9vZHBMm2cxa0pI2D9DtMiqQGhOca/3OiK
X-Received: by 2002:a17:90b:3ec3:: with SMTP id rm3mr10243454pjb.186.1634860281760;
        Thu, 21 Oct 2021 16:51:21 -0700 (PDT)
Received: from netskope.com ([163.116.131.172])
        by smtp-relay.gmail.com with ESMTPS id pi11sm3033451pjb.14.2021.10.21.16.51.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 16:51:21 -0700 (PDT)
X-Relaying-Domain: riotgames.com
Received: by mail-ed1-f72.google.com with SMTP id u23-20020a50a417000000b003db23c7e5e2so1978909edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 16:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+PTcSOFwWEcq9oTy0sMRAqods1g3LEj7JCe2Z0YjmU=;
        b=ojaLK0HvIJ82oNRz7+C2hMZO0pIoLO/gi4pSqB+nhc58D65M7ZN18Z3a8/xxcGFvnx
         dc8mkwwbqjMMaYpWTXy4IMyziYwQsUvHXK4EjwfL01I9r21m/lzt9e9bSBETBglXfjh5
         vnYiDGUSabTlMOP8PNRKnNYSk5Gdx/JdgB9Ls=
X-Received: by 2002:a17:906:9a07:: with SMTP id ai7mr11435105ejc.55.1634860279639;
        Thu, 21 Oct 2021 16:51:19 -0700 (PDT)
X-Received: by 2002:a17:906:9a07:: with SMTP id ai7mr11435067ejc.55.1634860279333;
 Thu, 21 Oct 2021 16:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211020104442.021802560@infradead.org> <20211020105843.345016338@infradead.org>
 <YW/4/7MjUf3hWfjz@hirez.programming.kicks-ass.net> <20211021000502.ltn5o6ji6offwzeg@ast-mbp.dhcp.thefacebook.com>
 <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
In-Reply-To: <YXEpBKxUICIPVj14@hirez.programming.kicks-ass.net>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Thu, 21 Oct 2021 16:51:08 -0700
Message-ID: <CAC1LvL33KYZUJTr1HZZM_owhH=Mvwo9gBEEmFgdpZFEwkUiVKw@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, x86@kernel.org,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
x-netskope-inspected: true
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 1:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 20, 2021 at 05:05:02PM -0700, Alexei Starovoitov wrote:
> > On Wed, Oct 20, 2021 at 01:09:51PM +0200, Peter Zijlstra wrote:
>
> > > @@ -446,25 +440,8 @@ static void emit_bpf_tail_call_indirect(
> > >  {
> > >     int tcc_off = -4 - round_up(stack_depth, 8);
> > >     u8 *prog = *pprog, *start = *pprog;
> > > -   int pop_bytes = 0;
> > > -   int off1 = 42;
> > > -   int off2 = 31;
> > > -   int off3 = 9;
> > > -
> > > -   /* count the additional bytes used for popping callee regs from stack
> > > -    * that need to be taken into account for each of the offsets that
> > > -    * are used for bailing out of the tail call
> > > -    */
> > > -   pop_bytes = get_pop_bytes(callee_regs_used);
> > > -   off1 += pop_bytes;
> > > -   off2 += pop_bytes;
> > > -   off3 += pop_bytes;
> > > -
> > > -   if (stack_depth) {
> > > -           off1 += 7;
> > > -           off2 += 7;
> > > -           off3 += 7;
> > > -   }
> > > +   static int out_label = -1;
> >
> > Interesting idea!
>
> I nicked it from emit_bpf_tail_call() in the 32bit jit :-) It seemed a
> lot more robust than the 64bit one and I couldn't figure out why the
> difference.
>
> > All insn emits trying to do the right thing from the start.
> > Here the logic assumes that there will be at least two passes over image.
> > I think that is correct, but we never had such assumption.
>
> That's not exactly true; I think image is NULL on every first run, so
> all insn that depend on it will be wrong to start with. Equally there's
> a number of insn that seem to depend on addrs[i], that also requires at
> least two passes.
>
> > A comment is certainly must have.
>
> I can certainly add one, although I think we'll disagree on the comment
> style :-)
>
> > The race is possible too. Not sure whether READ_ONCE/WRITE_ONCE
> > are really warranted though. Might be overkill.
>
> Is there concurrency on the jit?
>
> > Once you have a git branch with all the changes I can give it a go.
>
> Ok, I'll go polish this thing and stick it in the tree mentioned in the
> cover letter.
>
> > Also you can rely on our BPF CI.
> > Just cc your patchset to bpf@vger and add [PATCH bpf-next] to a subject.
> > In patchwork there will be "bpf/vmtest-bpf-next" link that
> > builds kernel, selftests and runs everything.
>
> What's a patchwork and where do I find it?
>

Patchwork[0] tracks the status of patches from submission through to merge (and
beyond?).

[0]: https://patchwork.kernel.org/

> > It's pretty much the same as selftests/bpf/vmtest.sh, but with the latest
> > clang nightly and other deps like pahole.
>
> nice.
