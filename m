Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334E740192F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 11:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241465AbhIFJr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 05:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241358AbhIFJr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 05:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630921613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5PtHHIZDp8gAWvUlkCms1Gx7x4SSQagx1CFC8z46SQ=;
        b=Zqty5OwxVbP1xAlBz3barh/iawJC7Uylg5yf5lKrsXA0LYr9HftdwTGROmf6jIazRTvCxi
        MXZxpMDAw+wpJQL7J1zrxjBvjQB+b7VLqvfmFYLqIXXY0DqrKMDYD0QYD599AIBs6/lAZ4
        +ZjYJ5dAQ+FD1Dc/P6iFqZx6rFkXKJc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-JyI7cYP-PDmoRClwnSWmQA-1; Mon, 06 Sep 2021 05:46:52 -0400
X-MC-Unique: JyI7cYP-PDmoRClwnSWmQA-1
Received: by mail-wm1-f71.google.com with SMTP id p11-20020a05600c204b00b002f05aff1663so3029910wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 02:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/5PtHHIZDp8gAWvUlkCms1Gx7x4SSQagx1CFC8z46SQ=;
        b=bN+hK8JKYMWX1iQVCv7I+9ihiqt+ZpRBFXPZVAjhxhtLxHqp0Ok97DQycSebzvakIA
         z/y3c3gKF2k3mBtTb/OLb7y9UbaGchzQ0+ZiBGjG6pXia2uq6xkuUkOwP6mPQWgrfA5h
         A2EP7lREdwRsJNfAGtiCd8xpkMxeHTOOlt+oDd9atvMsIE0ScCbjzdxM2nPMTyWH914s
         NQyRR6ghq33125UZjzRTgmeGT1/auyg7nG9Fr8gXGuIba1+jN4a44ZdUqUKtdNxFIQ96
         tQeuvzg0KfQ1YUJzfqygkDxwb9YsnPu9yh3SmJN/anlGE7M2mY1TVcvTaKWM86xfPfKz
         gw6w==
X-Gm-Message-State: AOAM531pbIdeI2y8TPdeKv4DsmBpUuZl9e1eFyLWIf05BRX/Zy5P9k+P
        tT6C3Xcaw6cyzlw2WxspgB6gvVUwI5lyjN0zHVUrtk4ilEi1MrKkoe0Ucy2KF7eHVXoJ7qXfMaf
        FN4ePuXovKH/bR9BN4CM3nElxWYERScBZX+O09x1Ui5n1aR2hM3cesVh0rTnboJTRr3U5MqKS
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr10406976wmj.169.1630921610918;
        Mon, 06 Sep 2021 02:46:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXS8yCWHtLRpU75iEnxvwJNw91CV8ByCD0LRmJTGiky9SdAVEEtluv2gYbDJU33Fj6vuzfBg==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr10406952wmj.169.1630921610640;
        Mon, 06 Sep 2021 02:46:50 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6323.dip0.t-ipconnect.de. [91.12.99.35])
        by smtp.gmail.com with ESMTPSA id t14sm6615395wmi.12.2021.09.06.02.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 02:46:50 -0700 (PDT)
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210904092053.33037-1-linmiaohe@huawei.com>
 <dcfcacf2-0018-3b91-6da5-2420bad889c1@redhat.com>
 <ebbef13c-921e-c385-1233-a7aeecec6127@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
Message-ID: <ec7fd827-55c8-120f-4c68-ec0076797d36@redhat.com>
Date:   Mon, 6 Sep 2021 11:46:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ebbef13c-921e-c385-1233-a7aeecec6127@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.21 11:38, Miaohe Lin wrote:
> On 2021/9/6 17:27, David Hildenbrand wrote:
>> On 04.09.21 11:20, Miaohe Lin wrote:
>>> In start_isolate_page_range() undo path, pfn_to_online_page() just checks
>>> the first pfn in a pageblock while __first_valid_page() will traverse the
>>> pageblock until the first online pfn is found. So we may miss the call to
>>> unset_migratetype_isolate() in undo path and pages will remain isolated
>>> unexpectedly. Fix this by calling undo_isolate_page_range() and this will
>>> also help to remove some duplicated codes.
>>>
>>> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
>>
>> While that is true, we shouldn't ever trigger, neither via cma, virtio-mem nor memory offlining, because essentially all operate on MAX_ORDER -1 -aligned ranges without memory holes.
> 
> I think this should never trigger too. It's a theoretical issue. So is the Fixes tag necessary ?
> 

I think it's one of these "let's add Fixes: but no need for Cc: stable".

BUT in older kernels we could have triggered this via memory offlining 
eventually ... before c5e79ef561b0 ("mm/memory_hotplug.c: don't allow to 
online/offline memory blocks with holes") ... so maybe even a Cc: stable?

-- 
Thanks,

David / dhildenb

