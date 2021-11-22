Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235D845970B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 22:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhKVWAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 17:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236774AbhKVWAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 17:00:34 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E74C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 13:57:27 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id f9so25147934ioo.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 13:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXGfPpbQic+jC8P7dcy3GoN3wRlBo8QMxW6F4njlwrg=;
        b=NJHB1yCu6ije/v77hoI9V8CFrh/itNDBfwe/zNuayvj3LxjejgkRKz7pptrZ6VSZaz
         /iTYQvUaeVf4Ck1eYJnZFj65iQd1R2MJz+6s0koeHc60wrijmoaUl7Q7M6bXYyz+UHNG
         mTYS+D/Ppp7rHAdOkzLHVqcPu2fnt2QNLnY7580i+zSLUiZiDqsu9LxnZ/a/vKv/wYAJ
         a/OSnoDjoGIDGXyOVZ+yRs7QadV2h/VF1uSJmTLaelR5BC+KdrcHJsCz01J0JztmVLZA
         znzWT05gOE+Hu0Fgs+FFy14SIrZDDd6qpoBQgV6mC5rCFLdgkq43zYQNQndZtN/1pMHR
         hbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXGfPpbQic+jC8P7dcy3GoN3wRlBo8QMxW6F4njlwrg=;
        b=QyN4FjBTah8j77IJpdpe2/ue+ykBOJr2RiJ97h6MOEite8Q3yvYGqM6b8WfuweZCwC
         tj1YrqVT0bb7/tjPELp6WQnZ+1JOWUsbawYfWNTknc+t4qgXW7bR3DOfl2NGB/a2RjkS
         nFjlv0DgZVwheYZDEmkCdYmC86/mqNRLllZe3kEk1VVNVZ+VE8gYW5AqF0LcAXoVDaLi
         9nC2tWtr1M7hQYS0RoRCwrVchZE04v03WBxlAOGfx0IZB9ZJetSXlUWQT8Q9vr0KMLTk
         wjhqKzlI19RhMnlMZ4duBE8FdrWu03aZJPZuskUiQ1ADkE19EGSB/RHEgi8MetRrzOfx
         E15g==
X-Gm-Message-State: AOAM533uGPDA8fGck+1u1zPgVopvvEIW0obNzXqgaRigheBvR3t6YDgU
        yEAJl61/+LGmG6i5zJK3akkbinE657c3fB0g4EP3RQ==
X-Google-Smtp-Source: ABdhPJwtqc09dCzuzmqGkO2wfZtq4x5EKSdT94Ltu4HrWeB72KncSYsFwDVX/wlatkzS3wOuoNIdT73Tqfe9L/t1UPs=
X-Received: by 2002:a5d:8049:: with SMTP id b9mr42673ior.41.1637618246707;
 Mon, 22 Nov 2021 13:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com> <20211120045046.3940942-17-seanjc@google.com>
In-Reply-To: <20211120045046.3940942-17-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 22 Nov 2021 13:57:15 -0800
Message-ID: <CANgfPd9N2HspOiVeLo5Pqi_wCETuYWcx==97Bhi1bqXBzU7c0A@mail.gmail.com>
Subject: Re: [PATCH 16/28] KVM: x86/mmu: WARN if old _or_ new SPTE is REMOVED
 in non-atomic path
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
> WARN if the new_spte being set by __tdp_mmu_set_spte() is a REMOVED_SPTE,
> which is called out by the comment as being disallowed but not actually
> checked.  Keep the WARN on the old_spte as well, because overwriting a
> REMOVED_SPTE in the non-atomic path is also disallowed (as evidence by
> lack of splats with the existing WARN).
>
> Fixes: 08f07c800e9d ("KVM: x86/mmu: Flush TLBs after zap in TDP MMU PF handler")
> Cc: Ben Gardon <bgardon@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 085f6b09e5f3..d9524b387221 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -638,13 +638,13 @@ static inline void __tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
>         lockdep_assert_held_write(&kvm->mmu_lock);
>
>         /*
> -        * No thread should be using this function to set SPTEs to the
> +        * No thread should be using this function to set SPTEs to or from the
>          * temporary removed SPTE value.
>          * If operating under the MMU lock in read mode, tdp_mmu_set_spte_atomic
>          * should be used. If operating under the MMU lock in write mode, the
>          * use of the removed SPTE should not be necessary.
>          */
> -       WARN_ON(is_removed_spte(iter->old_spte));
> +       WARN_ON(is_removed_spte(iter->old_spte) || is_removed_spte(new_spte));
>
>         kvm_tdp_mmu_write_spte(iter->sptep, new_spte);
>
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
