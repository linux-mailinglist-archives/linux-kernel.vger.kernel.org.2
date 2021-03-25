Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE16349BED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCYVsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhCYVsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:48:04 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BD0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:48:04 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id n21so3415921ioa.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LjgpCYxPhOQJpuC7Cc9bLaIGNPJJ0qzOtd9jTBZBhrg=;
        b=GQO/z+TzFRAglc2wQUo8ySqTD1u9odjmmny4u/mrp6OZ10vnij6+gZLGPlregr5x79
         zC8pK5A4bqQNhJmY8WbTMqRLM1qbkzx5wF7kptCuRxXpeKa12MR6CUT2dBii3jRR9m+X
         I3kqOkNW39cy59qOIog55kufGixaOlqWjvdX9mocL3rQ8oem6ZFoghyiDW92Fml0Im6C
         VDqnOUeygBjb38ertVpGA56KQSjcliJGlwHXg4dG4yeGJ0U/rVp5IIhVXodQ7w55bx0J
         67bHn8qf5EY8Ne/AXZeOxUT4YRKipya/JAnVSSiT5moGmFVcAWB/3CkllT642UhC+Ytb
         x3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjgpCYxPhOQJpuC7Cc9bLaIGNPJJ0qzOtd9jTBZBhrg=;
        b=dzp2F6YJjV901ht4/5Hv7CJr63lJuRrBYS2CU6CPQOkLzqVGTkivks8TgrcKPHYkti
         xIbwceeQN1gl38pW7sZZbDhKm7xuuLGmPMMquJ2PgomqTB2k/vZii8ElBaRM04vI1EfJ
         NNhG5IqKCDo+vshdnTgTNTTKJIESXXvtG+GEiwFQTiO17cwC3dnwRBeS7fwEAk/WRiAk
         IF0djxrpMSg0woAxt5weVlU4EFlZVZxjx3UwQWFJ4/TykzwMInapXgMru1ut2Tp2CToq
         H32pacC5nGI1b2ejm49FiCM4gBL1ovnr1q5z2aX9AonwF/2fdqDwJiJgTxkZV0nM0cEF
         b34w==
X-Gm-Message-State: AOAM530Vyc4Zi9ZlM3GHwxlC86AmmITqaj5k7ot4XMcGEGEaDmynv59B
        hurNfweGOrbDELJgT33LXAPut5YlIvaf8MEHUZuckA==
X-Google-Smtp-Source: ABdhPJyGF3V9ymsojPk0PUm++AQs+v0r7ENAJRobTfFkX6wLoztHpPkMlf3C/RGErMgGa7pWL8hfuWOgPJ7pRJ9UKfE=
X-Received: by 2002:a6b:7f4d:: with SMTP id m13mr7917152ioq.134.1616708883934;
 Thu, 25 Mar 2021 14:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210325200119.1359384-1-seanjc@google.com> <20210325200119.1359384-3-seanjc@google.com>
In-Reply-To: <20210325200119.1359384-3-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 25 Mar 2021 14:47:53 -0700
Message-ID: <CANgfPd_M=De3L41+86y8V-5tYGPQ96UC3sq+D=N9EVCOvwXcKw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: x86/mmu: Ensure TLBs are flushed for TDP MMU
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

On Thu, Mar 25, 2021 at 1:01 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Honor the "flush needed" return from kvm_tdp_mmu_zap_gfn_range(), which
> does the flush itself if and only if it yields (which it will never do in
> this particular scenario), and otherwise expects the caller to do the
> flush.  If pages are zapped from the TDP MMU but not the legacy MMU, then
> no flush will occur.
>
> Fixes: 29cf0f5007a2 ("kvm: x86/mmu: NX largepage recovery for TDP MMU")
> Cc: stable@vger.kernel.org
> Cc: Ben Gardon <bgardon@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Ben Gardon <bgardon@google.com>

> ---
>  arch/x86/kvm/mmu/mmu.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index c6ed633594a2..5a53743b37bc 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5939,6 +5939,8 @@ static void kvm_recover_nx_lpages(struct kvm *kvm)
>         struct kvm_mmu_page *sp;
>         unsigned int ratio;
>         LIST_HEAD(invalid_list);
> +       bool flush = false;
> +       gfn_t gfn_end;
>         ulong to_zap;
>
>         rcu_idx = srcu_read_lock(&kvm->srcu);
> @@ -5960,19 +5962,20 @@ static void kvm_recover_nx_lpages(struct kvm *kvm)
>                                       lpage_disallowed_link);
>                 WARN_ON_ONCE(!sp->lpage_disallowed);
>                 if (is_tdp_mmu_page(sp)) {
> -                       kvm_tdp_mmu_zap_gfn_range(kvm, sp->gfn,
> -                               sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level));
> +                       gfn_end = sp->gfn + KVM_PAGES_PER_HPAGE(sp->role.level);
> +                       flush = kvm_tdp_mmu_zap_gfn_range(kvm, sp->gfn, gfn_end);
>                 } else {
>                         kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list);
>                         WARN_ON_ONCE(sp->lpage_disallowed);
>                 }
>
>                 if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
> -                       kvm_mmu_commit_zap_page(kvm, &invalid_list);
> +                       kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
>                         cond_resched_rwlock_write(&kvm->mmu_lock);
> +                       flush = false;
>                 }
>         }
> -       kvm_mmu_commit_zap_page(kvm, &invalid_list);
> +       kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
>
>         write_unlock(&kvm->mmu_lock);
>         srcu_read_unlock(&kvm->srcu, rcu_idx);
> --
> 2.31.0.291.g576ba9dcdaf-goog
>
