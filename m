Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9AE3DEB57
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhHCKz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbhHCKzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:55:20 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C26C061798
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:55:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 21so27671283oin.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WSoxwt2C8CYjlH9xHjQ+oboKdUtA9Rzp9ra0MKS0sc=;
        b=wM20ZIpUC2FBSnnZrCMauN6hWl7/tiPmQyuM3X7RY2OiF4DcfWAA2K9WP/8KiiIEcb
         dQVeVU/X0ukr8213stUsNNy617xD/83+c4SlsE4XlD770TEq4lro5WA9FRV9o7wOs3Ef
         8Uuki8kxrh6oIA2KUPMk9YsXcoYbI1HcYHjL4nGMntTWKirqZM+8LVJMxsFvaL5FQfr2
         sckZkQOCMlJVPa/xj4T04ySWt7wqy1HKXBYhPOBrzbSy8+przMwH0dWrwWa1XkNRjD/2
         LC7QS1RGoU0ZMwsBP+q19aKABLCS/wU/1xc+mOWMM5NinLyNOxClp0EdnNAX9TmlBpJ4
         1dAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WSoxwt2C8CYjlH9xHjQ+oboKdUtA9Rzp9ra0MKS0sc=;
        b=ZIUlsdMonhNpC1Aydd3z7TbvlMJ7GA/YCiyGWPnMi1Hu3x8PILhIkG36DRu45oTGKs
         Vk8RUE+24NL8gZ+jsWkLY+x2jaS6AQuz8OpxULp7OzspZi1cfRHZSMH2avNOKVmJ9va6
         KzmfvNqHIxXH3DAVJnRXaMtvE0P1R3osX4PFX/fgH8pphlHRDUsG/CoHxtd7knqsiC3T
         KrgTKOikMi7EY3Z+6nTKztsi5m/sWEEX8MtzOe9sgQG6E6IBEXaIcqA4q8CeatNqte9g
         ZCFNwmpXtz2SJU6m9tm8GEAciv1qicBcvY6eGspdYIBZ+uhmow1m2gJuaaB2OxZwJjYT
         /byw==
X-Gm-Message-State: AOAM532JhyYJHfJI/sf29P2uxkBYJdpUK4te6FxWBCIl7TgFtYCLMUtE
        4wiGZbmOlsXErEsKWmHjdiOBmkQnkwRCotYSukkIXQ==
X-Google-Smtp-Source: ABdhPJwYlFcjoKB1AsgH5I1o+peqrhsWTuZXg6FQYN4DxDCoFu6YtiZbcpIvRedwV2a/4OLXMpfMsVv2ddav3MvA0Os=
X-Received: by 2002:a05:6808:1981:: with SMTP id bj1mr1110754oib.8.1627988109163;
 Tue, 03 Aug 2021 03:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-18-qperret@google.com>
 <CA+EHjTwfsA8Z+_dJzqjsBXJ_SSC55Bcxc6HQ_Q4OJDrqmk0Unw@mail.gmail.com> <YQkboRdFP9oPVJgn@google.com>
In-Reply-To: <YQkboRdFP9oPVJgn@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 3 Aug 2021 12:54:32 +0200
Message-ID: <CA+EHjTym0agkuzuy1ZnxU7QbL4jP1xmW4sX2YixBCVo5cSKzog@mail.gmail.com>
Subject: Re: [PATCH v3 17/21] KVM: arm64: Mark host bss and rodata section as shared
To:     Quentin Perret <qperret@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

> > > +       ret = pkvm_create_mappings(__hyp_bss_end, __bss_stop, prot);
> >
> > nit: for clarity, I wonder if it might be good to create an alias of
> > __hyp_bss_end as __bss_start or something. When it's been moved here,
> > it sticks out a bit more and makes the reader wonder about the
> > significance of __hyp_bss_end.
>
> I understand what you mean, but I'm not sure this aliasing is really
> going to clarify things much. We have a comment in arm.c (see
> init_hyp_mode()) to explain exactly why we're doing this, so maybe it
> would be worth adding it here too. WDYT?

Not sure to be honest. Comments are good, until they're stale, and
replicating the comment increases the odds of that happening. No
strong opinion either way.

> > > +       if (ret)
> > > +               return ret;
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -148,6 +159,57 @@ static void hpool_put_page(void *addr)
> > >         hyp_put_page(&hpool, addr);
> > >  }
> > >
> > > +static int finalize_host_mappings_walker(u64 addr, u64 end, u32 level,
> > > +                                        kvm_pte_t *ptep,
> > > +                                        enum kvm_pgtable_walk_flags flag,
> > > +                                        void * const arg)
> > > +{
> > > +       enum kvm_pgtable_prot prot;
> > > +       enum pkvm_page_state state;
> > > +       kvm_pte_t pte = *ptep;
> > > +       phys_addr_t phys;
> > > +
> > > +       if (!kvm_pte_valid(pte))
> > > +               return 0;
> > > +
> > > +       if (level != (KVM_PGTABLE_MAX_LEVELS - 1))
> > > +               return -EINVAL;
> >
> > I know that it's not in scope here, but I'm wondering whether we
> > should be checking for KVM_PTE_TYPE_PAGE instead of the level. Maybe
>
> Well these would check different things no?
>
> > it would be good to have a helper somewhere for all these checks both
> > for clarity and to ensure that nothing has gone wrong with the pte.
>
> The reason I need this check is just to make sure the call to
> host_stage2_idmap_locked() further down is correct with a hardcoded
> PAGE_SIZE size. The alternative would be to not be lazy and actually
> compute the current granule size based on the level and use that, as
> that would make this code robust to using block mappings at EL2 stage-1
> in the future.
>
> And I'll fix this up for v4.

I get it now. Thanks!
/fuad


> Cheers,
> Quentin
>
> > > +
> > > +       phys = kvm_pte_to_phys(pte);
> > > +       if (!addr_is_memory(phys))
> > > +               return 0;
> > > +
> > > +       /*
> > > +        * Adjust the host stage-2 mappings to match the ownership attributes
> > > +        * configured in the hypervisor stage-1.
> > > +        */
> > > +       state = pkvm_getstate(kvm_pgtable_hyp_pte_prot(pte));
> > > +       switch (state) {
> > > +       case PKVM_PAGE_OWNED:
> > > +               return host_stage2_set_owner_locked(phys, phys + PAGE_SIZE, pkvm_hyp_id);
> > > +       case PKVM_PAGE_SHARED_OWNED:
> > > +               prot = pkvm_mkstate(KVM_PGTABLE_PROT_RWX, PKVM_PAGE_SHARED_BORROWED);
> > > +               break;
> > > +       case PKVM_PAGE_SHARED_BORROWED:
> > > +               prot = pkvm_mkstate(KVM_PGTABLE_PROT_RWX, PKVM_PAGE_SHARED_OWNED);
> > > +               break;
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       return host_stage2_idmap_locked(phys, phys + PAGE_SIZE, prot);
> > > +}
> > > +
> > > +static int finalize_host_mappings(void)
> > > +{
> > > +       struct kvm_pgtable_walker walker = {
> > > +               .cb     = finalize_host_mappings_walker,
> > > +               .flags  = KVM_PGTABLE_WALK_LEAF,
> > > +       };
> > > +
> > > +       return kvm_pgtable_walk(&pkvm_pgtable, 0, BIT(pkvm_pgtable.ia_bits), &walker);
> > > +}
> > > +
> > >  void __noreturn __pkvm_init_finalise(void)
> > >  {
> > >         struct kvm_host_data *host_data = this_cpu_ptr(&kvm_host_data);
> > > @@ -167,6 +229,10 @@ void __noreturn __pkvm_init_finalise(void)
> > >         if (ret)
> > >                 goto out;
> > >
> > > +       ret = finalize_host_mappings();
> > > +       if (ret)
> > > +               goto out;
> > > +
> > >         pkvm_pgtable_mm_ops = (struct kvm_pgtable_mm_ops) {
> > >                 .zalloc_page = hyp_zalloc_hyp_page,
> > >                 .phys_to_virt = hyp_phys_to_virt,
> > > --
> > > 2.32.0.432.gabb21c7263-goog
> > >
> >
> > Thanks,
> > /fuad
