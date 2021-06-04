Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E3A39B3D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 09:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFDH0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 03:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39730 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230099AbhFDH0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 03:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622791475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ElFb664kDca3zTUpMXZCL5Csjp2/nyoNDD9HukhmOHM=;
        b=TnlVERX2WCccv73rRj+yMV72uhH/2GHU7sl8HB55t/ERJoXUzRYdL/CuKMoJrLWVT78foe
        XFg/BBEKf6L66s5ompGQJrLedD+9pEWksjvkh/xoghLGBf6cL0dryFAkhNicq74W/M5dOg
        2TuKJjL2eZ7HY8FgemWzln8LNQavm6k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-Q8gBKQW9Pfmv9pvLJq-YGg-1; Fri, 04 Jun 2021 03:24:33 -0400
X-MC-Unique: Q8gBKQW9Pfmv9pvLJq-YGg-1
Received: by mail-ej1-f71.google.com with SMTP id o5-20020a1709068605b02904034c0d7648so1294110ejx.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 00:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ElFb664kDca3zTUpMXZCL5Csjp2/nyoNDD9HukhmOHM=;
        b=isFbPf+TrV4j94bKLz6WaoDqkQd4EX5PPd8HohxEPHux5QLNDwTZCzySRkUxGQxBLy
         Fb7rW7HNTnHBlPOV+gva8HmEC5F5kdoFKY1bPy0PuA66wuXRE8YpNNaCgYdebkxEWH6+
         SkgYyHosetYuObxWp9wJFluyBg6ZLXohxNKSw10i/Brsugj/hgOex0P8t/BBG5Cya6n8
         +p72NYSqsU56xZHHqV0+U0H+ykPs4LUmQbB5Fpm9V2u9toYPojowLRtsiSjLjyWoIwDJ
         afxw3Z2eB3uY1bWlJN3B0xu6SL4MhbmkeXWr0bJnuhkB5CkTJnWXlwH+F2ZMPWJxP/Fv
         7Kng==
X-Gm-Message-State: AOAM530XXB5h/PLdcP9NjuMRx+XgCAhZb1dspk8gFivWHTyLQgtIHfor
        zBIm/YhpOXpQf/LzKxDoZBRv/cnfSZUlBoZrbjKWyA9NsB4s3CTmcUz3KPiJSkmj/m6j+OUi9Oi
        p7ch5+u8+uqQdwCShBziqknQ+
X-Received: by 2002:a17:906:1401:: with SMTP id p1mr2849919ejc.526.1622791472784;
        Fri, 04 Jun 2021 00:24:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwf6cQzWkBIEpZuWDj8mD3YKNJZw3J7U1/Ic7+UpRFaWTIKLqYoDPaxKjav78eW5CkReqQfnw==
X-Received: by 2002:a17:906:1401:: with SMTP id p1mr2849903ejc.526.1622791472650;
        Fri, 04 Jun 2021 00:24:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id nc26sm2296091ejc.106.2021.06.04.00.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 00:24:32 -0700 (PDT)
Subject: Re: [RFC][PATCH] kvm: add suspend pm-notifier
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Suleiman Souhlal <suleiman@google.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
References: <20210603164315.682994-1-senozhatsky@chromium.org>
 <87a6o614dn.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4b4e872-4b22-82b7-57fc-65a7d10482c0@redhat.com>
Date:   Fri, 4 Jun 2021 09:24:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87a6o614dn.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/21 09:21, Vitaly Kuznetsov wrote:
>>   
>>   	preempt_notifier_inc();
>> +	kvm_init_pm_notifier(kvm);
>>   
> You've probably thought it through and I didn't but wouldn't it be
> easier to have one global pm_notifier call for KVM which would go
> through the list of VMs instead of registering/deregistering a
> pm_notifier call for every created/destroyed VM?

That raises questions on the locking, i.e. if we can we take the 
kvm_lock safely from the notifier.

Paolo

