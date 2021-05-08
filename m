Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE03376F22
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 05:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhEHDdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 23:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhEHDdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 23:33:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90264C061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 20:32:10 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b3so6212446plg.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 20:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JYYAmwYunC3A/UB35SuTsQeKsWMhFLNBAsmanEYycc=;
        b=h2daclxA/ZVdOCctymOzhMZaQP/AtcACEj64ahtKuimTmR6UQfOS5kIAwWDY9EB4lS
         TNlW/WlekKGjD6B6cGGsanQtHODdVi9uXNpeAJbVjb5g/9edzLIPqGPTJ+6qter83elK
         KFYAiETqXkVxpWJ2cVkGJOTyeHxXIjUgp1fo29IeY9/KSvZSRv9Xj8dV+VhyA1AVUCF8
         OmX28vXl93cFcLiNSC8lnCapr6XMgGeWHmBs8a9TSEjiFN54yawffUmPGQG0nFMjtl64
         qkA+f7r2Z/BRuOqXl6+jox+/q7DZwx4PCl1zKbBi2YCpdC1Onwli9S9cDn1X6AWIkgnT
         OQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JYYAmwYunC3A/UB35SuTsQeKsWMhFLNBAsmanEYycc=;
        b=qaTnsT5F4LvOh2t8hqdU87jZ9HKVSZ0MM3z2YsHFIva2A6YAp4PrHt+ScqFWWiC87Q
         Iw1iUf+asq4KM+dZa8GY69UIlMTI33/BFRvI/6EgqzGHClS0FTtp4Axyakrj6FSa/oNM
         QPDm6tgXfz6X52F/bnLAjRQR6ufE9rn11rHPy7KXecnqByhyzEEEyrTEDyNghU6yUqWF
         fxxCDR5dP24O/TwtL7UwPHnwh8nrCqZyyOqxonoYy9RDTncxIUM/HfHpQCF5jmxMzbu+
         1neoGvRire+83HOLeATT2JQPqOENmd0tAZPmli+KJASZLZAvggxJu2HzkmY8KXxL/UGB
         wxsA==
X-Gm-Message-State: AOAM531yhDJ+AnWYxjm1ScVypDNQZkR1Exf9ylZGF7DsHccqIHXSLSYh
        rOAmYGfgE0vAuRwS1x0rnWwrr7eKa9FBExhRnF/Tcg==
X-Google-Smtp-Source: ABdhPJzip2jqsEDqlFdRd8w3o8BQZ7NP/TwAeaT3iaJZVotos8f6QBllfS4nCWODNnOXuEdE87xAo9sxcxAKokmX/8c=
X-Received: by 2002:a17:90a:fa8f:: with SMTP id cu15mr14393879pjb.216.1620444729736;
 Fri, 07 May 2021 20:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210504171734.1434054-1-seanjc@google.com> <20210504171734.1434054-10-seanjc@google.com>
In-Reply-To: <20210504171734.1434054-10-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Fri, 7 May 2021 20:31:53 -0700
Message-ID: <CAAeT=FyKjHykGNcQc=toqvhCR281SWc6UqNihsjyU+vuo3z5Yg@mail.gmail.com>
Subject: Re: [PATCH 09/15] KVM: VMX: Use flag to indicate "active" uret MSRs
 instead of sorting list
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static void vmx_setup_uret_msr(struct vcpu_vmx *vmx, unsigned int msr)
> +static void vmx_setup_uret_msr(struct vcpu_vmx *vmx, unsigned int msr,
> +                              bool load_into_hardware)
>  {
> -       struct vmx_uret_msr tmp;
> -       int from, to;
> +       struct vmx_uret_msr *uret_msr;
>
> -       from = __vmx_find_uret_msr(vmx, msr);
> -       if (from < 0)
> +       uret_msr = vmx_find_uret_msr(vmx, msr);
> +       if (!uret_msr)
>                 return;
> -       to = vmx->nr_active_uret_msrs++;
>
> -       tmp = vmx->guest_uret_msrs[to];
> -       vmx->guest_uret_msrs[to] = vmx->guest_uret_msrs[from];
> -       vmx->guest_uret_msrs[from] = tmp;
> +       uret_msr->load_into_hardware = load_into_hardware;
>  }
>
>  /*
> @@ -1785,30 +1781,36 @@ static void vmx_setup_uret_msr(struct vcpu_vmx *vmx, unsigned int msr)
>   */
>  static void setup_msrs(struct vcpu_vmx *vmx)
>  {
> -       vmx->guest_uret_msrs_loaded = false;
> -       vmx->nr_active_uret_msrs = 0;
>  #ifdef CONFIG_X86_64
> +       bool load_syscall_msrs;
> +
>         /*
>          * The SYSCALL MSRs are only needed on long mode guests, and only
>          * when EFER.SCE is set.
>          */
> -       if (is_long_mode(&vmx->vcpu) && (vmx->vcpu.arch.efer & EFER_SCE)) {
> -               vmx_setup_uret_msr(vmx, MSR_STAR);
> -               vmx_setup_uret_msr(vmx, MSR_LSTAR);
> -               vmx_setup_uret_msr(vmx, MSR_SYSCALL_MASK);
> -       }
> +       load_syscall_msrs = is_long_mode(&vmx->vcpu) &&
> +                           (vmx->vcpu.arch.efer & EFER_SCE);
> +
> +       vmx_setup_uret_msr(vmx, MSR_STAR, load_syscall_msrs);
> +       vmx_setup_uret_msr(vmx, MSR_LSTAR, load_syscall_msrs);
> +       vmx_setup_uret_msr(vmx, MSR_SYSCALL_MASK, load_syscall_msrs);
>  #endif
> -       if (update_transition_efer(vmx))
> -               vmx_setup_uret_msr(vmx, MSR_EFER);
> +       vmx_setup_uret_msr(vmx, MSR_EFER, update_transition_efer(vmx));
>
> -       if (guest_cpuid_has(&vmx->vcpu, X86_FEATURE_RDTSCP)  ||
> -           guest_cpuid_has(&vmx->vcpu, X86_FEATURE_RDPID))
> -               vmx_setup_uret_msr(vmx, MSR_TSC_AUX);
> +       vmx_setup_uret_msr(vmx, MSR_TSC_AUX,
> +                          guest_cpuid_has(&vmx->vcpu, X86_FEATURE_RDTSCP) ||
> +                          guest_cpuid_has(&vmx->vcpu, X86_FEATURE_RDPID));

Shouldn't vmx_setup_uret_msr(,MSR_TSC_AUX,) be called to update
the new flag load_into_hardware for MSR_TSC_AUX when CPUID
(X86_FEATURE_RDTSCP/X86_FEATURE_RDPID) of the vCPU is updated ?


Thanks,
Reiji
