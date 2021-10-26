Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC44B43B6AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhJZQRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234886AbhJZQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635264878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAAzOJIZshLT5gRfcvPfI+wHgBi/Zbeh5mViB3wqN9Y=;
        b=Rqrtuc41QqGO9IHSZet48m36qg8eMndSy5IkJnzcB8lnhCqc0MmIrEJ4DIKDm2ybD6Dt5q
        jH6TSMPCLYzvVftAw+jGh9ZJSoeHILmesEKZaUKGKjWV5OatJVGsUS4OugrFGvTR/JVcg0
        TcjrkiBMLUVjj+zj9lMApbpuoAF8HWw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-_bT3xz5BNyaHSRobsxRyHA-1; Tue, 26 Oct 2021 12:14:37 -0400
X-MC-Unique: _bT3xz5BNyaHSRobsxRyHA-1
Received: by mail-ed1-f70.google.com with SMTP id q6-20020a056402518600b003dd81fc405eso2669935edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nAAzOJIZshLT5gRfcvPfI+wHgBi/Zbeh5mViB3wqN9Y=;
        b=TU3p3aeZ5iMaIMP8dgoXO3qK6OCH5fztVf5fex9IaUh8lSbfGkrv1yD3BIljPmMGmB
         sm0B1ObYwgfDy1zwQcTUI9CPzZXUjGzlM6gsWKkDT9gieRr2G3ukpG0p7eLfthHgm1J5
         p40lPTRyzff0OlRZmq+ssGP28ikknbb+Vn8jgNQn0Clo854+B5a2Dgyb2jBTYLIXwpv3
         QEt15CDedwPLkJhFrGfA6VeFOU4Rr9U5ZWDIyP5sbMDXx0/fBCcwVIC4Hkn+vWmZ57SN
         sW7kIK0+HVgLkrMKPoiimtM2RRQvGxWngfTIquXtM6ZC7/Th7LhM8TrGNkXswJ8oMMfo
         MDfQ==
X-Gm-Message-State: AOAM531zvvhHtjJX6H+d284d127PoHIkzoLIAZ50BCP0DTKR60K0UIVz
        BridqUnBNKDfaGR/jL9V7fMeLl+7BHAn8FQQw7c+4smNJUB2mgc8O88qOal7GWPupm1k9S0kV9b
        ki5ZIzrK9Z7luyz64p51Fy6hT
X-Received: by 2002:a17:906:2bd5:: with SMTP id n21mr31835021ejg.337.1635264876465;
        Tue, 26 Oct 2021 09:14:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsmXT1S2dUXbLniu/Vt6Q3qHqeqq2MVl17CxSLBokD1O3xPho3oeqmwVbFxih2dz8J6zWXgA==
X-Received: by 2002:a17:906:2bd5:: with SMTP id n21mr31834996ejg.337.1635264876220;
        Tue, 26 Oct 2021 09:14:36 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id cb17sm3694530edb.11.2021.10.26.09.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:14:35 -0700 (PDT)
Message-ID: <9c88dadb-8cae-9bbe-1241-dfc06afe13d5@redhat.com>
Date:   Tue, 26 Oct 2021 18:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH MANUALSEL 5.14 1/5] KVM: X86: fix lazy allocation of rmaps
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, kvm@vger.kernel.org
References: <20211025203828.1404503-1-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211025203828.1404503-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/21 22:38, Sasha Levin wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> [ Upstream commit fa13843d1565d4c5b3aeb9be3343b313416bef46 ]
> 
> If allocation of rmaps fails, but some of the pointers have already been written,
> those pointers can be cleaned up when the memslot is freed, or even reused later
> for another attempt at allocating the rmaps.  Therefore there is no need to
> WARN, as done for example in memslot_rmap_alloc, but the allocation *must* be
> skipped lest KVM will overwrite the previous pointer and will indeed leak memory.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/x86.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4b0e866e9f08..60d9aa0ab389 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11341,7 +11341,8 @@ static int memslot_rmap_alloc(struct kvm_memory_slot *slot,
>   		int lpages = gfn_to_index(slot->base_gfn + npages - 1,
>   					  slot->base_gfn, level) + 1;
>   
> -		WARN_ON(slot->arch.rmap[i]);
> +		if (slot->arch.rmap[i])
> +			continue;
>   
>   		slot->arch.rmap[i] = kvcalloc(lpages, sz, GFP_KERNEL_ACCOUNT);
>   		if (!slot->arch.rmap[i]) {
> 

NACK

There is no lazy allocation of rmaps in 5.14, and any failure to 
allocate goes straight to memslot_rmap_free followed by return -ENOMEM. 
  So the WARN_ON is justified there.

Paolo

