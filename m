Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68205439B88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhJYQeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbhJYQeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:34:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30891C061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:31:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so11890987pjl.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uBXcTZ7zwU5lKtdrjfFr6VEtdDs7btpoA1mR533tDtQ=;
        b=kKo6CdI73gJDaa3pbfuZOQyqK9n4e9ubBAyEfFCi9B8AfXB/Kx6p6Jrsp4LRfOeiXG
         viwF8uvVa7cdHcvHcFB6jWiosIhbrM1FPcERnAXnRT8JvMF/Xaptqqnx7FZrA9F1aiI0
         f4AcVm/sMel2d8+iMm1PnLBJkEenL9YSXT0a98QcVrsGRcUHJzUSAFI8F0IPCA6I1Ex1
         Dd2INBZj3pIzxvj5Q7hjHQ379OipXVCntrrdsMdtAcizghqrfZRoYKVlxsFWJYlluvB9
         N1ER9Mxg0051xF8QgLCjxjiddJg92LiKABB1ZCoZMuJkxraoLncaSQqyzEcvaA3czxNX
         sTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uBXcTZ7zwU5lKtdrjfFr6VEtdDs7btpoA1mR533tDtQ=;
        b=SALf0JY/tbOMakrfMbPs6j2F806WGmFOXCIA6kei6iHFaFrv1GVbozQ7WcrmLt7aOo
         MiEjaR+HsaPewJlNs3n1oVK3+sN9GkEiwaMyqXBlUFLnkLwrHV96zenR0vRS72/dcRlY
         UHGkNAqtQmOH1DbA5Kqj1KKQ9wYSXuosfo6z3Yq+qaRWPYr409w8hz2e68rSHnRH8ebb
         e457TncmzzDylkSjoMY1hno8bJg0jRCcBLxwcD07atYXSIxlvI3zfx1pnPWMLnJW0kz9
         D/Rt1Fm/lJGNq1R3XdebJEtJDGSNArI28FJSujJ8mrTv9ECHgzMhnpB/e2mr6pMNtz+w
         Z37g==
X-Gm-Message-State: AOAM530XAD+sguymwAnS62lDJAf+EUyqtqjDrlXrhYXJaA5RJbs1OOxn
        0xt8mzKgSgobL3TBrEzSNy4/Zw==
X-Google-Smtp-Source: ABdhPJxfUuubFCqRX3vvBUd5Wa66fp9aCyJj/2PTog5VN7ymxHpMTwq0YKTdwrnfSnc1XylBANug9A==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr22190422pjb.167.1635179498379;
        Mon, 25 Oct 2021 09:31:38 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d19sm1543762pgk.81.2021.10.25.09.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 09:31:37 -0700 (PDT)
Date:   Mon, 25 Oct 2021 16:31:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: vPMU: Don't program counter for interrupt-based
 event sampling w/o lapic_in_kernel
Message-ID: <YXbb5ePpVWKxBsbh@google.com>
References: <1634894233-84041-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634894233-84041-1-git-send-email-wanpengli@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> vPMU depends on in-kernel lapic to deliver pmi interrupt, there is a
> lot of overhead when creating/maintaining perf_event object, 
> locking/unlocking perf_event_ctx etc for vPMU. It silently fails to 
> deliver pmi interrupt if w/o in-kernel lapic currently. Let's not 
> program counter for interrupt-based event sampling w/o in-kernel 
> lapic support to avoid the whole bothering. 

This feels all kinds of wrong.  AFAIK, there's no way for KVM to enumerate to
the guest that the vPMU isn't capable of generating interrupts.  I.e. any setup
that exposes a vPMU to the guest without an in-kernel local APIC is either
inherently broken or requires a paravirtualized guest.  I don't think KVM's bugs
should be optimized.

> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/pmu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 0772bad9165c..fa5cd33af10d 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -179,6 +179,7 @@ void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel)
>  	struct kvm_pmu_event_filter *filter;
>  	int i;
>  	bool allow_event = true;
> +	bool intr = eventsel & ARCH_PERFMON_EVENTSEL_INT;
>  
>  	if (eventsel & ARCH_PERFMON_EVENTSEL_PIN_CONTROL)
>  		printk_once("kvm pmu: pin control bit is ignored\n");
> @@ -187,7 +188,8 @@ void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel)
>  
>  	pmc_pause_counter(pmc);
>  
> -	if (!(eventsel & ARCH_PERFMON_EVENTSEL_ENABLE) || !pmc_is_enabled(pmc))
> +	if (!(eventsel & ARCH_PERFMON_EVENTSEL_ENABLE) || !pmc_is_enabled(pmc)
> +	    || (intr && !lapic_in_kernel(pmc->vcpu)))
>  		return;
>  
>  	filter = srcu_dereference(kvm->arch.pmu_event_filter, &kvm->srcu);
> @@ -233,7 +235,7 @@ void reprogram_gp_counter(struct kvm_pmc *pmc, u64 eventsel)
>  	pmc_reprogram_counter(pmc, type, config,
>  			      !(eventsel & ARCH_PERFMON_EVENTSEL_USR),
>  			      !(eventsel & ARCH_PERFMON_EVENTSEL_OS),
> -			      eventsel & ARCH_PERFMON_EVENTSEL_INT,
> +			      intr,
>  			      (eventsel & HSW_IN_TX),
>  			      (eventsel & HSW_IN_TX_CHECKPOINTED));
>  }
> @@ -248,7 +250,7 @@ void reprogram_fixed_counter(struct kvm_pmc *pmc, u8 ctrl, int idx)
>  
>  	pmc_pause_counter(pmc);
>  
> -	if (!en_field || !pmc_is_enabled(pmc))
> +	if (!en_field || !pmc_is_enabled(pmc) || (pmi && !lapic_in_kernel(pmc->vcpu)))
>  		return;
>  
>  	filter = srcu_dereference(kvm->arch.pmu_event_filter, &kvm->srcu);
> -- 
> 2.25.1
> 
