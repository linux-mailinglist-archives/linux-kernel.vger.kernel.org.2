Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96823453C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCWAP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhCWAPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:15:36 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01197C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:15:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso11365060pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RS6wPVYyUBLVpylUrm+tt5pYjrHAQIAVImbkij7jmxA=;
        b=UB5HrDlqMb57TL/dG+wUYp3t10QglOWevw6bRuyHyB7j/XFQwT4DPXTJkWjdrWSPMP
         WY7oRe+j5OC+Ig5e1tJBt5ng9nwC4JIhFn1rOECvFTvDc/4Bfldk889gE0IJ5GBQQbZP
         RmGiuqikAML8sq6vTC3JuCu62ae4rWcY7I9tSJVdW0F834VTsVIpc3LHUiykMriiVRP9
         /h+jrTt8t3qkw8bRMHsA1FGFBVaYDZMWj+DTShvxDn+yOTUt0t5pWg9tdjYXuNEcSnQO
         VpYSh3zTolGEkrBI0c2bj6zHglK1dmF9e/5S0RKMsHBYYfzRpQmv9IY0n2rN6RHedHO8
         J2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RS6wPVYyUBLVpylUrm+tt5pYjrHAQIAVImbkij7jmxA=;
        b=gmL6+bGvgCVAN8AL6ZPhXrJg+bdWjom3yPPeFJLm846e3sw3Pr11otEivkmukS0XgO
         NBX359dmqa54Eq5FMj/TmZ1Eo83b5G4uXMdR1Vjz1++DVLSTkoBOewzFMsgXr7OO0tDD
         494nqEurhe72XLG5qjgWkSaxqor0Mv39KbnaQ6/oLwXmaxU+WNhvZKoHvyE/qtPKTSL5
         jbXpfGOPf5dmIAgX/rxDHIPnnM3nw6QYO68RlRWQDr74TEneT5sxQDE5pIu0iJ0V5KT7
         IHa6mRdohpXojS0ztQpnAwW5WE648SGlrQ0n8cF1Bv3rdCpAFb9JFyX/VQppermsrAFp
         RCJw==
X-Gm-Message-State: AOAM531wGnajw/9ifCfeV7OdXfbzHZYtKY4OvpxxuNnx/X3/ZjNxsSoc
        U6X7gigJssl9FSjU++kwznx5BA==
X-Google-Smtp-Source: ABdhPJzXA0SDIYTNNHtvoEjRYkmSgAP8Xpm9zHAa+s1cmO9DQfg1PI6iwt9jFeArQ2DPvhu1tVIQ4Q==
X-Received: by 2002:a17:90a:7344:: with SMTP id j4mr1482427pjs.223.1616458535347;
        Mon, 22 Mar 2021 17:15:35 -0700 (PDT)
Received: from google.com ([2620:15c:f:10:f8cd:ad3d:e69f:e006])
        by smtp.gmail.com with ESMTPSA id v11sm4272852pgg.68.2021.03.22.17.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:15:34 -0700 (PDT)
Date:   Mon, 22 Mar 2021 17:15:28 -0700
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Ensure TLBs are flushed when yielding
 during NX zapping
Message-ID: <YFkzIAVOeWS32fdX@google.com>
References: <20210319232006.3468382-1-seanjc@google.com>
 <20210319232006.3468382-3-seanjc@google.com>
 <CANgfPd_6d+SvJ-rQxP6k5nRmCsRFyUAJ93B0dE3NtpmdPR78wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd_6d+SvJ-rQxP6k5nRmCsRFyUAJ93B0dE3NtpmdPR78wg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021, Ben Gardon wrote:
> On Fri, Mar 19, 2021 at 4:20 PM Sean Christopherson <seanjc@google.com> wrote:
> > @@ -5960,19 +5963,21 @@ static void kvm_recover_nx_lpages(struct kvm *kvm)
> >                                       lpage_disallowed_link);
> >                 WARN_ON_ONCE(!sp->lpage_disallowed);
> >                 if (is_tdp_mmu_page(sp)) {
> > -                       kvm_tdp_mmu_zap_gfn_range(kvm, sp->gfn,
> > -                               sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level));
> > +                       gfn_end = sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level);
> > +                       flush = kvm_tdp_mmu_zap_gfn_range(kvm, sp->gfn, gfn_end,
> > +                                                         flush || !list_empty(&invalid_list));
> >                 } else {
> >                         kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
> >                         WARN_ON_ONCE(sp->lpage_disallowed);
> >                 }
> >
> >                 if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
> > -                       kvm_mmu_commit_zap_page(kvm, &invalid_list);
> > +                       kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
> 
> This pattern of waiting until a yield is needed or lock contention is
> detected has always been a little suspect to me because
> kvm_mmu_commit_zap_page does work proportional to the work done before
> the yield was needed. That seems like more work than we should like to
> be doing at that point.
> 
> The yield in kvm_tdp_mmu_zap_gfn_range makes that phenomenon even
> worse. Because we can satisfy the need to yield without clearing out
> the invalid list, we can potentially queue many more pages which will
> then all need to have their zaps committed at once. This is an
> admittedly contrived case which could only be hit in a high load
> nested scenario.
> 
> It could be fixed by forbidding kvm_tdp_mmu_zap_gfn_range from
> yielding. Since we should only need to zap one SPTE, the yield should
> not be needed within the kvm_tdp_mmu_zap_gfn_range call. To ensure
> that only one SPTE is zapped we would have to specify the root though.
> Otherwise we could end up zapping all the entries for the same GFN
> range under an unrelated root.

Hmm, I originally did exactly that, but changed my mind because this zaps far
more than 1 SPTE.  This is zapping a SP that could be huge, but is not, which
means it's guaranteed to have a non-zero number of child SPTEs.  The worst case
scenario is that SP is a PUD (potential 1gb page) and the leafs are 4k SPTEs.

But, I didn't consider the interplay between invalid_list and the TDP MMU
yielding.  Hrm.
