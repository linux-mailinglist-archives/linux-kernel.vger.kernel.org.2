Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DA44234E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhJFAYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbhJFAYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:24:31 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06891C061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 17:22:40 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id u32so1444147ybd.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 17:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UpXLrh9ISxkV7+Pc26q+lSfTSBXoeABrn82Q2xNxwo=;
        b=ehSdwoVRZn9dzdH7fY9EO3PZLPES+2mwNTF8U86S5yn8M/SQRYUUKP42+aVVdYzq+9
         781w5Op0tRfCJGBEj1xtyN39UXZ92TAXGzIyEgnqYIbKyFFisBPTHsbqFkOtGe2msLII
         tmScH509RD6vXXH4THRdGf4Dj1BKVaAbI8K0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UpXLrh9ISxkV7+Pc26q+lSfTSBXoeABrn82Q2xNxwo=;
        b=5Ndlsjf3wF1ld2UEvvSUAX7zu0eshLYG+7T3AkAP820MJEyl/v/EaiFFkN6zZ8rSNS
         lgPGVNfx+71fp0utesbD617GgeY/d6kiUifbnogkUnAYnTTcfYc+EliYA0fsept6pq29
         waiBcVsg84hXJ5/4SZ/uhF8yI4f0c2Uz+gXYd4IMpCeMLVXwHhxWFA8VJDhLjWTEa6e1
         mgD/KR5lT5c+zKiPNbjPgdgwOQPuCxcWFlktyQCzVvZhXZdUUVwXazHbB3J9oFMPyjH9
         jVGOq0zPjO6h81cyWlhw9DBNQx71N/iR2pbdMxK4Z397D2IqJXgDiui8QLG7PDZw6Yvd
         7zgQ==
X-Gm-Message-State: AOAM532q9f86WRmWQjIMDUc5KGrBj7fKPIq89YwAuiOafi6jpMDe4F+j
        eG/2bZDFQG/v7+JPFkuav0/c2yVmrS5Au9rJLAimrQ==
X-Google-Smtp-Source: ABdhPJxWmhGNgWvP+DDobatjNQIbyTyTdSThgXaXp6AUedp/m2bJobNc3ftswm5zZAR60U4GaS7lk9i10qDc258Z/ZI=
X-Received: by 2002:a25:4586:: with SMTP id s128mr24279102yba.361.1633479759262;
 Tue, 05 Oct 2021 17:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211001110106.15056-1-colin.king@canonical.com> <YVxyNgyyxA7EnvJb@google.com>
In-Reply-To: <YVxyNgyyxA7EnvJb@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Wed, 6 Oct 2021 09:22:28 +0900
Message-ID: <CAD=HUj7t0qRbpzXDs4EZDeLUK=cTTCAxSbh8V0FUCMzpq7rNFg@mail.gmail.com>
Subject: Re: [PATCH][next] KVM: x86: Fix allocation sizeof argument
To:     Sean Christopherson <seanjc@google.com>
Cc:     Colin King <colin.king@canonical.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 12:41 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Oct 01, 2021, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The allocation for *gfn_track should be for a slot->npages lot of
> > short integers, however the current allocation is using sizeof(*gfn_track)
> > and that is the size of a pointer, which is too large. Fix this by
> > using sizeof(**gfn_track) instead.
> >
> > Addresses-Coverity: ("Wrong sizeof argument")
> > Fixes: 35b330bba6a7 ("KVM: x86: only allocate gfn_track when necessary")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  arch/x86/kvm/mmu/page_track.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> > index bb5d60bd4dbf..5b785a5f7dc9 100644
> > --- a/arch/x86/kvm/mmu/page_track.c
> > +++ b/arch/x86/kvm/mmu/page_track.c
> > @@ -92,7 +92,7 @@ int kvm_page_track_enable_mmu_write_tracking(struct kvm *kvm)
> >               slots = __kvm_memslots(kvm, i);
> >               kvm_for_each_memslot(slot, slots) {
> >                       gfn_track = slot->arch.gfn_track + KVM_PAGE_TRACK_WRITE;
> > -                     *gfn_track = kvcalloc(slot->npages, sizeof(*gfn_track),
> > +                     *gfn_track = kvcalloc(slot->npages, sizeof(**gfn_track),
> >                                             GFP_KERNEL_ACCOUNT);
>
> Eww (not your patch, the original code).  IMO the double indirection is completely
> unnecessary, e.g. I find this far easier to follow
>
> diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> index bb5d60bd4dbf..8cae41b831dd 100644
> --- a/arch/x86/kvm/mmu/page_track.c
> +++ b/arch/x86/kvm/mmu/page_track.c
> @@ -75,7 +75,7 @@ int kvm_page_track_enable_mmu_write_tracking(struct kvm *kvm)
>  {
>         struct kvm_memslots *slots;
>         struct kvm_memory_slot *slot;
> -       unsigned short **gfn_track;
> +       unsigned short *gfn_track;
>         int i;
>
>         if (write_tracking_enabled(kvm))
> @@ -91,13 +91,13 @@ int kvm_page_track_enable_mmu_write_tracking(struct kvm *kvm)
>         for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
>                 slots = __kvm_memslots(kvm, i);
>                 kvm_for_each_memslot(slot, slots) {
> -                       gfn_track = slot->arch.gfn_track + KVM_PAGE_TRACK_WRITE;
> -                       *gfn_track = kvcalloc(slot->npages, sizeof(*gfn_track),
> -                                             GFP_KERNEL_ACCOUNT);
> -                       if (*gfn_track == NULL) {
> +                       gfn_track = kvcalloc(slot->npages, sizeof(*gfn_track),
> +                                            GFP_KERNEL_ACCOUNT);
> +                       if (gfn_track == NULL) {
>                                 mutex_unlock(&kvm->slots_arch_lock);
>                                 return -ENOMEM;
>                         }
> +                       slot->arch.gfn_track[KVM_PAGE_TRACK_WRITE] = gfn_track;
>                 }
>         }
>
>
>
> >                       if (*gfn_track == NULL) {
> >                               mutex_unlock(&kvm->slots_arch_lock);
>
> Hrm, this fails to free the gfn_track allocations for previous memslots.  The
> on-demand rmaps code has the exact same bug (it frees rmaps for previous lpages
> in the _current_ slot, but does not free previous slots).
>
> And having two separate flows (and flags) for rmaps vs. gfn_track is pointless,
> and means we have to maintain two near-identical copies of non-obvious code.

I agree that's better than my patch. I can put together a new patch
once it's decided whether or not my patch should be dropped.

-David
