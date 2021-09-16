Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AEB40D482
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhIPIbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234108AbhIPIbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631781025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfBVqsgDph978vd7uxoPuxcND045kBmQjEMf3xFIUro=;
        b=Hqh9G2tjiK5fJY1zInzKSExzTZSP18qecqsi8XPy9OVgnuRpBDJl6CpzUvnwjTtOlYzJzO
        a/V+amQxAs7G6+DunzQVnxI6h/oq+Rn1Be8+Lc0xbr67AD8pJ6eB6wLeQe3Qdnh/CR2r+O
        wSZ5v6G9wFderyC6eb1YXNpWwfLWpdo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-N8JIyq57O4W0sOf917PFFQ-1; Thu, 16 Sep 2021 04:30:23 -0400
X-MC-Unique: N8JIyq57O4W0sOf917PFFQ-1
Received: by mail-wr1-f70.google.com with SMTP id r5-20020adfb1c5000000b0015cddb7216fso2131932wra.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QfBVqsgDph978vd7uxoPuxcND045kBmQjEMf3xFIUro=;
        b=IFGNPweRXWpKAp+tOoUgDF2aeSbD9ddx2FkTGTrU7vWDdcv2eDgVbESbGW3G9fCsLW
         kSFX7uv9J6DMQqQM2PQX8Tzqk1BCOcDdPgjI0HNcOZjH8I2kVkKJPfFmbj6X24U9w0Sw
         fgBQYtY1JBISKb51WTcIl7JwbP1tSHjn1IM/V6j1GzVQBEgFWdJBW2p5ghF2ZLAJ5B5E
         VUqWyvPPp40DVwEE/okVEz83HSlVLhTr8b5jtQUm9Yv/71jzOZBirPPTtNVuTgaV5sCR
         ntXsU6OgOjjyE4uFNeFJWU/SolVFZLvH4/4bHcA9YqAm2ohw0TN9KrszHfY8eDpIvvA7
         xbyA==
X-Gm-Message-State: AOAM531z4ocFv1SoHxRvOFsVkRxQrBYoWNdVSZUiHXjBSTOYUDLOVrlR
        5qz8Y3JQvKYct89plxe1TNZDPCig48eiyadnREpg+K6zzUTrBPiLzz3rQEpRW/Or/hHozJIYSxz
        cDywi3/w8zqfYENTt4ryQBJX1
X-Received: by 2002:a1c:9dd2:: with SMTP id g201mr8610174wme.46.1631781022658;
        Thu, 16 Sep 2021 01:30:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE2zWRN4h3CiVwdhdjW3gid/lPl3CkT/IUtUfZzt6UDdN+RX5Qu2Z8r2/NQNcCglaP/qdLPA==
X-Received: by 2002:a1c:9dd2:: with SMTP id g201mr8610146wme.46.1631781022459;
        Thu, 16 Sep 2021 01:30:22 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23828.dip0.t-ipconnect.de. [79.242.56.40])
        by smtp.gmail.com with ESMTPSA id s10sm2533403wrg.42.2021.09.16.01.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 01:30:22 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] Free user PTE page table pages
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <5b9348fc-95fe-5be2-e9df-7c906e0c9b81@redhat.com>
 <41ceeec1-52c4-4e99-201c-e1e05b2afbbc@bytedance.com>
 <20210915145933.GH3544071@ziepe.ca>
 <d33a4349-a228-f98a-ab14-e221bf80dd4a@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <b7514329-7ae4-b78e-a4f1-4208c9cfe802@redhat.com>
Date:   Thu, 16 Sep 2021 10:30:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d33a4349-a228-f98a-ab14-e221bf80dd4a@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.21 07:32, Qi Zheng wrote:
> 
> 
> On 9/15/21 10:59 PM, Jason Gunthorpe wrote:
>> On Wed, Sep 15, 2021 at 10:52:40PM +0800, Qi Zheng wrote:
>>> I am going to split this patch series as follows:
>>>
>>> 1. Introduce the new dummy APIs, which is an empty implementation.
>>>      But I will explain its semantics.
>>> 2. Merge #6, #7 and #8, and call these dummy APIs in any necessary
>>>      location, and split some special cases into single patches, such as
>>>      pagefault and gup, etc. So that we can explain in more detail the
>>>      concurrency in these cases. For example, we don't need to hold any
>>>      pte_refcount in the fast path in gup on the x86_64 platform. Because
>>>      the PTE page can't be freed after the local CPU interrupt is closed
>>>      in the fast path in gup.
>>> 3. Introduce CONFIG_FREE_USER_PTE and implement these empty dummy APIs.
>>> 4. Add a description document.
>>>
>>> And I try to add a function that combines pte_offset_map() and
>>> pte_try_get(). Maybe the func name is pte_try_map() recommended by
>>> Jason, or keep the pte_offset_map() unchanged?
>>
>> It is part of the transformation, add a
>> pte_try_map()/pte_undo_try_map() and replace all the pte_offset_map()
>> callsites that can use the new API with it. The idea was that try_map
>> would incorporate the pmd_trans_unstable/etc mess so searching for
>> trans_unstable is a good place to start finding candidates. Some are
>> simple, some are tricky.
> 
> Yes, I will search pte_offset_map()/pmd_trans_unstable/etc, and then
> analyze the specific situation.

Maybe propose the new API first, before doing the actual implementation. 
Might safe you from doing some additional back-and-forth
work eventually.


-- 
Thanks,

David / dhildenb

