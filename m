Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1240A459806
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 23:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhKVW6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 17:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbhKVW6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 17:58:16 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993C7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 14:55:09 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id v23so25477081iom.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 14:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zh9CFupaQEsImYNyAs58bopMZGL1j+sruJ4MSTS5OT8=;
        b=T/RhWcG4Bhqm7CtvqKJ5jA68sB38XyNr32oMSgKc2wQswplPemB9jd5eagcW+3pP6m
         wjvnq1mF/8wiPmHtmGcYF6ooGbPl4OZ26V6JNS6jAmT1uxtAPwEXnIxo1CF839xds1Nh
         omfvmUBuFr6f0asEEJw0rzQ+wWetTRu3FfPcHdUIwnAzY4/D/xz0bsxWPsqTAMkR4MVW
         1WurGYJX/HDZdern0dxZRWtKLhXxbf40PnWx4f9JkzSJuzNz/MTIYoFkZWmmh5yPkfOv
         pMxKZ7m/m/Khg2aYukSDtjjuC6Q97nNmoDYFJwM161Smkv4bhQod0aOanJu/pcGg7IQf
         WQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zh9CFupaQEsImYNyAs58bopMZGL1j+sruJ4MSTS5OT8=;
        b=a5BSrvCcYzMkjOOk8g263/tkzYTb+ap4c9x+YNOhB/6I7Ze6yg8WgfePM61sVd2Qcj
         WBvqpJd09lwYgER7fmwZRQM1tUo6w2sZ3aN8eVAvRpumkKwYmmKlg7XxFYrHJxzln86J
         JlEt+Aa3B7rnDuJ3SEc6KJDCm8P7uIFYJMVEhMfz4rt6s0Yn132AFiDUm2iSaJ8ZENSM
         wVTL4goxyx4yGyeqWQPm82h90iNvAjqCm3f6hUW9dis5rsgQbYD4ET6q6NY6FEJeI7kp
         RjUuQJOiO3jZU58GIJBZMr2cdzqVKB4o2kFo+2ldzvQQdOpLhEDGUxNTPVK8l76msdAD
         TG0A==
X-Gm-Message-State: AOAM531NWZGfgrLnWJLmBwVvbyYAt2txkmeATQ20cU21edpo1nwOXlAe
        DTchREv+Egrm+t7wYHt0e0u6M7ZWitpizF3TzOV4TQ==
X-Google-Smtp-Source: ABdhPJzQf+uXOlKY00zavpohO2RVjxIgnyYkQZO79zO2ndWUHwKR/Em345CTtZYRg5LGdARhllrhxoaGOM6Ok7AuQ7Y=
X-Received: by 2002:a5d:9493:: with SMTP id v19mr502434ioj.34.1637621708875;
 Mon, 22 Nov 2021 14:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20211120045046.3940942-1-seanjc@google.com> <20211120045046.3940942-22-seanjc@google.com>
In-Reply-To: <20211120045046.3940942-22-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 22 Nov 2021 14:54:57 -0800
Message-ID: <CANgfPd83-1yT=p1bMTRiOqCBq_m5AZuuhzmmyKKau9ODML39oA@mail.gmail.com>
Subject: Re: [PATCH 21/28] KVM: x86/mmu: Add TDP MMU helper to zap a root
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
> Add a small wrapper to handle zapping a specific root.  For now, it's
> little more than syntactic sugar, but in the future it will become a
> unique flow with rules specific to zapping an unreachable root.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/tdp_mmu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index 9449cb5baf0b..31fb622249e5 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -79,11 +79,18 @@ static void tdp_mmu_free_sp_rcu_callback(struct rcu_head *head)
>         tdp_mmu_free_sp(sp);
>  }
>
> +static bool tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
> +                            bool shared)
> +{
> +       return zap_gfn_range(kvm, root, 0, -1ull, true, false, shared);

Total aside:
Remembering the order of these three boolean parameters through all
these functions drives me nuts.
It'd be really nice to put them into a neat, reusable struct that tracks:
MMU lock mode (read / write / none)
If yielding is okay
If the TLBs are dirty and need to be flushed

I don't know when I'll have time to do that refactor, but it would
make this code so much more sensible.

> +}
> +
>  /*
>   * Note, putting a root might sleep, i.e. the caller must have IRQs enabled and
>   * must not explicitly disable preemption (it will be disabled by virtue of
>   * holding mmu_lock, hence the lack of a might_sleep()).
>   */
> +
>  void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
>                           bool shared)
>  {
> @@ -118,7 +125,7 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
>          * should have been zapped by kvm_tdp_mmu_zap_invalidated_roots(), and
>          * inserting new SPTEs under an invalid root is a KVM bug.
>          */
> -       if (zap_gfn_range(kvm, root, 0, -1ull, true, false, shared))
> +       if (tdp_mmu_zap_root(kvm, root, shared))
>                 WARN_ON_ONCE(root->role.invalid);
>
>         call_rcu(&root->rcu_head, tdp_mmu_free_sp_rcu_callback);
> @@ -923,7 +930,7 @@ void kvm_tdp_mmu_zap_invalidated_roots(struct kvm *kvm,
>                  * will still flush on yield, but that's a minor performance
>                  * blip and not a functional issue.
>                  */
> -               (void)zap_gfn_range(kvm, root, 0, -1ull, true, false, true);
> +               (void)tdp_mmu_zap_root(kvm, root, true);
>                 kvm_tdp_mmu_put_root(kvm, root, true);
>         }
>  }
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
