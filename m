Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C746367F09
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhDVKuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235782AbhDVKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619088574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cepH4DVmZgMHRHW+WV87UBOsh4wAs3M6NCnks6Bbd8Y=;
        b=I98JjUVOdepGVuTw5k2kwn+qPVr3FMwUfKpN7sa/uylvEkb4Qguhh0AcrwEkB25qrKCtqy
        3jhzFWYhqvfAtY7G2OTleD2xYq5R3uErlTMNMuCRzzWNUKDL+DGH3y/z3+SaJ2tUzIL8Kc
        g1lMhrBf4XRZKDLwzhrbOcssTErDNQQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-jaZ4sH9JOFeK5W2IGTTocw-1; Thu, 22 Apr 2021 06:49:32 -0400
X-MC-Unique: jaZ4sH9JOFeK5W2IGTTocw-1
Received: by mail-ed1-f69.google.com with SMTP id h13-20020a05640250cdb02903790a9c55acso16487478edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 03:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cepH4DVmZgMHRHW+WV87UBOsh4wAs3M6NCnks6Bbd8Y=;
        b=o+3sK/xR6Yg9GZs3fvN3EW86LEFmmIHm0vWC1XbYfcr2GAEc3TlaGIE05POYtGvz8f
         SnChWeyP85lYhD9MsDgC2Dr2xj3Fy4vxogL5fXPMF43jOsKSpfZK4MBCWrgVroAACxUG
         W0wNf/c29TZU+UdCS2X7BkcmiHfa2GWGT31wwP7nYIWrTyBFzYv4yx76DychlnK+DORx
         ImFvLWjP0bu7fdZL8Ivxr56g16QrlVB4bRleYxOtP7QgAyQND4zSJKxjrKgqRdTb/8r2
         ZEUWJCRPnWduwKLVbG1lhaveY8KWhDW6eMCS2gDjFNU+bDKZo7l2ltgAMB1YgCylpCJ7
         JtcA==
X-Gm-Message-State: AOAM532MStrtgqTwQ373r+S+UNr6EaSLEYQooDSbUKW1YsFUqKdrBToL
        fXFbb66D/ni59ZVhduIsyrcv442C8dDtYsh3/eI9yat2gtqWooH+GbQEDa0NnCKqfJoH9aG6586
        ByZbhFTJ4d6S3uSpHFJrR5nCv
X-Received: by 2002:aa7:d9ce:: with SMTP id v14mr3085688eds.110.1619088571585;
        Thu, 22 Apr 2021 03:49:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLGo5TNn7MXo/voi472GduRwPJLEiKPNQM3olHulqQpsFAmVYDu4AmUn1ZFcytO2+nkGT0YQ==
X-Received: by 2002:aa7:d9ce:: with SMTP id v14mr3085671eds.110.1619088571445;
        Thu, 22 Apr 2021 03:49:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n13sm1598355ejx.27.2021.04.22.03.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 03:49:31 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2 7/9] KVM: x86/xen: Drop RAX[63:32] when processing
 hypercall
In-Reply-To: <2ddcc979-519c-a38c-065f-a9036cc2b58e@redhat.com>
References: <20210422022128.3464144-1-seanjc@google.com>
 <20210422022128.3464144-8-seanjc@google.com>
 <877dkuhcl7.fsf@vitty.brq.redhat.com>
 <2ddcc979-519c-a38c-065f-a9036cc2b58e@redhat.com>
Date:   Thu, 22 Apr 2021 12:49:30 +0200
Message-ID: <874kfyh9vp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 22/04/21 11:51, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>>> Truncate RAX to 32 bits, i.e. consume EAX, when retrieving the hypecall
>>> index for a Xen hypercall.  Per Xen documentation[*], the index is EAX
>>> when the vCPU is not in 64-bit mode.
>>>
>>> [*] http://xenbits.xenproject.org/docs/sphinx-unstable/guest-guide/x86/hypercall-abi.html
>>>
>>> Fixes: 23200b7a30de ("KVM: x86/xen: intercept xen hypercalls if enabled")
>>> Cc: Joao Martins <joao.m.martins@oracle.com>
>>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>> ---
>>>   arch/x86/kvm/xen.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
>>> index ae17250e1efe..7f27bb65a572 100644
>>> --- a/arch/x86/kvm/xen.c
>>> +++ b/arch/x86/kvm/xen.c
>>> @@ -673,7 +673,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
>>>   	bool longmode;
>>>   	u64 input, params[6];
>>>   
>>> -	input = (u64)kvm_register_read(vcpu, VCPU_REGS_RAX);
>>> +	input = (u64)kvm_register_readl(vcpu, VCPU_REGS_RAX);
>>>   
>>>   	/* Hyper-V hypercalls get bit 31 set in EAX */
>>>   	if ((input & 0x80000000) &&
>> 
>> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> 
>> Alternatively, as a minor optimization, you could've used '!longmode'
>> check below, something like:
>> 
>> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
>> index ae17250e1efe..7df1498d3a41 100644
>> --- a/arch/x86/kvm/xen.c
>> +++ b/arch/x86/kvm/xen.c
>> @@ -682,6 +682,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
>>   
>>          longmode = is_64_bit_mode(vcpu);
>>          if (!longmode) {
>> +               input = (u32)input;
>>                  params[0] = (u32)kvm_rbx_read(vcpu);
>>                  params[1] = (u32)kvm_rcx_read(vcpu);
>>                  params[2] = (u32)kvm_rdx_read(vcpu);
>> 
>
> You haven't seen patch 9 yet. :)
>

True; suggestion dismissed :-)

-- 
Vitaly

