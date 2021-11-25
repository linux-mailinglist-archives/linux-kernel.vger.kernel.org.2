Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17EB45D84F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354644AbhKYKhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:37:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229938AbhKYKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637836332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2830KMnShyNuf2bxSXiCKSiHB3AQr1k1blCmoANtdQ=;
        b=PbTVDFnKaghO2eP0CtGdYQ7l77YQOnn+CF/s/D7M1aI7Nxcxa3L6N36iRFQp1FNwdFM/SJ
        E6uXlsQWNNvZvJdfsM5zcVRiWCgV9FtM0Lw4TOP7BX5Pqx9K8Pl5GIKZyrUCTLBJBpxZa4
        V+lUPqZGJfs2VXyge3/Kq+xXb0yksyk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-kBu5fppMPRa-pghi3mW62w-1; Thu, 25 Nov 2021 05:32:11 -0500
X-MC-Unique: kBu5fppMPRa-pghi3mW62w-1
Received: by mail-wm1-f72.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso4737578wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 02:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=R2830KMnShyNuf2bxSXiCKSiHB3AQr1k1blCmoANtdQ=;
        b=C0Efw4twpzlOcMN3XhO9ukGAFLrC++7HeYrLZ48PShwn57kVVpjKzBWDvTv12hWQUC
         vlWYEjAQXoXa/GoablM6SxGyGUMDhYmqnM6bff2Ld8iL6PYqxlFXGibjjH9vfkkUDjAw
         CO6fvSgwilvFpKHWio8ia33bQEzHbhEpfrzKS6ozQvdR/NfngsAWTK8S29aw2me1u3/q
         b42CJhWKT65ziGMf6ZMj4xhraCB/51/WaRQGBIXszsytLWPtd5awOnrLnMwoqC2njnbh
         Q7j5sXfK+K5tUfsk+ZR9rWzTlFSBTcXPwmmz3ivjfHhdpERuwWCCgRTswZ5y15lGzz18
         NPhQ==
X-Gm-Message-State: AOAM533qB8qGXcrRmAoDTYKWCEtj1G8i3ud0OtR+WUA0DjB7aJpK+tmW
        BhTxAEmPJyG0uvrW7LT9Yq94AVdeWukZVj5+VYXp79BskyIRZMOLlRdu3tKw1lX3reYTldkSTzy
        okjjEKFC19SG+IjSskH+d7qZW
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr5732446wmg.181.1637836330048;
        Thu, 25 Nov 2021 02:32:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7t63uIqqTxzhaKcTf1lT56VtFnAZirrfQW8WEA3StqKFm5yksQdgS/b+gYiHyev/uaIx4vw==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr5732419wmg.181.1637836329864;
        Thu, 25 Nov 2021 02:32:09 -0800 (PST)
Received: from [192.168.3.132] (p5b0c679e.dip0.t-ipconnect.de. [91.12.103.158])
        by smtp.gmail.com with ESMTPSA id n13sm2528641wrt.44.2021.11.25.02.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 02:32:09 -0800 (PST)
Message-ID: <57d649c8-fe13-17cd-8819-2cd93500a79c@redhat.com>
Date:   Thu, 25 Nov 2021 11:32:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Shakeel Butt <shakeelb@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211120201230.920082-1-shakeelb@google.com>
 <25b36a5c-5bbd-5423-0c67-05cd6c1432a7@redhat.com>
 <CALvZod5L1C1DV_DVs9O3xZm6CJnriunAoj89YLDdCp7ef5yBxA@mail.gmail.com>
 <YZ9kUD5AG6inbUEg@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: split thp synchronously on MADV_DONTNEED
In-Reply-To: <YZ9kUD5AG6inbUEg@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.21 11:24, Peter Xu wrote:
> On Mon, Nov 22, 2021 at 10:40:54AM -0800, Shakeel Butt wrote:
>>> Do we have a performance evaluation how much overhead is added e.g., for
>>> a single 4k MADV_DONTNEED call on a THP or on a MADV_DONTNEED call that
>>> covers the whole THP?
>>
>> I did a simple benchmark of madvise(MADV_DONTNEED) on 10000 THPs on
>> x86 for both settings you suggested. I don't see any statistically
>> significant difference with and without the patch. Let me know if you
>> want me to try something else.
> 
> I'm a bit surprised that sync split thp didn't bring any extra overhead.
> 
> "unmap whole thp" is understandable from that pov, because afaict that won't
> even trigger any thp split anyway even delayed, if this is the simplest case
> that only this process mapped this thp, and it mapped once.
> 
> For "unmap 4k upon thp" IIUC that's the worst case and zapping 4k should be
> fast; while what I don't understand since thp split requires all hand-made work
> for copying thp flags into small pages and so on, so I thought there should at
> least be some overhead measured.  Shakeel, could there be something overlooked
> in the test, or maybe it's me that overlooked?
> 
> I had the same concern as what Kirill/Matthew raised in the other thread - I'm
> worried proactively splitting simply because any 4k page is zapped might
> quickly free up 2m thps in the system and I'm not sure whether it'll exaggerate
> the defragmentation of the system memory in general.  I'm also not sure whether
> that's ideal for some very common workload that frequently uses DONTNEED to
> proactively drop some pages.

The pageblock corresponding to the THP is movable. So (unless we start
spilling unmovable allocations into movable pageblocks) we'd only place
movable allocations in there. Compaction will be able to migrate to
re-create a free THP.

In contrast I think, compaction will happily skip over the THP and
ignore it, because it has no clue that the THP could be repurposed by
split+migrate (at least I am not aware of code that does it).

Unless I am missing something, with the above in mind it could make
sense to split as soon as possible, even before we're under memory
pressure -- for example, for proactive compaction.

[proactive compaction could try splitting first as well I think]

-- 
Thanks,

David / dhildenb

