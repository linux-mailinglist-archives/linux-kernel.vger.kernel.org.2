Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A09E3DEAC9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhHCKZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbhHCKYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:24:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0177DC061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:24:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p5so24762052wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d6Nsv/xNSHs2Om+wxrSlYuqNQWvEFvnUhoy5ThkMx0Q=;
        b=FP0D12uUpP5OBvBJhAyl2dhq/xIpjHa4hZWkq4WRNfgxNtiPI5C6WPYX+SGVeC3ukl
         ZWEGnBrN5n6lwuVMkQyX0O7o8hsbO7aJ8dYH1ye3Tpp7c4cGB/2sVFrXYy12qm5rGvds
         hkTc+cakkXC9bcPjo4laVstTV0GDVZrfNNWrsIMRP+Tau4jPgy2iP2jvKkZiDWjfFrFy
         cP6Sozo7M0T5i08TOHBQfZd/TJI5Es/WHVej0aFyjpVZQZC9d2Fe7bnTPaB8Gy3tB//n
         ETrsOto9MjuxzgoSsMaWII+VfYTMe60WGl3u0yO5efg66bp2CHBuitvheec6vOCRi9JF
         UI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d6Nsv/xNSHs2Om+wxrSlYuqNQWvEFvnUhoy5ThkMx0Q=;
        b=ZVm0fp1keQZOSOxxEJf0vneWk5edfEDGYPhyo7gipWV5kaxrvJpPWy4zRJG/5o2h+j
         l3p2rAtXcnaYaxUyezXzmx+PAXlDVY2Ia/yBtMkHzfqy390LNIwR3tDb6LmfZN7STKuV
         v02/5otPxU6ntoZF9cRRPC4PrLYV4EbO6z4fkShuXrQM3Z72NfvxeayWbP9iFXnjKB4s
         nlcN4e1JV1oD4/9nIv7JyQhKTzGa4waU4qyuJU9yHK2U/4YMLAQrYufFngrbOZVbRkVN
         wzOE5b/JeFpohkpgI8+rpd6PhMXlH99twVI/Vylev0cK2UrE6Hx15YiH9t3c+ArziGtt
         5WnA==
X-Gm-Message-State: AOAM533aGPw3Ma+qDZAJWjYTBYQiSx6nYkV6SzFhS7AAjsJZqHqTfrOt
        02aYZCAlmkvH+wwIo4yYfMWl6g==
X-Google-Smtp-Source: ABdhPJwblvZME7yKQlNor7Ndnl8b41R6jAh8T6Km7UHNqfvDgBQx1oplfzKTG7fCFMoS/YBxs1eocA==
X-Received: by 2002:adf:f2cd:: with SMTP id d13mr22244889wrp.315.1627986257474;
        Tue, 03 Aug 2021 03:24:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:754:7d1b:7303:129a])
        by smtp.gmail.com with ESMTPSA id v15sm2179876wmj.39.2021.08.03.03.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 03:24:17 -0700 (PDT)
Date:   Tue, 3 Aug 2021 11:24:14 +0100
From:   Quentin Perret <qperret@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH v3 16/21] KVM: arm64: Enable retrieving protections
 attributes of PTEs
Message-ID: <YQkZTnVLwVYDFvoA@google.com>
References: <20210729132818.4091769-1-qperret@google.com>
 <20210729132818.4091769-17-qperret@google.com>
 <CA+EHjTwL+grX__03SfeDdxeppjSovEZhKRvqjmA_4kSBwsjswg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTwL+grX__03SfeDdxeppjSovEZhKRvqjmA_4kSBwsjswg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 Aug 2021 at 16:52:49 (+0200), Fuad Tabba wrote:
> Hi Quentin,
> 
> On Thu, Jul 29, 2021 at 3:29 PM Quentin Perret <qperret@google.com> wrote:
> >
> > Introduce helper functions in the KVM stage-2 and stage-1 page-table
> > manipulation library allowing to retrieve the enum kvm_pgtable_prot of a
> > PTE. This will be useful to implement custom walkers outside of
> > pgtable.c.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h | 20 +++++++++++++++
> >  arch/arm64/kvm/hyp/pgtable.c         | 37 ++++++++++++++++++++++++++++
> >  2 files changed, 57 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index d5ca9b6ce241..7ff9f52239ba 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -505,4 +505,24 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
> >   */
> >  int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
> >                          kvm_pte_t *ptep, u32 *level);
> > +
> > +/**
> > + * kvm_pgtable_stage2_pte_prot() - Retrieve the protection attributes of a
> > + *                                stage-2 Page-Table Entry.
> > + * @pte:       Page-table entry
> > + *
> > + * Return: protection attributes of the page-table entry in the enum
> > + *        kvm_pgtable_prot format.
> > + */
> > +enum kvm_pgtable_prot kvm_pgtable_stage2_pte_prot(kvm_pte_t pte);
> > +
> > +/**
> > + * kvm_pgtable_hyp_pte_prot() - Retrieve the protection attributes of a stage-1
> > + *                             Page-Table Entry.
> > + * @pte:       Page-table entry
> > + *
> > + * Return: protection attributes of the page-table entry in the enum
> > + *        kvm_pgtable_prot format.
> > + */
> > +enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte);
> >  #endif /* __ARM64_KVM_PGTABLE_H__ */
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 1915489bb127..a6eda8f23cb6 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -363,6 +363,26 @@ static int hyp_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
> >         return 0;
> >  }
> >
> > +enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte)
> > +{
> > +       enum kvm_pgtable_prot prot = pte & KVM_PTE_LEAF_ATTR_HI_SW;
> > +       u32 ap;
> > +
> > +       if (!kvm_pte_valid(pte))
> > +               return prot;
> > +
> > +       if (!(pte & KVM_PTE_LEAF_ATTR_HI_S1_XN))
> > +               prot |= KVM_PGTABLE_PROT_X;
> > +
> > +       ap = FIELD_GET(KVM_PTE_LEAF_ATTR_LO_S1_AP, pte);
> > +       if (ap == KVM_PTE_LEAF_ATTR_LO_S1_AP_RO)
> > +               prot |= KVM_PGTABLE_PROT_R;
> > +       else if (ap == KVM_PTE_LEAF_ATTR_LO_S1_AP_RW)
> > +               prot |= KVM_PGTABLE_PROT_R | KVM_PGTABLE_PROT_W;
> 
> nit: why not use the freshly minted KVM_PGTABLE_PROT_RW?

No good reason, I'll fix that up, thanks!
