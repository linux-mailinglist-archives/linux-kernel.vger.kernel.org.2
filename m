Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659D43BD95E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 17:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhGFPHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 11:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232118AbhGFPHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 11:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625583904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2uDQFfbEEnoXVD07oyEydX792HJ7X0nk2qGNk3vVko=;
        b=QCyFKiWDfYXMtHO7p+babVcsidcXWwcW7gcJh0fVaYxEDO5QliVvBuw7y2BSz3NXK8awoX
        q+tu7iNfdjr0uUgSkcl2GM1jAarmNkqsyQLo554pCXXpivnjBeE7MulsH0wJaA+BmZw+qN
        CezOT0hzWTWIkRTE5kxtv3/oXtUzDps=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-SewjmqIeO3ODXRS1M5F3wA-1; Tue, 06 Jul 2021 11:05:03 -0400
X-MC-Unique: SewjmqIeO3ODXRS1M5F3wA-1
Received: by mail-ed1-f72.google.com with SMTP id m21-20020a50ef150000b029039c013d5b80so815035eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 08:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q2uDQFfbEEnoXVD07oyEydX792HJ7X0nk2qGNk3vVko=;
        b=SkJ8DWBWlZdi9F4U0pT7/Zzc1OQboRdNobPy+Dzh7l+BGbZIrpRnEEz6u6RgHzB1NW
         A0mcWw4Ne37kjAUVuntQXsBu/aTxzV50jnxwx4srYXXoZwHF6Plb2D43eDKzsPRXQLgo
         XjZ12OIMzBa2wP2qB7pxAOBMQO1GM9TUGT08DjTAq9eeCmNLK5gXWFzUgJ8moQ+JbIIV
         iPOP8k6hM2QBChoDrw26EgTDNv/X59K1lRB/u50lwk+gbzrRvDGDvFW31xK+4nTCkNXM
         HvfWdWSOZSDXzOkfr/pb54Tb5bP+M3f2cVX08UYDrLo4SPKHgca/VoNW1a15jjkNMxJa
         yY9w==
X-Gm-Message-State: AOAM531Qo9z95ncypRzVhGtrOumeCpBhIm8mdyEp4dVzH0R4DqCyCPtW
        XIHOzYMQBr/FcYekZCbOIXjYnmnkpHRbbF5BwlhF5RZzFSM+gvgEFBy3hgyeSHR/gZxJmB40pFi
        bXXsxU9JZ1fZzbRA9qbsM2Yhb
X-Received: by 2002:a50:f0cf:: with SMTP id a15mr23385494edm.347.1625583901923;
        Tue, 06 Jul 2021 08:05:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4JZdaoLVBIs59oV7XxVix+8w+NQtA7nL8i3Dt7I2MXGAg2Ez37F+DmFIWNBHLnqqCa/+jJQ==
X-Received: by 2002:a50:f0cf:: with SMTP id a15mr23385458edm.347.1625583901736;
        Tue, 06 Jul 2021 08:05:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n11sm6026214ejg.43.2021.07.06.08.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 08:05:01 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] Add support for XMM fast hypercalls
To:     Siddharth Chandrasekaran <sidcha@amazon.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Siddharth Chandrasekaran <sidcha.dev@gmail.com>,
        Alexander Graf <graf@amazon.com>,
        Evgeny Iakovlev <eyakovl@amazon.de>,
        Liran Alon <liran@amazon.com>,
        Ioannis Aslanidis <iaslan@amazon.de>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <cover.1622019133.git.sidcha@amazon.de>
 <20210630115559.GA32360@u366d62d47e3651.ant.amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f318fd42-6b98-1a82-f334-d05f4e6cb715@redhat.com>
Date:   Tue, 6 Jul 2021 17:04:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630115559.GA32360@u366d62d47e3651.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/21 13:56, Siddharth Chandrasekaran wrote:
> On Wed, May 26, 2021 at 10:56:07AM +0200, Siddharth Chandrasekaran wrote:
>> Hyper-V supports the use of XMM registers to perform fast hypercalls.
>> This allows guests to take advantage of the improved performance of the
>> fast hypercall interface even though a hypercall may require more than
>> (the current maximum of) two general purpose registers.
>>
>> The XMM fast hypercall interface uses an additional six XMM registers
>> (XMM0 to XMM5) to allow the caller to pass an input parameter block of
>> up to 112 bytes. Hyper-V can also return data back to the guest in the
>> remaining XMM registers that are not used by the current hypercall.
>>
>> Although the Hyper-v TLFS mentions that a guest cannot use this feature
>> unless the hypervisor advertises support for it, some hypercalls which
>> we plan on upstreaming in future uses them anyway. This patchset adds
>> necessary infrastructure for handling input/output via XMM registers and
>> patches kvm_hv_flush_tlb() to use xmm input arguments.
> 
> Hi Paolo,
> 
> Are you expecting more reviews on these patches?

They are part of 5.14 already. :)

Paolo

