Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63193DDCA9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhHBPqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235102AbhHBPqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627919185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ajvnHluA867RdGZlexeIhFwJ8QUYCttbeHBIj4eOw+8=;
        b=CkB86EPXRxrMg+GAl/bu2RTahlwNJBQlly1IM4n/1e8QrQp8bFVI6C4BMMOA6+M5RbMZs2
        sFcibkU2vGofqsOtQ1A7jKwgTV5ofcF+pdKFnvgSTX1wsl98a24oP9otEtntj9TDgrj8TV
        nNgydpbhFj7dovwb3InahcWcz+13JNw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-zkSpEOt2OYqraQEJ6Tb5Jw-1; Mon, 02 Aug 2021 11:46:24 -0400
X-MC-Unique: zkSpEOt2OYqraQEJ6Tb5Jw-1
Received: by mail-wr1-f70.google.com with SMTP id z10-20020adfdf8a0000b02901536d17cd63so6623767wrl.21
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ajvnHluA867RdGZlexeIhFwJ8QUYCttbeHBIj4eOw+8=;
        b=LG8WIEUrMc01+5RjX1uAGTJEueQ3bqGpzKdRO12NXF2I8U4G66ReRZQb9NGlLqqmyD
         bLQA8eynLdrGNHTwZ2N1gLiN1LyL3EcMb6fm59ynLgZkC/53rG4sQ5Ef6GOCrvBG1tDw
         caqDhob41RK4tnZC1s2x0E2c2Pky4257DGR9ITXttNBCUWlU/h7FtXvkElOT0XCXDRFm
         baIhtDihNBJd2GU0EMIVjdgbpeHDnq5S+dqJmiS5pOoO88ADpva3oQvcZWPNBsjzUSkr
         f0DnXmf54FQ1bm644woRmuzAjW0cXW20Llmkbg36PJbFU84YOHr0Kqj+ixIMvTVXpKpC
         usqw==
X-Gm-Message-State: AOAM533v5bsFims5PCyyo5C1CTb5rGFejrNZH7Y0imkWo5MrDf6QxE5y
        b8FRzgnb+wk9KIqMzJwmcky7Y6J6GMkF5ptSzLFnLtJs7/WUgdav8fdQP9CPRR81OLwcUC+YOqu
        1M0OKb1ZNPwFtTcnNLwBqGDnh6F28Z7hqMm2PSKNvPKZ/LIjak7qXjmasm/3gmKjNVHalaHnh6a
        sH
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr18847301wro.390.1627919182468;
        Mon, 02 Aug 2021 08:46:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY1BCQzPsZFV2SjOkvGPU+pQM37pPcAbyInqUAOs1oZfToNhXPHVMmxMcu3td2vrkDkR3Lkw==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr18847276wro.390.1627919182214;
        Mon, 02 Aug 2021 08:46:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j6sm10367926wmq.29.2021.08.02.08.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 08:46:21 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/pmu: Introduce pmc->is_paused to reduce the call
 time of perf interfaces
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210728120705.6855-1-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e1526dd-12e6-ad35-e69c-4eb58ed032e0@redhat.com>
Date:   Mon, 2 Aug 2021 17:46:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728120705.6855-1-likexu@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/21 14:07, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Based on our observations, after any vm-exit associated with vPMU, there
> are at least two or more perf interfaces to be called for guest counter
> emulation, such as perf_event_{pause, read_value, period}(), and each one
> will {lock, unlock} the same perf_event_ctx. The frequency of calls becomes
> more severe when guest use counters in a multiplexed manner.
> 
> Holding a lock once and completing the KVM request operations in the perf
> context would introduce a set of impractical new interfaces. So we can
> further optimize the vPMU implementation by avoiding repeated calls to
> these interfaces in the KVM context for at least one pattern:
> 
> After we call perf_event_pause() once, the event will be disabled and its
> internal count will be reset to 0. So there is no need to pause it again
> or read its value. Once the event is paused, event period will not be
> updated until the next time it's resumed or reprogrammed. And there is
> also no need to call perf_event_period twice for a non-running counter,
> considering the perf_event for a running counter is never paused.
> 
> Based on this implementation, for the following common usage of
> sampling 4 events using perf on a 4u8g guest:
> 
>    echo 0 > /proc/sys/kernel/watchdog
>    echo 25 > /proc/sys/kernel/perf_cpu_time_max_percent
>    echo 10000 > /proc/sys/kernel/perf_event_max_sample_rate
>    echo 0 > /proc/sys/kernel/perf_cpu_time_max_percent
>    for i in `seq 1 1 10`
>    do
>    taskset -c 0 perf record \
>    -e cpu-cycles -e instructions -e branch-instructions -e cache-misses \
>    /root/br_instr a
>    done
> 
> the average latency of the guest NMI handler is reduced from
> 37646.7 ns to 32929.3 ns (~1.14x speed up) on the Intel ICX server.
> Also, in addition to collecting more samples, no loss of sampling
> accuracy was observed compared to before the optimization.
> 
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>   arch/x86/include/asm/kvm_host.h | 1 +
>   arch/x86/kvm/pmu.c              | 5 ++++-
>   arch/x86/kvm/pmu.h              | 2 +-
>   arch/x86/kvm/vmx/pmu_intel.c    | 4 ++--
>   4 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 99f37781a6fc..a079880d4cd5 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -482,6 +482,7 @@ struct kvm_pmc {
>   	 * ctrl value for fixed counters.
>   	 */
>   	u64 current_config;
> +	bool is_paused;
>   };
>   
>   struct kvm_pmu {
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 827886c12c16..0772bad9165c 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -137,18 +137,20 @@ static void pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type,
>   	pmc->perf_event = event;
>   	pmc_to_pmu(pmc)->event_count++;
>   	clear_bit(pmc->idx, pmc_to_pmu(pmc)->reprogram_pmi);
> +	pmc->is_paused = false;
>   }
>   
>   static void pmc_pause_counter(struct kvm_pmc *pmc)
>   {
>   	u64 counter = pmc->counter;
>   
> -	if (!pmc->perf_event)
> +	if (!pmc->perf_event || pmc->is_paused)
>   		return;
>   
>   	/* update counter, reset event value to avoid redundant accumulation */
>   	counter += perf_event_pause(pmc->perf_event, true);
>   	pmc->counter = counter & pmc_bitmask(pmc);
> +	pmc->is_paused = true;
>   }
>   
>   static bool pmc_resume_counter(struct kvm_pmc *pmc)
> @@ -163,6 +165,7 @@ static bool pmc_resume_counter(struct kvm_pmc *pmc)
>   
>   	/* reuse perf_event to serve as pmc_reprogram_counter() does*/
>   	perf_event_enable(pmc->perf_event);
> +	pmc->is_paused = false;
>   
>   	clear_bit(pmc->idx, (unsigned long *)&pmc_to_pmu(pmc)->reprogram_pmi);
>   	return true;
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 67e753edfa22..0e4f2b1fa9fb 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -55,7 +55,7 @@ static inline u64 pmc_read_counter(struct kvm_pmc *pmc)
>   	u64 counter, enabled, running;
>   
>   	counter = pmc->counter;
> -	if (pmc->perf_event)
> +	if (pmc->perf_event && !pmc->is_paused)
>   		counter += perf_event_read_value(pmc->perf_event,
>   						 &enabled, &running);
>   	/* FIXME: Scaling needed? */
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 9efc1a6b8693..10cc4f65c4ef 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -437,13 +437,13 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   			    !(msr & MSR_PMC_FULL_WIDTH_BIT))
>   				data = (s64)(s32)data;
>   			pmc->counter += data - pmc_read_counter(pmc);
> -			if (pmc->perf_event)
> +			if (pmc->perf_event && !pmc->is_paused)
>   				perf_event_period(pmc->perf_event,
>   						  get_sample_period(pmc, data));
>   			return 0;
>   		} else if ((pmc = get_fixed_pmc(pmu, msr))) {
>   			pmc->counter += data - pmc_read_counter(pmc);
> -			if (pmc->perf_event)
> +			if (pmc->perf_event && !pmc->is_paused)
>   				perf_event_period(pmc->perf_event,
>   						  get_sample_period(pmc, data));
>   			return 0;
> 

Queued, thanks.

Paolo

