Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B893DDB92
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhHBOxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbhHBOxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:53:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9C8C061796
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:53:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id e19so31323653ejs.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2IiuJBcGGHlU+MZOjJcOdM9TvLs3ZLSnxY+XqABa0c=;
        b=USbbLnzqSe8hzqWM6MzvtVB4fSWYo4OClr3p9ww33ZPRsdM8MzcX/U7glKcc5rddND
         HlSvxeOH4qaLa+CbTy62XQzUpI6/GDhqUl3Raf1NKZgSSj4fDDUpHr9+1sEAiWsAenaZ
         IBPwEAMHf+4PBDzd/06RF7q5oYEOW7F5tjLioL8BXQqxLT2JB3YZO5VAOO+7xMcUSnwj
         9cTNw/c9HMe1miCLXfK2CBsy/RZu7J95iOEwE1oEVe6xo6m+akJWMQaqeX5IMLAh+6n5
         rv8uMfOYFTwjNgdDV016+hPQsaISP6NMFbMPdKBd4w6jZLjvmQ/Q4s1zdushGvo6wIYT
         rRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2IiuJBcGGHlU+MZOjJcOdM9TvLs3ZLSnxY+XqABa0c=;
        b=MT6+MSLJKohG8DFz5cQPk8MUg7nH4JYu3FmuTJlXg+1gwAZrodagGQmgBiZN3+QA1g
         er2wdO5sWjh/jtqSigmmuEpfvsnNHuIvtQX8c6IVH9GyRdvtpV9iM6bf9BjVxT91xO9w
         suPKfZLX4PmIxXbZsA35l8awksD0aRZd28WWdJN9rC4BJdrbeuEe1O+8YnWy05ey2dmt
         GwbwlVNMHH/JwbodAuyCrB6736p3X9c0neIdIY5eE+5ybiwmkJ173i35eL7pmtDlvswi
         nNypOGb3gOdo9B2ndhUIJn2B/ntdkeWngiyMkY3gI1TTTVzabf8wKixDVvRjmXBBo80N
         nZ/A==
X-Gm-Message-State: AOAM532IOvRPnsjHzn/4rE1D0PEh6biWnRjT8HmUztDPyPQeYBXOZ8Qj
        YAfdZHWBq0C7YeiPK/+GMsKzHVNpK3WuiFDo46e4Dg==
X-Google-Smtp-Source: ABdhPJyBbigDvWGHVWOmQazVw8pxVXKqhiol21T3Dx4QXWONixp+CbjlyQf4i6I2RwpRHQdtWK86vFVNoEXF75wGOZc=
X-Received: by 2002:a17:907:7895:: with SMTP id ku21mr15674328ejc.265.1627915987486;
 Mon, 02 Aug 2021 07:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-16-qperret@google.com>
In-Reply-To: <20210729132818.4091769-16-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 2 Aug 2021 16:52:31 +0200
Message-ID: <CA+EHjTxrdA3wVsBe7zwvvGUGgoWuaGwuWCBL0k2+FcAdTGB=Qw@mail.gmail.com>
Subject: Re: [PATCH v3 15/21] KVM: arm64: Introduce addr_is_memory()
To:     Quentin Perret <qperret@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin.

On Thu, Jul 29, 2021 at 3:28 PM Quentin Perret <qperret@google.com> wrote:
>
> Introduce a helper usable in nVHE protected mode to check whether a
> physical address is in a RAM region or not.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 1 +
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index cc86598654b9..5968fbbb3514 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -51,6 +51,7 @@ extern const u8 pkvm_hyp_id;
>  int __pkvm_prot_finalize(void);
>  int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
>
> +bool addr_is_memory(phys_addr_t phys);

I'm just wondering about the naming of the function. I understand what
you're trying to achieve with it, but an address without a unit that
conveys size or type seems to be missing something. Would
memregion_addr_is_memory or something like that be a better
description, since it is what find_mem_range finds?

Thanks,
/fuad


>  int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot);
>  int host_stage2_set_owner_locked(u64 start, u64 end, u8 owner_id);
>  int kvm_host_prepare_stage2(void *pgt_pool_base);
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index bb18940c3d12..4532f3d55a1a 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -196,6 +196,13 @@ static bool find_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
>         return false;
>  }
>
> +bool addr_is_memory(phys_addr_t phys)
> +{
> +       struct kvm_mem_range range;
> +
> +       return find_mem_range(phys, &range);
> +}
> +
>  static bool range_is_memory(u64 start, u64 end)
>  {
>         struct kvm_mem_range r1, r2;
> --
> 2.32.0.432.gabb21c7263-goog
>
