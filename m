Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEB234CD2F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhC2JkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231776AbhC2Jj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617010797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XH1p60GLm1qMEaeWBYCic3Rl4rfDvGvY/I2BlpVV/RY=;
        b=gGZ8iOoaQFBq8fDw2J88AJqJST0eHpelW8M+IBIpNDB7yMjBu3qejyvsTN4JxTav9AlhWr
        Za2CggjNtvbJitXMq361DbbhGWSc0Bl9dsrK0M74BMOX62t0mvUdQYl7ARxoYOKdGjiVgC
        uuaxv+RaNQPUjf2CH5QHxuUiPtc22S0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-0vRSVgHBNt-fE3fddC-5_A-1; Mon, 29 Mar 2021 05:39:56 -0400
X-MC-Unique: 0vRSVgHBNt-fE3fddC-5_A-1
Received: by mail-wm1-f69.google.com with SMTP id n17so1412814wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 02:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XH1p60GLm1qMEaeWBYCic3Rl4rfDvGvY/I2BlpVV/RY=;
        b=sdiCeXBocWBy7Xv16G7CszCB280pURg6zcu6PKx3XZ8aB61fyFGtyA15R23+EH+WKJ
         7wWHRXs17TU5/qH8BDWUCE/GKoMoha7uwlnNe4Yhi/QH7zbwLEbI2syGOIBOxRp8C8iP
         KVNF5zZP9JNkqfL4Hgwz9Xz++qIq/LH8+d0VuLmjGiOyCRX5VETbmIjTSxKnaM1Q0PBR
         xuTiBjRv6DtkY83gw5q4Hb+z3agfbsDqhK/xXqxgo2Sh7kVCIDftTH5w/oHnPbEtV1lx
         /kKCRFKhwneAynyvD48ayI4rSsYwQquYMiLGrURpk6ySczUyOUuYcV/8ZoGW9sVkJG7x
         WHBw==
X-Gm-Message-State: AOAM530HT0a3m/PCXAt2Oyfho/J8piSF6vPNDN5R5GlLIodV2x+/CcMM
        QrEHpgkJyLzdtwaRjWYD7hH8ONueeg21NeiyRwMqWvg8vk0z+QAtmTJzLIjNCPxEPNLUNeL2kNl
        TybTPjovb+fauBDXX7QKIcdDFcm9K3l7T3ls9eNu9K+YI3uqiNzIhUEs6tFdM6NKaHMas9MYUOP
        S8
X-Received: by 2002:a05:600c:203:: with SMTP id 3mr23780401wmi.88.1617010794712;
        Mon, 29 Mar 2021 02:39:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdSnNJS7HC+pi2XoA8apSkQkFQkiLJqju8IpJxHu6Mftlx0OI7Nd1JagHG7r7oN3w6uh/2pw==
X-Received: by 2002:a05:600c:203:: with SMTP id 3mr23780386wmi.88.1617010794459;
        Mon, 29 Mar 2021 02:39:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id j13sm28646969wrt.29.2021.03.29.02.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 02:39:53 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/vPMU: Forbid writing to MSR_F15H_PERF MSRs when
 guest doesn't have X86_FEATURE_PERFCTR_CORE
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Wei Huang <wei.huang2@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org
References: <20210323084515.1346540-1-vkuznets@redhat.com>
 <a40090f1-23a1-fca0-3105-b5e48ee5c86e@redhat.com>
 <874kgubau4.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7310ec0-4c4c-0d1c-5725-5377b539344a@redhat.com>
Date:   Mon, 29 Mar 2021 11:39:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <874kgubau4.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/21 10:52, Vitaly Kuznetsov wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 23/03/21 09:45, Vitaly Kuznetsov wrote:
>>> MSR_F15H_PERF_CTL0-5, MSR_F15H_PERF_CTR0-5 MSRs are only available when
>>> X86_FEATURE_PERFCTR_CORE CPUID bit was exposed to the guest. KVM, however,
>>> allows these MSRs unconditionally because kvm_pmu_is_valid_msr() ->
>>> amd_msr_idx_to_pmc() check always passes and because kvm_pmu_set_msr() ->
>>> amd_pmu_set_msr() doesn't fail.
>>>
>>> In case of a counter (CTRn), no big harm is done as we only increase
>>> internal PMC's value but in case of an eventsel (CTLn), we go deep into
>>> perf internals with a non-existing counter.
>>>
>>> Note, kvm_get_msr_common() just returns '0' when these MSRs don't exist
>>> and this also seems to contradict architectural behavior which is #GP
>>> (I did check one old Opteron host) but changing this status quo is a bit
>>> scarier.
>>
>> Hmm, since these do have a cpuid bit it may not be that scary.
> 
> Well, if you're not scared I can send a patch)

Go ahead.

Paolo

