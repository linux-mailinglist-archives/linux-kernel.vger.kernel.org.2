Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F365545ACEE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbhKWUBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 15:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhKWUBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:01:39 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7570DC061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:58:31 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z18so154580iof.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzkHFWCeJ5B0HVtGojsjqbGpQYRfubbgVYpeWL+4Wf4=;
        b=QcEWH5gQ3keGnFBHuTq11/AVEIGGI3PUY29+an7xWGSG0yhl4PFxoJ6e9Ybw2rFGbh
         ak+7FM/GTuM9npHLorAY/fGa6GqVe4eURzonq4MRTJbBKA4kVmXCy/fxf0Kgwx7lsjN5
         vh/swCRkJSHFmW9DRGlr9FcN33dviD3cXCfNXm4/aomy/yiW8vp6HUjhWZiLhj8/+Mm1
         CX705eYfzgIrYvI0SDpG2Ib/sfMP4BMFfhldFznJBL3d0GcFxu0NyopyM6Rb75Dz5qMp
         XsY8KALIxxSHv7/+5KmLsPi0GdEf71KDED4W+vI4n4NRunhlZvf1Yl/X29sPo/onA7GR
         T0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzkHFWCeJ5B0HVtGojsjqbGpQYRfubbgVYpeWL+4Wf4=;
        b=XAByxwBX4A9aW6Q75nxK5m5Wc/Wg66nlMDuhyqxPJAWh8MjUtZ077aeRn7BjdakrZG
         XcF9B32EyX1RpAJqYqRxsJzwW0NrMGL6IoD3g8WYFpFwKmiZhFlk4RNJHD1t3B5njlQE
         Io7VZavzr3jNQqHROpX6m+Q2GDCf//0OLPDWlNh3LdhOHvMV20o3XDnZd3fNSWwjBkD8
         alHnQv2ytSwJRQgMFj/d7Pppq5Hn1sdolF0ecELZ2+tBn1Jzg0Ln95tKYJTkr9VzFDGu
         R4K1SjAyACyTPu25ILnEOKuxd9ix3dK/mxfaKXV3T+o0p8G2cGCKJwuKylYVv9Yy7FGK
         6kKg==
X-Gm-Message-State: AOAM532qkUokmOhKItmwT/sbmB0bLOAVxr/b07Ei+FMkTxC89HvGn9t7
        NTIYeXRmwL0VOJxZafVnK4BM87hfzuQa5T912gHN9g==
X-Google-Smtp-Source: ABdhPJy5P0sr4ayilFNItLf0ekqsSE3fZ9eCTEk9wA1SVD8rSOpPakRE9oiR1+L8xMg/MZaIyota8Yu1T98NEinCbao=
X-Received: by 2002:a5d:9493:: with SMTP id v19mr8150597ioj.34.1637697510750;
 Tue, 23 Nov 2021 11:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com> <20211120045046.3940942-28-seanjc@google.com>
In-Reply-To: <20211120045046.3940942-28-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 23 Nov 2021 11:58:19 -0800
Message-ID: <CANgfPd-MNnx0GVZCHcDYUyx5kqAQSr=s_QGr8zDyw8Wnz0devQ@mail.gmail.com>
Subject: Re: [PATCH 27/28] KVM: x86/mmu: Do remote TLB flush before dropping
 RCU in TDP MMU resched
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
> When yielding in the TDP MMU iterator, service any pending TLB flush
> before  dropping RCU protections in anticipation of using the callers RCU
> "lock" as a proxy for vCPUs in the guest.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 79a52717916c..55c16680b927 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -732,11 +732,11 @@ static inline bool tdp_mmu_iter_cond_resched(struct kvm *kvm,
>                 return false;
>
>         if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
> -               rcu_read_unlock();
> -
>                 if (flush)
>                         kvm_flush_remote_tlbs(kvm);
>
> +               rcu_read_unlock();
> +

Just to check my understanding:
Theoretically PT memory could be freed as soon as we release the RCU
lock, if this is the only thread in a read critical section. In order
to ensure that we can use RCU as a proxy for TLB flushes we need to
flush the TLBs while still holding the RCU read lock. Without this
change (and with the next one) we could wind up in a situation where
we drop the RCU read lock, then the RCU callback runs and frees the
memory, and then the guest does a lookup through the paging structure
caches and we get a use-after-free bug. By flushing in an RCU critical
section, we ensure that the TLBs will have been flushed by the time
the RCU callback runs to free the memory. Clever!

>                 if (shared)
>                         cond_resched_rwlock_read(&kvm->mmu_lock);
>                 else
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
