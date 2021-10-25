Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13DC439BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhJYQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231127AbhJYQrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635180302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNT3hqzp5JAiOj7EMmMtN5eINp8qeUVSTFxs1YCteUs=;
        b=TnvKjYzbMABLpt+O8ruzcYRIXfO2gNSscay+j2EeGDbzmE4KHJ8374z8yYXuv3GQktfjI+
        7xNH23y1+De9mppDB4a7I6xoDdoHjg8gAo3FMKgnzCQdvq4eGniOPTM/PVWx064TXGNQ/J
        3VRR26l/Es7/0CIeN2JmTK1bXVuTK6A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-iLanOH5oPqeSz6P6_RUIIQ-1; Mon, 25 Oct 2021 12:44:59 -0400
X-MC-Unique: iLanOH5oPqeSz6P6_RUIIQ-1
Received: by mail-ed1-f71.google.com with SMTP id f4-20020a50e084000000b003db585bc274so10425149edl.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WNT3hqzp5JAiOj7EMmMtN5eINp8qeUVSTFxs1YCteUs=;
        b=LLA7/c0N2qP9FZozPhBq74Xo7uA2cY8fkPv1YCpLKt8dze65J6idz7aV/hA+CAOMYc
         mgzgD02QDGvQhwJFStvo3CXQZEJfSEiflzHLmupAbaUOO2GU+5Roh/p1s6oS5yih2xKM
         BY6mLgYVYCu6HT/scTHsBMzH/1ZmXNUL2pNRGZCzOyxcYo5/R/TKOguVwtdlhJqNRSs2
         4bB1NJbRQ65rpXTefTQF0MQHpL/2ieTbyQ6CzA0g1O1U6WUoA6n/bG2MNiinPBwMmI3H
         1Oo+CjX2eWbCK0YOn2kxbeoOIIOtLpYbto7NlWyZcolgRS9bU5TbWDLFeAmgSJLwoqSY
         rP9w==
X-Gm-Message-State: AOAM530KibbNT3UuP+nlfBCJzKEWsyoDLPEWStnlSSwyqVq1z4bBoXQG
        GMpKlM/Ipu2TIAwMIOj/MWiDZ0OzoORJJRHhbMJlUh7YlwQgf91sKDLjF7O71J+K/9p4BnPJpMf
        QSD6Q5HErExwulfT16MSwJr75
X-Received: by 2002:aa7:c6c1:: with SMTP id b1mr28232442eds.11.1635180298515;
        Mon, 25 Oct 2021 09:44:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7JYRq/uuVj1jP70lO/MEVNlpAjXxBqnB+rGkuCz/InSJ3GTqq0f97A6YdgndqkltHiDRXuw==
X-Received: by 2002:aa7:c6c1:: with SMTP id b1mr28232408eds.11.1635180298290;
        Mon, 25 Oct 2021 09:44:58 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id v22sm5792394edb.47.2021.10.25.09.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:44:57 -0700 (PDT)
Message-ID: <84444ec9-cebf-1ec2-ec3e-8b28e587682d@redhat.com>
Date:   Mon, 25 Oct 2021 18:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: vPMU: Don't program counter for interrupt-based
 event sampling w/o lapic_in_kernel
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1634894233-84041-1-git-send-email-wanpengli@tencent.com>
 <YXbb5ePpVWKxBsbh@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YXbb5ePpVWKxBsbh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/21 18:31, Sean Christopherson wrote:
>> vPMU depends on in-kernel lapic to deliver pmi interrupt, there is a
>> lot of overhead when creating/maintaining perf_event object,
>> locking/unlocking perf_event_ctx etc for vPMU. It silently fails to
>> deliver pmi interrupt if w/o in-kernel lapic currently. Let's not
>> program counter for interrupt-based event sampling w/o in-kernel
>> lapic support to avoid the whole bothering.
>
> This feels all kinds of wrong.  AFAIK, there's no way for KVM to enumerate to
> the guest that the vPMU isn't capable of generating interrupts.  I.e. any setup
> that exposes a vPMU to the guest without an in-kernel local APIC is either
> inherently broken or requires a paravirtualized guest.  I don't think KVM's bugs
> should be optimized.

Yeah, if it simplified the code it would be a different story, but here 
there's even not one but two new checks.

Paolo

