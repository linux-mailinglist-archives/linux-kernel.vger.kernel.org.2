Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203CF367EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbhDVKfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41978 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235830AbhDVKfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619087717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdfhyPjzl93I4RQH6K4cW6ygLnYx8XGst7dOo3yXFqo=;
        b=db+IcnRL93XbosIkX/JQnOfjj5FkuReyY96EtCGGcX4PiSuQcicgHCuq+S6W1lTULyhFbK
        jYKFgN6gr7KMz1xqYY69ee+JmJntx7FdS3UpQAeEgh/Sr+Fnl/M1eVLktvtYt6qgWNb3WI
        QpcITRpgnHZeUYCId4tVE5L5nUyqWxo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-Q9y1A5wDPsW-3xVFkOdk5w-1; Thu, 22 Apr 2021 06:35:10 -0400
X-MC-Unique: Q9y1A5wDPsW-3xVFkOdk5w-1
Received: by mail-ed1-f71.google.com with SMTP id i25-20020a50fc190000b0290384fe0dab00so10915549edr.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 03:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LdfhyPjzl93I4RQH6K4cW6ygLnYx8XGst7dOo3yXFqo=;
        b=SqNgQH9qN4/4K4X+0PqGYLyvmV8PkhSYNhYHtvq4mi4lzAS5prj51nfqO0QLQWwmCy
         UwcVC6OTp94efXtNkX4xq58z4z7miiAiXH4ZllVb4B4whZtmZEBT5caNiY1WhLh7JW65
         embF6Dniu9Bg34YZwNZr3DpecVOFSusOgxp9Q8Vc5cylklMM+Z2hfbBAD7VvofG6hxvD
         tr9VqD98Sb4TslOsRZu3LqU+vU45c0Bce7f4b3xgugsrwRUV+CyWt9VdfqGBYndip3R+
         o5VslWUF101mp5Xyyhsnjn4PytkE6gCIXB0bEpUlcoS/mqnq0dLUzIco4KfahCBETtah
         FhVg==
X-Gm-Message-State: AOAM532VmC6oghVGglcdKJCU40SIwkHJ7N3zLudFTp0y56zUcKT4OUY6
        qBjV+EWT50ys6NqOMIwerzqnJmH5E2qj4wINQReBs1mQ6pGFneX/64lJOymA1lRXuOstRF09tYo
        2PfjkAJ26QMmIQlaztLoIGSJr
X-Received: by 2002:a17:906:5487:: with SMTP id r7mr2693768ejo.550.1619087708900;
        Thu, 22 Apr 2021 03:35:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOYCcXJDqdwFM+0LB++LtNM+KTanbcqcjFE3HE+WxK++ywXbUncB4GYd3RidtLudCQz//cYA==
X-Received: by 2002:a17:906:5487:: with SMTP id r7mr2693756ejo.550.1619087708767;
        Thu, 22 Apr 2021 03:35:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c13sm1768536edw.88.2021.04.22.03.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 03:35:07 -0700 (PDT)
Subject: Re: [PATCH v2 7/9] KVM: x86/xen: Drop RAX[63:32] when processing
 hypercall
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20210422022128.3464144-1-seanjc@google.com>
 <20210422022128.3464144-8-seanjc@google.com>
 <877dkuhcl7.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ddcc979-519c-a38c-065f-a9036cc2b58e@redhat.com>
Date:   Thu, 22 Apr 2021 12:35:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <877dkuhcl7.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 11:51, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
>> Truncate RAX to 32 bits, i.e. consume EAX, when retrieving the hypecall
>> index for a Xen hypercall.  Per Xen documentation[*], the index is EAX
>> when the vCPU is not in 64-bit mode.
>>
>> [*] http://xenbits.xenproject.org/docs/sphinx-unstable/guest-guide/x86/hypercall-abi.html
>>
>> Fixes: 23200b7a30de ("KVM: x86/xen: intercept xen hypercalls if enabled")
>> Cc: Joao Martins <joao.m.martins@oracle.com>
>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
>>   arch/x86/kvm/xen.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
>> index ae17250e1efe..7f27bb65a572 100644
>> --- a/arch/x86/kvm/xen.c
>> +++ b/arch/x86/kvm/xen.c
>> @@ -673,7 +673,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
>>   	bool longmode;
>>   	u64 input, params[6];
>>   
>> -	input = (u64)kvm_register_read(vcpu, VCPU_REGS_RAX);
>> +	input = (u64)kvm_register_readl(vcpu, VCPU_REGS_RAX);
>>   
>>   	/* Hyper-V hypercalls get bit 31 set in EAX */
>>   	if ((input & 0x80000000) &&
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> 
> Alternatively, as a minor optimization, you could've used '!longmode'
> check below, something like:
> 
> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index ae17250e1efe..7df1498d3a41 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -682,6 +682,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
>   
>          longmode = is_64_bit_mode(vcpu);
>          if (!longmode) {
> +               input = (u32)input;
>                  params[0] = (u32)kvm_rbx_read(vcpu);
>                  params[1] = (u32)kvm_rcx_read(vcpu);
>                  params[2] = (u32)kvm_rdx_read(vcpu);
> 

You haven't seen patch 9 yet. :)

Paolo

