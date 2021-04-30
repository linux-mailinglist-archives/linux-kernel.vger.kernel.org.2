Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72636F677
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhD3HlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhD3HlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619768408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eghNfNwYK/C3iXjA4b8fOp1z7unJQGi+R6RSjtyNSC0=;
        b=ZDvGswANyfvlDMBxKSae8UZV6toM2f3O+Dy2yR0FfDw1rVAnbq09leCHIbyVynDA0IRxF6
        PbTx99185dC61t+x6Koqr/5MQT/pX/K6/MPBbRFOuy59Myf1mcDgHLGjUvejl2LTJ++eFw
        P8IjI3jEv9OOoKnEQSgapKStY10IKaU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-doYU3A1pPOWnUXsv5BilvA-1; Fri, 30 Apr 2021 03:40:06 -0400
X-MC-Unique: doYU3A1pPOWnUXsv5BilvA-1
Received: by mail-ed1-f71.google.com with SMTP id k10-20020a50cb8a0000b0290387e0173bf7so5856911edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eghNfNwYK/C3iXjA4b8fOp1z7unJQGi+R6RSjtyNSC0=;
        b=WM1A4QXu/YRYLv3gGjkzCvrZoCamfQ9hYXXzMeYEr3VZACfr50E/MdpL98lpwu25Km
         WVSD9Fj2Jf0E5Xvz36fReYAtWggZA0q2pZmHGB7MuYJlJpYWL6mIqjavArVIgRUjrBCc
         wBFD/pWEZczHPgZJBwFQnOuxPyKoPsav0bDNQgv/RxyPXA+eDGFcewyG9M0cCopMsvfd
         tvmuc98mLGZbvzZzWpa4mJ/SpzF6pQpgKcPjx7o5ZzfUIJvmP7ZGvKZUYx21iDtNjfjQ
         V91SaMCexDBFcf1wAiQ1vUGbPRxCNN2uVgPf1EFU2DdiB3NoLssEAzWdxhuiBqeKVCWv
         G0Qg==
X-Gm-Message-State: AOAM533tqO/CJ09p7RcCEgb5dA2dgbOTFkXEbC48HPr9VhVyFzws+LbA
        LzrBRkZqvSjTqi/tS4r9KehHEm3KmHvDcHRQdKAHmb1+8daQ/Bvb3b9XBlAyD2kN1+TIiz4nF6N
        rJ8xfgjzxV33Ljaj8/kOpHwTG
X-Received: by 2002:a17:906:6a41:: with SMTP id n1mr2796615ejs.401.1619768405041;
        Fri, 30 Apr 2021 00:40:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCK5v9EG1ShABi3WWrKBuJeUHtTwHg4LMzvkk6H+YB7k0j6X+Mt1rUMaG4kH2ghtCxD3agSA==
X-Received: by 2002:a17:906:6a41:: with SMTP id n1mr2796585ejs.401.1619768404832;
        Fri, 30 Apr 2021 00:40:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z17sm1440309ejc.69.2021.04.30.00.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 00:40:04 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Add guest support for SEV live migration.
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        joro@8bytes.org, bp@suse.de, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, seanjc@google.com,
        venu.busireddy@oracle.com, brijesh.singh@amd.com
References: <cover.1619193043.git.ashish.kalra@amd.com>
 <20210430071927.GA8033@ashkalra_ubuntu_server>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f180f7f0-58c0-8370-1724-070ec89c1a40@redhat.com>
Date:   Fri, 30 Apr 2021 09:40:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210430071927.GA8033@ashkalra_ubuntu_server>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/21 09:19, Ashish Kalra wrote:
> Hello Boris, Paolo,
> 
> Do you have additional comments, feedback on this updated patchset ?

Just a small one that the guest ABI isn't finished yet; some #defines 
are going to change names and there will be two separate CPUIDs, one for 
the hypercall and one for the MSR.  It would be nice to provide correct 
encryption status even if the migration MSR is not there, because it can 
be useful for debugging.

Paolo

> Thanks,
> Ashish
> 
> On Fri, Apr 23, 2021 at 03:57:37PM +0000, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> The series adds guest support for SEV live migration.
>>
>> The patch series introduces a new hypercall. The guest OS can use this
>> hypercall to notify the page encryption status. If the page is encrypted
>> with guest specific-key then we use SEV command during the migration.
>> If page is not encrypted then fallback to default.
>>
>> This section descibes how the SEV live migration feature is negotiated
>> between the host and guest, the host indicates this feature support via
>> KVM_FEATURE_CPUID. The guest firmware (OVMF) detects this feature and
>> sets a UEFI enviroment variable indicating OVMF support for live
>> migration, the guest kernel also detects the host support for this
>> feature via cpuid and in case of an EFI boot verifies if OVMF also
>> supports this feature by getting the UEFI enviroment variable and if it
>> set then enables live migration feature on host by writing to a custom
>> MSR, if not booted under EFI, then it simply enables the feature by
>> again writing to the custom MSR.
>>
>> Changes since v1:
>>   - Avoid having an SEV specific variant of kvm_hypercall3() and instead
>>     invert the default to VMMCALL.
>>
>> Ashish Kalra (3):
>>    KVM: x86: invert KVM_HYPERCALL to default to VMMCALL
>>    EFI: Introduce the new AMD Memory Encryption GUID.
>>    x86/kvm: Add guest support for detecting and enabling SEV Live
>>      Migration feature.
>>
>> Brijesh Singh (1):
>>    mm: x86: Invoke hypercall when page encryption status is changed
>>
>>   arch/x86/include/asm/kvm_para.h       |   2 +-
>>   arch/x86/include/asm/mem_encrypt.h    |   4 +
>>   arch/x86/include/asm/paravirt.h       |   6 ++
>>   arch/x86/include/asm/paravirt_types.h |   2 +
>>   arch/x86/include/asm/set_memory.h     |   2 +
>>   arch/x86/kernel/kvm.c                 | 106 ++++++++++++++++++++++++++
>>   arch/x86/kernel/paravirt.c            |   1 +
>>   arch/x86/mm/mem_encrypt.c             |  72 ++++++++++++++---
>>   arch/x86/mm/pat/set_memory.c          |   7 ++
>>   include/linux/efi.h                   |   1 +
>>   10 files changed, 193 insertions(+), 10 deletions(-)
>>
>> -- 
>> 2.17.1
>>
> 

