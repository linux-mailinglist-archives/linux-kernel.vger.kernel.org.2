Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841B64595F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 21:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbhKVUNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 15:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbhKVUNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 15:13:22 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCBCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 12:10:15 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id x9so19349117ilu.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 12:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6LEE5kiT2TRIl7BNHFzJ59a75HPeibxuEmXR4XkzoQo=;
        b=FIg0ozS6oCy5vaFfInXqVSUAJa7E0i7Ei6ZptC+1UPCiuT1cafIhfMGwiydDvvxmyC
         KsLzOVuDU9AanKkdfb+G5CDseIRNFDMN9CSOA516PNHtjPGQHMVAEb/G08N04wgucgLS
         JKU8medsjOWPIN9YsUvCgoEr7qlS87aNAjVNK6pusMvIjcb+9AXeQKL3u+X03e4MS7Tv
         Zvtg2KNYxrCDXbYz3IYRG36zcse0W7ZaSjiwTXT/8Dq1sjv2zMKWq2YBFAblW2xfLedV
         bbKUX9l1cOD3UCBeal0ph7gYbj9JNnfnrqcFaZntuZS0D1ArWGfKxPoGJ8YYcNZ32ZN7
         9xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LEE5kiT2TRIl7BNHFzJ59a75HPeibxuEmXR4XkzoQo=;
        b=EfetLYMRCe0H09h801bODQhjfn6ZA8ydbska91rLxFJGyl1wjy/1lcEjPWt9HMecSf
         wUWwUYhrkwtQD8DHr9SbRoXZZ0vy2chhYtTbGHxLLOYZ5XNAyTLsnlp3GIqvFmtwRq8i
         DFCifeDoHm6Gpi2jGOoPqaZo7YkzQ6F8Y4n1hM6F26JFtBSE4jdZUG85bfWJaUZ+z+62
         7f8wxPEG1Qpb1rumvM7K02qgMWe5uLHjbwoVzPnchlduNCGu02qotPuCcBuEiL+tYSEc
         lyDW+Y7PZU0hFBnEVOJvwNkwebWJWoTt33ehDdt5+rSNNYjza38wefYCmlFhNPY/NJ97
         YGXg==
X-Gm-Message-State: AOAM530krG/x0m4zlgfB0AkTT6IiFiBLna/xkXPdPFGRouSlBDIG5DEy
        eeNZesq/M8cvovee/yIPoVI2IsAfCQQ0BGQ+xGFKmw==
X-Google-Smtp-Source: ABdhPJwG4eM/lEDOPt1rsqMzmfCa+H2mVLWpS255Hd+gjyj8SKdBp3A0qazWRG4Tfjoabop2nsWRnrV99V932Lw6S64=
X-Received: by 2002:a92:cda2:: with SMTP id g2mr20988283ild.2.1637611814468;
 Mon, 22 Nov 2021 12:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com> <20211120045046.3940942-10-seanjc@google.com>
In-Reply-To: <20211120045046.3940942-10-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 22 Nov 2021 12:10:03 -0800
Message-ID: <CANgfPd9=ce+JT3xEJy=p5MEfvkMGovEaBEu8KmxiZAJ1AA958g@mail.gmail.com>
Subject: Re: [PATCH 09/28] KVM: x86/mmu: Require mmu_lock be held for write in
 unyielding root iter
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
> Assert that mmu_lock is held for write by users of the yield-unfriendly
> TDP iterator.  The nature of a shared walk means that the caller needs to
> play nice with other tasks modifying the page tables, which is more or
> less the same thing as playing nice with yielding.  Theoretically, KVM
> could gain a flow where it could legitimately take mmu_lock for read in
> a non-preemptible context, but that's highly unlikely and any such case
> should be viewed with a fair amount of scrutiny.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 12a28afce73f..3086c6dc74fb 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -159,11 +159,17 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
>                 if (kvm_mmu_page_as_id(_root) != _as_id) {              \
>                 } else
>
> -#define for_each_tdp_mmu_root(_kvm, _root, _as_id)                             \
> -       list_for_each_entry_rcu(_root, &_kvm->arch.tdp_mmu_roots, link,         \
> -                               lockdep_is_held_type(&kvm->mmu_lock, 0) ||      \
> -                               lockdep_is_held(&kvm->arch.tdp_mmu_pages_lock)) \
> +/*
> + * Iterate over all valid TDP MMU roots.  Requires that mmu_lock be held for
> + * write, the implication being that any flow that holds mmu_lock for read is
> + * inherently yield-friendly and should use the yielf-safe variant above.

Nit: *yield-safe

> + * Holding mmu_lock for write obviates the need for RCU protection as the list
> + * is guaranteed to be stable.
> + */
> +#define for_each_tdp_mmu_root(_kvm, _root, _as_id)                     \
> +       list_for_each_entry(_root, &_kvm->arch.tdp_mmu_roots, link)     \
>                 if (kvm_mmu_page_as_id(_root) != _as_id) {              \
> +                       lockdep_assert_held_write(&(_kvm)->mmu_lock);   \

Did you mean for this lockdep to only be hit in this uncommon
non-matching ASID case?

>                 } else
>
>  static union kvm_mmu_page_role page_role_for_level(struct kvm_vcpu *vcpu,
> @@ -1063,6 +1069,8 @@ static __always_inline bool kvm_tdp_mmu_handle_gfn(struct kvm *kvm,
>         struct tdp_iter iter;
>         bool ret = false;
>
> +       lockdep_assert_held_write(&kvm->mmu_lock);
> +
>         rcu_read_lock();
>
>         /*
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
