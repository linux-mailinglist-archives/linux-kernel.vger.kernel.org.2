Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667AA30DCEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhBCOgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:36:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233004AbhBCOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612362827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6lK2u2BMNZgjS8FOn0e/cEsWDsni55t0Ii5LPe/n/VA=;
        b=eLwHXxvBCyQ0Q9vVyc6Z+ct2TQ8cmg7ha6OwmJHcu/QPdZ2ZBXJIYS3agRMMWVznA9+iCZ
        IriHfB2X0rt2RFS2LpIUv0XmLZ+Jq21FKlOXXUtaDFe6H9NCbA3WM5Ezkg+oK7+0HyCZvN
        dqa34LMebNGbQhtVDJ4fln4SfVz+JA8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-VGFaqktFN-qjEoGqIh64Wg-1; Wed, 03 Feb 2021 09:33:45 -0500
X-MC-Unique: VGFaqktFN-qjEoGqIh64Wg-1
Received: by mail-ed1-f72.google.com with SMTP id f21so11706047edx.23
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6lK2u2BMNZgjS8FOn0e/cEsWDsni55t0Ii5LPe/n/VA=;
        b=jSvZCcatXUKKKCGTqhK6tM073nLg9gK38kSuHvH9cphk5U8vqG9UId0YcQGuToWhGz
         PSGVZcjXw7a6WrERNXrarv/pRlGT1diityFFLtsjJ+tOnkPNYj/oOXOo06FgPkYeVW8J
         3zhZK0bEjgJGYtMxeupj6q0mkQrQDaiEnC8SphfprxSPhe4kFtvuse2wu9TAMPHFVSLc
         pQTd/PdMQaX0PiBJDrLNcrssTSXCOW2pVr3z+feybEQlHXAjQCrNg6EV2LcpRfaTcXe+
         NFyFnzdrM2kYtE54UCI4e2Z4PeGnSbEHuEoyCEUlZAg2zDvOd8sXXT5dM1+m2LP4/3OB
         a7ZA==
X-Gm-Message-State: AOAM530mj+J6MDQVID4sFLmXE3SI2gs1nKtEzdviXQunN7qIv2O8mnqu
        XKpfoORm6D6gIGWhSee6shgi7AyTzSCwLTw0oAsDO9YAxZIrPjF67hfEdIrvq/NEgbzQjyWxBF+
        CPKEuSKMFyFX93gHIm6xcYfhhuztuWuOP0JSZA4KpRLcP91s/NxqzzC/gPg/bX79L7tClX9HzlC
        4C
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr3682847ejp.458.1612362823795;
        Wed, 03 Feb 2021 06:33:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOOzOL6QtKRBXVx8lmpUZ6fGlVamfS2e7V5rEaBIHN3pWxL2z6zEh8bJEPzf3K3xafw9rEGQ==
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr3682671ejp.458.1612362821983;
        Wed, 03 Feb 2021 06:33:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j5sm969210edl.42.2021.02.03.06.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 06:33:40 -0800 (PST)
Subject: Re: [PATCH 2/2] KVM: Scalable memslots implementation
To:     David Hildenbrand <david@redhat.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ceb96527b6f7bb662eec813f05b897a551ebd0b2.1612140117.git.maciej.szmigiero@oracle.com>
 <4d748e0fd50bac68ece6952129aed319502b6853.1612140117.git.maciej.szmigiero@oracle.com>
 <YBisBkSYPoaOM42F@google.com>
 <9e6ca093-35c3-7cca-443b-9f635df4891d@maciej.szmigiero.name>
 <4bdcb44c-c35d-45b2-c0c1-e857e0fd383e@redhat.com>
 <5efd931f-9d69-2936-89e8-278fe106616d@redhat.com>
 <307603f3-52a8-7464-ba98-06cbe4ddd408@redhat.com>
 <b9aacf06-de2b-b831-6210-25191dd1b0ac@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6e3d6b2-e6fd-c0ae-db17-2218770ce4ed@redhat.com>
Date:   Wed, 3 Feb 2021 15:33:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b9aacf06-de2b-b831-6210-25191dd1b0ac@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 14:52, David Hildenbrand wrote:
>>
>> However, note that the TDP MMU does not need an rmap at all.  Since that
>> one is getting ready to become the default, the benefits of working on
>> the rmap would be quite small and only affect nested virtualization.
> 
> Right, but we currently always have to allocate it.
> 
> 8 bytes per 4k page, 8 bytes per 2M page, 8 bytes per 1G page.
> 
> The 4k part alone is 0.2% of the memblock size.
> 
> For a 1 TB memslot we might "waste" > 2 GB on rmap arrays.
> 
> (that's why I am asking :) )

Yes, we're in violent agreement. :)  I mean that the simplest solution 
would be to allocate it lazily when building a non-TDP root.

Paolo

