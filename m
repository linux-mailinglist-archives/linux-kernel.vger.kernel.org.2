Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF6F334B88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhCJWZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbhCJWZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:25:02 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A6DC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:25:02 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id u6so13598619oic.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQIYfjtgUHgni6JFAt7/VwxRLmto1V13D58zyPfKeVE=;
        b=USlEkai2cn+K/Clcj2iEzeKQbkFeTi8gGwovYsZQKNOrJDe24BnO7OJHsYmIPDRmZW
         PvRVhy+8Ar8zCPqq4PIsamPuVbDgLckQNLd9lPxDsGT+++o6nSgBWT/sUU23NL7SwcIw
         ORAB5T3OKfqhqfF+d0aXUuvAQ8+s6lAOw4drRs72Ox1TAdfV+77hXpqiARkI2qsOtaGX
         PfMwEEJfx5w1Q03eMXiuy5pN5Kdhsq2k9hYZq/xPrYkzkCqfUTEOrN6jKlwhA2qWiEIO
         8JQz4gxMWzdZJMgUyjReLWdN9mda7Il4oFHnDuCipVlXfVd2oR1JeMPk+0zf/fJoOI5a
         kh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQIYfjtgUHgni6JFAt7/VwxRLmto1V13D58zyPfKeVE=;
        b=VyHfIzDaj7IZ+tClOSgesYz3473NHfhrM28Kuh3KPoGExjUOzhQqyiGE+Rsh/TkdaP
         BqPwJbDWZc1Gq8sozpGMdhODIYA7dcutwcIqEQuuSYCZIBbQnatJzhyx5YkCGrb6XV7i
         OEs7/F4KEZMvHYQ1rBm8TiVAsEE3l3Avo48yxZWo+8x2+VytKRnkKF7znCX0v+3sZ0f6
         +lwlzQ40wgNI/g8PDROdnRTR4Jk+XcLEo/aVIy6ykmBhKuXZz9+QFqHApKB5KWcIwQcZ
         2rDiChzmH/jOQajjZTkdt3gDnVkI/DRZ6aIFDN5YLPlBG7sXFztmgG1rFTxT1Dy/yTtM
         S8lA==
X-Gm-Message-State: AOAM532jKxt9bQ4e20FxZLZh6e5NHm5IE6v+Gf0VSVdZ5UklHBDR9HQN
        w4jan+tZ4r0MhLhI7JPZTT99iR/trze1/iaQ6xXnMQ==
X-Google-Smtp-Source: ABdhPJzavjRAgQ/UaS0iEceAQhEvC+qkJPLJG4miOk18dlDF/qrAkUpGU5MyQElDu1zCc9dInB6yOmrkhunjHSO4hE4=
X-Received: by 2002:aca:3a41:: with SMTP id h62mr3945506oia.89.1615415101663;
 Wed, 10 Mar 2021 14:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20210310003029.1250571-1-seanjc@google.com> <07cf7833-c74a-9ae0-6895-d74708b97f68@redhat.com>
 <YEk2kBRUriFlCM62@google.com>
In-Reply-To: <YEk2kBRUriFlCM62@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 10 Mar 2021 14:24:50 -0800
Message-ID: <CANgfPd9WS+ntjdh87Gk97MQq6FYNUk8KVE3jQYfmgr2mFb3Stw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: Skip !MMU-present SPTEs when removing SP in
 exclusive mode
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 1:14 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Mar 10, 2021, Paolo Bonzini wrote:
> > On 10/03/21 01:30, Sean Christopherson wrote:
> > > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > > index 50ef757c5586..f0c99fa04ef2 100644
> > > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > > @@ -323,7 +323,18 @@ static void handle_removed_tdp_mmu_page(struct kvm *kvm, u64 *pt,
> > >                             cpu_relax();
> > >                     }
> > >             } else {
> > > +                   /*
> > > +                    * If the SPTE is not MMU-present, there is no backing
> > > +                    * page associated with the SPTE and so no side effects
> > > +                    * that need to be recorded, and exclusive ownership of
> > > +                    * mmu_lock ensures the SPTE can't be made present.
> > > +                    * Note, zapping MMIO SPTEs is also unnecessary as they
> > > +                    * are guarded by the memslots generation, not by being
> > > +                    * unreachable.
> > > +                    */
> > >                     old_child_spte = READ_ONCE(*sptep);
> > > +                   if (!is_shadow_present_pte(old_child_spte))
> > > +                           continue;
> > >                     /*
> > >                      * Marking the SPTE as a removed SPTE is not
> >
> > Ben, do you plan to make this path take mmu_lock for read?  If so, this
> > wouldn't be too useful IIUC.
>
> I can see kvm_mmu_zap_all_fast()->kvm_tdp_mmu_zap_all() moving to a shared-mode
> flow, but I don't think we'll ever want to move away from exclusive-mode zapping
> for kvm_arch_flush_shadow_all()->kvm_mmu_zap_all()->kvm_tdp_mmu_zap_all().  In
> that case, the VM is dead or dying; freeing memory should be done as quickly as
> possible.

Yeah, as Sean said, zapping under the MMU lock in write mode probably
shouldn't go away, even if we find we're able to do it in read mode in
some flows.

This optimization also makes me think we could also skip the
__handle_changed_spte call in the read mode case if the SPTE change
was !PRESENT -> REMOVED.
