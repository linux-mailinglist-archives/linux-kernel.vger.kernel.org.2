Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD463E5262
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhHJEmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbhHJEmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:42:50 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39741C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:42:29 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so5011834oos.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bd2e89EFb2qiItJyKlrlfgjBBM7/Zn2J3//6956bc/E=;
        b=Xvr6yqrQsDl0A5hIX0l7Y8z30odcy0GqB8nZ+F/pojyjJZAhyMmdiV1NihwKAAaNPX
         3dvNw+cunuzu90NjAFP3DWqj1KAKJOyNvKt7aRGvAePMvkeArlZEDjB13mC3GgJvXgUD
         PRHoKtQ/kOfx9LZ/9j7SqeEHfEtxDWCe/MERESwtrXaeS2WGlGyaQNEI325nf4TszPC0
         bLi5NITNN93RGxBTO3aqi9VXYWruC9o8QAWylkdPY1xNwWiiCZjCfRly5SUFKbqHBOLY
         yygUIBZXsU6rIfuuAIZm8dVmssbdXRVZj+mW5agjmoVSU/cdZJn45foey/yP+lnf8zBE
         ZieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bd2e89EFb2qiItJyKlrlfgjBBM7/Zn2J3//6956bc/E=;
        b=BVhhGX6xBuU4oTKZ9dGMXuiGJkimFEYtHK6pvobE75g3EQ/bo9W1zYDKjOoHWdlcLz
         asXMcIxzAJGXyVCLj4J+5pDLCoPYnfriR2Kk1BM74tNlGQjZwkThdT8eIb66ECm+NZXX
         JuIdA3yEBZk8hR0YYTVHdugYpFxyiIOP9ZEKBc3Nj5l0A0CVL9RMTs7cBkqUy9c5fxw+
         e87vipfuiQet7pZiz7lERxNakI0usdHqVXAOnMzDWoqPb29vCFMrYetf9Dkq8/KQiXFy
         Wn9tF9pWNCrnoGDQ8Hi0ssMvtZUZ71H0kgiatCPYL0rcjyRZ8iunbpxCZnJXhWHsrXUt
         Xmlw==
X-Gm-Message-State: AOAM530VB2KtAwYF8I5ayacm41xikuHj3kAucTkP8MFeWKo870X1unSC
        zqaMX04eRGstvV7Gj9gzap995o7M52w6RlCG6roOHw==
X-Google-Smtp-Source: ABdhPJxn1pzJQUqJZiVp4uQHbWoRAbEwDouBRi0K1Wptkk8N3Hpeqq86pGs9alv+MsLMBL+2VJU0oDhNxLzdkd/Tibg=
X-Received: by 2002:a4a:e14f:: with SMTP id p15mr17359764oot.42.1628570548380;
 Mon, 09 Aug 2021 21:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com> <20210809152448.1810400-20-qperret@google.com>
In-Reply-To: <20210809152448.1810400-20-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 10 Aug 2021 06:41:52 +0200
Message-ID: <CA+EHjTxfnNFwOk=V+w5BUMTCREX+FUpVnzKAhCoCMnyL3BPZBw@mail.gmail.com>
Subject: Re: [PATCH v4 19/21] KVM: arm64: Refactor protected nVHE stage-1 locking
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

On Mon, Aug 9, 2021 at 5:25 PM Quentin Perret <qperret@google.com> wrote:
>
> Refactor the hypervisor stage-1 locking in nVHE protected mode to expose
> a new pkvm_create_mappings_locked() function. This will be used in later
> patches to allow walking and changing the hypervisor stage-1 without
> releasing the lock.
>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

> ---
>  arch/arm64/kvm/hyp/include/nvhe/mm.h |  1 +
>  arch/arm64/kvm/hyp/nvhe/mm.c         | 18 ++++++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> index 8ec3a5a7744b..c76d7136ed9b 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
> @@ -23,6 +23,7 @@ int hyp_map_vectors(void);
>  int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
>  int pkvm_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
>  int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
> +int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot);
>  int __pkvm_create_mappings(unsigned long start, unsigned long size,
>                            unsigned long phys, enum kvm_pgtable_prot prot);
>  unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
> diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
> index a8efdf0f9003..6fbe8e8030f6 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mm.c
> @@ -67,13 +67,15 @@ unsigned long __pkvm_create_private_mapping(phys_addr_t phys, size_t size,
>         return addr;
>  }
>
> -int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> +int pkvm_create_mappings_locked(void *from, void *to, enum kvm_pgtable_prot prot)
>  {
>         unsigned long start = (unsigned long)from;
>         unsigned long end = (unsigned long)to;
>         unsigned long virt_addr;
>         phys_addr_t phys;
>
> +       hyp_assert_lock_held(&pkvm_pgd_lock);
> +
>         start = start & PAGE_MASK;
>         end = PAGE_ALIGN(end);
>
> @@ -81,7 +83,8 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
>                 int err;
>
>                 phys = hyp_virt_to_phys((void *)virt_addr);
> -               err = __pkvm_create_mappings(virt_addr, PAGE_SIZE, phys, prot);
> +               err = kvm_pgtable_hyp_map(&pkvm_pgtable, virt_addr, PAGE_SIZE,
> +                                         phys, prot);
>                 if (err)
>                         return err;
>         }
> @@ -89,6 +92,17 @@ int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
>         return 0;
>  }
>
> +int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> +{
> +       int ret;
> +
> +       hyp_spin_lock(&pkvm_pgd_lock);
> +       ret = pkvm_create_mappings_locked(from, to, prot);
> +       hyp_spin_unlock(&pkvm_pgd_lock);
> +
> +       return ret;
> +}
> +
>  int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back)
>  {
>         unsigned long start, end;
> --
> 2.32.0.605.g8dce9f2422-goog
>
