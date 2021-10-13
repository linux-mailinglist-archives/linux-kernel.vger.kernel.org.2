Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECED42B625
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 07:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbhJMFy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 01:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhJMFyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 01:54:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD3DC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 22:52:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so1377787pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 22:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2yJVVNGRPJXsa1/Y1Zn9pdM/oy3KfLkUusY0H2kckAc=;
        b=Q579i91kdRJn3mILCUDSbxAKnocs2ICoskyM6NFXs0qu98H/SYDhwvyeV9R5vTQCyA
         P17ZAAI/uwNVNrlG8kyETHrT+4bzLBKInEv5K+IP6YdbHtwHUUo0PPmwnklkKl7okPBk
         glOtv45Bv2Whu4p4LF3emRjqM3I5oVJ9JGrGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2yJVVNGRPJXsa1/Y1Zn9pdM/oy3KfLkUusY0H2kckAc=;
        b=ggpyCn+LXwpAMjKyHEfXyX9wWhcnxBYvw0KQPYTpGID/fiv+zWD2EXDseNAL6IMEMY
         ce4uvHALPkF0IDR0eQU7aZWj8gifNXhCBhKdmlf8LXWpibxi4nEZPwcooidlQml5Y9vh
         Zgyfdu+J2smlj06YigSa/xne3ttGxp0m6iFRZycl1iGKXWT2XCxmjliFBwdveivVRvEE
         n0UMA1SqDnIzPiewmVPJ16Ja3x2688nKbumv0U3aQzhlPjvj6BtmnxeS2O6Y4csa87qm
         BDcwuFiMs7g6Lm4y3RI1wjwTxrmfUaEKAlnzPZdHb0TepP3kMINqoDCIZ59mti5ceiip
         OcnA==
X-Gm-Message-State: AOAM532tLQTJjaFhRaW63stX2kr8EnwcGAljBabspGY/yPJyrD/X7HTS
        Xy0QbnDAjJpuwH7hqV+eeGnRjw==
X-Google-Smtp-Source: ABdhPJwDQdREjCTkLNonU7TRezwdPLTKa3ccQrKdRYfuM8Ymn5G3JCafYCvHci/p4+0uubDkvnH1lw==
X-Received: by 2002:a17:90b:3a84:: with SMTP id om4mr11171166pjb.153.1634104341357;
        Tue, 12 Oct 2021 22:52:21 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:e5ac:84f1:6b7d:9dac])
        by smtp.gmail.com with ESMTPSA id z12sm1654839pjh.51.2021.10.12.22.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 22:52:20 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:52:15 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     David Matlack <dmatlack@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suleiman Souhlal <suleiman@google.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: MMU: make PTE_PREFETCH_NUM tunable
Message-ID: <YWZ0D9r5BOm/8f7d@google.com>
References: <20211012091430.1754492-1-senozhatsky@chromium.org>
 <CALzav=dYeCs=ieC2p074J4KVyFpRsxRVa5ZQuST--2GOVJm7Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=dYeCs=ieC2p074J4KVyFpRsxRVa5ZQuST--2GOVJm7Kw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/10/12 09:50), David Matlack wrote:
> On Tue, Oct 12, 2021 at 2:16 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > Turn PTE_PREFETCH_NUM into a module parameter, so that it
> > can be tuned per-VM.
> 
> Module parameters do not allow tuning per VM, they effect every VM on
> the machine.
> 
> If you want per-VM tuning you could introduce a VM ioctl.

ACK.

> > ---
> >  arch/x86/kvm/mmu/mmu.c | 31 ++++++++++++++++++++++---------
> 
> Please also update the shadow paging prefetching code in
> arch/x86/kvm/mmu/paging_tmpl.h, unless there is a good reason to
> diverge.

ACK.

> > @@ -732,7 +734,7 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
> >
> >         /* 1 rmap, 1 parent PTE per level, and the prefetched rmaps. */
> >         r = kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
> > -                                      1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM);
> > +                                      1 + PT64_ROOT_MAX_LEVEL + pte_prefetch_num);
> 
> There is a sampling problem. What happens if the user changes
> pte_prefetch_num while a fault is being handled?

Good catch.

> > @@ -2753,20 +2755,29 @@ static int direct_pte_prefetch_many(struct kvm_vcpu *vcpu,
> >                                     struct kvm_mmu_page *sp,
> >                                     u64 *start, u64 *end)
> >  {
> > -       struct page *pages[PTE_PREFETCH_NUM];
> > +       struct page **pages;
> >         struct kvm_memory_slot *slot;
> >         unsigned int access = sp->role.access;
> >         int i, ret;
> >         gfn_t gfn;
> >
> > +       pages = kmalloc_array(pte_prefetch_num, sizeof(struct page *),
> > +                             GFP_KERNEL);
> 
> This code runs with the MMU lock held. From
> In general we avoid doing any dynamic memory allocation while the MMU
> lock is held. That's why the memory caches exist. You can avoid
> allocating under a lock by allocating the prefetch array when the vCPU
> is first initialized. This would also solve the module parameter
> sampling problem because you can read it once and store it in struct
> kvm_vcpu.

I'll do per-VCPU pre-allocation, thanks. GFP_KERNEL is less of a problem
if we hold read kvm->mmu_lock, but more so if we hold write kvm->mmu_lock.

> >  static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
> > @@ -2785,10 +2798,10 @@ static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
> >
> >         WARN_ON(!sp->role.direct);
> >
> > -       i = (sptep - sp->spt) & ~(PTE_PREFETCH_NUM - 1);
> > +       i = (sptep - sp->spt) & ~(pte_prefetch_num - 1);
> 
> This code assumes pte_prefetch_num is a power of 2, which is now no
> longer guaranteed to be true.

It does. I can test if it's a pow(2) in ioctl
