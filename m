Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801C04596EF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 22:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhKVVvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 16:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhKVVvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 16:51:12 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4369CC061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 13:48:05 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id j21so14057688ila.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 13:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUC78J9wnQRA3xZgTEIrovLm14ZaQAPvQlLV0U3n2pw=;
        b=IT5jT8xzVfVGW6Mg1OOKSuNBTjB5AxkIvoS5Gl0u42kXXs4oP+xw21Z8ZHe4TeNaf/
         YIxy+giqHsn9DArXeYwptZPg62aL7WHvrjVDjRMCPWglGdcuaMjDGROwVJuY42TCV0y4
         3JfzZGRGEQDZOsfxIhWF/x2h9vBh500cRRoW83ff6Pq2WaVhXFnkOZdR5OtBOUY7OFeN
         XzpiM/yKFK7A6mqYKuN6ak/jSlf3n5joGkcfFiETt0E6vQoozvQXXIFautgmRH/dFxUQ
         omXJIJ5zCYGHwqDkkmoyTXtRlQEiXlDguA7I9iHoKuUOPjElC+pcRbSOtx/OKQefGN0X
         LiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUC78J9wnQRA3xZgTEIrovLm14ZaQAPvQlLV0U3n2pw=;
        b=oiXoNrN8thyeYEYHQbXg8mPmf/HSjgwtNzYipGWwdbabMYu8xM/iZsVHdB3+jfBwKm
         UySTkm7YZWsf5bYn8jLNvWmfY20oARZdQq3IjNND0qRj6PDakzrONvoZI0pnC1liSjxa
         YHUSY+uQ272A9qMbd/CFuTzmLIlmdLOJVpKdaKPh3WkU+/ccQZ1Qa+fb0ktQl9Gf9Ngr
         lII9VBU4nH94IJ+uUU/S7vAoiFWHiRFak7o4iUahPy6q9odFEoyFKX5WGCVIUPPDg7jj
         fqJ0gKGtnB9ZbGVnMQnR61yVhBGZdhs/6aLsjrDOnD7dvnL/DMCngrfaAOx+It565w1u
         mcqA==
X-Gm-Message-State: AOAM5303yGRa2amhtqLRcI8dmM+VDVdhPPZlvaq7LZbstX33kfq+jSXn
        hrsifgt3TJgOkaQTlXa8jhQ91N7zKWjTNm4cbDIMPA==
X-Google-Smtp-Source: ABdhPJzzT5CLp/xkYMUjDKH3WpZQW3gASaEDHJx3UvFMjqMssQrQnFx5SlykLjKhKNwT9fHnMlGwWUATHUYWkb1YQBY=
X-Received: by 2002:a92:dccc:: with SMTP id b12mr130966ilr.129.1637617684507;
 Mon, 22 Nov 2021 13:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com> <20211120045046.3940942-14-seanjc@google.com>
In-Reply-To: <20211120045046.3940942-14-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 22 Nov 2021 13:47:53 -0800
Message-ID: <CANgfPd8pWuH9aC4FEJg6WBOBjUrCpNnsBL23d+nwmkCsM-niNQ@mail.gmail.com>
Subject: Re: [PATCH 13/28] KVM: x86/mmu: Drop RCU after processing each root
 in MMU notifier hooks
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
> Drop RCU protection after processing each root when handling MMU notifier
> hooks that aren't the "unmap" path, i.e. aren't zapping.  Temporarily
> drop RCU to let RCU do its thing between roots, and to make it clear that
> there's no special behavior that relies on holding RCU across all roots.
>
> Currently, the RCU protection is completely superficial, it's necessary
> only to make rcu_dereference() of SPTE pointers happy.  A future patch
> will rely on holding RCU as a proxy for vCPUs in the guest, e.g. to
> ensure shadow pages aren't freed before all vCPUs do a TLB flush (or
> rather, acknowledge the need for a flush), but in that case RCU needs to
> be held until the flush is complete if and only if the flush is needed
> because a shadow page may have been removed.  And except for the "unmap"
> path, MMU notifier events cannot remove SPs (don't toggle PRESENT bit,
> and can't change the PFN for a SP).
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 06b500fab248..3ff7b4cd7d0e 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -1079,18 +1079,19 @@ static __always_inline bool kvm_tdp_mmu_handle_gfn(struct kvm *kvm,
>
>         lockdep_assert_held_write(&kvm->mmu_lock);
>
> -       rcu_read_lock();
> -
>         /*
>          * Don't support rescheduling, none of the MMU notifiers that funnel
>          * into this helper allow blocking; it'd be dead, wasteful code.
>          */
>         for_each_tdp_mmu_root(kvm, root, range->slot->as_id) {
> +               rcu_read_lock();
> +
>                 tdp_root_for_each_leaf_pte(iter, root, range->start, range->end)
>                         ret |= handler(kvm, &iter, range);
> +
> +               rcu_read_unlock();
>         }
>
> -       rcu_read_unlock();
>
>         return ret;
>  }
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
