Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4963E527A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhHJE4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhHJE4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:56:15 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B44CC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:55:54 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id z9-20020a9d62c90000b0290462f0ab0800so11366718otk.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iwdt3HNT24d+uG35SBp/awntNiJ26kO30qxB/8b/DyE=;
        b=SJ1H3G4wQVz8ix00SAID9drRfjddS2+mObQZ2BMAkGumFF7qoMi8P5gYvM61yILCXK
         q9De96kdQDNfxtBmgIdpe2CwCtyuaFQnevlEhQPmmvaapjnMpaNUosnev11kzUxjuJvQ
         BwkGP+/4FZONH4Qu3KtN5WJf6cXa9czgRYZ6CoKYH1FpXDVCbzgLQAOJq6mO1XioDhiw
         UT3/1NIAcTr/mFNLYHyHZlsIBhrPDwzpyRQW7vGLdngCxrm+zW2ZzYZ+oO4AjuBksrbi
         9HsF0IB1nvUNDOrMvwwzoaEAX4LS6NqC4iYceXOWK5H0BTpchi9tYIJInCfZmp9eO/bc
         xtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iwdt3HNT24d+uG35SBp/awntNiJ26kO30qxB/8b/DyE=;
        b=FL0gTnUa8zSeuIgIivrYfU+sedjguG6QVNZrC9d4l3ABZ7Q3gn2UhUlaZCyw04OgN5
         fRvQyPp4zkxMIFQVmdcoOy84A1AjAHh4mSlhSFBf6ifHyqa5XlsyQg90vo9uSWCP1Tqh
         3D7rfJ5uaqeSXSUa8DavAmQoDrANlNbYa6zwbKWnz9ESQNxLsBep8T4hajjrmqX059BB
         tovegrS7276JW20bzA16zjjNKyxhFEsqJpignd8+OHA21nuM77i9gcUD+OVHXPnUwhl+
         mrwzdVsm7wN4LXVK567DPptzrfLV2JFqjFkMufOnzwqjIoM4C6WTzje2R+dyIKhDlls9
         4ypQ==
X-Gm-Message-State: AOAM533iERvPKpiRnLFOorybhk1y+MTNYkdWdfmwyvhPL4m8Bj3OQNmc
        OgqnC6Gb2WAsZ246GHS0strmGJJso0G7pR38rWsqUg==
X-Google-Smtp-Source: ABdhPJz6QxA3vmNjzHyjlpUGvF/rAR9JnHsduFjjqC9eBsqPV1YltxjQzZVdVMjVmXCm+l/FGBHumv4E28ZT7zmhaV8=
X-Received: by 2002:a05:6830:1095:: with SMTP id y21mr9478716oto.144.1628571353794;
 Mon, 09 Aug 2021 21:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152448.1810400-1-qperret@google.com> <20210809152448.1810400-19-qperret@google.com>
In-Reply-To: <20210809152448.1810400-19-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 10 Aug 2021 06:55:17 +0200
Message-ID: <CA+EHjTx=jb2vzo9U2=RxHYH79u7jRmncLGzR6PNC0ZiRN+km+A@mail.gmail.com>
Subject: Re: [PATCH v4 18/21] KVM: arm64: Remove __pkvm_mark_hyp
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
> Now that we mark memory owned by the hypervisor in the host stage-2
> during __pkvm_init(), we no longer need to rely on the host to
> explicitly mark the hyp sections later on.
>
> Remove the __pkvm_mark_hyp() hypercall altogether.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

>  arch/arm64/include/asm/kvm_asm.h              |  3 +-
>  arch/arm64/kvm/arm.c                          | 46 -------------------
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  1 -
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  9 ----
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 19 --------
>  5 files changed, 1 insertion(+), 77 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index 9f0bf2109be7..432a9ea1f02e 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -63,8 +63,7 @@
>  #define __KVM_HOST_SMCCC_FUNC___pkvm_create_private_mapping    17
>  #define __KVM_HOST_SMCCC_FUNC___pkvm_cpu_set_vector            18
>  #define __KVM_HOST_SMCCC_FUNC___pkvm_prot_finalize             19
> -#define __KVM_HOST_SMCCC_FUNC___pkvm_mark_hyp                  20
> -#define __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc                  21
> +#define __KVM_HOST_SMCCC_FUNC___kvm_adjust_pc                  20
>
>  #ifndef __ASSEMBLY__
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index e9a2b8f27792..2f378482471b 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1954,57 +1954,11 @@ static void _kvm_host_prot_finalize(void *discard)
>         WARN_ON(kvm_call_hyp_nvhe(__pkvm_prot_finalize));
>  }
>
> -static inline int pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
> -{
> -       return kvm_call_hyp_nvhe(__pkvm_mark_hyp, start, end);
> -}
> -
> -#define pkvm_mark_hyp_section(__section)               \
> -       pkvm_mark_hyp(__pa_symbol(__section##_start),   \
> -                       __pa_symbol(__section##_end))
> -
>  static int finalize_hyp_mode(void)
>  {
> -       int cpu, ret;
> -
>         if (!is_protected_kvm_enabled())
>                 return 0;
>
> -       ret = pkvm_mark_hyp_section(__hyp_idmap_text);
> -       if (ret)
> -               return ret;
> -
> -       ret = pkvm_mark_hyp_section(__hyp_text);
> -       if (ret)
> -               return ret;
> -
> -       ret = pkvm_mark_hyp_section(__hyp_rodata);
> -       if (ret)
> -               return ret;
> -
> -       ret = pkvm_mark_hyp_section(__hyp_bss);
> -       if (ret)
> -               return ret;
> -
> -       ret = pkvm_mark_hyp(hyp_mem_base, hyp_mem_base + hyp_mem_size);
> -       if (ret)
> -               return ret;
> -
> -       for_each_possible_cpu(cpu) {
> -               phys_addr_t start = virt_to_phys((void *)kvm_arm_hyp_percpu_base[cpu]);
> -               phys_addr_t end = start + (PAGE_SIZE << nvhe_percpu_order());
> -
> -               ret = pkvm_mark_hyp(start, end);
> -               if (ret)
> -                       return ret;
> -
> -               start = virt_to_phys((void *)per_cpu(kvm_arm_hyp_stack_page, cpu));
> -               end = start + PAGE_SIZE;
> -               ret = pkvm_mark_hyp(start, end);
> -               if (ret)
> -                       return ret;
> -       }
> -
>         /*
>          * Flip the static key upfront as that may no longer be possible
>          * once the host stage 2 is installed.
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 49db0ec5a606..0118527b07b0 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -49,7 +49,6 @@ extern struct host_kvm host_kvm;
>  extern const u8 pkvm_hyp_id;
>
>  int __pkvm_prot_finalize(void);
> -int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end);
>
>  bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 1632f001f4ed..7900d5b66ba3 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -163,14 +163,6 @@ static void handle___pkvm_prot_finalize(struct kvm_cpu_context *host_ctxt)
>  {
>         cpu_reg(host_ctxt, 1) = __pkvm_prot_finalize();
>  }
> -
> -static void handle___pkvm_mark_hyp(struct kvm_cpu_context *host_ctxt)
> -{
> -       DECLARE_REG(phys_addr_t, start, host_ctxt, 1);
> -       DECLARE_REG(phys_addr_t, end, host_ctxt, 2);
> -
> -       cpu_reg(host_ctxt, 1) = __pkvm_mark_hyp(start, end);
> -}
>  typedef void (*hcall_t)(struct kvm_cpu_context *);
>
>  #define HANDLE_FUNC(x) [__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
> @@ -196,7 +188,6 @@ static const hcall_t host_hcall[] = {
>         HANDLE_FUNC(__pkvm_create_mappings),
>         HANDLE_FUNC(__pkvm_create_private_mapping),
>         HANDLE_FUNC(__pkvm_prot_finalize),
> -       HANDLE_FUNC(__pkvm_mark_hyp),
>  };
>
>  static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index cb023d31666e..2991dc6996b9 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -339,25 +339,6 @@ static int host_stage2_idmap(u64 addr)
>         return ret;
>  }
>
> -int __pkvm_mark_hyp(phys_addr_t start, phys_addr_t end)
> -{
> -       int ret;
> -
> -       /*
> -        * host_stage2_unmap_dev_all() currently relies on MMIO mappings being
> -        * non-persistent, so don't allow changing page ownership in MMIO range.
> -        */
> -       if (!range_is_memory(start, end))
> -               return -EINVAL;
> -
> -       hyp_spin_lock(&host_kvm.lock);
> -       ret = host_stage2_try(kvm_pgtable_stage2_set_owner, &host_kvm.pgt,
> -                             start, end - start, &host_s2_pool, pkvm_hyp_id);
> -       hyp_spin_unlock(&host_kvm.lock);
> -
> -       return ret != -EAGAIN ? ret : 0;
> -}
> -
>  void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt)
>  {
>         struct kvm_vcpu_fault_info fault;
> --
> 2.32.0.605.g8dce9f2422-goog
>
