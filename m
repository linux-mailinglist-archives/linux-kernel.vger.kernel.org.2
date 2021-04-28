Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB39936DCED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhD1QY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240930AbhD1QYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:24:55 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6416C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:24:08 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso56984703otb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFFeVW33ruUEu/k84GYwSnkp1LcEq7XYbpo7nxvVcFI=;
        b=hn+R2pvJfLdJc/4FJGrLTsET9/BSFZHQ3oyvmGarpqqestJfKms3Tpj/IujFgKAK+I
         STWb4Qige1UGtc7wy0KuENrTa2Pu7sEZx/BXCYVQJon9TnFgC+6xapjpJeI5XS97UqAD
         PskI9dX0Haq3e0/eOmrBhs2wAU1K8uE8bjQ+PnDAHPcoMhfs+0Mw4COjmFSyNb6GfUZ1
         RK8Yo+sHZ9mW/OSVZjISnjiwOxC7J4/DScD6bpR+wPrmH1F8+uAyDiyZKQ87bFtPxypQ
         il5d7LCT4zkXOqK7HNc0ERUv6Xx9PXmyWzUrEl4z4nHacZRpZDTTC5x+58shKX+l84bn
         bAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFFeVW33ruUEu/k84GYwSnkp1LcEq7XYbpo7nxvVcFI=;
        b=tw/uJK1LZP/g/+VTjYjRBot7WM/LUXaYn7FVjE9UXtM8yh1LxbbhJnbx4Y7AbKOrHP
         lK7bduPKxjnMBzxoZkMIxqPP9Jj/Y0nIx9aqktdT409TAWgoZKRmD/7X5cVho35GWqBT
         8ySkHoWYbhDV9L1cHQX2wqDSyzyz7JkyoD5ASNwbqVp0SIOFiO3v55modV+V3aZ18IBf
         1DLjJQc3v4tE5IBbMYC0UhEGr14Ai64frIYFex7HCsCSQnP3slvkEBAhz9ZOAOFOQ+zq
         bD+VwoE9JTykntd/aN42jbjI2SaNNR4aOdZddFTmz3YXhlWf/xxXZc1tetsH+GjpeXfb
         d8/w==
X-Gm-Message-State: AOAM531NOQ8InRrD9cwf3fjSe3VH5FzLqbcIRLiPrFNv439D5q0PKZ2v
        8CXjw9XlMAHT6wW+Ap5qkf1cpMYBl4dulhhtjf+wAg==
X-Google-Smtp-Source: ABdhPJwWHRNFe5yz7wBYtOPEdrHwUqI1dTfIVjAv50VzHm+M+vApvLtLT8m3GLJkwbhFeJKPFsHpIeINVS9qEG1hLoA=
X-Received: by 2002:a05:6830:1deb:: with SMTP id b11mr25593909otj.72.1619627047878;
 Wed, 28 Apr 2021 09:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210427223635.2711774-1-bgardon@google.com> <20210427223635.2711774-4-bgardon@google.com>
 <2e5ecc0b-0ef4-a663-3b1d-81d020626b39@redhat.com>
In-Reply-To: <2e5ecc0b-0ef4-a663-3b1d-81d020626b39@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 28 Apr 2021 09:23:56 -0700
Message-ID: <CANgfPd9OrCFoH1=2G_GD5MB5R54q5w=SDKP7vLnHPvDZox5WiQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] KVM: x86/mmu: Deduplicate rmap freeing in allocate_memslot_rmap
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 3:00 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Typo in the commit subject, I guess?

Oh woops, yeah It should just be "Deduplicate rmap freeing" or
something to that effect.

>
> Paolo
>
> On 28/04/21 00:36, Ben Gardon wrote:
> > Small code deduplication. No functional change expected.
> >
> > Signed-off-by: Ben Gardon <bgardon@google.com>
> > ---
> >   arch/x86/kvm/x86.c | 19 +++++++++++--------
> >   1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index cf3b67679cf0..5bcf07465c47 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -10818,17 +10818,23 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
> >       kvm_hv_destroy_vm(kvm);
> >   }
> >
> > -void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
> > +static void free_memslot_rmap(struct kvm_memory_slot *slot)
> >   {
> >       int i;
> >
> >       for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
> >               kvfree(slot->arch.rmap[i]);
> >               slot->arch.rmap[i] = NULL;
> > +     }
> > +}
> >
> > -             if (i == 0)
> > -                     continue;
> > +void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
> > +{
> > +     int i;
> > +
> > +     free_memslot_rmap(slot);
> >
> > +     for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
> >               kvfree(slot->arch.lpage_info[i - 1]);
> >               slot->arch.lpage_info[i - 1] = NULL;
> >       }
> > @@ -10894,12 +10900,9 @@ static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
> >       return 0;
> >
> >   out_free:
> > -     for (i = 0; i < KVM_NR_PAGE_SIZES; ++i) {
> > -             kvfree(slot->arch.rmap[i]);
> > -             slot->arch.rmap[i] = NULL;
> > -             if (i == 0)
> > -                     continue;
> > +     free_memslot_rmap(slot);
> >
> > +     for (i = 1; i < KVM_NR_PAGE_SIZES; ++i) {
> >               kvfree(slot->arch.lpage_info[i - 1]);
> >               slot->arch.lpage_info[i - 1] = NULL;
> >       }
> >
>
