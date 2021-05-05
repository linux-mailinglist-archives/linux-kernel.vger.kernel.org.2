Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3853735F6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 10:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhEEIC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 04:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231869AbhEEICz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 04:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620201719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5qx/tux63yhpA+wbBJMEnO707eoeKsE9vMXUK3A6WA=;
        b=TOGOFCVNiCoBEpkUbxX0HrvCsR4bBlEV/swFG429TqgghKFyjSbdsfWKUcE8di3fmEflpp
        iCW7X1slxWQ7VncHhMwawGSQ+F6UoEe5j8ZkZiVsPBqXqLjaPjtnQh5JyhazuvTULxXDyK
        mXoDR4Fp5w4fMuxgZDsQBUoZqX/GEek=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-L8kQ96UqPOGJmYRVzMoI6A-1; Wed, 05 May 2021 04:01:57 -0400
X-MC-Unique: L8kQ96UqPOGJmYRVzMoI6A-1
Received: by mail-ed1-f70.google.com with SMTP id c15-20020a056402100fb029038518e5afc5so451831edu.18
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 01:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o5qx/tux63yhpA+wbBJMEnO707eoeKsE9vMXUK3A6WA=;
        b=OwREXfDwZh9UJx4W3WfVYRqAy8MhgkJ17Fqhh3za9t1cw28DTpEstioFqIkNemUEgW
         hincBsF3Tf7gKHEnSMrGjQVXssricFFqv5BDOWewiH1IJcPerpighlfVd4cjDy8Z+g50
         b+fpWNp+i2j3CaCy/AhojDo6ufFx9rq1A9IfGv/FzuIUhaXYhqWtM+kpJrROrBiVMGC7
         66NgBq/9dmuO2DlkadKjOFGawwUcgtLBWFVN/Ju/9NQOXA6RTq2LslIhDi6OoU3L9Lix
         /fD1+W7Vm2c/zp4sKfXEN1G/iHhM/aqH6xgVwLkWHQXh6rnfTLYM2ZtuwTyWEFfekeR3
         1lAQ==
X-Gm-Message-State: AOAM533s+nc+QscOrTZc4HEoXX0xkRz5/a508L/d3cLUpz9MACmF+vyd
        /EQZyqaj40qUDqQBTkF4pHwN8HKRVNf+uOVcYyNvALRR8vL7da5wKawPOX8KimCR9KQ0jq4IgX/
        pPRV/D5pCE0TD/1Ta+4cQuyCJ
X-Received: by 2002:a17:906:2511:: with SMTP id i17mr24291678ejb.198.1620201716645;
        Wed, 05 May 2021 01:01:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrVxfYIB3jt2bZhK7Mv1cXV5hHwNeR5Y3b/l7UvZaWKRYVvayeN0ZRhl4nPFFZLSpfIxrCcQ==
X-Received: by 2002:a17:906:2511:: with SMTP id i17mr24291658ejb.198.1620201716443;
        Wed, 05 May 2021 01:01:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id p4sm2499967ejr.81.2021.05.05.01.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 01:01:55 -0700 (PDT)
Subject: Re: [PATCH 02/15] KVM: x86: Emulate RDPID only if RDTSCP is supported
To:     Reiji Watanabe <reijiw@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20210504171734.1434054-1-seanjc@google.com>
 <20210504171734.1434054-3-seanjc@google.com>
 <CAAeT=FycnR2BonmiHSWobsLCGTuQuTS3kg9x_eYCKLRQGOvYzQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92131802-68b7-3d27-3e61-9b388bfcbc7f@redhat.com>
Date:   Wed, 5 May 2021 10:01:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAAeT=FycnR2BonmiHSWobsLCGTuQuTS3kg9x_eYCKLRQGOvYzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/21 05:51, Reiji Watanabe wrote:
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -637,7 +637,8 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>>          case 7:
>>                  entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
>>                  entry->eax = 0;
>> -               entry->ecx = F(RDPID);
>> +               if (kvm_cpu_cap_has(X86_FEATURE_RDTSCP))
>> +                       entry->ecx = F(RDPID);
>>                  ++array->nent;
>>          default:
>>                  break;
> I'm wondering if entry->ecx should be set to F(RDPID) here
> even if the CPU supports RDPID natively.
> (i.e. kvm_cpu_cap_has(X86_FEATURE_RDPID) is true)
> 
> The document "Documentation/virt/kvm/api.rst" says:
> ---
> 4.88 KVM_GET_EMULATED_CPUID
> ---------------------------
> <...>
> Userspace can use the information returned by this ioctl to query
> which features are emulated by kvm instead of being present natively.
> ---

Setting it always is consistent with the treatment of MOVBE above. 
Either way is okay but it should be done for both bits.

Paolo

