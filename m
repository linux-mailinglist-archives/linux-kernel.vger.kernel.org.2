Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D5E3DE631
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 07:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhHCFby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 01:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhHCFbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:31:50 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675FDC061764
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 22:31:40 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so19697328ott.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 22:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Po/YZOILTmzrKkwPCgFv0W6S5rEcnTiI475aJx7OtDk=;
        b=tspspKCzxf3dmvM9PbDYEPm3AmQpSu50tc9b+llKKl7n1mT4jrbe+Z6JGQDcifMAF+
         HQY90mmsaeiBqaBa0zJVodVm+2NmqPjcsViqcCVODxGkOF5ysu1zCjyeOvmQvutwqF2Q
         xyBGMpTCE/+qoBcJ9OZOU7EXqwbCN8VOrL8EA9myE9R0bcJs3uOPWRRr3HJNstqH1jHe
         M/awtkRnSp+XXF7yXRKRu0R6aVoLeZuxy4CgQzPVN95+XgmsjMVe7Rxalo7LE7ZsrA+P
         MBYrJ13XeNcKRFqBMNULhow1Bq3fV8f0w32XIuU7iAGaWWJwBU1MQat268IbtZ5tlcgV
         /L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Po/YZOILTmzrKkwPCgFv0W6S5rEcnTiI475aJx7OtDk=;
        b=bxkL7itwEjK2qU1po8BMcrSDTKSXMGx63RIEskX+6q20C18UMpyuftCdp59kHISXk3
         peDRBe8NwOnJ2nN5uwL54zDsGx56msQg0HeG71KfyaO6mZX5xLOltqdpKN8wNeeWyuKt
         eCE0E7NPGd/0lw3pma7prVjqVYCpopq0sYu5LUXzlKE3fkREzQKbKSlXLj5RMuz8CWc1
         6wl2cFF6DC/5hzpn3/URCSDpwhxLPTXd/wRYcpAcCPWwjkCbPSsSGvQHkTl41rId9kte
         Vu6MWGA2jJqCohXkYAXdXJSz5IjX2j9Zq+Bc6WNm4EVVkw5b3NR0elH4bg2BBwwySLaZ
         FhHQ==
X-Gm-Message-State: AOAM531Mj2LN+JyLaBHrGOwYW6gUHiCxto30b7oVsu16YsjlGMnlrdsg
        fAK1R5vAvOTUyBWugDKdk0WPbrPsBX0zVuQjs/YuvA==
X-Google-Smtp-Source: ABdhPJy1HDBBzhcvNCRK5xNSS9iFpgQuB17eEHlmHNL8ct6gYXoCpJTZVAjHq3COPZzflHgWQ+W5gfuj9ZOJYJghGNM=
X-Received: by 2002:a05:6830:1455:: with SMTP id w21mr14380175otp.365.1627968699557;
 Mon, 02 Aug 2021 22:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-20-qperret@google.com>
In-Reply-To: <20210729132818.4091769-20-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 3 Aug 2021 07:31:03 +0200
Message-ID: <CA+EHjTwWt+jvRZsk5KEhQWzn+XqdV2gZSq7oCuOCVXRa1=JiWw@mail.gmail.com>
Subject: Re: [PATCH v3 19/21] KVM: arm64: Refactor protected nVHE stage-1 locking
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

On Thu, Jul 29, 2021 at 3:29 PM Quentin Perret <qperret@google.com> wrote:
>
> Refactor the hypervisor stage-1 locking in nVHE protected mode to expose
> a new pkvm_create_mappings_locked() function. This will be used in later
> patches to allow walking and changing the hypervisor stage-1 without
> releasing the lock.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
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

I'm wondering whether this patch should also refactor
__pkvm_create_mappings. It doesn't quite do the exact same thing and
has different parameters.

Thanks,
/fuad

>  int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back)
>  {
>         unsigned long start, end;
> --
> 2.32.0.432.gabb21c7263-goog
>
