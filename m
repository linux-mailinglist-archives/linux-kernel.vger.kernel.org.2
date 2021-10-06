Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8E0423CB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbhJFLZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238448AbhJFLZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633519396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cwJDi3dXbHoGWrH9UTdaW4pqTLM9RuzG7yK9uGbXyIc=;
        b=WsOq9i9zpTuPMzPIHjhpBywxnOBmEqBUFU4C7ULz34OR2yLKbrUJv543+57O97ozULD2rU
        0zw0Z6xMZN8S0QSw4BP5epli2fWfqtxnMOsv2V1Xr3g5OFx7eFJx86eoAPSlqef6oio/58
        vi5a5ES7VobY14pWfmJYsKzLd1grV3s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-fBqjyLbsNw6yMUxSNhCm7A-1; Wed, 06 Oct 2021 07:23:15 -0400
X-MC-Unique: fBqjyLbsNw6yMUxSNhCm7A-1
Received: by mail-ed1-f70.google.com with SMTP id w6-20020a50d786000000b003dabc563406so2287591edi.17
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 04:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cwJDi3dXbHoGWrH9UTdaW4pqTLM9RuzG7yK9uGbXyIc=;
        b=7k+M3e8mJAwax7TziK+sLeryK9YG7jT4sX4hoAUVSuqrP+YDlCqFz4Jm07jQAlDO7b
         tWX2Rnmo9ObzQvOKP9iLVs+SJh/LCKZvvLxX5p+BhT9puKidHyvxVHlgg1/j14PsyfFy
         aT19CGuMBeyFi5a0sJXWf/ocqNs0oOD4UT60BnG/dEHVdHytO1I2bBuvuna2VqAwDRjp
         fnn0OfuT7m6WYTkGwnAW2BJAo65sQvCvX1oZbOfVQZAlbHbUUJQ8kn7igrZWixGLtLzt
         2l6YKpVXP7qLiXqGiv4zEuAOC2j4chhYXxV3sixtdiSQNDP97kzxky5wqx26QIicuFmD
         uR2A==
X-Gm-Message-State: AOAM5309fyqV6d0yzIrF7tpLA9vFa77D0jnP+BnBA65Lqhq5jGxZLDgl
        WyDV21AEpG5JQfwv/mYkG5dgCQbUbnGrnKlWviWTceIEY+URW8Ud39/ceDFUgzQgOBSEwsv5Fjt
        hRJVuYvXBss+W+pYsjwRQ4+jy
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr32209592ejc.249.1633519394532;
        Wed, 06 Oct 2021 04:23:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE3suZXUr4cp0B3UpwBcE2Rj9bs3G/seiS/zIPgZInL2THx7fKpkf+oaSVxGKyv1s/LKAwpA==
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr32209572ejc.249.1633519394351;
        Wed, 06 Oct 2021 04:23:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id u16sm8749641ejy.14.2021.10.06.04.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 04:23:13 -0700 (PDT)
Message-ID: <90e9e5e8-0f9f-e31f-ba76-2d46b6a44736@redhat.com>
Date:   Wed, 6 Oct 2021 13:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH MANUALSEL 5.10 5/7] kvm: x86: Add AMD PMU MSRs to
 msrs_to_save_all[]
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Fares Mehanna <faresx@amazon.de>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, kvm@vger.kernel.org
References: <20211006111234.264020-1-sashal@kernel.org>
 <20211006111234.264020-5-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211006111234.264020-5-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/21 13:12, Sasha Levin wrote:
> From: Fares Mehanna <faresx@amazon.de>
> 
> [ Upstream commit e1fc1553cd78292ab3521c94c9dd6e3e70e606a1 ]
> 
> Intel PMU MSRs is in msrs_to_save_all[], so add AMD PMU MSRs to have a
> consistent behavior between Intel and AMD when using KVM_GET_MSRS,
> KVM_SET_MSRS or KVM_GET_MSR_INDEX_LIST.
> 
> We have to add legacy and new MSRs to handle guests running without
> X86_FEATURE_PERFCTR_CORE.
> 
> Signed-off-by: Fares Mehanna <faresx@amazon.de>
> Message-Id: <20210915133951.22389-1-faresx@amazon.de>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/x86.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d65da3b5837b..b885063dc393 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1250,6 +1250,13 @@ static const u32 msrs_to_save_all[] = {
>   	MSR_ARCH_PERFMON_EVENTSEL0 + 12, MSR_ARCH_PERFMON_EVENTSEL0 + 13,
>   	MSR_ARCH_PERFMON_EVENTSEL0 + 14, MSR_ARCH_PERFMON_EVENTSEL0 + 15,
>   	MSR_ARCH_PERFMON_EVENTSEL0 + 16, MSR_ARCH_PERFMON_EVENTSEL0 + 17,
> +
> +	MSR_K7_EVNTSEL0, MSR_K7_EVNTSEL1, MSR_K7_EVNTSEL2, MSR_K7_EVNTSEL3,
> +	MSR_K7_PERFCTR0, MSR_K7_PERFCTR1, MSR_K7_PERFCTR2, MSR_K7_PERFCTR3,
> +	MSR_F15H_PERF_CTL0, MSR_F15H_PERF_CTL1, MSR_F15H_PERF_CTL2,
> +	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
> +	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
> +	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
>   };
>   
>   static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_all)];
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

