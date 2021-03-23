Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8765A346510
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhCWQ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhCWQ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:26:25 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A82C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:26:25 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id t6so18696373ilp.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUNBxRkAkOtRY1OiV0crY0KIix9dM5aWEuy0SY7J1Gs=;
        b=dcPE+srCxCWpXsH961eV0+dJ/taytb1qF8u5NYNy5fMwZ+yLZ6+RyfM7CH3my4ba0u
         A5/N66JLUZSZKXtMVLh/TCz414yazr4GaLu5DgdYXb2vwx8iwuVz9MFGv1qa2shn28YI
         BVXBpMN7yUnWGzB8/eCxWIfvknwAm5e48moZA19OcRn1tlXH6CDRTSj3gVwZuL24OueV
         4pKzGh2AGjwBgqNapPJma3PYYsmf5S/Vv6cQp6ECZhNixBR7DDPe4B5dugPAPAs74qAR
         L4rZ1RbqcDAhCp/7ItDKurx7zA3s9Ps6ia111LLLrN1curCqA9bSts1nYdcjRRf0BKs/
         J5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUNBxRkAkOtRY1OiV0crY0KIix9dM5aWEuy0SY7J1Gs=;
        b=E5+rQKFBvZR6Hd8RS3+pMIeXI+2qbSVF8bKQ2DHWnbMLbye0tmj+6S0asXyq2H0wnM
         8MsIUWGGMkC0NKuNrzD+1iiJJ2y1Ol6FbGEA99K5vIHMry2qiYpmzWyefPzCMyrY2xI6
         wcgJf8lDaRkbAeyX6M82IQN/63dJ4+m7/2rrpajl4LiUIES8om/TUGNT3zmPasfxAEro
         t6CktSVHYsLVxZK+RIEkA+Rzo6cclv4sCpk/QfqifSsXZ1y5GpkWhnZgWRG1V/OAVOj4
         /11OxiU/vO+t2Fxwn7Lubuu/gDuVyBxl21zC5cKUaC+B/4msomG7X7uyVXn2CwvA526x
         NgHQ==
X-Gm-Message-State: AOAM532RL25dkAtr6P7vhejF98IGWthtQut240jN+j6IbGbKDmkYJGVU
        igG/xVBbfxZxRUkdiCVc1mJwYU5nxksMB6iHxpIvqQ==
X-Google-Smtp-Source: ABdhPJxiWIgvPfl8wUjGs53X8G5LEONTes5gCcGWaxRVmCAD2wYkVHXvRFHP1BbC5uR4+LdJF0cev4pnh7ixq56vgvw=
X-Received: by 2002:a05:6e02:d0e:: with SMTP id g14mr5433785ilj.285.1616516784956;
 Tue, 23 Mar 2021 09:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210319232006.3468382-1-seanjc@google.com> <20210319232006.3468382-3-seanjc@google.com>
 <CANgfPd_6d+SvJ-rQxP6k5nRmCsRFyUAJ93B0dE3NtpmdPR78wg@mail.gmail.com> <YFkzIAVOeWS32fdX@google.com>
In-Reply-To: <YFkzIAVOeWS32fdX@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 23 Mar 2021 09:26:14 -0700
Message-ID: <CANgfPd8ti7Wa3YnPxgVsEiUzhOzraEcKoLyXUW9E=Wjz4L-oNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Ensure TLBs are flushed when yielding
 during NX zapping
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

On Mon, Mar 22, 2021 at 5:15 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Mar 22, 2021, Ben Gardon wrote:
> > On Fri, Mar 19, 2021 at 4:20 PM Sean Christopherson <seanjc@google.com> wrote:
> > > @@ -5960,19 +5963,21 @@ static void kvm_recover_nx_lpages(struct kvm *kvm)
> > >                                       lpage_disallowed_link);
> > >                 WARN_ON_ONCE(!sp->lpage_disallowed);
> > >                 if (is_tdp_mmu_page(sp)) {
> > > -                       kvm_tdp_mmu_zap_gfn_range(kvm, sp->gfn,
> > > -                               sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level));
> > > +                       gfn_end = sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level);
> > > +                       flush = kvm_tdp_mmu_zap_gfn_range(kvm, sp->gfn, gfn_end,
> > > +                                                         flush || !list_empty(&invalid_list));
> > >                 } else {
> > >                         kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
> > >                         WARN_ON_ONCE(sp->lpage_disallowed);
> > >                 }
> > >
> > >                 if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
> > > -                       kvm_mmu_commit_zap_page(kvm, &invalid_list);
> > > +                       kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
> >
> > This pattern of waiting until a yield is needed or lock contention is
> > detected has always been a little suspect to me because
> > kvm_mmu_commit_zap_page does work proportional to the work done before
> > the yield was needed. That seems like more work than we should like to
> > be doing at that point.
> >
> > The yield in kvm_tdp_mmu_zap_gfn_range makes that phenomenon even
> > worse. Because we can satisfy the need to yield without clearing out
> > the invalid list, we can potentially queue many more pages which will
> > then all need to have their zaps committed at once. This is an
> > admittedly contrived case which could only be hit in a high load
> > nested scenario.
> >
> > It could be fixed by forbidding kvm_tdp_mmu_zap_gfn_range from
> > yielding. Since we should only need to zap one SPTE, the yield should
> > not be needed within the kvm_tdp_mmu_zap_gfn_range call. To ensure
> > that only one SPTE is zapped we would have to specify the root though.
> > Otherwise we could end up zapping all the entries for the same GFN
> > range under an unrelated root.
>
> Hmm, I originally did exactly that, but changed my mind because this zaps far
> more than 1 SPTE.  This is zapping a SP that could be huge, but is not, which
> means it's guaranteed to have a non-zero number of child SPTEs.  The worst case
> scenario is that SP is a PUD (potential 1gb page) and the leafs are 4k SPTEs.

It's true that there are potentially 512^2 child sptes, but the code
to clear those after the single PUD spte is cleared doesn't yield
anyway. If the TDP MMU is only  operating with one root (as we would
expect in most cases), there should only be one chance for it to
yield.

I've considered how we could allow the recursive changed spte handlers
to yield, but it gets complicated quite fast because the caller needs
to know if it yielded and reset the TDP iterator to the root, and
there are some cases (mmu notifiers + vCPU path) where yielding is not
desirable.

>
> But, I didn't consider the interplay between invalid_list and the TDP MMU
> yielding.  Hrm.
