Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64F23AD0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhFRQ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbhFRQ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:56:14 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CFAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 09:54:05 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id x196so11196048oif.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AtSqJOQGfjKv3UOcjj+P/M/U0KAJcbotecQbdXLeGdE=;
        b=S6H4mLsocQZXJTWCCi58vEGYojWSPpW0UBu5oyIqTluZ1mhtIhmr8gi/WkMNeemx9V
         ZVVxgzztTTFLcKcB7Fl9a6JjekIFLAD7GK8aco+Ed9UvOgWLWmhtPKxbFX7Mrii+GK36
         +vCHyWa+xfsZbl8w9tKOmCXqnyHgWTsCGYhiqctrFdiWgo6mBo6503RS8pHiIA+1kgNy
         Lo0e8EpTtukNP0M0cubZstkmwYWHaCIzJx7hIwLb3IcYuXpfOlay3MIWYwWYDIbyqQ9y
         3OccBtAaOIJQ4IxlAb4Zyp8/H3I0oUeZLf6vCuoF7iakCwbd7Fv9Z/dTSnxhl9Nlqvdn
         UeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtSqJOQGfjKv3UOcjj+P/M/U0KAJcbotecQbdXLeGdE=;
        b=UsMAxjhgnlND6W2BUDYyeDicvpLas1RqsyQoiBq83R+YQi9Qr3pRTQldIapMmtsKtJ
         YeG+jsTc/6f6FlhdOky2gDBQJzKWdPFKMZNbudjefpmBkkwHndTxtK6SRiiz+xQLkzyZ
         d8sibcrngd6JR4I/A0e3KzTb4fyTrONxOttO9NpdWVT4Qm0PHC7F6V5JXRXCUQ5DI186
         S/8WtAyohZhURibgc/mvSYm8acsuMhfySDFLkZ7gQsHf3ONCOcG18Ic72gjMV/+6m3JM
         2Av5ON54ixtFQBch7Q8JqrMYoK768E7XcnjwTCE9dwt2LDnXcx4BZ9imOKJTW0xRkulw
         FYaw==
X-Gm-Message-State: AOAM530Vo13ctWcci9QoY43k0mObxn8/CyGz7PK+UnG9GJ/urNvR6r1Q
        zqV/xR3WmK1+HlRAh3PuHY6Ik161WOVGlmfwRLtnBA==
X-Google-Smtp-Source: ABdhPJyHzNg1FTlnP0ojeJkXrYeJkXPTb5H3tCQJjlx70G2MdTVcBObUsy/Yte/q9+CooW6Ir2VvuD/lJo1v/CAIyYs=
X-Received: by 2002:aca:1e07:: with SMTP id m7mr7727189oic.28.1624035244083;
 Fri, 18 Jun 2021 09:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <0c00d96c46d34d69f5f459baebf3c89a507730fc.camel@perches.com>
 <20200603101131.2107303-1-efremov@linux.com> <CALMp9eSFkRrWLjegJ5OC7kZ4oWtZypKRDjXFQD5=tFX4YLpUgw@mail.gmail.com>
 <YMw2YeWHFsn+AFmN@dhcp22.suse.cz>
In-Reply-To: <YMw2YeWHFsn+AFmN@dhcp22.suse.cz>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 18 Jun 2021 09:53:53 -0700
Message-ID: <CALMp9eR9n6N5EB-nUEJPM=e2YtE3_tQBDHj0uP3T2dcGsutSCQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: Use vmemdup_user()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joe@perches.com,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:00 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 17-06-21 17:25:04, Jim Mattson wrote:
> > On Wed, Jun 3, 2020 at 3:10 AM Denis Efremov <efremov@linux.com> wrote:
> > >
> > > Replace opencoded alloc and copy with vmemdup_user().
> > >
> > > Signed-off-by: Denis Efremov <efremov@linux.com>
> > > ---
> > > Looks like these are the only places in KVM that are suitable for
> > > vmemdup_user().
> > >
> > >  arch/x86/kvm/cpuid.c | 17 +++++++----------
> > >  virt/kvm/kvm_main.c  | 19 ++++++++-----------
> > >  2 files changed, 15 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > > index 901cd1fdecd9..27438a2bdb62 100644
> > > --- a/arch/x86/kvm/cpuid.c
> > > +++ b/arch/x86/kvm/cpuid.c
> > > @@ -182,17 +182,14 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
> > >         r = -E2BIG;
> > >         if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
> > >                 goto out;
> > > -       r = -ENOMEM;
> > >         if (cpuid->nent) {
> > > -               cpuid_entries =
> > > -                       vmalloc(array_size(sizeof(struct kvm_cpuid_entry),
> > > -                                          cpuid->nent));
> > > -               if (!cpuid_entries)
> > > -                       goto out;
> > > -               r = -EFAULT;
> > > -               if (copy_from_user(cpuid_entries, entries,
> > > -                                  cpuid->nent * sizeof(struct kvm_cpuid_entry)))
> > > +               cpuid_entries = vmemdup_user(entries,
> > > +                                            array_size(sizeof(struct kvm_cpuid_entry),
> > > +                                                       cpuid->nent));
> >
> > Does this break memcg accounting? I ask, because I'm really not sure.
>
> What do you mean by that? The original code uses plain vmalloc so the
> allocation is not memcg accounted (please note that __GFP_ACCOUNT needs
> to be specified explicitly). vmemdup_user is the same in that regards.

I asked, because I wasn't sure if plain vmalloc was accounted or not.

In any case, these allocations *should* be accounted, shouldn't they?
