Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA09361E42
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbhDPKwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 06:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238871AbhDPKwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 06:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618570295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YsdE4aBtRF6OaepSn/JlqHBTIWYEbbsIvfRH1G5zP4Y=;
        b=XdhWJ1XLYw0sfvNUZpbwjLwQN6nTX6LfU2qjkqTkOmMkLhqNKHry5r8guM/TLkMDBpCd1q
        S5x9XXxqoKBR26caJfU30nfyZPesddxPqmBLzkLdNjR1gLBJTMLwMzN4dn0HJTApKhJf7W
        NxU8smRIspKkjNaZO1TTE+YSpBQRi0Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-zQbD8RHyOBqXFFdalTLyjw-1; Fri, 16 Apr 2021 06:51:33 -0400
X-MC-Unique: zQbD8RHyOBqXFFdalTLyjw-1
Received: by mail-wm1-f70.google.com with SMTP id o18-20020a05600c3792b0290128219cbc7bso3610983wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 03:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YsdE4aBtRF6OaepSn/JlqHBTIWYEbbsIvfRH1G5zP4Y=;
        b=DSZArgECZQMTG4WPGRy96VBIuIt6tdsPkGmJeRfkbVMixEturQLHkJT9UC3yEUmQFa
         oyWPsXwJuKEJBwUPcCMyO9kY2h91HeQ1NWK9K63KulowPpXnFCUCteEdQw5X8sTBQNDr
         A/EsPKTuDmkOJQhCA6BShFQ76icAlllQUj105UUrH6kOJQAczJmuPInx8owzl6HISD/0
         elK6W2K6g1ivBKtay65H+TuTwmrl0tCxvp2JiUIISiD/R/nSsmTG23lGeqfqgkygAJaG
         PBzVROt6aHodDr9ZeHQSUv8NAT2rxJBEkIumliL2K7/CI0EjxkH6FMc2rn4DMmcS52qV
         Qjzw==
X-Gm-Message-State: AOAM533cR++jLeRCua7CxrFF/I9cCVjFXHeVfmOKei0Ltv+JDsKmtP3K
        UfHhyVT5EOUIOryVTarYkl9o0yCoVtP2Odp8vKwd/4yRw5FaDPkIUCdSMAfkXWpwYl1eqsScMHg
        A9ACrTfKaY+udBZAHPg5VRRd9xtU52vTlbyhVBqGTAHrK8V8h+h/Yi7XNNwJjBqOgFWdjENkL
X-Received: by 2002:adf:dc4f:: with SMTP id m15mr8484665wrj.420.1618570292730;
        Fri, 16 Apr 2021 03:51:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweF/6BcjMRZE8+gjAGS6HVlKLvC2tz4xd9osECg0GaLRPFAxwNzekTuVXgjgZKk1cIJyk1Gg==
X-Received: by 2002:adf:dc4f:: with SMTP id m15mr8484640wrj.420.1618570292560;
        Fri, 16 Apr 2021 03:51:32 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fb.dip0.t-ipconnect.de. [91.12.100.251])
        by smtp.gmail.com with ESMTPSA id u9sm8361069wmc.38.2021.04.16.03.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 03:51:32 -0700 (PDT)
Subject: Re: [PATCH v8 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210416102153.8794-1-osalvador@suse.de>
 <20210416102153.8794-5-osalvador@suse.de>
 <df8220ac-4214-5ff6-0048-35553fea8c8c@redhat.com>
 <YHlpAvTPuRZtKo0i@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6e659d5b-c3f1-bd72-a3af-235d6bc55b0b@redhat.com>
Date:   Fri, 16 Apr 2021 12:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHlpAvTPuRZtKo0i@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.21 12:37, Oscar Salvador wrote:
> On Fri, Apr 16, 2021 at 12:33:34PM +0200, David Hildenbrand wrote:
>> IIRC, we have to add the zero shadow first, before touching the memory. This
>> is also what mm/memremap.c does.
>>
>> In mhp_deinit_memmap_on_memory(), you already remove in the proper
>> (reversed) order :)
> 
> But looking at online_pages(), we do it after the
> move_pfn_range_to_zone(), right? AFAIK (I might be well wrong here),
> memory_notify() will eventually call kasan_add_zero_shadow? So that
> comes after the move_pfn_range_to_zone? Or is my understanding
> incorrect?

The thing is: move_pfn_range_to_zone() in case of ordinary 
online_pages() won't touch the pages but only the memmap. The memmap has 
a proper kasan shadow already. Pages won't be touched before exposing 
them to the page allocator via generic_online_pages().

This is different in this case :)

-- 
Thanks,

David / dhildenb

