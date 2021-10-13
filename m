Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DC342B39C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbhJMDbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbhJMDbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:31:50 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2376DC061746
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:29:48 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id d131so3044701ybd.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1V9NDATmu17pUoF4QdYlG/zF1QvhHmXa48+FoG1Ebg=;
        b=V4hO+e2bD1JKo+Av7J5TFNJ1Ayzjepp5lrSlnAALB4jkPnPZEm3JE2msYawjx0E+JD
         tymz1KVCEPIHc7Lb1cN8BmImJcbDMIBN1FhakghcvYzmLRFwru1SX8emTJ2jfivukZrU
         17T4/dOBCe4YOLTSInLOyPaslkb0C1DApR82U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1V9NDATmu17pUoF4QdYlG/zF1QvhHmXa48+FoG1Ebg=;
        b=HRC7rjMqpDOPjSQrYo8P0+tXT4QbURX3Z2ebx3rU/7t5I+ULXAzvGBMnkengRwnwCm
         QaYDAsvOfTaGIMDvprk0XJj9LL3OigDGnC0bRYdVO7ETri3EWJR+PHXUI3Ji5s+zat8p
         m561ZwCrcXjArgbs3pLYNcuwGK6uZgsuQWNRByUt7AcqKbxepwuTR9zyyrOJ3XG74T43
         OETzGCHqfCElIzMWkQp0uNsvEqL7oHPrqE11utB4wV6KwrQkZWHwbZGCnuKek8yDtmrZ
         uB+4ocGuSHOapGK2X2O//UN8SE6a3r/8vHVE8EWP4UJPsjT/Hv+Vn+f1+nWsy8JQE1lA
         ky1Q==
X-Gm-Message-State: AOAM530KFAH+evj8fSDnbln5jSIfn8QlnP70Bu6GEIpdSAmufpDrdYW2
        FDmjjqMe+zQwxqMjXmakcnn5f5qZ5w28Mv8OrP9xsA==
X-Google-Smtp-Source: ABdhPJxq87bgca01rLjYkuSh5HTdIgTMzvRne9NDRirxkvsd38A826PPWMoXsd9Iv9DztgPg8Lkfu/gUc5455msojX4=
X-Received: by 2002:a25:22d7:: with SMTP id i206mr34357892ybi.355.1634095787342;
 Tue, 12 Oct 2021 20:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210929042908.1313874-1-stevensd@google.com> <20210929042908.1313874-5-stevensd@google.com>
 <YWYiJy1Z7VZ0SxAd@google.com>
In-Reply-To: <YWYiJy1Z7VZ0SxAd@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Wed, 13 Oct 2021 12:29:36 +0900
Message-ID: <CAD=HUj5HCdBBU2z=yJCCiAhTj0ARj-8XpLqdVbam7Kt9af+SSA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] KVM: mmu: remove over-aggressive warnings
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        open list <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 9:02 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Sep 29, 2021, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > Remove two warnings that require ref counts for pages to be non-zero, as
> > mapped pfns from follow_pfn may not have an initialized ref count.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 7 -------
> >  virt/kvm/kvm_main.c    | 2 +-
> >  2 files changed, 1 insertion(+), 8 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 5a1adcc9cfbc..3b469df63bcf 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -617,13 +617,6 @@ static int mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
> >
> >       pfn = spte_to_pfn(old_spte);
> >
> > -     /*
> > -      * KVM does not hold the refcount of the page used by
> > -      * kvm mmu, before reclaiming the page, we should
> > -      * unmap it from mmu first.
> > -      */
> > -     WARN_ON(!kvm_is_reserved_pfn(pfn) && !page_count(pfn_to_page(pfn)));
>
> Have you actually observed false positives with this WARN?  I would expect anything
> without a struct page to get filtered out by !kvm_is_reserved_pfn(pfn).

Those are the type of pfns that were responsible for CVE-2021-22543
[1]. One specific example is that amdgpu uses ttm_pool, which makes
higher order, non-compound allocation. Without the head/tail metadata,
only the first base page in such an allocation has non-zero
page_count.

[1] https://github.com/google/security-research/security/advisories/GHSA-7wq5-phmq-m584

> If you have observed false positives, I would strongly prefer we find a way to
> keep the page_count() sanity check, it has proven very helpful in the past in
> finding/debugging bugs during MMU development.

When we see a refcount of zero, I think we can look up spte->(gfn,
slot)->hva->vma and determine whether or not the zero refcount is
okay, based on vm_flags. That's kind of heavy for a debug check,
although at least we'd only pay the cost for unusual mappings. But it
still might make sense to switch to a MMU_WARN_ON, in that case. Or we
could just ignore the cost, since at least from a superficial reading
and some basic tests, tdp_mmu doesn't seem to execute this code path.

Thoughts? I'd lean towards MMU_WARN_ON, but I'd like to know what the
maintainers' preferences are before sending an updated patch series.

-David

>
> > -
> >       if (is_accessed_spte(old_spte))
> >               kvm_set_pfn_accessed(pfn);
> >
