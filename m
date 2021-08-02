Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27C93DD47C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 13:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhHBLOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 07:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhHBLOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:14:08 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB65DC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 04:13:57 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i39-20020a9d17270000b02904cf73f54f4bso3364819ota.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CfDLtrkCkMzvLd35FEs6eMwBrh1e58lQcLyXALKvq0=;
        b=AybFJOtKRe0q6jJhqwD86EFrT14YFKKUCn0/lX25FdoRhTsyaZ6uPTsCg/y0ubJqCO
         z/Ap1RHVChJarWRV1k+rH/fX/V4fmA4obJqont8F6g1d3ckqT7Vwpdll97eRr8n54TVe
         no5UyzPnO+eGTcIgU4Py4/s+xQKjE1Y4DsVo7wfz3fKgAXXo9aGFCsDxRxOd8pCms28s
         eYg6g1qgj6fIIXsNYwhK+FKg/U0izdC0WLdlaY0+aFI2rEx+U7B4xOIQpkJjyXQjIEfl
         fEK3BsXeSe3kbUyaTWSsnt8Y94PtzisV7qFyHIjbUX4l7SGMM3rbjKz7LifoSAUA0FrV
         EKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CfDLtrkCkMzvLd35FEs6eMwBrh1e58lQcLyXALKvq0=;
        b=CkvtEngiFyv0LA//FngvWn01ptTRjjHR6OMlzu1CYyAlNXKS03F0tSknwDpLbvWrhO
         5TvIS9yYeU69Np/HZkFQAw2ZVsC/IP7BjohYST9Og+Uhozw66LyUHTgdQYzHs4gAg7Zo
         84rhfFgNeNcR1P3AWeB1aYfP81bobLjtTO8daTaitMTAJ11Xv35LOzeF9/74VADOASWQ
         swPIDGGFqWRSTg3T7dh2TTV+UsW3swSZqtQ9GDyMQvp5DxOQaHfuPmEt7gGOdxiKPsn+
         lFJjkwg15mOpPLMIL7wi2X4a5wlT++WfavMEzfYFEgylihINUKUf5x7QW65cPjtOMDOP
         8+WA==
X-Gm-Message-State: AOAM5323kov3VtWRKMsXRDmZ9Q8E6dxdpI8qhxwNkGSfBee4nxJTfCC3
        9ZP4jjaxsAkFSUaCVeRV8hXSc9apYFnnauqu7JZLdw==
X-Google-Smtp-Source: ABdhPJxRpcv8YUt/d5raKHTBgJ8s47A7Jkisqse/dDL12s34vizVFXgZbUpeOvNeTac/Ai7ulOfMTQki8uGGCwIVlzk=
X-Received: by 2002:a9d:4b02:: with SMTP id q2mr11320334otf.52.1627902836962;
 Mon, 02 Aug 2021 04:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-14-qperret@google.com>
In-Reply-To: <20210729132818.4091769-14-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 2 Aug 2021 13:13:20 +0200
Message-ID: <CA+EHjTxTaPc=bt_kyXf0TE85v5eyHnq0o3KQ3Pd6+kOwmm5oMw@mail.gmail.com>
Subject: Re: [PATCH v3 13/21] KVM: arm64: Expose host stage-2 manipulation helpers
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

Hi Quentin,

On Thu, Jul 29, 2021 at 3:28 PM Quentin Perret <qperret@google.com> wrote:
>
> We will need to manipulate the host stage-2 page-table from outside
> mem_protect.c soon. Introduce two functions allowing this, and make
> them usable to users of mem_protect.h.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 ++
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 17 ++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index ae355bfd8c01..47c2a0c51612 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -49,6 +49,8 @@ extern struct host_kvm host_kvm;
>  int __pkvm_prot_finalize(void);
>  int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
>
> +int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot);
> +int host_stage2_set_owner_locked(u64 start, u64 end, u8 owner_id);
>  int kvm_host_prepare_stage2(void *pgt_pool_base);
>  void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 70c57d2c3024..a7f6134789e0 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -272,6 +272,21 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
>         return 0;
>  }
>
> +int host_stage2_idmap_locked(u64 start, u64 end, enum kvm_pgtable_prot prot)
> +{
> +       hyp_assert_lock_held(&host_kvm.lock);
> +
> +       return host_stage2_try(__host_stage2_idmap, start, end, prot);
> +}
> +
> +int host_stage2_set_owner_locked(u64 start, u64 end, u8 owner_id)
> +{
> +       hyp_assert_lock_held(&host_kvm.lock);
> +
> +       return host_stage2_try(kvm_pgtable_stage2_set_owner, &host_kvm.pgt,
> +                              start, end - start, &host_s2_pool, owner_id);
> +}

This is a potential issue elsewhere as well, but all functions in
kvm_pgtable.h, including kvm_pgtable_stage2_set_owner, specify an
address range via address and size. The two you have introduced here
take a start and an end. I'm not sure if making these two consistent
with the ones in kvm_pgtable.h would be good, or would just complicate
things in other places.

Thanks,
/fuad

>  static bool host_stage2_force_pte_cb(u64 addr, u64 end, enum kvm_pgtable_prot prot)
>  {
>         /*
> @@ -309,7 +324,7 @@ static int host_stage2_idmap(u64 addr)
>         if (ret)
>                 goto unlock;
>
> -       ret = host_stage2_try(__host_stage2_idmap, range.start, range.end, prot);
> +       ret = host_stage2_idmap_locked(range.start, range.end, prot);
>  unlock:
>         hyp_spin_unlock(&host_kvm.lock);
>
> --
> 2.32.0.432.gabb21c7263-goog
>
