Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643443BD847
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhGFOgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhGFOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625581681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jP5DGGxJWoHogq5jV5uZ5mGaY2kRQONzJzlVOQeyzM0=;
        b=jONxPTpgylrsDkjyeSzbSIq+5ybobqnG0YL1rqRJSXpf1kEGD8mBfNmHozcTygte1IgzR1
        n7ipIVAqNqtdKz/fz5ObP6eTuXYcaVtC6mZth1vNgj4iJUOQCc/vdCcebzQNU8HEm+kHii
        GBDJdCkdD84vOvxGFjyUinw/UY6cWqE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-s1IvoWJxOV-_X_JwGsrtiw-1; Tue, 06 Jul 2021 10:11:01 -0400
X-MC-Unique: s1IvoWJxOV-_X_JwGsrtiw-1
Received: by mail-ed1-f72.google.com with SMTP id i8-20020a50fc080000b02903989feb4920so5400518edr.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jP5DGGxJWoHogq5jV5uZ5mGaY2kRQONzJzlVOQeyzM0=;
        b=JZ9xPERTOXWtMGSm1K0eC8MuQDZecimTU9o7F3yqMmkSD0GHDE+SRjlbrjtwF25URn
         rsuWqrjWzDA8Tg3w1oH+Al4HIAPDO4K1mDfb1AB4AICg1w0xsD0qM+wP+xQ7/cM5DxnM
         0Qnw89JRvXvEu08zBozjGXBMG+yW3d/6re0NEUT4pKuycYT05bvRf5cZwaABuqFo+ug7
         VIuNVoi6d3PrQemKltdPkQEwCJlypRD/Y1iEEco/VWgoUWohKDMmDTI6DZSznzExsviX
         4ZEQ+VlVGXFvf1AhjKN+C2Ln+/sxTkCiMvCbrBxzBGsYkSWvDCA2hkq2WrFz1JScs/k3
         56cQ==
X-Gm-Message-State: AOAM533yTm2LxE5Hl9EJye2G0CdOTeMfiozGTkm2tfKNdeHdoFUBPKpH
        pnnWjh24UQNRGKIzC1PuQchhoPZCtKnv8E7RbSD/dFFsCpJ5dgjp9SczgfyM8VRS5xgV4OJm+a7
        HSeibMIQ5g/JSKeAYEeWDLi2A
X-Received: by 2002:a17:906:dc91:: with SMTP id cs17mr18827618ejc.389.1625580659905;
        Tue, 06 Jul 2021 07:10:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3OchyKJxg4IMKf3xa49iq+6B/OGalJj/TJI+5nrz+mfJ2AakBWeZtDiyZEdBBtoYaxp7Pkw==
X-Received: by 2002:a17:906:dc91:: with SMTP id cs17mr18827594ejc.389.1625580659732;
        Tue, 06 Jul 2021 07:10:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id lz19sm5925092ejb.48.2021.07.06.07.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:10:58 -0700 (PDT)
Subject: Re: [RFC PATCH v2 33/69] KVM: x86: Add kvm_x86_ops .cache_gprs() and
 .flush_gprs()
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <1d51898908a53120e3c60944108730e1922c2206.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71ea2142-b299-0fbf-c6f5-5146ad8370a6@redhat.com>
Date:   Tue, 6 Jul 2021 16:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1d51898908a53120e3c60944108730e1922c2206.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add hooks to cache and flush GPRs and invoke them from KVM_GET_REGS and
> KVM_SET_REGS respecitively.  TDX will use the hooks to read/write GPRs
> from TDX-SEAM on-demand (for debug TDs).
> 
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   arch/x86/include/asm/kvm_host.h | 2 ++
>   arch/x86/kvm/x86.c              | 6 ++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 00333af724d7..9791c4bb5198 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1248,6 +1248,8 @@ struct kvm_x86_ops {
>   	void (*set_gdt)(struct kvm_vcpu *vcpu, struct desc_ptr *dt);
>   	void (*sync_dirty_debug_regs)(struct kvm_vcpu *vcpu);
>   	void (*set_dr7)(struct kvm_vcpu *vcpu, unsigned long value);
> +	void (*cache_gprs)(struct kvm_vcpu *vcpu);
> +	void (*flush_gprs)(struct kvm_vcpu *vcpu);
>   	void (*cache_reg)(struct kvm_vcpu *vcpu, enum kvm_reg reg);
>   	unsigned long (*get_rflags)(struct kvm_vcpu *vcpu);
>   	void (*set_rflags)(struct kvm_vcpu *vcpu, unsigned long rflags);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c231a88d5946..f7ae0a47e555 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9850,6 +9850,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>   
>   static void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>   {
> +	if (kvm_x86_ops.cache_gprs)
> +		kvm_x86_ops.cache_gprs(vcpu);
> +
>   	if (vcpu->arch.emulate_regs_need_sync_to_vcpu) {
>   		/*
>   		 * We are here if userspace calls get_regs() in the middle of
> @@ -9924,6 +9927,9 @@ static void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>   
>   	vcpu->arch.exception.pending = false;
>   
> +	if (kvm_x86_ops.flush_gprs)
> +		kvm_x86_ops.flush_gprs(vcpu);
> +
>   	kvm_make_request(KVM_REQ_EVENT, vcpu);
>   }
>   
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

