Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D50F459819
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 00:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhKVXDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhKVXDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:03:36 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D504C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 15:00:29 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id w15so19771637ill.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 15:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KqzudgxvDHxbsACN2hyT/DCzCMYmcRVPr4pAoGO0TP0=;
        b=bDooNcAD5p77TutKj0FM3MrDF0lpSs+bqRBXxP7+fVeL+11Y/6R9iJZf8OEn6wpE1u
         82fVCu73xLht0vMgZma0VLgsLbMaSO4HSjgzEoGAPhlWLZ87RATqWDKMfG2+xXCZdg3A
         XyRxtk2JHjoX3uOdJB5lBpzjfEo5h1DZvpyUpbZgE2E5kpbKGPdEq6LiuZSLftjYJCkb
         ao8WWpJmgF1zIUFzcsaQUq8nr01wdsEkfsSdurs1O8+BMFgWfHOk+nDr1hfV/SoAsVU3
         ObcdXauNdHr5Dv+4VTe09DLJYx8epBtJW9Wkd3uZS9iJ2ohAe5YBmOn8Rt/8DGXVFFK5
         fH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqzudgxvDHxbsACN2hyT/DCzCMYmcRVPr4pAoGO0TP0=;
        b=fbdimo7pKVoMWfOVBpsdqo3McNT4h3wr2zGWyiKojV7HyZdhQJUM4Z9Uhha3DIQTF2
         FkImmcbhwL8zNPuUu4Z5rjLxHwHda9X9JlX/TvmejS9uqzS9To1YKECzA5c2xyIcQiI5
         vx4eiZpiGeN/T4iq4hRoNZaMrayPyaRhk5dfGkuPQf+294DCFnQG5NgFdFlKZW7+Qi7v
         7CcKzmb07LZwx5QouWQL3EGjenOcx4hhJYGb7RjnhX8/n0+4ZHxJFohE7DkoCilTTpNc
         Tsu+UOjHK4kaJCXfX6omRM4NQNo/gZ92eRURTi91GbRhFF6oXUtmaM9JZIeaWGzLlCZ7
         GG4Q==
X-Gm-Message-State: AOAM530JX53Qwz89IhZWpMHYiXDCS8oJI6I7sG75/6g1U+BVPP/si1z3
        E14Za2XMn6wHGYAPFH12C9vpbmtJqmXr9x4Jg5PRVg==
X-Google-Smtp-Source: ABdhPJxn8wqxrVM9cIwLEQpa5tABRswi2kZzDJ2JqLzCgE+3gmRr6TnNmW+QbO7VHE5LNSgdL8N0yi30ytVaf1qk7GI=
X-Received: by 2002:a92:dccc:: with SMTP id b12mr638313ilr.129.1637622028440;
 Mon, 22 Nov 2021 15:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com> <20211120045046.3940942-23-seanjc@google.com>
In-Reply-To: <20211120045046.3940942-23-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 22 Nov 2021 15:00:17 -0800
Message-ID: <CANgfPd9Mx5PrP7MH4U2SrHUTTHe=TUo-vipR2ymGiipBaU8=TA@mail.gmail.com>
Subject: Re: [PATCH 22/28] KVM: x86/mmu: Skip remote TLB flush when zapping
 all of TDP MMU
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
> Don't flush the TLBs when zapping all TDP MMU pages, as the only time KVM
> uses the slow version of "zap everything" is when the VM is being
> destroyed or the owning mm has exited.  In either case, KVM_RUN is
> unreachable for the VM, i.e. the guest TLB entries cannot be consumed.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 31fb622249e5..e5401f0efe8e 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -888,14 +888,15 @@ bool __kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, int as_id, gfn_t start,
>
>  void kvm_tdp_mmu_zap_all(struct kvm *kvm)
>  {
> -       bool flush = false;
>         int i;
>
> +       /*
> +        * A TLB flush is unnecessary, KVM's zap everything if and only the VM
> +        * is being destroyed or the userspace VMM has exited.  In both cases,
> +        * KVM_RUN is unreachable, i.e. no vCPUs will ever service the request.
> +        */

Nit: Suggest:
       /*
        * A TLB flush is unnecessary. KVM's zap_all is used if and
only if the VM
        * is being destroyed or the userspace VMM has exited.  In both cases,
        * the vCPUs are not running and will never run again, so their
TLB state doesn't matter.
        */

>         for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
> -               flush = kvm_tdp_mmu_zap_gfn_range(kvm, i, 0, -1ull, flush);
> -
> -       if (flush)
> -               kvm_flush_remote_tlbs(kvm);
> +               (void)kvm_tdp_mmu_zap_gfn_range(kvm, i, 0, -1ull, false);
>  }
>
>  /*
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
