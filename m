Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3563AC8C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 12:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhFRK3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 06:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229768AbhFRK3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 06:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624012052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Z2CJ9V34y2pAE384/ANEr0yGKWrtOTaGvsqCpVRS+U=;
        b=CVBuJ4scA8FL49OKv6xID43XZuJf1ezm4VEWdMRqBng1vmmHuR+XaRzKMNWH1zL75Pvj7F
        bxuvkA/M7bNqCdXo2DpVcyp4ICkhdSdNpc2ljOZCZck8eUmaNwkYHCLCEzElXfPcqHgIFM
        zJW7KwPxmKYzi7p75aKz354QHE8YEAQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-neHOHbioNcmu42HQJ3SNLA-1; Fri, 18 Jun 2021 06:27:31 -0400
X-MC-Unique: neHOHbioNcmu42HQJ3SNLA-1
Received: by mail-ed1-f72.google.com with SMTP id a16-20020aa7cf100000b0290391819a774aso1723622edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Z2CJ9V34y2pAE384/ANEr0yGKWrtOTaGvsqCpVRS+U=;
        b=ml3Z7DhJ7Vm+0SeNIRftYI2h7b+oJrJCrZFQW1FqgtgicJ/h9SrHbGfl58pCxILMnO
         gYlq+qvexaKakL0lG/4gqcv5cFrL2drVkTIRPa3TTr4t9tMXUUY3uUlcLHxhEaNaOVxU
         QUhp9X9LS3e5zz6bIKEw2OHtFexUOsM+mB/WZAGAZZEEGBBD2BLoiKD3DsBoKaXndJWQ
         QZHEgEWjGMQ8zdS7XLJ8kobWTxfX8frUerPEqQWKLNq4Dgilh+Wd+doEynz7aTaNjim3
         vO6TNOg1Hbb03u/B8vPvGoK/BTi4fVvTHZ3QCHEDvhvIiI/3UeQAQIrfeQ0nipQETOAf
         uqRQ==
X-Gm-Message-State: AOAM5326ezK0RiiV9F5qmfo//Oc3Gcs8mOSxRQUKhltVTU8kA0M9LaeC
        TbtQqqLrGrjg1GUAXLZaaTNYNO/PmECF4ui/gxgGOm+bc3TF/giDXupd9O6ZSFxSD9vVxAwvwyW
        5AzoXark5J5ECFnIZYUiGwkkPc7o8hHw9kOWhFnI6/PyqU/QAl44mUdql/nx4YbrZf30Md1Tq2T
        XD
X-Received: by 2002:a17:906:3057:: with SMTP id d23mr10217667ejd.131.1624012049534;
        Fri, 18 Jun 2021 03:27:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXkfkJJzO9ow7Rx03C2rZ0ep5F363V1TXI14icaVSd94bulhKHWZRzimP1DHsWrjdYztsWog==
X-Received: by 2002:a17:906:3057:: with SMTP id d23mr10217649ejd.131.1624012049358;
        Fri, 18 Jun 2021 03:27:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n13sm848630ejk.97.2021.06.18.03.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 03:27:28 -0700 (PDT)
Subject: Re: [PATCH 3/4] KVM: x86: WARN and reject loading KVM if NX is
 supported but not enabled
To:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210615164535.2146172-1-seanjc@google.com>
 <20210615164535.2146172-4-seanjc@google.com>
 <CALMp9eSkVaDfCJwW1eds=7H7yn2pKJPKoFVpc1GQcEqGD5S0Dg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ea2385a-9abe-82b8-6c57-8dc3aac824b2@redhat.com>
Date:   Fri, 18 Jun 2021 12:27:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CALMp9eSkVaDfCJwW1eds=7H7yn2pKJPKoFVpc1GQcEqGD5S0Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/21 00:39, Jim Mattson wrote:
>>
>>          rdmsrl_safe(MSR_EFER, &host_efer);
>> +       if (WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_NX) &&
>> +                        !(host_efer & EFER_NX)))
>> +               return -EIO;
> Input/output error? Is that really the most appropriate error here?
> Why not, say, -ENOTSUP?
> 
> I'm sure there's some arcane convention here that I'm not privy to.:-)
> 
> Reviewed-by: Jim Mattson<jmattson@google.com>
> 

EIO often means "how the heck did we get here?" or "look in dmesg to get 
more info", both of which I think are appropriate after a WARN.

Paolo

