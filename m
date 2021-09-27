Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4492C419720
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbhI0PFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234939AbhI0PFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632755040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/mgKtKp5KKfxcrjzch748kWu470axxG1OqY2NSG+pg=;
        b=YWXa4ceanug9gp8E7xrMg7zT2lRpaIvboHjTbrZkC1+iqqgD9nZhArJN0b6YZ/BhhyGY7U
        ZKdNVxm9q0pvMvapi3c3lW1RdzokydGsQ+IxZB+q/dxOmIVTA51RLe69ybLdo/PwHcYxfi
        BHU1J8Y2YbAfUpOzJtTCSd7xI7wxqu8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-hJen7GguPeqa10LkNWfctQ-1; Mon, 27 Sep 2021 11:03:59 -0400
X-MC-Unique: hJen7GguPeqa10LkNWfctQ-1
Received: by mail-wr1-f71.google.com with SMTP id j15-20020a5d564f000000b00160698bf7e9so917905wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r/mgKtKp5KKfxcrjzch748kWu470axxG1OqY2NSG+pg=;
        b=A7Jus8PThQcI1kEB1dAMc1ITtP6LBq+PHmbotBWHrecV2HvNGw55w1qKl4P1qG825N
         GfnmDt4583jv/VXIE6W7vCBLIwFLyNyYHoTl6isjEaduTiHqCiZ1iv0ejYMfYGD2u8vh
         wNAyBu3ulRjmk+80fuc7m7IdKmqGgDpW+I89nJwpujY8XCCFsPrJYvFfthqdyM3yUOCI
         sr4CtmDXjYC3ea+6tFm6H09SnMAxgJPNnXdzjQf8vWOUYttZyPCO17VpY+kD5vSAciLD
         r4pkGADXBcigDRkfcTj/aPD7C5TkrAZQIYI0bTQLgOhrGKFoI6aB7+X03iTZO2H6GMeo
         ZaCw==
X-Gm-Message-State: AOAM530ujC0c070M/umCd56t7vRBlL16a7d9+SNFzKbnjShQ9UK4QRBM
        98iKSWdzwjWLxKjImW7fccLUNc7XwuTQX16d3CEgndAIRNUQOTSTcCGFOFsIQTPtzZi2Cqk1vZh
        4diHDaJ6eCBJFzgbBWrM5tHcV
X-Received: by 2002:a7b:c209:: with SMTP id x9mr388013wmi.9.1632755038165;
        Mon, 27 Sep 2021 08:03:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEdm9plI8QQmwPL2SFhkzquOawAtG2L3LzWjsrxEcUhatBpqdEXWMPsZ+lvaoVsF5QfHy+Uw==
X-Received: by 2002:a7b:c209:: with SMTP id x9mr387973wmi.9.1632755037927;
        Mon, 27 Sep 2021 08:03:57 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id c9sm15544500wmb.41.2021.09.27.08.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 08:03:57 -0700 (PDT)
Message-ID: <f37ab68c-61ce-b6fb-7a49-831bacfc7424@redhat.com>
Date:   Mon, 27 Sep 2021 17:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: disabling halt polling broken? (was Re: [PATCH 00/14] KVM:
 Halt-polling fixes, cleanups and a new stat)
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     David Matlack <dmatlack@google.com>,
        Jon Cargille <jcargill@google.com>,
        Jim Mattson <jmattson@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Zhang <jingzhangos@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Janosch Frank <frankja@linux.ibm.com>
References: <20210925005528.1145584-1-seanjc@google.com>
 <03f2f5ab-e809-2ba5-bd98-3393c3b843d2@de.ibm.com>
 <YVHcY6y1GmvGJnMg@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YVHcY6y1GmvGJnMg@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/21 16:59, Sean Christopherson wrote:
>> commit acd05785e48c01edb2c4f4d014d28478b5f19fb5
>> Author:     David Matlack<dmatlack@google.com>
>> AuthorDate: Fri Apr 17 15:14:46 2020 -0700
>> Commit:     Paolo Bonzini<pbonzini@redhat.com>
>> CommitDate: Fri Apr 24 12:53:17 2020 -0400
>> 
>>      kvm: add capability for halt polling
>> 
>> broke the possibility for an admin to disable halt polling for already running KVM guests.
>> In past times doing
>> echo 0 > /sys/module/kvm/parameters/halt_poll_ns
>> 
>> stopped polling system wide.
>> Now all KVM guests will use the halt_poll_ns value that was active during
>> startup - even those that do not use KVM_CAP_HALT_POLL.
>> 
>> I guess this was not intended?

No, but...

> I would go so far as to say that halt_poll_ns should be a hard limit on
> the capability

... this would not be a good idea I think.  Anything that wants to do a 
lot of polling can just do "for (;;)".

So I think there are two possibilities that makes sense:

* track what is using KVM_CAP_HALT_POLL, and make writes to halt_poll_ns 
follow that

* just make halt_poll_ns read-only.

Paolo

