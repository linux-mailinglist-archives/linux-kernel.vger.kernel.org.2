Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA1930BD65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhBBLtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:49:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhBBLtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612266496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ecwjUL9ogQPnlg5os6JZZvpRuGjYi8S365zVuRrXRN0=;
        b=ieBKBbvxXCrl955M8t1MclAH5abE/xc2QDS0JSJbXQRp+q8c4cB1bkBfaUn5aP73HJx8SC
        gfNMpAk+iG+yeveunm5fAWgSWpvTB2RcIUssPiYdGrMLZr7bThnpM3Jngeny2IoF9V8oIi
        mdKKV+Zlf3hKLVsTUfZVCHiv5YtgPRk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-lnPCydTgP_qoiRDtaGrjhw-1; Tue, 02 Feb 2021 06:48:14 -0500
X-MC-Unique: lnPCydTgP_qoiRDtaGrjhw-1
Received: by mail-ej1-f72.google.com with SMTP id p1so9824779ejo.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 03:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ecwjUL9ogQPnlg5os6JZZvpRuGjYi8S365zVuRrXRN0=;
        b=QjlsKRZA2b7mzPk/ygMovnQsKgFAbzu1vLnNRk/GKSHZcYyWyrGvkka1aZnyFWQKjl
         rpQMEjK/YCi/xD1dwsqSwn6fviLunMWcYbF0qIQq7+d+YIp1xQ9Mkjjbxf/IuFIpCdWG
         In7IONMOPhzlFQdV7sQ2F55w9ftQMdq0k2KptfFfe8j0URsVu3gEZwQZDLXbrbUh97H7
         AosIwlOlA/HMiq5xCe6IQcoio+CuzEYJzvzDC/N17sGiK47tJny6ANi1BkA5i0aV7ze9
         BOwbMPjNoNaQpXIYgMS78UvyiO3zLAXef+uMdtjFn6oAB9iriUj8fIFPG91+m7S2M/N+
         zOTg==
X-Gm-Message-State: AOAM532QVCWr2MiszlmobxOQPnspg2xakRSh0Rqsk3WUpmHqzkKTNRIm
        rK7aPHfFN0X4UFKMmMLhjhO4JfCo8R3zTVCluJOIKtu/+OzVGV/MHfFqnbAO4H+j0iQl7OkbhjN
        y2hwWRPvx7OWtT1rhji/j1zF71UBDJnVZzIZRykGFHf1qjp4UMixxGcr1aRAeAlQBdYvI9tL7xJ
        y6
X-Received: by 2002:a17:906:e18:: with SMTP id l24mr4823118eji.500.1612266493378;
        Tue, 02 Feb 2021 03:48:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXKadNE8loFIx9Vwhb8yb6G+ELvCav6sNirryjEr9VKc/JCBv37u6gJqBKqHiycC0AhKpG3A==
X-Received: by 2002:a17:906:e18:: with SMTP id l24mr4823091eji.500.1612266492992;
        Tue, 02 Feb 2021 03:48:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j4sm9952998edt.18.2021.02.02.03.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 03:48:11 -0800 (PST)
Subject: Re: [PATCH v14 02/11] KVM: x86/pmu: Set up IA32_PERF_CAPABILITIES if
 PDCM bit is available
To:     Like Xu <like.xu@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, ak@linux.intel.com,
        wei.w.wang@intel.com, kan.liang@intel.com,
        alex.shi@linux.alibaba.com, kvm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210201051039.255478-1-like.xu@linux.intel.com>
 <20210201051039.255478-3-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ddc6861-7830-84db-a0c9-9da842237f6b@redhat.com>
Date:   Tue, 2 Feb 2021 12:48:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210201051039.255478-3-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/21 06:10, Like Xu wrote:
> 
> -	if (guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
> -		vcpu->arch.perf_capabilities = vmx_get_perf_capabilities();

Why remove this "if"?

>  	pmu->nr_arch_gp_counters = min_t(int, eax.split.num_counters, >  					 x86_pmu.num_counters_gp);
> @@ -405,6 +402,8 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
>  		pmu->fixed_counters[i].idx = i + INTEL_PMC_IDX_FIXED;
>  		pmu->fixed_counters[i].current_config = 0;
>  	}
> +
> +	vcpu->arch.perf_capabilities = 0;

Paolo

