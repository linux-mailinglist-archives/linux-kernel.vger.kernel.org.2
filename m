Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283DC36902A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbhDWKPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241898AbhDWKPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619172908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zU8xSHS0eLUV311ziEBewDcU/XJ05AOBQVWlp6b2OZI=;
        b=hayLeO+e7zNk0TeNBC482wcjdHRU3ihciBASZzDM5gQYewwKU301diW9dvyUuA+aQ23sFj
        xafp3FpJr+BAz1iueldYjJJEOtXjkTjM1eim1JgCGKvzb57wKW+Ro7DvF1NnzCw1H/b/0F
        L8txBcxNS1vJ4PZ2cLmMCsM+eqHSdto=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-zQXPCaAGPCCcndmlzyCZ9Q-1; Fri, 23 Apr 2021 06:15:06 -0400
X-MC-Unique: zQXPCaAGPCCcndmlzyCZ9Q-1
Received: by mail-ed1-f72.google.com with SMTP id y10-20020a50f1ca0000b0290382d654f75eso18343067edl.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 03:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zU8xSHS0eLUV311ziEBewDcU/XJ05AOBQVWlp6b2OZI=;
        b=JggpHQjgsG6iLoRzKDfmW0n2qsW/8boOoZEDEV8Awk5C4xryns2yMULYkkjYtXVXbb
         S4RNFmsw35JJs8o4+CLVlcclpYeJ1Y+eO9VyZk5tkf9E/BX5eqBKnDT/4dYZIYmKLOK1
         c7ifyuEHFegBMu7kU64tZD9uQHLoJuGUP8Fxlo70L1MOh4p7BzmLG/9FmJuIiElClGXy
         XZVsakCw3l25HpFnIM0ksyqF/26qbqzzp2thMQEz6MDHMwGBi3YTs3fghvXjmCUa/ZrE
         KWfhzarQky+ZR/kR+H0xuD5avQu3Kg9xZZGVWxi4Ww2ox53ENguA7N5/5vcCELsrAL18
         TbHg==
X-Gm-Message-State: AOAM5304j9SIzxOu5FrKukkkWRs6p8J058xqIcE06juMDShKiUgT+vfd
        /g8YhX2RuFU/445CCfY4Sk/95G0Spu8K/qLZhNfR0CoarF3GZOxaUJe0dwlAAkoZeI+qUswvtI7
        qlMBcwlJFo2yaWkbNBrPC/UewzWZkW9npg6yiODHFkDRij6v4Gk5cG1xA76WqVdb42sMA3fhzr5
        E1
X-Received: by 2002:a17:906:1c83:: with SMTP id g3mr3431453ejh.93.1619172904539;
        Fri, 23 Apr 2021 03:15:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz32hxW6BwlqELQ71xlnrs8HZakqBtXQL7FatSt+SW5KA+zaUvrU624umIv9PYL0XNS2iW2rA==
X-Received: by 2002:a17:906:1c83:: with SMTP id g3mr3431406ejh.93.1619172904194;
        Fri, 23 Apr 2021 03:15:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p13sm3685996ejr.87.2021.04.23.03.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 03:15:03 -0700 (PDT)
To:     Alexander Graf <graf@amazon.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Evgeny Iakovlev <eyakovl@amazon.de>, Liran Alon <liran@amazon.com>,
        Ioannis Aslanidis <iaslan@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210423090333.21910-1-sidcha@amazon.de>
 <224d266e-aea3-3b4b-ec25-7bb120c4d98a@amazon.com>
 <213887af-78b8-03ad-b3f9-c2194cb27b13@redhat.com>
 <ded8db53-0e58-654a-fff2-de536bcbc961@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: hyper-v: Add new exit reason HYPERV_OVERLAY
Message-ID: <45888d26-89d2-dba6-41cb-de2d58cd5345@redhat.com>
Date:   Fri, 23 Apr 2021 12:15:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <ded8db53-0e58-654a-fff2-de536bcbc961@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/21 11:58, Alexander Graf wrote:
>> In theory userspace doesn't know how KVM wishes to implement the
>> hypercall page, especially if Xen hypercalls are enabled as well.
> 
> I'm not sure I agree with that sentiment :). User space is the one that 
> sets the xen compat mode. All we need to do is declare the ORing as part 
> of the KVM ABI. Which we effectively are doing already, because it's 
> part of the ABI to the guest, no?

Good point.  But it may change in the future based on KVM_ENABLE_CAP or 
whatever, and duplicating code between userspace and kernel is ugly.  We 
already have too many unwritten conventions around CPUID, MSRs, get/set 
state ioctls, etc.

That said, this definitely tilts the balance against adding an ioctl to 
write the hypercall page contents.  Userspace can either use the 
KVM_SET_MSR or assemble it on its own, and one of the two should be okay.

Paolo

>>
>> But userspace has two plausible ways to get the page contents:
>>
>> 1) add a ioctl to write the hypercall page contents to an arbitrary
>> userspace address
>>
>> 2) after userspace updates the memslots to add the overlay page at the
>> right place, use KVM_SET_MSR from userspace (which won't be filtered
>> because it's host initiated)
>>
>> The second has the advantage of not needing any new code at all, but
>> it's a bit more ugly.
> 
> The more of all of that hyper-v code we can have live in user space, the 
> happier I am :).

