Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18A45C7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352393AbhKXOo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:44:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353995AbhKXOoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637764870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05PN9xn7GnEUgcf2Sc2TC/qS5xmqWs58yCFcmH/P7j0=;
        b=UTPEwn4h8KxYq86KuF3/TsqWeiXYK6diKDZiBOQsoX2OZpOk4TdjD5mZABRAG5sYMJaxJW
        kynDvQIz3kU27mKETbzs0SepWGiH3/eJIFiUbYqljJ63M929Y8EmZWrixsaQimsvplLFMr
        RAzC6xkOgL1vm1ongndWCyeEXculqzo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-162-aOYjeUTzNRyUzwKuGMwy1Q-1; Wed, 24 Nov 2021 09:41:08 -0500
X-MC-Unique: aOYjeUTzNRyUzwKuGMwy1Q-1
Received: by mail-wr1-f71.google.com with SMTP id q15-20020adfbb8f000000b00191d3d89d09so548304wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 06:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=05PN9xn7GnEUgcf2Sc2TC/qS5xmqWs58yCFcmH/P7j0=;
        b=qEyf25jLOj1n5po9C590R0n4bnjmH/ySHcd2qBvyjooMesDTKYMbhDM0iqjhd10101
         QmwebK8TgKf/8zGr/o3iSPWjWg3Z4BpWvchxAt/GeTvpkM2hxQvZaqy/uORfe0kozIfj
         ViJLvVF9E57kMLpFjgrU+bq++1dHK5Ei2bsJiPKHC8KAzA9joIyzaCKC1pw7GVSn9C9q
         00sKZMVth8fPpEnRjKVJWhnTggX/fHK5vqJ0IP8aDmfS1WMe4MhhwnbSYMTRXMWRn5er
         Ij0/5po5yi+0sKQFqrI4BiGpfTV7lyU0t/ClQIRTEBGBesuMERbvvbT/ZPG3R6ZPR3Bk
         r+8w==
X-Gm-Message-State: AOAM531wKPaDAZuy06TWh9RTTGCzRiUC3AXWesxKn0t0QPUXckm7d5FW
        ra2xwZMhUBKL1ghAxyTQFBwBQGe3fqwpaVKsP0yqxgp18Kd3m2kXMf4T0tzFnQOYTZFwp0ZSgEO
        6Hqf44cKcNUVaEHEpcoSmdTV4
X-Received: by 2002:a7b:c008:: with SMTP id c8mr15311368wmb.87.1637764867357;
        Wed, 24 Nov 2021 06:41:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxF7ZFf+xn1AKx+sORexMmiOn/XrWXeSdy5eaDUZxe1RqZJyUBzwaHLdz+J+JQnLnMzS44+XA==
X-Received: by 2002:a7b:c008:: with SMTP id c8mr15311334wmb.87.1637764867166;
        Wed, 24 Nov 2021 06:41:07 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6380.dip0.t-ipconnect.de. [91.12.99.128])
        by smtp.gmail.com with ESMTPSA id l8sm5226970wmc.40.2021.11.24.06.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 06:41:06 -0800 (PST)
Message-ID: <cea956bf-66cf-dfa5-cc0a-50a2c14a68ec@redhat.com>
Date:   Wed, 24 Nov 2021 15:41:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Dona-Couch <andrew@donacou.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew DeVault <sir@cmpwn.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        io_uring Mailing List <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org
References: <8f219a64-a39f-45f0-a7ad-708a33888a3b@www.fastmail.com>
 <333cb52b-5b02-648e-af7a-090e23261801@redhat.com>
 <ca96bb88-295c-ccad-ed2f-abc585cb4904@kernel.dk>
 <5f998bb7-7b5d-9253-2337-b1d9ea59c796@redhat.com>
 <20211123132523.GA5112@ziepe.ca>
 <10ccf01b-f13a-d626-beba-cbee70770cf1@redhat.com>
 <20211123140709.GB5112@ziepe.ca>
 <e4d7d211-5d62-df89-8f94-e49385286f1f@redhat.com>
 <20211123170056.GC5112@ziepe.ca>
 <dd92a69a-6d09-93a1-4f50-5020f5cc59d0@suse.cz>
 <20211123235953.GF5112@ziepe.ca>
 <2adca04f-92e1-5f99-6094-5fac66a22a77@redhat.com>
 <b513d058-0721-cdcd-c146-de104db8af3a@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b513d058-0721-cdcd-c146-de104db8af3a@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.11.21 15:37, Vlastimil Babka wrote:
> On 11/24/21 09:57, David Hildenbrand wrote:
>> On 24.11.21 00:59, Jason Gunthorpe wrote:
>>>> Similarly for io-uring we could be migrating pages to be pinned so that
>>>> the end up consolidated close together, and prevent pathologic
>>>> situations like in David's reproducer. 
>>>
>>> It is an interesting idea to have GUP do some kind of THP preserving
>>> migration.
>>
>>
>> Unfortunately it will only be a band aid AFAIU. I can rewrite my
>> reproducer fairly easily to pin the whole 2M range first, pin a second
>> time only a single page, and then unpin the 2M range, resulting in the
>> very same way to block THP. (I can block some THP less because I always
>> need the possibility to memlock 2M first, though).
> 
> Hm I see, then we could also condsider making it possible to migrate the
> pinned pages - of course io-uring would have to be cooperative here,
> similarly to anything that supports PageMovable.
I might be wrong but that would then essentially be an actual mlock+mmu
notifier mechanism, and no longer FOLL_LONGTERM. And the mlock could
actually be done by user space and would be optional.

I'd be very happy to see something like that instead ... but so far
people don't even agree that it's an issue worth fixing.

So ...

-- 
Thanks,

David / dhildenb

