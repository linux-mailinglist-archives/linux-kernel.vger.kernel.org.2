Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D11645A99B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbhKWRHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:07:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237500AbhKWRHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637687061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kByPH5nF0InwM69v4kGnfWv6NJm9wrS3dWWDwL74Lw=;
        b=ZYSS2FgD8AR3k803S9/nmpdN8bAbcrApxvY+fZPev90nUTs/iwt1gqoBCQk6jo2fUhw81y
        hjfvkY24xBUUcrnY303WQcOh64rEkeT3BZnGlgiNyLgXEQRnCvT4juSnLJ802oUaB/ckU7
        w1wlUTNw5nB2x2o+8SgzizrdkGfo2DA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-xH7aRp0XOkCadYpN1v4Hmg-1; Tue, 23 Nov 2021 12:04:20 -0500
X-MC-Unique: xH7aRp0XOkCadYpN1v4Hmg-1
Received: by mail-wr1-f71.google.com with SMTP id d18-20020adfe852000000b001985d36817cso473181wrn.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=7kByPH5nF0InwM69v4kGnfWv6NJm9wrS3dWWDwL74Lw=;
        b=y2pYqCT5LpRT7T5VxWUlgBfZrzo7UdeRAPLjsJM4epxHaXpTYCbTHyW3SuQk3DPo8q
         6moOnO4sJwsQqUO89qwI0paQBclaSZeS1v7warMFxIif1i6ke1tBxJettRm0Oc7OE3uj
         3rGF3HUAOi3D6yvxm/VDbVceqExzeBTzi39ilD+S3eHbr5YGjEnfackjcPmXFX1aceFb
         jci1fzXzrxoo+C+dRvNPx0ltQDd3Rdzl9Dqz5wB2js1RHkkhQW4/LgnIQtKmp4BIQbLf
         cOO48C8KlRg7fviPR1edW7o756StXj+2pW2hMwBj7pmwx2SRRLXRd6Eu8SW3KVmFyEEk
         R+7w==
X-Gm-Message-State: AOAM530xCrw4vRMWq5V5R4l0pmoUsZxzU51ktgoloFAQhPKCVybdGARd
        azdeSyKUMwCIPzLhz6u7lIkbDzJgkQeq4hFDzFVkHRLJXKjHfBi1p35InWTJqy0Ps9hndLRC+hX
        IDKagsl2Z+fiIyjKC/UZ8a6a9
X-Received: by 2002:adf:ec45:: with SMTP id w5mr8994346wrn.183.1637687058960;
        Tue, 23 Nov 2021 09:04:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykyScG+fmWu1ZxlpPcTdQ5mn0yh6fhIHez7GTidDv3h8Ip176ypu5cz+undY5/dGCL1kztVw==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr8994305wrn.183.1637687058753;
        Tue, 23 Nov 2021 09:04:18 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6765.dip0.t-ipconnect.de. [91.12.103.101])
        by smtp.gmail.com with ESMTPSA id 38sm13027369wrc.1.2021.11.23.09.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 09:04:18 -0800 (PST)
Message-ID: <98470479-7ba9-9f05-e597-e5afeb3464a3@redhat.com>
Date:   Tue, 23 Nov 2021 18:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Dona-Couch <andrew@donacou.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew DeVault <sir@cmpwn.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        io_uring Mailing List <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org
References: <20211116133750.0f625f73a1e4843daf13b8f7@linux-foundation.org>
 <b84bc345-d4ea-96de-0076-12ff245c5e29@redhat.com>
 <8f219a64-a39f-45f0-a7ad-708a33888a3b@www.fastmail.com>
 <333cb52b-5b02-648e-af7a-090e23261801@redhat.com>
 <ca96bb88-295c-ccad-ed2f-abc585cb4904@kernel.dk>
 <5f998bb7-7b5d-9253-2337-b1d9ea59c796@redhat.com>
 <20211123132523.GA5112@ziepe.ca>
 <10ccf01b-f13a-d626-beba-cbee70770cf1@redhat.com>
 <20211123140709.GB5112@ziepe.ca>
 <e4d7d211-5d62-df89-8f94-e49385286f1f@redhat.com>
 <20211123170056.GC5112@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211123170056.GC5112@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.21 18:00, Jason Gunthorpe wrote:
> On Tue, Nov 23, 2021 at 03:44:03PM +0100, David Hildenbrand wrote:
>> On 23.11.21 15:07, Jason Gunthorpe wrote:
>>> On Tue, Nov 23, 2021 at 02:39:19PM +0100, David Hildenbrand wrote:
>>>>>
>>>>>> 2) Could be provide a mmu variant to ordinary users that's just good
>>>>>> enough but maybe not as fast as what we have today? And limit
>>>>>> FOLL_LONGTERM to special, privileged users?
>>>>>
>>>>> rdma has never been privileged
>>>>
>>>> Feel free to correct me if I'm wrong: it requires special networking
>>>> hardware and the admin/kernel has to prepare the system in a way such
>>>> that it can be used.
>>>
>>> Not really, plug in the right PCI card and it works
>>
>> Naive me would have assumed that the right modules have to be loaded
>> (and not blacklisted), that there has to be an rdma service installed
>> and running, that the NIC has to be configured in some way, and that
>> there is some kind of access control which user can actually use which
>> NIC.
> 
> Not really, we've worked hard that it works as well as any other HW
> device. Plug it in and it works.
> 
> There is no systemd service, or special mandatory configuration, for
> instance.
> 
>> For example, I would have assume from inside a container it usually
>> wouldn't just work.
> 
> Nope, RDMA follows the net namespaces of its ethernet port, so it just
> works in containers too.
> 
>> believe what you say and I trust your experience :) So could as well be
>> that on such a "special" (or not so special) systems there should be a
>> way to restrict it to privileged users only.
> 
> At this point RDMA is about as "special" as people running large
> ZONE_MOVABLE systems, and the two are going to start colliding
> heavily. The RDMA VFIO migration driver should be merged soon which
> makes VMs using this stuff finally practical.

Sounds like fun. At least we documented it already ;)

https://www.kernel.org/doc/html/latest/admin-guide/mm/memory-hotplug.html#zone-movable-sizing-considerations

-- 
Thanks,

David / dhildenb

