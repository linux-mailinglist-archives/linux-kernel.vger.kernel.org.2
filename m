Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D853FFB24
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347928AbhICHcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234372AbhICHcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630654292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyKqSxHAqtRgLuja3A5/OxlFAavADXVdY5DxybXyPgA=;
        b=RopVhT+/+ox1WdvVC8aKiZV5EXDqVwVhJpX7BgWYJ2MtONotvbMmtFZzn/OttXu8Yasioz
        22Pwx6+shqyzg67lv9TVICdsHssX64WU4tXuo8WTVixL7c6BKGtjHoOW010Q8u9atzxbvR
        CTM6AmMXABTUgO/XGe6ummZaRQVn4k8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-r3kBrIQdP1q1hxH3sp-O2w-1; Fri, 03 Sep 2021 03:31:31 -0400
X-MC-Unique: r3kBrIQdP1q1hxH3sp-O2w-1
Received: by mail-wr1-f70.google.com with SMTP id z15-20020adff74f000000b001577d70c98dso1278912wrp.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 00:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LyKqSxHAqtRgLuja3A5/OxlFAavADXVdY5DxybXyPgA=;
        b=LaEERz1CC8Y1PcbS0PzrqhnFp25Uh/LOw+bZTKCmkr9cP119IzN62adwwB30pw/oya
         TxU5ba/8ZWSrM1iJrkCDL1XdB7S56sEqUN0pALoPM3FVOIWgmLZsp72LknUuRQQFHhnj
         ojGzDBvJNF3urTWUX3wmSKDFI7mUc5MxnV4FxG+moGwndU1ezv5gTzZzQCK7JH+6LQJB
         rJ2iZoRUTiAaidyNdD6bWjC1bg8Vlg094oKtpdUqayjFw3aSlUgAdrqb39T8LLLwwVPB
         abq8eYZTBsoF+AHTiGO1ckrcqp1JWmJ5KTUcvJFVUffa4q4fzWg7Z+L/Ax5EX+fBqjw6
         7VSQ==
X-Gm-Message-State: AOAM5301YPZ1e8iV6RZOO7sZy5/DsWiaPvvFYK6qQMHXJNidDR1qDTcw
        TJm9J4jt1RALwkwsqpTlSN7YCvqw3L7/2u8MA4RMFGKvpfpMmX1JSQC+tNm9DZTFxEPiSvnVEl0
        vpldWIbQPXAz6jdCIl02TOsTV
X-Received: by 2002:a1c:2313:: with SMTP id j19mr7013307wmj.189.1630654290026;
        Fri, 03 Sep 2021 00:31:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTi0va8xvkYtxRvasQVBbPjwSjjUJEqirBs9Ca3dzZ1Z6zv7lNuRLRQQbxW8esF8g5T0TMiA==
X-Received: by 2002:a1c:2313:: with SMTP id j19mr7013298wmj.189.1630654289874;
        Fri, 03 Sep 2021 00:31:29 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e05.dip0.t-ipconnect.de. [79.242.62.5])
        by smtp.gmail.com with ESMTPSA id z6sm3583891wmp.1.2021.09.03.00.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 00:31:29 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] mm: Add ZAP_FLAG_SKIP_SWAP and zap_flags
From:   David Hildenbrand <david@redhat.com>
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210902201721.52796-1-peterx@redhat.com>
 <20210902201836.53605-1-peterx@redhat.com>
 <ecd7c89e-da54-d08c-5085-88c2ee8cdfaf@redhat.com>
Organization: Red Hat
Message-ID: <86536aa5-8e9a-64ec-1bee-c47ee24fc683@redhat.com>
Date:   Fri, 3 Sep 2021 09:31:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ecd7c89e-da54-d08c-5085-88c2ee8cdfaf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -3377,7 +3377,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>>    		pgoff_t nr, bool even_cows)
>>    {
>>    	pgoff_t	first_index = start, last_index = start + nr - 1;
>> -	struct zap_details details = { };
>> +	struct zap_details details = { .zap_flags = ZAP_FLAG_SKIP_SWAP };
>>    
>>    	details.zap_mapping = even_cows ? NULL : mapping;
>>    	if (last_index < first_index)
>>
> 
> I think what would really help is to add a high-level description what
> unmap_mapping_page() vs. unmap_mapping_pages() really does, and what the
> expectations/use cases are. The names are just way too similar ...

aaaaand staring only at this patch I missed that we have nice 
descriptions already :)
-- 
Thanks,

David / dhildenb

