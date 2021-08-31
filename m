Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D513FC9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbhHaOYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230135AbhHaOYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630419791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=urLJX4mD4+0+z3Cmi5p6BeY5jBhCGBwwOY1UjB3PyvE=;
        b=K/7ZzMkTwmaXgcEp/T0Ftk6oZEvqpSkwV5iLJlXsTv3VqYUNcfeZUxKcIs7Icl8EDn1KXz
        9EkRArD8kSESS4X1lasmO7mTHWWIlHMGozQa4rlCcdIy/IVFd/ZjYVCZug2hkXuxB++qH0
        8dZ56oy+QDaWW9q8E1QxcwISEeOqRB0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-BgeHJxzjP46FUKtaw9iDUQ-1; Tue, 31 Aug 2021 10:23:10 -0400
X-MC-Unique: BgeHJxzjP46FUKtaw9iDUQ-1
Received: by mail-wm1-f72.google.com with SMTP id c4-20020a1c9a04000000b002e864b7edd1so6040084wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=urLJX4mD4+0+z3Cmi5p6BeY5jBhCGBwwOY1UjB3PyvE=;
        b=c+ciXN0HL0Y1MPqnl+SuFYKYvoa0Ho6hdwS7sCWAjyxbUPntsA6XeSRLIzMlEZKItU
         1TY6mhjAbyHdkU12CXWrcFf68iFhGtSYH1A5NthdjxVwthn7ug0ytCR+aEyEPc/nfp9K
         Je/QAS9NB2KAWyloW/v+aunlMYBwRdQP06bhfCVt5F2JqtzC1CxVlVmuV8zzHnpWj/Ut
         lE/IeGmitjdIiDjwCChAGNORyHoXl1YpAqJXRARWW3MjllsfyzLsZMVbz8g7EizYToXM
         TdY8Hn+D8ams7rjChl8SXpvttXT1uegwXapHvQa9yOCGlon8QjgodFMlO2uC+hgK/4Fj
         QreA==
X-Gm-Message-State: AOAM530R/pYjDjFPyrQc+EA9lrf5AnAb0RPZ5YgCkOIKZGR5LoHkc+dO
        zdKgIC0HBhxSHIb3IsVkvTbgGoMd9+0oqCj2mYEuF/j71YWlyKeG9jBMej9p18pB3AXJvbAQsrY
        hywmbKzdi7nWCLz3w95nl5Y37ClHKr+4T0uOjf69YhhJ4T2WjCy/Scod2Fxt23GuRt9gia22Z
X-Received: by 2002:a1c:f712:: with SMTP id v18mr4475229wmh.25.1630419789324;
        Tue, 31 Aug 2021 07:23:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2oxz4h5PTJEcybV9HdfEeThpSVgOxrmM77fxTd1EzWzzl5aFc4X49pdQOHATL0hmWjMfzZA==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr4475189wmh.25.1630419789029;
        Tue, 31 Aug 2021 07:23:09 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bf5.dip0.t-ipconnect.de. [79.242.59.245])
        by smtp.gmail.com with ESMTPSA id d145sm2560524wmd.3.2021.08.31.07.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 07:23:08 -0700 (PDT)
To:     Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, sfr@canb.auug.org.au,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-6-linmiaohe@huawei.com>
 <20210831134311.GG4128@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 5/6] mm/page_alloc.c: avoid accessing uninitialized pcp
 page migratetype
Message-ID: <877b7043-65c3-5e08-ac89-ad6f10e354b3@redhat.com>
Date:   Tue, 31 Aug 2021 16:23:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210831134311.GG4128@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.08.21 15:43, Mel Gorman wrote:
> On Mon, Aug 30, 2021 at 10:10:50PM +0800, Miaohe Lin wrote:
>> If it's not prepared to free unref page, the pcp page migratetype is
>> unset. Thus We will get rubbish from get_pcppage_migratetype() and
>> might list_del &page->lru again after it's already deleted from the
>> list leading to grumble about data corruption.
>>
>> Fixes: 3dcbe270d8ec ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 
> This fix is fairly important. Take this patch out and send it on its own
> so it gets picked up relatively quickly. It does not belong in a series
> that is mostly cosmetic cleanups.

I think the commit id is wrong. Shouldn't that be

df1acc856923 ("mm/page_alloc: avoid conflating IRQs disabled with 
zone->lock")

?

-- 
Thanks,

David / dhildenb

