Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2192737522B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhEFKUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234110AbhEFKUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620296394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4AlmcxHNK6jvbhK2/zhBDdPr/gsgwHyIrd/Q6pHQ5E=;
        b=XDsPx4L64PsS8cOSdIKokxGUSJ5XsLS9vXRTIegCTXQjoFATlYUweEtZwWp/ZFUxkD+t+k
        Tx1MK1j+oBVMrHJMeY8pi3M8cAZM48nKyaLSdjGH/SWZS6ne+V5dAtyu4NMsCgrdWK9dy7
        Sohw525GL3NwHecqpmto/imjpXcpaNw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300--lgM1z95MmW6aldHKc7-hg-1; Thu, 06 May 2021 06:19:53 -0400
X-MC-Unique: -lgM1z95MmW6aldHKc7-hg-1
Received: by mail-wr1-f72.google.com with SMTP id l2-20020adf9f020000b029010d6bb7f1cbso1994904wrf.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 03:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/4AlmcxHNK6jvbhK2/zhBDdPr/gsgwHyIrd/Q6pHQ5E=;
        b=FfKwNOa9KtIVnIjxyzbvAatL/LUodv98xTO95W0qFXcDYQ3kAyxqzGG5aOwIMUWwLj
         aNlHRQjAZGor9AKxAzahc1RAEvAi0zcS5ikCOUNSysmBzyYbCpnfYv+j2VKYWMNRotrY
         3AFcAIegQEgufIDkUAR1jQsP9rOdg8Qzgz7WSeyddyjaIEvBP6mBsJ7ZkBKlC6/LnFtz
         1y60aifJX8q2qDiWt3O7Kd1oI+A/TrBwH61Skn2kVlOhb5fQFV3LaR7ddwOmM4BasXv0
         +QiFZO4UCgmRjw7oixHgpZRlC3foqayhKgx+01s7eL8DVorzJh0ZLKbCK+o7ApKJ/NOG
         lgvg==
X-Gm-Message-State: AOAM531gDP3w/G1Vakz20jXbkIH4QFDo6z/OAU5Cf8NQrCYPvkCRbLl7
        v48F/TnN9x+/olUvf8+cKZNYx2ZBKObPNLtCkGiqG8fCSXqqo/SSuqnW5YHQQ2IOZfE87aHoZEK
        RDZNOn0zhzTPGaNT6lqczTCiAh0EkUgFWTo+9dAMRf88ywDX0WbyHhpR2h79lknxZWgsxQPRds3
        Qf
X-Received: by 2002:a7b:c8ca:: with SMTP id f10mr3240039wml.118.1620296391829;
        Thu, 06 May 2021 03:19:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2RzhaNbA2WpOR6chOGiG4O6PtUzpc3NV+HioaR04QGKhmGmhPqls4+o0IVxWuBoWJ0ynqfg==
X-Received: by 2002:a7b:c8ca:: with SMTP id f10mr3240015wml.118.1620296391552;
        Thu, 06 May 2021 03:19:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d9sm3463587wrp.47.2021.05.06.03.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 03:19:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] KVM: X86: Rename DR6_INIT to DR6_ACTIVE_LOW
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210202090433.13441-1-chenyi.qiang@intel.com>
 <20210202090433.13441-2-chenyi.qiang@intel.com>
 <3db069ba-b4e0-1288-ec79-66ac44938682@redhat.com>
 <6678520f-e69e-6116-88c9-e9d6cd450934@intel.com>
 <ea9eaa84-999b-82cb-ef40-66fde361704d@redhat.com>
 <dc22f0a2-97c5-d54d-a521-c02f802c2229@intel.com>
 <3d7455a7-dca7-3c60-0c34-3a3ab8f7f1fb@redhat.com>
 <f8d6f502-e870-b374-afc4-62fd49dd5571@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f64eb246-e3a8-a22d-cf34-10f10b55d8b4@redhat.com>
Date:   Thu, 6 May 2021 12:19:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f8d6f502-e870-b374-afc4-62fd49dd5571@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/21 10:21, Chenyi Qiang wrote:
> 
> 
> On 4/2/2021 5:01 PM, Paolo Bonzini wrote:
>> On 02/04/21 10:53, Xiaoyao Li wrote:
>>>>
>>>
>>> Hi Paolo,
>>>
>>> Fenghua's bare metal support is in tip tree now.
>>> https://lore.kernel.org/lkml/20210322135325.682257-1-fenghua.yu@intel.com/ 
>>>
>>>
>>> Will the rest KVM patches get into 5.13 together?
>>
>> Yes, they will.
>>
>> Thanks for the notice!
>>
> 
> Hi Paolo,
> 
> I notice the patch 1 is merged but the remaining patch 2 and 3 are not 
> included yet. The bare metal support is merged. Will the rest KVM parts 
> be in 5.13 as well?

Yes.

Paolo

