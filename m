Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182F8352C05
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhDBO70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbhDBO7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:59:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5950C06178C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 07:59:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id v10so3761331pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hrWlBAMIox9uyp5vA/6pgwPUQG03jLxXChap4JWk798=;
        b=Wis80br4QxI0udXSM5bgb12ub29OxkCYgsG+Q5MaHbKjRYNZTxX2dKGqJxK+5x27Ec
         bCjK5MvvUurkyJh+2dVl5bUVlOF+S5kkzM86t1vFaJEMUN3T8Kr2U41JVg3ikRq9VsY9
         bmvTxU20lmUiRhm6QGV5OSagHM6CMIS3zcbQPID23xudkFfFOfaNfDFrfAAV9MBGBCbG
         4fo9i95YmINHH5yrkVF5nSKywYI/L+Mv9lKQ9OfuRtFbwYvD08rHo26eFSvgUFwVqUjF
         9D9+2OjiT3WWi7P0x9fBHYTDN17PeeBVM5FGjv80+DwDvYvLLhKy7ATI6OvoR6zd0tW3
         xYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hrWlBAMIox9uyp5vA/6pgwPUQG03jLxXChap4JWk798=;
        b=Rbxu2bwmssag4Kvrm+n85R/Poxe64LLRw2V9qiy9KKCOlqlNr9uyuSCNLbgOspU8Oo
         jBtjDZVS9abAa2qm3UcvhClsJ1K9R00AKPS93i475pRLnEFm3A3dB2+vfn0nepW0qyNo
         IiBYFZl8+UB5FiyK3JA7CNcc34JMovyruQC/VU68fxsuqVunZJf5MTIUPYqq1NhR8MS3
         nVzOGHHytvtkqPsmRxFS+2ZW2IBnH+uK41u2mJW95iZbu7UFGVtM1srBQhS+SPqLsm5J
         r4d/8Jy1kIVUQNkqyM2VOyz5WDkpWDR4/G3ZyBu+gy95sGOdJnW+7pZVqwV0CYvSDLEh
         FPNw==
X-Gm-Message-State: AOAM532uJ4kcI4y9A1tK/It5GFwkGudnfe5g6ixxu1I8V0ReqZklQ4Sp
        A2/EjlebcPuQiviknXYfU0X4QA==
X-Google-Smtp-Source: ABdhPJwt/NANo8uiyFDGCSZL9IUa09CiSHlR3SZWQT4n9NqXGj8DMBBrtVhreCbJVQp+DfbrA8SQSg==
X-Received: by 2002:a62:7708:0:b029:1ee:f656:51d5 with SMTP id s8-20020a6277080000b02901eef65651d5mr12750775pfc.59.1617375562873;
        Fri, 02 Apr 2021 07:59:22 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id b186sm8540014pfb.170.2021.04.02.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 07:59:22 -0700 (PDT)
Date:   Fri, 2 Apr 2021 14:59:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v2 09/10] KVM: Don't take mmu_lock for range invalidation
 unless necessary
Message-ID: <YGcxRmzbEr3kPsWE@google.com>
References: <20210402005658.3024832-1-seanjc@google.com>
 <20210402005658.3024832-10-seanjc@google.com>
 <417bd6b5-b7d0-ed22-adae-02150cdbfebe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417bd6b5-b7d0-ed22-adae-02150cdbfebe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021, Paolo Bonzini wrote:
> On 02/04/21 02:56, Sean Christopherson wrote:
> > Avoid taking mmu_lock for unrelated .invalidate_range_{start,end}()
> > notifications.  Because mmu_notifier_count must be modified while holding
> > mmu_lock for write, and must always be paired across start->end to stay
> > balanced, lock elision must happen in both or none.  To meet that
> > requirement, add a rwsem to prevent memslot updates across range_start()
> > and range_end().
> > 
> > Use a rwsem instead of a rwlock since most notifiers _allow_ blocking,
> > and the lock will be endl across the entire start() ... end() sequence.
> > If anything in the sequence sleeps, including the caller or a different
> > notifier, holding the spinlock would be disastrous.
> > 
> > For notifiers that _disallow_ blocking, e.g. OOM reaping, simply go down
> > the slow path of unconditionally acquiring mmu_lock.  The sane
> > alternative would be to try to acquire the lock and force the notifier
> > to retry on failure.  But since OOM is currently the _only_ scenario
> > where blocking is disallowed attempting to optimize a guest that has been
> > marked for death is pointless.
> > 
> > Unconditionally define and use mmu_notifier_slots_lock in the memslots
> > code, purely to avoid more #ifdefs.  The overhead of acquiring the lock
> > is negligible when the lock is uncontested, which will always be the case
> > when the MMU notifiers are not used.
> > 
> > Note, technically flag-only memslot updates could be allowed in parallel,
> > but stalling a memslot update for a relatively short amount of time is
> > not a scalability issue, and this is all more than complex enough.
> 
> Proposal for the locking documentation:

Argh, sorry!  Looks great, I owe you.

> diff --git a/Documentation/virt/kvm/locking.rst b/Documentation/virt/kvm/locking.rst
> index b21a34c34a21..3e4ad7de36cb 100644
> --- a/Documentation/virt/kvm/locking.rst
> +++ b/Documentation/virt/kvm/locking.rst
> @@ -16,6 +16,13 @@ The acquisition orders for mutexes are as follows:
>  - kvm->slots_lock is taken outside kvm->irq_lock, though acquiring
>    them together is quite rare.
> +- The kvm->mmu_notifier_slots_lock rwsem ensures that pairs of
> +  invalidate_range_start() and invalidate_range_end() callbacks
> +  use the same memslots array.  kvm->slots_lock is taken outside the
> +  write-side critical section of kvm->mmu_notifier_slots_lock, so
> +  MMU notifiers must not take kvm->slots_lock.  No other write-side
> +  critical sections should be added.
> +
>  On x86, vcpu->mutex is taken outside kvm->arch.hyperv.hv_lock.
>  Everything else is a leaf: no other lock is taken inside the critical
> 
> Paolo
> 
