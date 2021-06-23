Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7583B216C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 21:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFWTzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 15:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 15:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624477999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUTB7rHthe76pbGmYM084Sjx8ayVBRHQw9Xw36oAOPE=;
        b=FPzNZYTWMw/pRgTdcR+rtdQw3SHcN+US+7dUxb0PwgDmQzRYBbeq9Ncmyc+GN3uR8XXjWw
        sebFPngHNRBfNWooMEpn/Z8q38dd9NFYJYY9jp3qimUClprpGaSgMFRKinT3DMDdWpKzqM
        YCpS/vhgtnwCkLAmV0hGgWuN+F5xTV8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-yXdSlLKWOymDJzMHq_easg-1; Wed, 23 Jun 2021 15:53:17 -0400
X-MC-Unique: yXdSlLKWOymDJzMHq_easg-1
Received: by mail-ed1-f72.google.com with SMTP id dy23-20020a05640231f7b0290394996f1452so1921268edb.18
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 12:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cUTB7rHthe76pbGmYM084Sjx8ayVBRHQw9Xw36oAOPE=;
        b=THe+CyiZLjr0Nd9CmLJdnLAh2Qkdhr6RQQn7o+DbUp6xUTt4fM5k5U9w7i6N0vWhOe
         KPnzPctcq2RkQzmHEwaB009aeYS6RoymXl3olyxhvgM9MQJ7VHPtwbIvwKSSXhEDgbo+
         fvHLBZg5jRpuxh8dJFZ3uUtg26br3GxA+xs1IcmZ8/ajk+9cidIzCJZWjbW1Y86MCDGd
         dQOYvsiCLO1BXWTBki/syWQI3lTLBcuQTXwuu0KFNjvveQ7ALA+NIEgVMDnln55K082M
         gHcz6d+YwTYo/GIlqttMQevXhX5iVdTFBdyjcHaey0K03fbSRqpuwLannYLz/gQ4VOka
         CrVQ==
X-Gm-Message-State: AOAM532SWtVySuwtG7Gr3Xy8UJTEDSZUzJC8IsJm59F9BS4aY3TzcP5P
        OFbfMiI6PAYsCx+nBAwIqaAVER+2u88uLHYmxzct3qo9B0cUZ+/MeLRmvvim7EEAwHv7ExNlP+w
        i4ocJJ0/3+kjw13KIRGRGsROF
X-Received: by 2002:a50:9345:: with SMTP id n5mr1945644eda.289.1624477996233;
        Wed, 23 Jun 2021 12:53:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx84bbbDxSbyKIa+Y8qhpY6dQ36JqHh+T/qbouegnSKBx6sL5tYBEvLNWn+o6T39EXZa6onVA==
X-Received: by 2002:a50:9345:: with SMTP id n5mr1945623eda.289.1624477996039;
        Wed, 23 Jun 2021 12:53:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id jx17sm282801ejc.60.2021.06.23.12.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 12:53:15 -0700 (PDT)
Subject: Re: [PATCH 07/54] KVM: x86: Alert userspace that KVM_SET_CPUID{,2}
 after KVM_RUN is broken
To:     Jim Mattson <jmattson@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20210622175739.3610207-1-seanjc@google.com>
 <20210622175739.3610207-8-seanjc@google.com>
 <f031b6bc-c98d-8e46-34ac-79e540674a55@redhat.com>
 <CALMp9eSpEJrr6mNoLcGgV8Pa2abQUkPA1uwNBMJZWexBArB3gg@mail.gmail.com>
 <6f25273e-ad80-4d99-91df-1dd0c847af39@redhat.com>
 <CALMp9eTzJb0gnRzK_2MQyeO2kmrKJwyYYHE5eYEai+_LPg8HrQ@mail.gmail.com>
 <af716f56-9d68-2514-7b85-f9bbb1a82acf@redhat.com>
 <CALMp9eQG-QLm1xRXw2CxLEsRukH0q6HoaQKPraDo-TyCSv6EKg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00691c37-5c29-e898-2657-8d7ef6b5dfad@redhat.com>
Date:   Wed, 23 Jun 2021 21:53:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CALMp9eQG-QLm1xRXw2CxLEsRukH0q6HoaQKPraDo-TyCSv6EKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/21 21:02, Jim Mattson wrote:
>>
>> BTW, there is actually a theoretical usecase for KVM_SET_CPUID2 after
>> KVM_RUN, which is to test OSes against microcode updates that hide,
>> totally random example, the RTM bit.  But it's still not worth keeping
>> it given 1) the bugs and complications in KVM, 2) if you really wanted
>> that kind of testing so hard, the fact that you can just create a new
>> vcpu file descriptor from scratch, possibly in cooperation with
>> userspace MSR filtering 3) AFAIK no one has done that anyway in 15 years.
>
> Though such a usecase may exist, I don't think it actually works
> today. For example, kvm_vcpu_after_set_cpuid() potentially changes the
> value of the guest IA32_PERF_GLOBAL_CTRL MSR.

Yep, and that's why I'm okay with actively deprecating KVM_SET_CPUID2 
and not just "discouraging" it.

Paolo

