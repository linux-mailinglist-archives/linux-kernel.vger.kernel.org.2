Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9496E397676
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhFAPYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhFAPYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:24:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5870C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:23:01 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1707473pjx.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v7fsR2AcFXY2+WqXVmpbWzzfun3lTcFSNVSw/lxou6Q=;
        b=MTrd80JdKZH7LDWyq/xW5nNiTk2Y/ScfnFkT4GJXsyRRbxVILl8KLmbPWNSADshG8e
         hnP37ciN0DQpwlbDowias/xBWDkLkmtO6YWJAiJDQKkx8nKG1nFgzMugptqq0YnwOw0n
         9fhNM7cxgGHiwQHynBclWER5/PJvEpdmUIRm8Wn3prcLctCCifS1c0DhtU1PIbFhLo/f
         Ah3uDKw6Ej+DhXv2tSdLyQXs3JEB7tCeRTpvR6Y0DkvUj42r36aiThK5eXN74A/RgSdx
         BpEUDe0dc2HO2uHqQm3tGKuG1lnDUvV+Tr10IqHnfOh2Op4kfbku5fOiv4ENzI2dGsCe
         Y39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v7fsR2AcFXY2+WqXVmpbWzzfun3lTcFSNVSw/lxou6Q=;
        b=ZNEo1HIyU4lIfdNLxq7pj12TPH1qONV6p+5KIEaIeDcNnXT4vLJoo9Epyi13ixaqWr
         AJx4NiC6NzVYJwXZCwCfhGVD9vkFIJvCKrYjZQfbcCQBw7kqPZzEpMVo9eYvnjMv0Bl3
         Nihik5/OyHVqupWj5pFqfO/IMimCKWTGyC+2WEtgwWsGdoBGWR5T2eZXTElSbUrZqynR
         8OT3l9r3KNjO3Dw6RJ4EfR5rw6tAP0mfJAw6Mtes1FFSQZ9KNe+pL/urJYDU4f62nXh2
         HGYSle1n7ajLr1LUYAraB30SzBHB9HQ14KzjFP87h2plm2DiIF5J8DQc5RqlM/WSvVJg
         QOug==
X-Gm-Message-State: AOAM5315SAKMi3UE9/mqpYf8hF8Pcor3H4iqYMfLB5a44AwSk5FGfoFp
        Jj7O/8mPxNthhdrm8mUeZx5urg==
X-Google-Smtp-Source: ABdhPJz3gOHAXDXOCaeCLt+Wm8OxE3J7KW2DVAJ92m6u9gcU/CrsdHoZu+3TbWKutjmJYzUNSsJocw==
X-Received: by 2002:a17:90b:3851:: with SMTP id nl17mr437677pjb.40.1622560981121;
        Tue, 01 Jun 2021 08:23:01 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id o27sm14737217pgb.70.2021.06.01.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:23:00 -0700 (PDT)
Date:   Tue, 1 Jun 2021 15:22:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ilias Stamatis <ilstam@amazon.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, mlevitsk@redhat.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        zamsden@gmail.com, mtosatti@redhat.com, dwmw@amazon.co.uk
Subject: Re: [PATCH v5 09/11] KVM: X86: Add vendor callbacks for writing the
 TSC multiplier
Message-ID: <YLZQ0FS0dBzFFZ/3@google.com>
References: <20210528105745.1047-1-ilstam@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528105745.1047-1-ilstam@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021, Ilias Stamatis wrote:
> @@ -10343,8 +10360,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	else
>  		vcpu->arch.mp_state = KVM_MP_STATE_UNINITIALIZED;
>  
> -	kvm_set_tsc_khz(vcpu, max_tsc_khz);
> -
>  	r = kvm_mmu_create(vcpu);
>  	if (r < 0)
>  		return r;
> @@ -10443,6 +10458,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  	if (mutex_lock_killable(&vcpu->mutex))
>  		return;
>  	vcpu_load(vcpu);
> +	kvm_set_tsc_khz(vcpu, max_tsc_khz);

It would be safer to move the call within kvm_arch_vcpu_create(), not to
postcreate().  postcreate() runs after the vCPU file descriptor is exposed to
userspace, e.g. KVM_GET_TSC_KHZ could theoretically read the wrong value.  I
don't know if there's anything more sinister that could be done, but I also
don't see any reason to find out :-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bc6160db94b1..08f6b8f82506 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10291,8 +10291,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
        else
                vcpu->arch.mp_state = KVM_MP_STATE_UNINITIALIZED;

-       kvm_set_tsc_khz(vcpu, max_tsc_khz);
-
        r = kvm_mmu_create(vcpu);
        if (r < 0)
                return r;
@@ -10360,6 +10358,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
        vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
        kvm_vcpu_mtrr_init(vcpu);
        vcpu_load(vcpu);
+       kvm_set_tsc_khz(vcpu, max_tsc_khz);
        kvm_vcpu_reset(vcpu, false);
        kvm_init_mmu(vcpu, false);
        vcpu_put(vcpu);



>  	kvm_synchronize_tsc(vcpu, 0);
>  	vcpu_put(vcpu);
>  
> -- 
> 2.17.1
> 
