Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4142F7AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241125AbhJOQIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47246 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241059AbhJOQId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634313986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1aoeziL0xzFFKN0RHg65RlSBhdoiRCAVh5QP+AQQgH4=;
        b=eXRONNw2A5jTRFEND0sPzfjLYVNucj6X7Y/ZkagvKkRamx8hL7PwQBgx1aKm2qDjlGVckk
        Tj7LjI2npZpG6Zu8uFF8xgIDaJpsWE2LhpxfckqDcxVb/76vO8+/k2g+NcF8i2AAbpYp5e
        DJqGPwocqgNRxDyYlLwX5PPLOz1cl5c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-9W_4kMpcNp2p6Ptw5jbmnQ-1; Fri, 15 Oct 2021 12:06:25 -0400
X-MC-Unique: 9W_4kMpcNp2p6Ptw5jbmnQ-1
Received: by mail-ed1-f72.google.com with SMTP id i7-20020a50d747000000b003db0225d219so4042240edj.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1aoeziL0xzFFKN0RHg65RlSBhdoiRCAVh5QP+AQQgH4=;
        b=sdEArCQ3isY8QXKVpurSWAMkt9Cdk7H6QilRskz0fHOjp7oFGTfM8zwWCl9uRflmXR
         b9DEDERe5QB2TeJWZzjiW7HNh3GYzb6YhzRhSAWdLFvcpLudibadluZWQGf5VlJSyS0P
         T0hHuJYiga5+htJ4y8nedfqNttKS9UTanDCKouASvvAncskFJxWoRG0U4hGJeT7FA/hU
         qq2gEkXJLjrZ43ySObHwOcqSmgT6b7XDfJZW+5ZBA/3IBxvzOXZCua3K67QlJW0EOEdr
         cow+jN5FtL4gxDnwVi3Z2i2RjrYPX1npYYebkeZZQ5shRo2kMDSTJ8wV69X050Jd2Eew
         az4Q==
X-Gm-Message-State: AOAM532lyLQeluLGwIcrc7flsXOCTEhYGiSRfjXtTLzzbeNFjfxTgff9
        mOG5F9e5PdIWVhIutdYbVDAMuOvlUv7z6oQ5nJg9AAabXZ1Ey5oAWVAG0e5mntOS1YlWrBagVed
        JzVLQc/EO0+I5Y+feGo0bqXQp
X-Received: by 2002:a05:6402:2345:: with SMTP id r5mr18689607eda.202.1634313983387;
        Fri, 15 Oct 2021 09:06:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg0/9UNg7sGN4xD0y08rcDfbbj0LEzqB1J+T+jKrBu5AmUtRQ0wDHH8hA8gYlX5601Yl9lrw==
X-Received: by 2002:a05:6402:2345:: with SMTP id r5mr18689580eda.202.1634313983137;
        Fri, 15 Oct 2021 09:06:23 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ck9sm4514467ejb.56.2021.10.15.09.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 09:06:22 -0700 (PDT)
Message-ID: <5785637f-2b1a-b4c7-1f9e-67711f284264@redhat.com>
Date:   Fri, 15 Oct 2021 18:06:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: x86: Account for 32-bit kernels when handling
 address in TSC attrs
Content-Language: en-US
To:     Oliver Upton <oupton@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211007231647.3553604-1-seanjc@google.com>
 <CAOQ_Qsj9yiChnBZmotdYFYgsd=C0J5XXR8mthdiC+iXX22F7jw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAOQ_Qsj9yiChnBZmotdYFYgsd=C0J5XXR8mthdiC+iXX22F7jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/21 16:35, Oliver Upton wrote:
> On Thu, Oct 7, 2021 at 6:16 PM Sean Christopherson <seanjc@google.com> wrote:
>>
>> When handling TSC attributes, cast the userspace provided virtual address
>> to an unsigned long before casting it to a pointer to fix warnings on
>> 32-bit kernels due to casting a 64-bit integer to a 32-bit pointer.
>>
>> Add a check that the truncated address matches the original address, e.g.
>> to prevent userspace specifying garbage in bits 63:32.
>>
>>    arch/x86/kvm/x86.c: In function ‘kvm_arch_tsc_get_attr’:
>>    arch/x86/kvm/x86.c:4947:22: error: cast to pointer from integer of different size
>>     4947 |  u64 __user *uaddr = (u64 __user *)attr->addr;
>>          |                      ^
>>    arch/x86/kvm/x86.c: In function ‘kvm_arch_tsc_set_attr’:
>>    arch/x86/kvm/x86.c:4967:22: error: cast to pointer from integer of different size
>>     4967 |  u64 __user *uaddr = (u64 __user *)attr->addr;
>>          |                      ^
>>
>> Cc: Oliver Upton <oupton@google.com>
>> Fixes: 469fde25e680 ("KVM: x86: Expose TSC offset controls to userspace")
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
>>   arch/x86/kvm/x86.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
> 
> Reviewed-by: Oliver Upton <oupton@google.com>
> 

Squashed, thanks.

Paolo

