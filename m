Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEFA3DEABC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhHCKUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhHCKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:20:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8047AC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:20:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b13so13858723wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BH6VSubQLcCEeiXp46qRZOXRNaTnzvfumnh86E0J8aM=;
        b=NQYGJM/XzsrAJWy8BNxS7s5O7GkQgGVRYjx+8M/j9wHLNhSSVCVnmOw51NtulDRnRA
         YCrgVK54gw85K3GHJCd3kW0jmE48JlVl28VXS9mK9YrBDrotXYSyUcT+NhBO+eMx71sQ
         8KmrjMkyKg0DgnEJfodsW3C/yzAu4Y9E1ZOaW1AycJiMWXRAhJt2GqL22/BTK42XNN1m
         EfTqLZ5rwAO1wGEkJz4bWP/rrNEq64U+FN9ar5keUt3upGBQWHWvJ5K5Zph3vhV+fgQu
         grHCCISsAfzFD4PmL3Hhv8XvH+7cI0Sd117guye40xRgVwI2ospt3iM5xcn81EcjojHw
         VVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BH6VSubQLcCEeiXp46qRZOXRNaTnzvfumnh86E0J8aM=;
        b=PGVoAleV/GKTAD/UY0i2JIkNUScjqzAiEUGmYc8rdm/8uAlL0dlzvJ9ZuZ9YohM6TA
         wzHvZ5LtTCzUGXIdlDKHpDMRHF1orzff8+5GBBIQEC0AzWNqJaExZSF+uKe5lfASiaJc
         ZPbzvzu7B1yity+tH1KaZYEEhuITEiMpijpWWhs9fhhaSge9G61X7ELIL5IYQMMfIg7R
         m1IXiUbDJCz+mO2XpzrhEsKQVSUtPRPy4zvfWputzqs7PucB8ifveMuiY0yvJb2VdRxd
         poDQ+ST1fA2J6GY3jtyyXSmeg6m12JWwI5DNqgclVmLd9KsrawlSNOAxve2hDbroq6AY
         oYaw==
X-Gm-Message-State: AOAM532bBFuzTowxsFMiUMPTt6Gg2KY2fwsMmnEabQl4BvdtIPHzykfc
        5JUixCGMgkxYy+iUxmdWjiLOoA==
X-Google-Smtp-Source: ABdhPJz5+GPO3jAnmWN6At04JUGrSTja+UukYyBxLjRle00PwQsgFNeR9zO+8tsOnRxejD25t1bw1g==
X-Received: by 2002:a5d:6589:: with SMTP id q9mr22819763wru.284.1627986004001;
        Tue, 03 Aug 2021 03:20:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:754:7d1b:7303:129a])
        by smtp.gmail.com with ESMTPSA id e3sm14173327wrw.51.2021.08.03.03.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 03:20:03 -0700 (PDT)
Date:   Tue, 3 Aug 2021 11:20:00 +0100
From:   Quentin Perret <qperret@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH v3 13/21] KVM: arm64: Expose host stage-2 manipulation
 helpers
Message-ID: <YQkYUOaXx7+/EQP/@google.com>
References: <20210729132818.4091769-1-qperret@google.com>
 <20210729132818.4091769-14-qperret@google.com>
 <CA+EHjTxTaPc=bt_kyXf0TE85v5eyHnq0o3KQ3Pd6+kOwmm5oMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTxTaPc=bt_kyXf0TE85v5eyHnq0o3KQ3Pd6+kOwmm5oMw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 Aug 2021 at 13:13:20 (+0200), Fuad Tabba wrote:
> Hi Quentin,
> 
> On Thu, Jul 29, 2021 at 3:28 PM Quentin Perret <qperret@google.com> wrote:
> >
> > We will need to manipulate the host stage-2 page-table from outside
> > mem_protect.c soon. Introduce two functions allowing this, and make
> > them usable to users of mem_protect.h.
> >
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 ++
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 17 ++++++++++++++++-
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > index ae355bfd8c01..47c2a0c51612 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > @@ -49,6 +49,8 @@ extern struct host_kvm host_kvm;
> >  int __pkvm_prot_finalize(void);
> >  int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
> >
> > +int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot);
> > +int host_stage2_set_owner_locked(u64 start, u64 end, u8 owner_id);
> >  int kvm_host_prepare_stage2(void *pgt_pool_base);
> >  void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 70c57d2c3024..a7f6134789e0 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -272,6 +272,21 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
> >         return 0;
> >  }
> >
> > +int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot)
> > +{
> > +       hyp_assert_lock_held(&host_kvm.lock);
> > +
> > +       return host_stage2_try(__host_stage2_idmap, start, end, prot);
> > +}
> > +
> > +int host_stage2_set_owner_locked(u64 start, u64 end, u8 owner_id)
> > +{
> > +       hyp_assert_lock_held(&host_kvm.lock);
> > +
> > +       return host_stage2_try(kvm_pgtable_stage2_set_owner, &host_kvm.pgt,
> > +                              start, end - start, &host_s2_pool, owner_id);
> > +}
> 
> This is a potential issue elsewhere as well, but all functions in
> kvm_pgtable.h, including kvm_pgtable_stage2_set_owner, specify an
> address range via address and size. The two you have introduced here
> take a start and an end. I'm not sure if making these two consistent
> with the ones in kvm_pgtable.h would be good, or would just complicate
> things in other places.

Good point, and it looks like specifying these two with start-size
parameters would simplify the callers a tiny bit as well, so I'll fold
that in v4.

Thanks,
Quentin
