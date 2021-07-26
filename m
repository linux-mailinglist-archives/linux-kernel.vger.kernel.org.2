Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9A63D6861
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 23:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhGZUWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 16:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhGZUWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:22:12 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6C2C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:02:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id j21so13609826ioo.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 14:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6IT8x9lzIx6n/BJ/OVx0lxvbExZ5qOlfUXixHe0bbys=;
        b=pDMgqn4vHsn0oX7XfuvhKNIaiMD0p27Xd/46lgidJzEQgnLDi7rh4obI6GXlO5KNhz
         uW3JEdP8KUx77Bp+uaLK6lESAfW/bwcJVgwXCB4UjsN2H6PJwSA1anMG35GDUNATQzLZ
         LSqba8zm3DJLWHBQJH7HYrodbAkYRb3of4F6lEM1vXdb/HuhkUciAscbG3BRrgwCbVkF
         nqQFVxtqErHql/RTTVnYqZqBslRYsMuaY6pLWoPMpSnsW3X6kl3kVmzB8bq77HzJr3tJ
         xBvSG3fYigdlMKXD4uaGugG3yTbJAgn3ilGhJG4hyNCksDNZLDJ7XvqWVqNKDGQ73KIn
         U7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6IT8x9lzIx6n/BJ/OVx0lxvbExZ5qOlfUXixHe0bbys=;
        b=reY7LSbKZKU7wxPnu1umeahwSE0IUNBKycMdlRTKLyGpx67uRCtPaNo+5ibz5Ij27e
         Ba4hgz/EONzch2NaXcDS4k4zwFj5EJs1Cyn3acm6ltkHSCHdRBraALxosyaRmYGtILAW
         vIzl8n1K+5l5zo2wWo2GhMoPQ2lWKbeiBJ62Ld9h8tSOPm6zlFq9JrQ8GeErNx9k9f+X
         shmcOdJoIK9qqu/FZu/MO+6ma+xevrDCimHYg9sORottJKfMTsgkK/nWE8QMnFxNB1RD
         JWR0yYtbcKLQUPHq47T+hZb4nniDm9zCGkVIBAL2OfVhTGC+DoHeAe9bTpG4FuAfR2/6
         LCgg==
X-Gm-Message-State: AOAM530auUleLqpBGJ4BQM9axtUFUuPswK5xorDSni7jUXKpNycUEHrj
        xf3kz7F40k3I8FcoDC0xUTLg0aYonhdvAlUvzDznKg==
X-Google-Smtp-Source: ABdhPJyhGOvmp7xt5phBoDKVbyUJAWhk7mWImU5UN9SLg1JqYvVSLQ0kO7HYjwjDv0jwPBBN3364p2rxepSoPqthNCc=
X-Received: by 2002:a6b:2bd4:: with SMTP id r203mr11606325ior.157.1627333360050;
 Mon, 26 Jul 2021 14:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210726175357.1572951-1-mizhang@google.com> <20210726175357.1572951-3-mizhang@google.com>
In-Reply-To: <20210726175357.1572951-3-mizhang@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 26 Jul 2021 14:02:27 -0700
Message-ID: <CANgfPd95-FSeouU9Aa-6E4UYUy8St+-4Wswbo1dF2AWZo5BoQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: x86/mmu: Avoid collision with !PRESENT SPTEs
 in TDP MMU lpage stats
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 10:54 AM Mingwei Zhang <mizhang@google.com> wrote:
>
> Factor in whether or not the old/new SPTEs are shadow-present when
> adjusting the large page stats in the TDP MMU. A modified MMIO SPTE can
> toggle the page size bit, as bit 7 is used to store the MMIO generation,
> i.e. is_large_pte() can get a false positive when called on a MMIO SPTE.
> Ditto for nuking SPTEs with REMOVED_SPTE, which sets bit 7 in its magic
> value.
>
> Opportunistically move the logic below the check to verify at least one
> of the old/new SPTEs is shadow present.
>
> Use is/was_leaf even though is/was_present would suffice.  The code
> generation is roughly equivalent since all flags need to be computed
> prior to the code in question, and using the *_leaf flags will minimize
> the diff in a future enhancement to account all pages, i.e. will change
> the check to "is_leaf != was_leaf".
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index caac4ddb46df..cba2ab5db2a0 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -413,6 +413,7 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
>         bool was_leaf = was_present && is_last_spte(old_spte, level);
>         bool is_leaf = is_present && is_last_spte(new_spte, level);
>         bool pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
> +       bool was_large, is_large;
>
>         WARN_ON(level > PT64_ROOT_MAX_LEVEL);
>         WARN_ON(level < PG_LEVEL_4K);
> @@ -446,13 +447,6 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
>
>         trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
>
> -       if (is_large_pte(old_spte) != is_large_pte(new_spte)) {
> -               if (is_large_pte(old_spte))
> -                       atomic64_sub(1, (atomic64_t*)&kvm->stat.lpages);
> -               else
> -                       atomic64_add(1, (atomic64_t*)&kvm->stat.lpages);
> -       }
> -
>         /*
>          * The only times a SPTE should be changed from a non-present to
>          * non-present state is when an MMIO entry is installed/modified/
> @@ -478,6 +472,18 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
>                 return;
>         }
>
> +       /*
> +        * Update large page stats if a large page is being zapped, created, or
> +        * is replacing an existing shadow page.
> +        */
> +       was_large = was_leaf && is_large_pte(old_spte);
> +       is_large = is_leaf && is_large_pte(new_spte);
> +       if (was_large != is_large) {
> +               if (was_large)
> +                       atomic64_sub(1, (atomic64_t *)&kvm->stat.lpages);
> +               else
> +                       atomic64_add(1, (atomic64_t *)&kvm->stat.lpages);
> +       }
>
>         if (was_leaf && is_dirty_spte(old_spte) &&
>             (!is_present || !is_dirty_spte(new_spte) || pfn_changed))
> --
> 2.32.0.432.gabb21c7263-goog
>
