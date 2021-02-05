Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3093108D4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhBEKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:17:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230161AbhBEKMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612519849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uwWH69RD/U8R/Yz9V56rEzUfEXvsQXclaTN8AOW6CJQ=;
        b=L1jUfeoXXSbKX+7ZVLvHo0T/JHX7COrHLFQAUhqWVX27xsx8XmVCrp5Q6uCJE2L6MWm3oN
        s4WjDg8SDZb/FcHvU8BsaTZgLcPcx+LNXa9/AhceD5IbLL4Gz9bDsCZkgMUpzdm8dDGsSc
        PFJvwjUfOx1SCb+XtQUremTTaKgyfC8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-N7RITQUGP0qzf7f0UfNzvQ-1; Fri, 05 Feb 2021 05:10:47 -0500
X-MC-Unique: N7RITQUGP0qzf7f0UfNzvQ-1
Received: by mail-wr1-f72.google.com with SMTP id u3so5028169wri.19
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uwWH69RD/U8R/Yz9V56rEzUfEXvsQXclaTN8AOW6CJQ=;
        b=Sp3EMcDZEELH1dIyVIm9BxMb7st6uo9UwHsFYEuECfru0HEqvE3IqDW4628Jogz+iA
         NGb2CQQsvuxgSqpkT+Tw26SDOYHjVS/E8uB4i9XFDgl61U1GnI3x4Kv3wmN1IJlFwrfR
         YuUPpnsCHQLan6EgXnaW70WjAKFxDvSV/bbTWrFM6TDjIRrOdNgjpUkQOQXGUSl4A5Q6
         ADM+M6jz9m2eipq9gc8ceh8iFscLDH6OkTb1wYP3ZWpIU5jjQMKkOH1rgPypwB6y8fkN
         5IYxkIF1THga3o5I3YNmUmP3t9/5EfZmFYHBHxcvRef0e92diIDZrUrR87GbSantsFIs
         hhzg==
X-Gm-Message-State: AOAM532vN+NlVgrWvQ3NikK83NALkIEbQKDeqQPacs+BCWXxZt15veMp
        X39pGOtWQLtyq3QvXBqeVHfGxq5aLhiP5SCZaQcMnbusUkvI/AaPYr9k/CzcA7zCss5oOTbR960
        uQ5p8QZZyh3R0z4KaohzcbZTl
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr4033438wrp.127.1612519845816;
        Fri, 05 Feb 2021 02:10:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxx47BL9I/3ugpty5hVt2p3Lu1LcqvAbsB3zBvejcpJSyGhSuJeFM9oXaqJJ5kZd9xpcKW0WA==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr4033412wrp.127.1612519845639;
        Fri, 05 Feb 2021 02:10:45 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l10sm11574979wro.4.2021.02.05.02.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 02:10:44 -0800 (PST)
Subject: Re: [PATCH v4 2/5] KVM: X86: Expose PKS to guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
References: <20210205083706.14146-1-chenyi.qiang@intel.com>
 <20210205083706.14146-3-chenyi.qiang@intel.com>
 <8768ad06-e051-250d-93ec-fa4d684bc7b0@redhat.com>
 <20210205095603.GB17488@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e90dadf9-a4ad-96f2-01fd-9f57b284fa3f@redhat.com>
Date:   Fri, 5 Feb 2021 11:10:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210205095603.GB17488@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 10:56, Borislav Petkov wrote:
> On Fri, Feb 05, 2021 at 10:25:48AM +0100, Paolo Bonzini wrote:
>> On 05/02/21 09:37, Chenyi Qiang wrote:
>>>
>>> diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
>>> index 57718716cc70..8027f854c600 100644
>>> --- a/arch/x86/mm/pkeys.c
>>> +++ b/arch/x86/mm/pkeys.c
>>> @@ -390,3 +390,9 @@ void pks_key_free(int pkey)
>>>   	__clear_bit(pkey, &pks_key_allocation_map);
>>>   }
>>>   EXPORT_SYMBOL_GPL(pks_key_free);
>>> +
>>> +u32 get_current_pkrs(void)
>>> +{
>>> +	return this_cpu_read(pkrs_cache);
>>> +}
>>> +EXPORT_SYMBOL_GPL(get_current_pkrs);
>>> diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
>>> index bed0e293f13b..480429020f4c 100644
>>> --- a/include/linux/pkeys.h
>>> +++ b/include/linux/pkeys.h
>>> @@ -72,6 +72,10 @@ static inline void pks_mk_readwrite(int pkey)
>>>   {
>>>   	pr_err("%s is not valid without PKS support\n", __func__);
>>>   }
>>> +static inline u32 get_current_pkrs(void)
>>> +{
>>> +	return 0;
>>> +}
>>>   #endif /* ! CONFIG_ARCH_HAS_SUPERVISOR_PKEYS */
>>
>> This would need an ack from the x86 people.  Andy, Boris?
> 
> This looks like the PKS baremetal pile needs to be upstream first.

Yes, it does.  I would like to have an ack for including the above two 
hunks once PKS is upstream.

I also have CET and bus lock #DB queued and waiting for the bare metal 
functionality, however they do not touch anything outside arch/x86/kvm.

Paolo

