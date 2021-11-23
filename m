Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0879345AA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbhKWR3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 12:29:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44369 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230359AbhKWR3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 12:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637688373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+vj33RnkrSGQji5IuBxi1sYalXTGtUqdNgnp6hGXeQ=;
        b=JirSMHD1GqHwgbIhEl13SUYjHtXssXyYSu1v2guOfr5oZrBpMA0vK4zvtMWLiKs3zBe4J6
        hQ/JDdgC1CAqKTWodH3TDNn+qSw8Ya4AGfmSFs9BQ05WzexPYmjZCQo5cvrA6ELTysapgi
        +OZEt51dr0ZraZ8VNk9+x+WIjr8lA5s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-TYg4fhkyMfmPLmkYOVc_Bw-1; Tue, 23 Nov 2021 12:26:11 -0500
X-MC-Unique: TYg4fhkyMfmPLmkYOVc_Bw-1
Received: by mail-wr1-f72.google.com with SMTP id v17-20020adfedd1000000b0017c5e737b02so3850166wro.18
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=h+vj33RnkrSGQji5IuBxi1sYalXTGtUqdNgnp6hGXeQ=;
        b=0l+8ENqIyATKIeVDl9JMUUraAKc3x+Z7W0w8fihjPoPeeuxbgGCtOfybmo8+XOnxB3
         cQdBNYSlForoaTYfwTtcuTsZ6IaPeV0Djdw6FbF2t7k7O32w+Z0MImcGzJEwdY0kpP/G
         SABUVZ35bols8yu5VHyLE1GJsYWTt/8oR9tJF7hCIyNOHe2aLFPxw2qBcs1qDDdj2z4j
         sf9yXksrKpjqML41Mj3hJUH0Jdq8Q+yTsuLcvX7oyqZs8CdWM+6q7kLTQF/xtvsXPf0P
         jfMw5mhJHnBTB/YMpcV5UouIO4roea9fxdzC907xfssi0n52xu2dy5XU/Hv2MqSRnlTJ
         6Erw==
X-Gm-Message-State: AOAM5336ymR+DLIuEKd0Yg3iqSipS/fJahJeFOf3b/6TLw4wOmUf2GL0
        MANA6mstum1ePPWcy5Z/+sTrrWxNyzDDPGPfzPA3gv1CktJdB3JQJPqFT0sxFCtDDJQ4XrnYe2w
        On9hJKzB3OOCdJqn3yPIkKEg7
X-Received: by 2002:a05:600c:35d4:: with SMTP id r20mr5270603wmq.76.1637688370513;
        Tue, 23 Nov 2021 09:26:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHARx13S44k6l22g5/3XNnHYzQ3ErFenlzeu0rgBJk63QUHPrU7EUgyS/Qq/GqILF2F0+Q5g==
X-Received: by 2002:a05:600c:35d4:: with SMTP id r20mr5270571wmq.76.1637688370346;
        Tue, 23 Nov 2021 09:26:10 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6765.dip0.t-ipconnect.de. [91.12.103.101])
        by smtp.gmail.com with ESMTPSA id s13sm1878592wmc.47.2021.11.23.09.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 09:26:09 -0800 (PST)
Message-ID: <1b400921-8bef-8073-10f9-a7cbb09cfefe@redhat.com>
Date:   Tue, 23 Nov 2021 18:26:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211120201230.920082-1-shakeelb@google.com>
 <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <1b30d06d-f9c0-1737-13e6-2d1a7d7b8507@redhat.com>
 <CALvZod5sFQbf3t_ZDW6ob+BqVtezn-c7i1UyOeev6Lwch96=7g@mail.gmail.com>
 <92fe0c31-b083-28c4-d306-da8a3cd891a3@redhat.com>
 <CALvZod4C1V6Gk96oMCMguaqChjggH0KH3KKcU1QOmjRG+QEAbQ@mail.gmail.com>
 <c61a6f30-ed62-7773-3371-981102f6804f@redhat.com>
 <CALvZod7xTfg5aeQC7-EaOZJ47Twb8CkoS6u4C=8+y+AX-NREVw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CALvZod7xTfg5aeQC7-EaOZJ47Twb8CkoS6u4C=8+y+AX-NREVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.21 18:24, Shakeel Butt wrote:
> On Tue, Nov 23, 2021 at 9:20 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 23.11.21 18:17, Shakeel Butt wrote:
>>> On Tue, Nov 23, 2021 at 8:57 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>> [...]
>>>>>>
>>>>>> I do wonder which these locking contexts are exactly, and if we could
>>>>>> also do the same thing on ordinary munmap -- because I assume it can be
>>>>>> similarly problematic for some applications.
>>>>>
>>>>> This is a good question regarding munmap. One main difference is
>>>>> munmap takes mmap_lock in write mode and usually performance critical
>>>>> applications avoid such operations.
>>>>
>>>> Maybe we can extend it too most page zapping, if that makes things simpler.
>>>>
>>>
>>> Do you mean doing sync THP split for most of page zapping functions
>>> (but only if that makes things simpler)?
>>>
>>
>> Yes -- if there are no downsides.
>>
> 
> I will try. At the moment the assumption of "Not null zap_details
> implies leave swap entries" is giving me a headache.

Not only you, did you stumble over

https://lkml.kernel.org/r/20211115134951.85286-1-peterx@redhat.com

already?

-- 
Thanks,

David / dhildenb

