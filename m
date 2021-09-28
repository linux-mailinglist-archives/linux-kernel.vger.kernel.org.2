Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857EB41B39C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbhI1QQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241645AbhI1QQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632845696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DUgmLSqFKViIH555qVnPTYAQOfzz0hrtyQXQkZ2GF0M=;
        b=GEVdX1dhoSxo0A5HF6UaUMmgG+DrtXVpVrncJJl4QlFn7td0t1xw5DWrsBmmJBPDid6t6L
        HDZSMiE/ZxIR/MfPGI1Hee9vzTujqu5gYQTX5h0KiAt1p6xhdQ7oZ/O/4YlnC429Ntn4Y2
        q4t4MZFiVEVtorEMnMHCqMHZtOyAYAA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-oazHhE84Mu-Ydz33HQZjlQ-1; Tue, 28 Sep 2021 12:14:53 -0400
X-MC-Unique: oazHhE84Mu-Ydz33HQZjlQ-1
Received: by mail-ed1-f71.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so22349021edy.14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 09:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DUgmLSqFKViIH555qVnPTYAQOfzz0hrtyQXQkZ2GF0M=;
        b=1Af1oe9zSXor0b7MbJ/GNFc38AAHrB9QQ1ZX+EO8lZTrqFVsISFCPOz0KPRXsIhhxW
         EbJNddlXmNWOR510z5vXrrEnmGd6pWzW+NZVzMrYDBQBHmbNJg/ODVm7C/q00sEMCsF/
         xiiHTYDQoF4S/uVBsK3qMMhl9QJOjXA5n/5n+Hqccbhzr5f+1yoVRxbFbGObPzuD9cr4
         +YDS9+A4GYW90Dngr02wyxltbquayRfXxIzoAnkFMhRLueYSbSXIYGC8kxSNAwd89un1
         VtwfumqTXX8TLO3/qjzRYtxxep5/yjFmoErLnvkxDdc3m5mgr+m7dTeuaqchxEgIZTi+
         1NlA==
X-Gm-Message-State: AOAM531oPQqPjkGuzCemC9rW4sow6b0F0RJLdeI3TZhArhV4ypV45SAw
        LHDiIw94A5aCfIV2fNxhA/j8oz5XKxNG4L2TCK9KI7TQh+Z/cFe/MP8yVQJCZ45U9YoY/N8j/Is
        lgQmvbjF4ds8Z3mvzmJgYlGv9
X-Received: by 2002:a17:906:3486:: with SMTP id g6mr7895995ejb.71.1632845691927;
        Tue, 28 Sep 2021 09:14:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFe416aYG6LV8PAGm3jUviHG11Icl9C4GbfgLBpk6rj+OFZRzHIBuulvzceZ1Cy0qQforXRA==
X-Received: by 2002:a17:906:3486:: with SMTP id g6mr7895969ejb.71.1632845691744;
        Tue, 28 Sep 2021 09:14:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e3sm10543342ejr.118.2021.09.28.09.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 09:14:51 -0700 (PDT)
Message-ID: <05425bd8-46dc-f136-fbe0-52f42351aea1@redhat.com>
Date:   Tue, 28 Sep 2021 18:14:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH 1/2] nSVM: introduce struct vmcb_ctrl_area_cached
Content-Language: en-US
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20210917124956.2042052-1-eesposit@redhat.com>
 <20210917124956.2042052-2-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20210917124956.2042052-2-eesposit@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/21 14:49, Emanuele Giuseppe Esposito wrote:
> +static inline bool vmcb_is_intercept_cached(struct vmcb_ctrl_area_cached *control, u32 bit)
> +{
> +	return vmcb_is_intercept((struct vmcb_control_area *) control,
> +				 bit);
> +}
> +

This is quite dangerous, because it expects that the offset is the same 
between vmcb_control_area and vmcb_ctrl_area_cached.  You can just 
duplicate the implementation (which is essentially just a test_bit), and 
call the function

static inline bool vmcb12_is_intercept(struct kvm_vcpu *vcpu, u32 bit)

Likewise, nested_vmcb_check_controls can just take the vcpu since you 
moved nested_load_control_from_vmcb12 earlier.

Finally, copy_vmcb_control_area can be inlined, and its caller 
nested_load_control_from_vmcb12 can stop copying the ASID.  There is 
only one call to it since commit 4995a3685f1b ("KVM: SVM: Use a separate 
vmcb for the nested L2 guest", 2021-03-15).

Thanks,

Paolo

