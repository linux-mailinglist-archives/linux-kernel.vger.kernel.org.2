Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B913055FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhA0IlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:41:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41740 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231372AbhA0Iip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611736638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YoZlnoEYyqXHK2UNxG6Hxb0iClxpQuZEDSZD0zTeyUM=;
        b=igggR558ikLikx91F2UUm0+XLmOH96Q1D0xeh1C/k0sjyVxekxuvFSPwxirF1uWqsQvZGy
        7osK1v6Z+fpDW4efNTyWxxUdWldePuxtgLYmtFXDm5/DgdFxajy7Yk4/8gUC0MVyrIU76f
        CEu2uMMx1oXFyVOqd9qOtlnCvckrK2E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-qGOcFkjPNMudFeX4wH11ag-1; Wed, 27 Jan 2021 03:37:17 -0500
X-MC-Unique: qGOcFkjPNMudFeX4wH11ag-1
Received: by mail-ed1-f72.google.com with SMTP id o19so951321edq.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 00:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YoZlnoEYyqXHK2UNxG6Hxb0iClxpQuZEDSZD0zTeyUM=;
        b=Yqz8vemgTD8riFnrEfllQRnFWFPNqrJv+zf8b7c6NxU3yIeEK9opYJNYYICIEdGDkz
         c2UOhlfJ133n6rm2cqO0rWUYnPtIAFwAEwloTTkkKmxypKq1jWbcBGimGYtagDWM4YfM
         zRfcPJoBoWS3uJFonXRBSDyGCqVL6bIhA5fd11Qngqm6yWlvAAFMokf3Qgnw096WbUAq
         O4FipMvZ6IBsOv8nVyKszw1z0ln6zLKuxrIlFDQb4Wn4+AOLpVimtGK4ghd85+gk7ZuI
         8U1jZ78s24o9DkZqrILegNcufzloWv4Pun95irJbENG/nOHSXYOC7pY5VpRQmmgT4v8n
         B66w==
X-Gm-Message-State: AOAM532Ed783Dt5QkqzBS7oCwUVdDAi04bgztyg7eSAMTCmIzOp9qBc8
        axVv2EAG4X6+BLEiSR1EpmJFlf4VobDVf80yCJVIjhy+RMx+42bjMLDUSoJXXg+ls/nadZWw5xF
        hgvFaDDf8Otlu+1ENYzajSxqllwP8DFRFYR+McZI81WkqZ2bNfRsDi5I7yQw8820o6zQySlO8uC
        We
X-Received: by 2002:a17:907:10c8:: with SMTP id rv8mr5836460ejb.228.1611736635713;
        Wed, 27 Jan 2021 00:37:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEpetEgKASA0sCp5ApSW1+cFX0Bg1eFc09GcIVbnptLm3H8bQmkj78QGXL2t3AsQUDOaezHA==
X-Received: by 2002:a17:907:10c8:: with SMTP id rv8mr5836441ejb.228.1611736635488;
        Wed, 27 Jan 2021 00:37:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id gt12sm478496ejb.38.2021.01.27.00.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:37:14 -0800 (PST)
Subject: Re: [RFC 5/7] KVM: MMU: Add support for PKS emulation
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200807084841.7112-1-chenyi.qiang@intel.com>
 <20200807084841.7112-6-chenyi.qiang@intel.com>
 <0689bda9-e91a-2b06-3dd6-f78572879296@redhat.com>
 <3e38051e-b341-66b9-5e2e-2c3f26d3ff70@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed72302d-2644-75d4-f219-7855cf0430df@redhat.com>
Date:   Wed, 27 Jan 2021 09:37:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <3e38051e-b341-66b9-5e2e-2c3f26d3ff70@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/21 04:00, Chenyi Qiang wrote:
>>
>>>
>>>          if (pte_access & PT_USER_MASK)
>>>              pkr_bits = (vcpu->arch.pkru >> (pte_pkey * 2)) & 3;
>>> +        else if (!kvm_get_msr(vcpu, MSR_IA32_PKRS, &pkrs))
>>> +            pkr_bits = (pkrs >> (pte_pkey * 2)) & 3;
>>
>> You should be able to always use vcpu->arch.pkrs here.  So
>>
>> pkr = pte_access & PT_USER_MASK ? vcpu->arch.pkru : vcpu->arch.pkrs;
>> pkr_bits = (pkr >> pte_pkey * 2) & 3;
>>
> Concerning vcpu->arch.pkrs would be the only use case in current 
> submitted patches, is it still necessary to shadow it?

Yes, please do.  kvm_get_msr is pretty slow, and the code becomes 
simpler too.

Paolo

