Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEFF3A3041
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFJQMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230167AbhFJQMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623341404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y60W77r3fiC34Up6fwAkk1cbDXw7KsqAxkcqb84tN6A=;
        b=XjNbQfARBzB4Y/hYxPg/7QoOFMEGv+xph+D2Q30zH2xjuCmikg5L0cfbTHr8au0LxunsCF
        AegGNFZguQ872z6Do8ZltsIJSUwIjpYZ12e6X3gOEn/cXrkNIA1LksE+uhFFGoY0tnvN05
        eMTWdPcJnzgCO2HaGQy8GjJJJXf2Mzo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-k_zVIakhPUm7xqR_JYGEEw-1; Thu, 10 Jun 2021 12:10:03 -0400
X-MC-Unique: k_zVIakhPUm7xqR_JYGEEw-1
Received: by mail-wm1-f72.google.com with SMTP id y129-20020a1c32870000b029016920cc7087so1398435wmy.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y60W77r3fiC34Up6fwAkk1cbDXw7KsqAxkcqb84tN6A=;
        b=hpSRIjMYx7JWe2sk4siZGrneLEUWOfeCuEvwPF8Lycl7VvfzwW9aBf0BHgU+eSegCy
         2x2vwZgHOpjgFgNRoZA1eFf+NkFZlUytxuDHG+5XkTMQfLSULB/iVme6+OPUjPF6mQ/z
         eGfAEetkh3P/5yg6pBzMiXVxsmkJ+QuNNDqilSCtH4NEcGDZ+4aSJxI6Zb7YDrvUqq5/
         vZQgVvB2Rw2oEvrIuCz0LJ7W89xXEUFhCN1v6pDOUMAaa1Kn1K8eAwW8aTOQmRALRUD/
         Fi7LDtHuX7T8j9FTsJK1+b3GY3I0hoVp7oB8iWUAE80eWsUdWGZ7OnIi90jSYDi8/yn1
         EaWA==
X-Gm-Message-State: AOAM531Q4RNutQxEA5Ux1XxQLaAEPZ8lifQsf2QTO2f6h5IKZLqJz8jm
        BTELzgtiYg/n5MBlzoHXBfJ2+/z3DPCkWWGqIBL2lKKYbPjw59ThKMvwFw8XDAui9xedLv0aQqz
        1ZLmXJwsDe11SX6+PdndsWx9v
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr6442202wrt.124.1623341401779;
        Thu, 10 Jun 2021 09:10:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyV3SOGWnR1CI02DpB/yQxIQ2+Z055E0u1sTY3HxnwdkvRVGh+9dOtJz43t3TFozWRi7cCZ+Q==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr6442174wrt.124.1623341401505;
        Thu, 10 Jun 2021 09:10:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id l31sm3420068wms.31.2021.06.10.09.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 09:10:01 -0700 (PDT)
Subject: Re: [PATCH 15/15] KVM: nVMX: Drop redundant checks on vmcs12 in EPTP
 switching emulation
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
References: <20210609234235.1244004-1-seanjc@google.com>
 <20210609234235.1244004-16-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec192ad8-9ad7-d40a-02e6-07a0dec12607@redhat.com>
Date:   Thu, 10 Jun 2021 18:09:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609234235.1244004-16-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/21 01:42, Sean Christopherson wrote:
> Drop the explicit checks on EPTP switching and EPT itself being enabled.
> The EPTP switching check is handled in the generic VMFUNC function check,
> the underlying VMFUNC enablement check is done by hardware and redone
> by generic VMFUNC emulation, and the vmcs12 EPT check is handled by KVM
> at VM-Enter in the form of a consistency check.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/vmx/nested.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 0075d3f0f8fa..479ec9378609 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5448,10 +5448,6 @@ static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
>   	u32 index = kvm_rcx_read(vcpu);
>   	u64 new_eptp;
>   
> -	if (!nested_cpu_has_eptp_switching(vmcs12) ||
> -	    !nested_cpu_has_ept(vmcs12))
> -		return 1;
> -

Perhaps the EPT enabled check is worth keeping with a WARN_ON_ONCE?

Paolo

>   	if (index >= VMFUNC_EPTP_ENTRIES)
>   		return 1;
>   
> 

