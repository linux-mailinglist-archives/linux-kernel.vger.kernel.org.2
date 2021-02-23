Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D686F322F58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhBWRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:08:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232920AbhBWRI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614100022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMCIQJKY2gv1PvwEvAbWVmJle6/ioi4+zRFYF65GoXo=;
        b=OQgiX8FKt+C4CnteMrptKQUnMRPdE5wYYAvEEfOZYI1rW6tiS1hGpcTYwPTZTLlA/oXbnO
        HbOgLS9HPX00kh0XDdhdZR6MBzN3GriK/NZxzQ7JMulB3Gr8YQYJ9i+kxG+x3ryZBLayhg
        JxyaY+tDRbXnocCwa0FD+B2HKY5qCgE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-XKUz2DZZMYCHsQf50K2rJA-1; Tue, 23 Feb 2021 12:06:30 -0500
X-MC-Unique: XKUz2DZZMYCHsQf50K2rJA-1
Received: by mail-ed1-f72.google.com with SMTP id f11so8996130edk.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 09:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aMCIQJKY2gv1PvwEvAbWVmJle6/ioi4+zRFYF65GoXo=;
        b=Gi5CSBYHq9ILGQ6oHJi++UWPN4xrBlnxxNbMVPp7rirM6t7V46gU1YBA53S0vD6W7I
         WpvihXEcTCmlSkZLJWmpty+sbZ/ImTn3W+OxWPsLtJ/sYhkwpc3KMo3aCUsDjakX/tds
         4d+qJjHtJ4HrNRxgeZfv3M+hFm9jT95EJBXND+fvMr9xk0UGnkXUYl6Icr8GJFRyQQMB
         5UpkOObVqNNN/66RYuz1W+a4m/1Lg7mQhzEg8378z0OAKDvKDp8ck52X4DXI5HcBVhPw
         8/2Bz6iWswMQkm20r2lsnX7likC81XvVJRSVE9GiYf+YptMtf9EphLEdO8SzU1U/0idY
         EJSw==
X-Gm-Message-State: AOAM533JTgWTlxzNSKEdGCngN47mCHsrXcEDaj2bbaRHy0kWUeH/p/Bk
        883mOR6VTH2E2BS2zk/2b2d0CeONKKuVYtHpgCF0OL1p/KduJAoWWKQ+/9jZB8x5H15G2LZcCFY
        puHgZfDyjIJ9Y4p7fnM71oCpPXteG+ciB+p8tdwh/ZYwkrikFvJXL55eHE/CnTk2P9RuI+f0Ju6
        QX
X-Received: by 2002:a17:906:380c:: with SMTP id v12mr26752103ejc.65.1614099988462;
        Tue, 23 Feb 2021 09:06:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzr81niRC94WMSG/vddS3VKjUqmFd7IN/gk9bStHk7twlww78LpqTJIVWWqAbBcj5W8zGjzDQ==
X-Received: by 2002:a17:906:380c:: with SMTP id v12mr26752078ejc.65.1614099988306;
        Tue, 23 Feb 2021 09:06:28 -0800 (PST)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id r10sm3264536edd.49.2021.02.23.09.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 09:06:27 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: vmx/pmu: Fix dummy check if lbr_desc->event is
 created
To:     Like Xu <like.xu@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210223013958.1280444-1-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34fa477b-f630-43ee-1df5-f64bd57d90f1@redhat.com>
Date:   Tue, 23 Feb 2021 18:06:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210223013958.1280444-1-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/21 02:39, Like Xu wrote:
> If lbr_desc->event is successfully created, the intel_pmu_create_
> guest_lbr_event() will return 0, otherwise it will return -ENOENT,
> and then jump to LBR msrs dummy handling.
> 
> Fixes: 1b5ac3226a1a ("KVM: vmx/pmu: Pass-through LBR msrs when the guest LBR event is ACTIVE")
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>   arch/x86/kvm/vmx/pmu_intel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index d1df618cb7de..d6a5fe19ff09 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -320,7 +320,7 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
>   	if (!intel_pmu_is_valid_lbr_msr(vcpu, index))
>   		return false;
>   
> -	if (!lbr_desc->event && !intel_pmu_create_guest_lbr_event(vcpu))
> +	if (!lbr_desc->event && intel_pmu_create_guest_lbr_event(vcpu))
>   		goto dummy;

Queued, adding a "< 0" to clarify the semantics of the function.

Paolo

