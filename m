Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1200834D9C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhC2Vz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhC2VzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:55:13 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE78C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 14:55:12 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so13750432otn.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lXwK9TDHJMeRrnXTHqrcsnlfyiEUU93Inkgor2Calrw=;
        b=S5OHFkj9gRuAuPp2xsjRC8NT8r1TxdLdZkfO9vYEhUseN2QgfNrYt+fA+qtQjZ/QdX
         lQdkF0CmDqUtekeQiZEMzet8gzOxX5WycJDdqf1NoHputq6tJrJ7CPtRVUuG8q1QXBNb
         vvUH1YGeN9FEfWbn4InAdkMDcEy0YxTsraLbiK981q8GTZ54s7YgD5fg6xmxIXEpyCO9
         drxiGnsygnGdv6NgQiqyGSjPZ3G5iF5f7yXHekbKEzSbrQ8zw9QFbBQMEEdicZg/jO2l
         QBTgBwaEn+1Xe85+kPEXNhoNn804IichrEVu89AYwjQPp0mZdYEDq9hdiUYNyNcFJQpO
         zJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lXwK9TDHJMeRrnXTHqrcsnlfyiEUU93Inkgor2Calrw=;
        b=PemDmaLnlRVsg/fPf//3xgV1/O++kZ+dEs3kc7nxxNNP6+HEMOwcOLUXtbXBDmVBEK
         lk1LShXNu14gU2/Sqxpc2XZ4QB69MYGT5utMh+5qSo21WJqON/TGOtMcgfu13OFAx2Cg
         sEV3X1ybyP/0WOKOYPxCLE50Fi1L9ZqhLrNIVAcAP2EtuP1eR/NHhOUrKNRa0cDSWGL4
         JahnEQqAISk6R7DcniSDvMc2VO84GHJLhk86/J7prGCT+AzdyKb7jlXwuXCHkri36Gg5
         ip+wjfbtIunoCrsk21I6H/8ILZFDoAuXOXE722KevmX5Y5gB7vDR+QZNfmMz8VQbm6xS
         YJ1A==
X-Gm-Message-State: AOAM532CyVta07sP8d4fen9Gdv9J5ZWEDXGGQ8fCrdvkwaVQWQx6o70B
        zg/A77Px3tepCObbjY8y7YsqXAg3ZQuPOQB29+lbBA==
X-Google-Smtp-Source: ABdhPJzdet4bi7w/uPVDdbyf8vfHIDm1FNGVtEcqFd3fmNzmZ9zHWQIr1cQ8tpYR3xUSMuvJWnlazQF/w1Zu6fXUkLk=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr25234396otq.251.1617054911480;
 Mon, 29 Mar 2021 14:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPjj7ocn6rf-9LkwJrYdVw3AuKfuF7FzwMu=hwe7qrEUw@mail.gmail.com>
 <ED2525DC-4591-46D1-8238-0461D5006502@amacapital.net>
In-Reply-To: <ED2525DC-4591-46D1-8238-0461D5006502@amacapital.net>
From:   Marco Elver <elver@google.com>
Date:   Mon, 29 Mar 2021 23:54:59 +0200
Message-ID: <CANpmjNO+_4C0dYs6K8Ofy-xVSYxO8OtXSRbW6vCXBYdjJSjqbQ@mail.gmail.com>
Subject: Re: I915 CI-run with kfence enabled, issues found
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 at 23:47, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
> > On Mar 29, 2021, at 2:34 PM, Marco Elver <elver@google.com> wrote:
> >
> > =EF=BB=BFOn Mon, 29 Mar 2021 at 23:03, Dave Hansen <dave.hansen@intel.c=
om> wrote:
> >>> On 3/29/21 10:45 AM, Marco Elver wrote:
> >>>> On Mon, 29 Mar 2021 at 19:32, Dave Hansen <dave.hansen@intel.com> wr=
ote:
> >>> Doing it to all CPUs is too expensive, and we can tolerate this being
> >>> approximate (nothing bad will happen, KFENCE might just miss a bug an=
d
> >>> that's ok).
> >> ...
> >>>> BTW, the preempt checks in flush_tlb_one_kernel() are dependent on K=
PTI
> >>>> being enabled.  That's probably why you don't see this everywhere.  =
We
> >>>> should probably have unconditional preempt checks in there.
> >>>
> >>> In which case I'll add a preempt_disable/enable() pair to
> >>> kfence_protect_page() in arch/x86/include/asm/kfence.h.
> >>
> >> That sounds sane to me.  I'd just plead that the special situation (no=
t
> >> needing deterministic TLB flushes) is obvious.  We don't want any folk=
s
> >> copying this code.
> >>
> >> BTW, I know you want to avoid the cost of IPIs, but have you considere=
d
> >> any other low-cost ways to get quicker TLB flushes?  For instance, you
> >> could loop over all CPUs and set cpu_tlbstate.invalidate_other=3D1.  T=
hat
> >> would induce a context switch at the next context switch without needi=
ng
> >> an IPI.
> >
> > This is interesting. And it seems like it would work well for our
> > usecase. Ideally we should only flush entries related to the page we
> > changed. But it seems invalidate_other would flush the entire TLB.
> >
> > With PTI, flush_tlb_one_kernel() already does that for the current
> > CPU, but now we'd flush entire TLBs for all CPUs and even if PTI is
> > off.
> >
> > Do you have an intuition for how much this would affect large
> > multi-socket systems? I currently can't quite say, and would err on
> > the side of caution.
>
> Flushing the kernel TLB for all addresses
> Is rather pricy. ISTR 600 cycles on Skylake, not to mention the cost of l=
osing the TLB.  How common is this?

AFAIK, invalidate_other resets the asid, so it's not explicit and
perhaps cheaper?

In any case, if we were to do this, it'd be based on the sample
interval of KFENCE, which can be as low as 1ms. But this is a
production debugging feature, so the target machines are not test
machines. For those production deployments we'd be looking at every
~500ms. But I know of other deployments that use <100ms.

Doesn't sound like much, but as you say, I also worry a bit about
losing the TLB across >100 CPUs even if it's every 500ms.

Thanks,
-- Marco
