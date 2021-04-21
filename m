Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB96366F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbhDUPod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbhDUPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:44:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3500C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:43:56 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i190so29207120pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=elppaAkOc1/0Jt501kiVQEY924sEoMf9eWZWF2XQvuU=;
        b=Ic6Vtbe3Xp7p4sd47EraWwmCYorWJv/sTmFhoWimiMtu/s2p89+XSDD0oHxXAFBfWz
         5MbsuY5BovUonnGShHZqpfLWx40OEn/rnn7GiKlgCeA4mk1GoOLL9eSNEbxkTEjJ3Flw
         N3NN7MvrSCkyIuJ8r2FVuf1R9iPAff0Qw4NuSM/lTNwMsWLUH5SmRiXaCL8QCQ9MD4Az
         MI0SK4tSVFu6Ha6kg2v9fiDdQE8VBM8QMPo0/eZY7JC7JelGID3rvRoye1cz5QgKJRTT
         nkReOUPLhxsCOi8nCW0DUNtMnxbFMwGZume7rD1+xK4OqFfAqRNQ12QReEdPvl2/lcvJ
         oWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elppaAkOc1/0Jt501kiVQEY924sEoMf9eWZWF2XQvuU=;
        b=t3lBdcO1YnEBoJJgOjMFLkE7b8m/rVEhfDIZrhDCjMxoNEyDGr07B/UGpI0gDPTMJ3
         e5nEGH5ZFlPJx1gWaBK4hbq0DwriyUlM51XzSbj5p/Pn+m+UHw1t+C8jqL/MHbXy1RCa
         leVxTCaihxUz2c7rPrpyY+mgYUcbmh2WMA6Ahds0mW+9delFJsrZr0RrlSSKKjA3Yv8W
         wBXU/WQlWeXQH1khVo4dKTwpy7K5830S3g+c/xkhsUSheU2Q5mLv6tTuy/WaZD9cLMKg
         +Zir/hqGr1GtB5JMeNUXth1ULz3Q6EuHnW2xXaAMlQICCyVeLJKZGfY9MLp4bhr1Aeug
         R/nQ==
X-Gm-Message-State: AOAM531kRQAswwxuqgkxZkcgjTWip1bwCRReL9O77DaD+bXpKGH4RjMD
        qRj+psbD3Q+Kn2uVhGgGwzHY/w==
X-Google-Smtp-Source: ABdhPJxxmv19IvpPACaXWHT29Xx35rQYTgCDQM1IKc+vAOyw8cdhTkWh6GQv8HQ+fRhOWLW9J68OqQ==
X-Received: by 2002:a17:90b:46d7:: with SMTP id jx23mr11629409pjb.168.1619019835864;
        Wed, 21 Apr 2021 08:43:55 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id o127sm2170295pfd.147.2021.04.21.08.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 08:43:55 -0700 (PDT)
Date:   Wed, 21 Apr 2021 15:43:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kenta Ishiguro <kentaishiguro@sslab.ics.keio.ac.jp>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pl@sslab.ics.keio.ac.jp,
        kono@sslab.ics.keio.ac.jp
Subject: Re: [RFC PATCH 2/2] Boost vCPUs based on IPI-sender and receiver
 information
Message-ID: <YIBIN7i7W6SuDqjN@google.com>
References: <20210421150831.60133-1-kentaishiguro@sslab.ics.keio.ac.jp>
 <20210421150831.60133-3-kentaishiguro@sslab.ics.keio.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421150831.60133-3-kentaishiguro@sslab.ics.keio.ac.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021, Kenta Ishiguro wrote:
> This commit monitors IPI communication between vCPUs and leverages the
> relationship between vCPUs to select boost candidates.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Kenta Ishiguro <kentaishiguro@sslab.ics.keio.ac.jp>
> ---
>  arch/x86/kvm/lapic.c     | 14 ++++++++++++++
>  arch/x86/kvm/vmx/vmx.c   |  2 ++
>  include/linux/kvm_host.h |  5 +++++
>  virt/kvm/kvm_main.c      | 26 ++++++++++++++++++++++++--
>  4 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index cc369b9ad8f1..c8d967ddecf9 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1269,6 +1269,18 @@ void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, int vector)
>  }
>  EXPORT_SYMBOL_GPL(kvm_apic_set_eoi_accelerated);
>  
> +static void mark_ipi_receiver(struct kvm_lapic *apic, struct kvm_lapic_irq *irq)
> +{
> +	struct kvm_vcpu *dest_vcpu;
> +	u64 prev_ipi_received;
> +
> +	dest_vcpu = kvm_get_vcpu_by_id(apic->vcpu->kvm, irq->dest_id);
> +	if (READ_ONCE(dest_vcpu->sched_outed)) {
> +		prev_ipi_received = READ_ONCE(dest_vcpu->ipi_received);
> +		WRITE_ONCE(dest_vcpu->ipi_received, prev_ipi_received | (1 << apic->vcpu->vcpu_id));

The lack of "ull" on '1' actually means this will probably go sideways at >32 vCPUs.
Regardless, there needs to be an actual fallback path when the number of vCPUs
exceeds what the IPI-boost can support.  That said, it should be quite easy to
allocate a bitmap to support an arbitrary number of vCPUs.

> +	}
> +}
> +
>  void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high)
>  {
>  	struct kvm_lapic_irq irq;
> @@ -1287,6 +1299,8 @@ void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high)
>  
>  	trace_kvm_apic_ipi(icr_low, irq.dest_id);
>  
> +	mark_ipi_receiver(apic, &irq);
> +
>  	kvm_irq_delivery_to_apic(apic->vcpu->kvm, apic, &irq, NULL);
>  }
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 29b40e092d13..ced50935a38b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6718,6 +6718,8 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  		vmcs_write32(PLE_WINDOW, vmx->ple_window);
>  	}
>  
> +	WRITE_ONCE(vcpu->ipi_received, 0);
> +
>  	/*
>  	 * We did this in prepare_switch_to_guest, because it needs to
>  	 * be within srcu_read_lock.
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 1b65e7204344..6726aeec03e7 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -320,6 +320,11 @@ struct kvm_vcpu {
>  #endif
>  	bool preempted;
>  	bool ready;
> +	bool sched_outed;
> +	/*
> +	 * The current implementation of strict boost supports up to 64 vCPUs
> +	 */
> +	u64 ipi_received;

...

>  	struct kvm_vcpu_arch arch;
>  	struct kvm_dirty_ring dirty_ring;
>  };
