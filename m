Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F371F45F549
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbhKZTmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhKZTkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:40:03 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE872C06175A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 11:14:43 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z6so9761017pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 11:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iC8QW0FdwJEZGDL1E+nNH1jnGDYm7HQtGrqRLcMJWPc=;
        b=hgih+9z7xFCrSSLnJ6jZ2PX2qyLrM/vuYl1/6v+u45hBAyr1kHS6sQgiunUs76MjeS
         SCPMSsLISI5EznmqtRehLPu2xqOzXXFLh8MAwtjGjrjLoru2sFXHCOON4nnhzl7PF7jq
         V0hcvcH6sgwjeUHbLP/Xu9w4X5ixVwstkqyGBPeqKmFnUUgz61cM1rTctQh6nd1Z/yIS
         nA1KmbDvNa5nhxbEfxDYbt/+IBSyORquykkPr8DA5MB+TCwM0Hm+rbim9tOHOjhneQ/f
         hIpKTnvN0LpDX+ct+IjMsB5Hcog4ey0jXSiEyMtg+XWqKKvmOmJn/jqXAucAYtLdLHWn
         F8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iC8QW0FdwJEZGDL1E+nNH1jnGDYm7HQtGrqRLcMJWPc=;
        b=xEQtKs/5ampFbNssVPooTkYX6IX94JwJth83FSrql9Pc6H7ArWzqlfBRDVufclRzXk
         HdbHAy9OskdOHCpIbVOaWHnG+DEYDBzvHNIb4Y5aDOUy/JBJK7UJeRi0lGlc9MASFCHa
         O/N2oSpZg5Iv8g5BR4i9EiQxdrvtKE82s0kPHBws5Qx52JNTH6/dwMaIUPYGeVICODCZ
         c5yyeGnlXWzUvoZLzzahkF3wDaevFTtZagkMPwpaEsWtPgDHerpbjScnwQ1X480bjxeE
         docBvXLHo9AJ3LmogN0WR3VwNptEj8myyq0EkILZpjR1Zzuu2FwoA3yU3un7zBq3mnDH
         lmvg==
X-Gm-Message-State: AOAM5334qOvyA2QyybyjzU4zrigob+HUdlJ9ZcYNSnvsnHDGc7qfTxGQ
        B8tvdajf5v5ULjGn8bO1JwTkze8fl2rhjulULh0=
X-Google-Smtp-Source: ABdhPJzv7mCyU+oLxzsruPLj/ql1BoUYZC/kboYFBWmVP724de+GDkw+l82aZlmeXUwDfBjJXOHIjkJUPbGxGFMP37o=
X-Received: by 2002:a63:31ce:: with SMTP id x197mr20144500pgx.14.1637954083527;
 Fri, 26 Nov 2021 11:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
 <CANn89iJA1JOevgLSK019VYXKkLJsMjV-u9ZHvrgZ+XUypRWwfQ@mail.gmail.com>
 <CAFUsyfLeVGW8etXHuSGvYy_RoS3RGaA1L+NLKnpc7EsSMVORBg@mail.gmail.com>
 <CANn89iJxMhGfp364rPu6p_ZLrKnM1qWF_NWrw4_oL_KG+piByg@mail.gmail.com> <CAFUsyfJ33cKFQdUagHQ_b4N80CfBtGQZhyA4CN_JLgEmXEX=DA@mail.gmail.com>
In-Reply-To: <CAFUsyfJ33cKFQdUagHQ_b4N80CfBtGQZhyA4CN_JLgEmXEX=DA@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Fri, 26 Nov 2021 13:14:32 -0600
Message-ID: <CAFUsyf+TuU2Xe5Guy5yiFWsV-JZSjUJxcGZv=f0BYDSmODV+_w@mail.gmail.com>
Subject: Re: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Eric Dumazet <edumazet@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        X86 ML <x86@kernel.org>, hpa@zytor.com, peterz@infradead.org,
        alexanderduyck@fb.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 12:50 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Fri, Nov 26, 2021 at 12:27 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Nov 26, 2021 at 10:17 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > >
> >
> > >
> > > Makes sense. Although if you inline I think you definitely will want a more
> > > conservative clobber than just "memory". Also I think with 40 you also will
> > > get some value from two counters.
> > >
> > > Did you see the number/question I posted about two accumulators for 32
> > > byte case?
> > > Its a judgement call about latency vs throughput that I don't really have an
> > > answer for.
> > >
> >
> > The thing I do not know is if using more units would slow down the
> > hyper thread ?

Did some quick tests with the latency/throughput benchmarks running
in parallel on two hyperthreads on the same processors. The 32 byte case
latency advantage goes with 2 accum and there is still a slight regression
in throughput. The larger cases that hit the loop still still have improvements
both in tput and latency with 2 accum.

>
> There are more uops in the two accumulator version so it could be concern
> iff the other hyperthread is bottlenecked on p06 throughput. My general
> understanding is this is not the common case and that the very premise of
> hyperthreads is that most bottlenecks are related to memory fetch or resolving
> control flow.
>
> >
> > Would using ADCX/ADOX would be better in this respect ?
>
> What would code using those instructions look like? Having trouble
> seeing how to use them here.
