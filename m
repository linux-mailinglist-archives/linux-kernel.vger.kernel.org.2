Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F0E43B6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbhJZQUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237542AbhJZQTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635265039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3jgSUASYWyT5tYVtpdVqMRt2uKiCafnLlQ6NZfT7RQo=;
        b=FSjsOYfVE/KoKC9WQe/bd2vWMV8NOFlUSOFpBXmG+HTlHaq2uiYfZ4lCsitvIFfMbTzWfg
        Kz0QThOWgmSLB70s8++eG3zZ8jqmi3nuUStl1pyv28HnlzGWMLtUDuLxZ8SgqjME9qmcDD
        xUB6uP4NSM7TQFeaeZCYG3GnleE+wvE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-O4U-1WW3Pni_0Y58mWYRKw-1; Tue, 26 Oct 2021 12:17:15 -0400
X-MC-Unique: O4U-1WW3Pni_0Y58mWYRKw-1
Received: by mail-ed1-f69.google.com with SMTP id q6-20020a056402518600b003dd81fc405eso2677325edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3jgSUASYWyT5tYVtpdVqMRt2uKiCafnLlQ6NZfT7RQo=;
        b=pk3h2BK3ECj+P1MdQZKOEzgD5dUvzmJmzhqCTHU9uuMTJukT8zPuOuOa/Bic77VX0W
         KtEufVdUSjcMtXvZJhv8fpY1wi2+GpKwewkAhbtUN/uvtYZq6kOeq4LKNRblvuSUvMfo
         s0PdGnuCj5Lor9lNCDyrXusEL6mKIuY4hBsyFt2l3T2SJ94RMdzc44GmaokG/rWQj7js
         K/KTvjoPrcf+7vXb0vY27rQ+jHbIm24GsqmrH22ORD3c0p/j2I7Oyd7Gkj7pwY/tWWeK
         M5mMROyemtGKB0TDJo8NkPBxb/WGw9dUT8zeS8AB7o2PRnRdn/wzM6EX306/2L9TdZkq
         Rl1Q==
X-Gm-Message-State: AOAM533ErtJKUkne3gvtv5jdHfQuXBWntp/rVkYaq8a+X/Sx0ecA0168
        hIS21kDwizuLQELGuwDsQn+Cse8mTHQ4ltPU5znu/rGfuNVaywcqs3cBgyvfF5wNmImnFHlCXrB
        cilji9xHNRMELff90JMSMXxxv
X-Received: by 2002:a17:906:b184:: with SMTP id w4mr31291861ejy.418.1635265032943;
        Tue, 26 Oct 2021 09:17:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0CHq+n59DAZ2qwoWG3v25yTG1EA+fzNL7P1VBFbJ8j5wzwu7ibo4hUT23/l+2O/v0fOKE0A==
X-Received: by 2002:a17:906:b184:: with SMTP id w4mr31291837ejy.418.1635265032719;
        Tue, 26 Oct 2021 09:17:12 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id nd22sm10019205ejc.98.2021.10.26.09.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:17:12 -0700 (PDT)
Message-ID: <54842867-9d40-5b8d-ea24-3ce32c8137ac@redhat.com>
Date:   Tue, 26 Oct 2021 18:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH MANUALSEL 5.14 5/5] KVM: MMU: Reset mmu->pkru_mask to
 avoid stale data
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, huaitong.han@intel.com,
        guangrong.xiao@linux.intel.com, kvm@vger.kernel.org
References: <20211025203828.1404503-1-sashal@kernel.org>
 <20211025203828.1404503-5-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211025203828.1404503-5-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/21 22:38, Sasha Levin wrote:
> From: Chenyi Qiang <chenyi.qiang@intel.com>
> 
> [ Upstream commit a3ca5281bb771d8103ea16f0a6a8a5df9a7fb4f3 ]
> 
> When updating mmu->pkru_mask, the value can only be added but it isn't
> reset in advance. This will make mmu->pkru_mask keep the stale data.
> Fix this issue.
> 
> Fixes: 2d344105f57c ("KVM, pkeys: introduce pkru_mask to cache conditions")
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Message-Id: <20211021071022.1140-1-chenyi.qiang@intel.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/x86/kvm/mmu/mmu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index c268fb59f779..6719a8041f59 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4465,10 +4465,10 @@ static void update_pkru_bitmask(struct kvm_mmu *mmu)
>   	unsigned bit;
>   	bool wp;
>   
> -	if (!is_cr4_pke(mmu)) {
> -		mmu->pkru_mask = 0;
> +	mmu->pkru_mask = 0;
> +
> +	if (!is_cr4_pke(mmu))
>   		return;
> -	}
>   
>   	wp = is_cr0_wp(mmu);
>   
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

