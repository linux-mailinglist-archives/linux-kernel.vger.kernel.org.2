Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F045D372684
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhEDHYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56780 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhEDHYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620112990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDZzFVHUz6nuJ5xJd1dslJwLGgGS3xgzc5l8z25vt0g=;
        b=Ov5nArOJbJw6g/lF0VWx7VXtdEuR136/KOdFDWlCe+hHgXsh33gJM23PO20h/EjWYTHLxc
        P1XNaUODbiLhf00kMDpXsGrnP1tSJkagL7ZHw4K6LhAQjcgxNhuHJwTpaWicsd0fD7ixZc
        lSv01EXj2Niz9GmTONFQMaMuK3ip924=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-_F2OVJl7O7iilq6XzBlEGA-1; Tue, 04 May 2021 03:23:08 -0400
X-MC-Unique: _F2OVJl7O7iilq6XzBlEGA-1
Received: by mail-ed1-f69.google.com with SMTP id k10-20020a50cb8a0000b0290387e0173bf7so6034620edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 00:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vDZzFVHUz6nuJ5xJd1dslJwLGgGS3xgzc5l8z25vt0g=;
        b=kG4q1P1L2KXts5dcvgP5c9Vf1K/hPy0hEodKxAi1TDORXaVEJAZUXzZxNX4oBijl0e
         YaP3SwUTaMjpsKzDZFmLEmH6Weh7ImKwPjVitqQ7e8TeSnRjJuUiPay3T9kDMuj1+Iti
         Ic4STvnN4rQAHw53AlJBTBSRfNjQqFztd66vsf35UAmVp+qRTA+aL0Ppb5qrieJVM+yI
         sS4WysTUJni0Yr+0Tkn9TpLaTKfj1sa/dGVeC1Yd0AY21uPW/cCiKl36ujOsV53DCG8t
         Ue4mox8LANqJ759sf3jiw8whIVzOfXA4I7vxBUQRgm3/TBYo12njIpuWGeQOlrBLYDTZ
         rxDQ==
X-Gm-Message-State: AOAM531xc/Xwn4J90aGuwf4KqniNJQbRAouwf45ug5R9uTaPl94qBl39
        rQlxzAiGQyhMSJJ1pZiM4hwrZKzaN+KbY35i8MRFQ/FNSgqhTfyObt3p1Pdzcb+N91yct9Oi/P5
        bFN2CVLfFwQ4dYQ2JDG3XOYVM
X-Received: by 2002:a17:906:1284:: with SMTP id k4mr19971114ejb.409.1620112987709;
        Tue, 04 May 2021 00:23:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH+i8bygB46cYQo1fTbkLpUNZoJa+LXWC2Ieg7+dXmg88oJQA7q0vx3511SV/4Uuatr98sDg==
X-Received: by 2002:a17:906:1284:: with SMTP id k4mr19971092ejb.409.1620112987470;
        Tue, 04 May 2021 00:23:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h15sm915197ejs.72.2021.05.04.00.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 00:23:06 -0700 (PDT)
Subject: Re: [PATCH v4] KVM: x86: Fix KVM_GET_CPUID2 ioctl to return cpuid
 entries count
To:     "Denis V. Lunev" <den@openvz.org>,
        Sean Christopherson <seanjc@google.com>,
        Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20210428172729.3551-1-valeriy.vdovin@virtuozzo.com>
 <YIoFFl72VSeuhCRt@google.com>
 <0d68dbc3-8462-7763-fbad-f3b895fcf6e6@redhat.com>
 <be7eedf7-03a2-f998-079d-b18101b8b187@openvz.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63e54361-0018-ad3b-fb2b-e5dba6a0f221@redhat.com>
Date:   Tue, 4 May 2021 09:23:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <be7eedf7-03a2-f998-079d-b18101b8b187@openvz.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/21 21:18, Denis V. Lunev wrote:
> On 5/3/21 5:54 PM, Paolo Bonzini wrote:
>> On 29/04/21 03:00, Sean Christopherson wrote:
>>> On Wed, Apr 28, 2021, Valeriy Vdovin wrote:
>>>> It's very explicit by the code that it was designed to receive some
>>>> small number of entries to return E2BIG along with the corrected
>>>> number.
>>>
>>> LOL, saying KVM_GET_CPUID2 was "designed" is definitely giving the KVM
>>> forefathers the benefit of the doubt.
>>
>> I was going to make a different joke, i.e. that KVM_GET_CPUID2 was
>> indeed designed the way Valeriy described, but that design was
>> forgotten soon after.
>>
>> Really, this ioctl has been such a trainwreck that I think the only
>> good solution here is to drop it.
>>
>> Paolo
>>
> 
> should we discuss KVM_GET_CPUID3 which will work "normally"?

Is anybody using KVM_GET_CPUID2 at all?

Paolo

