Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCEE361B99
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbhDPIcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54213 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhDPIca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618561925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PnvDMIypdcGLNbXmi4rAPqjfFVmEXq6bGxFDBf16NtQ=;
        b=a39YY3oaiz7raklx/6I/DMr7ImdZPzmsDVFo3AHS5lTnxtGVPoRXjJw5hBeUyW7rSiBRVd
        Kly4qBKdL1bEmEDPPbGrCmvfBeC36e/Y9/i8fcE5ZZERhy2kiK9zvrcj0YCVlWeNRWGPJg
        nbnlR3KY51XApmGehF7aPZSFWx4bGx0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-MvN8-R6xPyCPdPaWJwslJg-1; Fri, 16 Apr 2021 04:32:03 -0400
X-MC-Unique: MvN8-R6xPyCPdPaWJwslJg-1
Received: by mail-ed1-f70.google.com with SMTP id bm19-20020a0564020b13b02903789d6e74b5so6568182edb.21
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PnvDMIypdcGLNbXmi4rAPqjfFVmEXq6bGxFDBf16NtQ=;
        b=DnnqphiLqjtNFJWWI8YWfivQ3MpqYtUxZSJ5rDXVNXhAe9VvDCgb0i1sNFpsXinpY6
         CW9sf3wxufh4K+E7fDshqtFnxstxyTj2xDBz8CJx7kjA86YZO3JsplEu8gVAeGOxgOgp
         rSS2Km6TP56ZngMR4VA1IOaHhFTLlmkzynMFrNa/+4bQFaHZbcNyAw5fcBj/Er5Lk0uC
         lJ6pXKU/RhFH8osbxTkKbDnYm5dDqo98D2eHEZOV4vZz4v2rixpOdaKP2EsNFG4jQqv5
         80PliSAE1UwmHYEybwMHiqv3zh5dpU/t5PzDLUAYriVbzIlC8l9PYG2jvQgB7LrzbMsm
         cgBg==
X-Gm-Message-State: AOAM532L1ryBbNA0Xh6Figsu92JzmI9nymL3ffiA0TN2wNA56WPiL5AZ
        xQXaEeZhcKBwlWivM1WdxTWLiF5DQxZZEX0VLIE+wUD7Po8Orbuxv5+ZH78GtZ3c3Yz7NOdps5s
        LDB7wAkCkhmQWH+kqgi3lkUZwi6RP8p7RgkLcuRFO+g+w3HLdrlkNgOQCqn0E6+8w644mWtLJ
X-Received: by 2002:a17:906:4112:: with SMTP id j18mr7149239ejk.171.1618561922779;
        Fri, 16 Apr 2021 01:32:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbCEbHQ25q3nrM4jI9jnOBm6c3k/sea4Ew+V1cPdL0HilM1GqRLImZhT+YkjAYJzZb6U7aaQ==
X-Received: by 2002:a17:906:4112:: with SMTP id j18mr7149220ejk.171.1618561922542;
        Fri, 16 Apr 2021 01:32:02 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fb.dip0.t-ipconnect.de. [91.12.100.251])
        by smtp.gmail.com with ESMTPSA id s5sm3730829ejq.52.2021.04.16.01.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:32:02 -0700 (PDT)
Subject: Re: [PATCH v7 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210408121804.10440-1-osalvador@suse.de>
 <20210408121804.10440-5-osalvador@suse.de>
 <54bed4d3-631f-7d30-aa2c-f8dd2f2c6804@redhat.com>
 <YHk8BCKwpKY0TM6p@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <de248f48-e45f-7318-a9b6-569bb6b2e736@redhat.com>
Date:   Fri, 16 Apr 2021 10:32:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHk8BCKwpKY0TM6p@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.21 09:25, Oscar Salvador wrote:
> On Thu, Apr 15, 2021 at 01:19:59PM +0200, David Hildenbrand wrote:
>>> Implementation wise we will reuse vmem_altmap infrastructure to override
>>> the default allocator used by __populate_section_memmap.
>>> Part of the implementation also relies on memory_block structure gaining
>>> a new field which specifies the number of vmemmap_pages at the beginning.
>>> This patch also introduces the following functions:
>>>
>>>    - vmemmap_init_space: Initializes vmemmap pages by calling move_pfn_range_to_zone(),
>>> 		       calls kasan_add_zero_shadow() or the vmemmap range and marks
>>> 		       online as many sections as vmemmap pages fully span.
>>>    - vmemmap_adjust_pages: Accounts/substract vmemmap_pages to node and zone
>>> 			 present_pages
>>>    - vmemmap_deinit_space: Undoes what vmemmap_init_space does.
>>>
>>
>> This is a bit asynchronous; and the function names are not really expressing what is being done :) I'll try to come up with better names below.
> 
> Yeah, was not happy either with the names but at that time I could not
> come up with anything better.
> 
>> It is worth mentioning that the real "mess" is that we want offline_pages() to properly handle zone->present_pages going to 0. Therefore, we want to manually mess with the present page count.
> 
> This should be explained by this:
> 
> "On offline, memory_block_offline() calls vmemmap_adjust_pages() prior to calling
> offline_pages(), because offline_pages() performs the tearing-down of kthreads
> and the rebuilding of the zonelists if the node/zone become empty."
> 
> Is not that clear?

Ehm, it is; for some reason my eyes ignored it -- sorry.

-- 
Thanks,

David / dhildenb

