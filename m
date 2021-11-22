Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9324A4597BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 23:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhKVWdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 17:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhKVWdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 17:33:17 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBF5C061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 14:30:10 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z18so25415088iof.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 14:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0erLLax/bV8EIRnwYcBE03SDdt6WiarfRYlEThW8pA=;
        b=OlxycZfJHQ3ZWuZNz8hAGftiXuDVSaH8c4zm4t5qAgIS9Ak4v3eY0hXUl2uw0lXzIV
         2BdB8HMfRepfOjk3sW8tkB60gb2HpM/FwUGGauREFtF5cy35ay1psT0iyVLOaweZ3bEi
         en9jPPar3vgcz/ykzTwhjRUJiMpNDQa0oyC1Vo/Ys4qmC3Yp1BEK4KhhiiT6xxXMBBQx
         94U27vFESnygB/udDv67Z+DUbePZXWD5XM6WSkF5gsPQRTISWnJauK6wuUeYjQY261lO
         J35ZVpMYkNDNqqgmcKwBMhQF0SjL5U+mcNBhnp6JGK5p9FrbkmOxU2L84HZ7+74eIsgq
         Fieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0erLLax/bV8EIRnwYcBE03SDdt6WiarfRYlEThW8pA=;
        b=8BodKWHuYZhoNzCV4jS/9P2PX0z/HotHyts+BxDTCAoBjDxuY60Ny0MzqjA+Q2+HCG
         4Qx0ofLCgjrTHjYdLB7wlTA2yw3/qgZJAjIZ5EQDWRoZl5HDlsH+vlbd4RkTJsLaucQG
         /24JEYdQdmX6gLRhkw6CABk+1owzL24/O6u0fJSc6ylH1tQm0GRE4cm2wLwBc1IpT6hs
         rIkq0xgsGp0K+dfZ3wa5gUFc7l3QQHBX162jKdgHCIlBxdHnn5ZhM40lEcH9xd8So4xh
         EjvQov7WiCjGeIXEKTXNrKq49OfQLgvU9xZU5RPKBk41Gqb1J2zjXZBEqVtXokIpwO9V
         e9/w==
X-Gm-Message-State: AOAM533i7YUFvx5K0qVT7ov7M7SpqQcBS4F22Nv5bfiv3Ug9Tu8+V113
        qfeCRgzJdJx9LAZXrKXqq/0h/GposjwhwLflrFMrx8pNGmk=
X-Google-Smtp-Source: ABdhPJyyjGKPLyiU+74t39OZXEaETRWn9HTZcd8ajQICiSNguq7yv9MVs73Uh9m6zf682vhkABhKg6GLl9cKta/diyQ=
X-Received: by 2002:a5d:9d92:: with SMTP id ay18mr352206iob.130.1637620209661;
 Mon, 22 Nov 2021 14:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com> <20211120045046.3940942-19-seanjc@google.com>
In-Reply-To: <20211120045046.3940942-19-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 22 Nov 2021 14:29:58 -0800
Message-ID: <CANgfPd-L20Me1vE_qt7TPpB_skTcT7ZjAtzDkOwj173U4iYUxQ@mail.gmail.com>
Subject: Re: [PATCH 18/28] KVM: x86/mmu: Refactor low-level TDP MMU set SPTE
 helper to take raw vals
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hou Wenlong <houwenlong93@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 8:51 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Refactor __tdp_mmu_set_spte() to work with raw values instead of a
> tdp_iter objects so that a future patch can modify SPTEs without doing a
> walk, and without having to synthesize a tdp_iter.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 47 +++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index cc8d021a1ba5..7d354344924d 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -622,9 +622,13 @@ static inline bool tdp_mmu_zap_spte_atomic(struct kvm *kvm,
>
>  /*
>   * __tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping
> - * @kvm: kvm instance
> - * @iter: a tdp_iter instance currently on the SPTE that should be set
> - * @new_spte: The value the SPTE should be set to
> + * @kvm:             KVM instance
> + * @as_id:           Address space ID, i.e. regular vs. SMM
> + * @sptep:           Pointer to the SPTE
> + * @old_spte:        The current value of the SPTE
> + * @new_spte:        The new value that will be set for the SPTE
> + * @gfn:             The base GFN that was (or will be) mapped by the SPTE
> + * @level:           The level _containing_ the SPTE (its parent PT's level)
>   * @record_acc_track: Notify the MM subsystem of changes to the accessed state
>   *                   of the page. Should be set unless handling an MMU
>   *                   notifier for access tracking. Leaving record_acc_track
> @@ -636,9 +640,9 @@ static inline bool tdp_mmu_zap_spte_atomic(struct kvm *kvm,
>   *                   Leaving record_dirty_log unset in that case prevents page
>   *                   writes from being double counted.
>   */
> -static inline void __tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
> -                                     u64 new_spte, bool record_acc_track,
> -                                     bool record_dirty_log)
> +static void __tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
> +                              u64 old_spte, u64 new_spte, gfn_t gfn, int level,
> +                              bool record_acc_track, bool record_dirty_log)
>  {
>         lockdep_assert_held_write(&kvm->mmu_lock);
>
> @@ -649,39 +653,46 @@ static inline void __tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
>          * should be used. If operating under the MMU lock in write mode, the
>          * use of the removed SPTE should not be necessary.
>          */
> -       WARN_ON(is_removed_spte(iter->old_spte) || is_removed_spte(new_spte));
> +       WARN_ON(is_removed_spte(old_spte) || is_removed_spte(new_spte));
>
> -       kvm_tdp_mmu_write_spte(iter->sptep, new_spte);
> +       kvm_tdp_mmu_write_spte(sptep, new_spte);
> +
> +       __handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level, false);
>
> -       __handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
> -                             new_spte, iter->level, false);
>         if (record_acc_track)
> -               handle_changed_spte_acc_track(iter->old_spte, new_spte,
> -                                             iter->level);
> +               handle_changed_spte_acc_track(old_spte, new_spte, level);
>         if (record_dirty_log)
> -               handle_changed_spte_dirty_log(kvm, iter->as_id, iter->gfn,
> -                                             iter->old_spte, new_spte,
> -                                             iter->level);
> +               handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte,
> +                                             new_spte, level);
> +}
> +
> +static inline void _tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
> +                                    u64 new_spte, bool record_acc_track,
> +                                    bool record_dirty_log)
> +{
> +       __tdp_mmu_set_spte(kvm, iter->as_id, iter->sptep, iter->old_spte,
> +                          new_spte, iter->gfn, iter->level,
> +                          record_acc_track, record_dirty_log);
>  }
>
>  static inline void tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
>                                     u64 new_spte)
>  {
> -       __tdp_mmu_set_spte(kvm, iter, new_spte, true, true);
> +       _tdp_mmu_set_spte(kvm, iter, new_spte, true, true);
>  }
>
>  static inline void tdp_mmu_set_spte_no_acc_track(struct kvm *kvm,
>                                                  struct tdp_iter *iter,
>                                                  u64 new_spte)
>  {
> -       __tdp_mmu_set_spte(kvm, iter, new_spte, false, true);
> +       _tdp_mmu_set_spte(kvm, iter, new_spte, false, true);
>  }
>
>  static inline void tdp_mmu_set_spte_no_dirty_log(struct kvm *kvm,
>                                                  struct tdp_iter *iter,
>                                                  u64 new_spte)
>  {
> -       __tdp_mmu_set_spte(kvm, iter, new_spte, true, false);
> +       _tdp_mmu_set_spte(kvm, iter, new_spte, true, false);
>  }
>
>  #define tdp_root_for_each_pte(_iter, _root, _start, _end) \
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
