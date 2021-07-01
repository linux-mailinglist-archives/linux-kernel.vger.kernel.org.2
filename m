Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5983B9489
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhGAQO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 12:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229664AbhGAQOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 12:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625155944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mIwe8Khs6FhWLrrM+H0LAuvLzKUWvJp+a9XY7xKa/s4=;
        b=EaJoCwNX1ZClLivBsrEYxnv3fiVVEeU+F3Q2zCLeEolwWfLSwuP9XeGjDWfk5Sv9Fv29d1
        DCEMJydsBJWQxAE4eyh/8AmLN25/F04t/4d3+PtEG4y1503GSV0fZ/qNapyOFoxJd/l1o1
        tsHz0PiteF8YX5vh1SJAu+lmwo6N12k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-gA3Md5N7PEWyt60qHiwAfQ-1; Thu, 01 Jul 2021 12:12:23 -0400
X-MC-Unique: gA3Md5N7PEWyt60qHiwAfQ-1
Received: by mail-wm1-f72.google.com with SMTP id i7-20020a05600c3547b02901eaa4d778adso1326495wmq.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 09:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mIwe8Khs6FhWLrrM+H0LAuvLzKUWvJp+a9XY7xKa/s4=;
        b=PUhs8BoIES5I7rz+vwcOpwO7QBRNP1tySVVrIecwSNO2mYhWA4aoOPnn4MRvNOk9EP
         P9RLtggKtZkvATQCp8Bb+3gSSFwiszG/kunUqsUJa5+cn+T7pcULgtPp5WhkJw5GshEv
         F4+NXAD5BcsS9gXtX+smQ51MtY9SWYtHzcCf+7c13BKGEiZDBOGg5RqgR9xm0gnbz0M8
         /VMcTh4Vco5iOyxmyGHnR6KZG2E5i4me7HXVKNMlWG0C1HHlKvthpDipOPv0BAO11+3n
         lddu35GMdSwDtXVW1Kq/eokAybrSlss+H15SX8WW6nAAR+KS3YnH3QNTAdmjRtKVxZBU
         SgcA==
X-Gm-Message-State: AOAM533Dtj3qOYER/USHOaqvGlWU4YA04dFMoM5PYaehAGkQCzF9++GP
        PQt6lADsQJl5gtNaAnQ193cXnLlF+sB9O3sprNLVhcZZbDdp2tHSxDftWwOxxvUzB5qjfbYhi13
        Xc4Koe9VO+VGYdzXLHKotEmL+sqbUnaFSVTbfZajDZ4vwpdrRIq103uDFj6l5VfIGGsTBRjd5
X-Received: by 2002:a1c:1dc6:: with SMTP id d189mr518851wmd.154.1625155942115;
        Thu, 01 Jul 2021 09:12:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5doBWvbxn6E0Y/3q0E5KMQ8lbD0rK3+Z1+HQhaiE5s59/TRHqjn+Y7JyfQoBTQCqbd/4ABw==
X-Received: by 2002:a1c:1dc6:: with SMTP id d189mr518818wmd.154.1625155941829;
        Thu, 01 Jul 2021 09:12:21 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bca.dip0.t-ipconnect.de. [79.242.59.202])
        by smtp.gmail.com with ESMTPSA id w13sm454230wrl.47.2021.07.01.09.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 09:12:21 -0700 (PDT)
Subject: Re: [PATCH] mm: sparse: pass section_nr to section_mark_present
To:     ohoono.kwon@samsung.com,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c5f8e6ae-9d2c-24a6-c21a-6c6c83912b35@redhat.com>
 <20210701135543epcms1p84a043bf49757bafada0a773372611d69@epcms1p8>
 <CGME20210701135543epcms1p84a043bf49757bafada0a773372611d69@epcms1p4>
 <20210701154146epcms1p4398db5708796ae291b09db29240e5ed1@epcms1p4>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <4550295f-0358-9c41-5655-7274f89f6c0a@redhat.com>
Date:   Thu, 1 Jul 2021 18:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701154146epcms1p4398db5708796ae291b09db29240e5ed1@epcms1p4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.07.21 17:41, 권오훈 wrote:
> On Thu, Jul 01, 2021 at 04:34:13PM +0200, David Hildenbrand wrote:
>> On 01.07.21 15:55, 권오훈 wrote:
>>> With CONFIG_SPARSEMEM_EXTREME enabled, __section_nr() which converts
>>> mem_section to section_nr could be costly since it iterates all
>>> sections to check if the given mem_section is in its range.
>>   
>> It actually iterates all section roots.
>>   
>>>
>>> On the other hand, __nr_to_section which converts section_nr to
>>> mem_section can be done in O(1).
>>>
>>> Let's pass section_nr instead of mem_section ptr to section_mark_present
>>> in order to reduce needless iterations.
>>   
>> I'd expect this to be mostly noise, especially as we iterate section
>> roots and for most (smallish) machines we might just work on the lowest
>> section roots only.
>>   
>> Can you actually observe an improvement regarding boot times?
>>   
>> Anyhow, looks straight forward to me, although we might just reintroduce
>> similar patterns again easily if it's really just noise (see
>> find_memory_block() as used by). And it might allow for a nice cleanup
>> (see below).
>>   
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>   
>>   
>> Can you send 1) a patch to convert find_memory_block() as well and 2) a
>> patch to rip out __section_nr() completely?
>>   
>>>
>>> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
>>> ---
>>>    mm/sparse.c | 9 +++++----
>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>> index 55c18aff3e42..4a2700e9a65f 100644
>>> --- a/mm/sparse.c
>>> +++ b/mm/sparse.c
>>> @@ -186,13 +186,14 @@ void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
>>>     * those loops early.
>>>     */
>>>    unsigned long __highest_present_section_nr;
>>> -static void section_mark_present(struct mem_section *ms)
>>> +static void section_mark_present(unsigned long section_nr)
>>>    {
>>> -        unsigned long section_nr = __section_nr(ms);
>>> +        struct mem_section *ms;
>>>    
>>>            if (section_nr > __highest_present_section_nr)
>>>                    __highest_present_section_nr = section_nr;
>>>    
>>> +        ms = __nr_to_section(section_nr);
>>>            ms->section_mem_map |= SECTION_MARKED_PRESENT;
>>>    }
>>>    
>>> @@ -279,7 +280,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
>>>                    if (!ms->section_mem_map) {
>>>                            ms->section_mem_map = sparse_encode_early_nid(nid) |
>>>                                                            SECTION_IS_ONLINE;
>>> -                        section_mark_present(ms);
>>> +                        section_mark_present(section);
>>>                    }
>>>            }
>>>    }
>>> @@ -933,7 +934,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>>>    
>>>            ms = __nr_to_section(section_nr);
>>>            set_section_nid(section_nr, nid);
>>> -        section_mark_present(ms);
>>> +        section_mark_present(section_nr);
>>>    
>>>            /* Align memmap to section boundary in the subsection case */
>>>            if (section_nr_to_pfn(section_nr) != start_pfn)
>>>
>>   
>>   
>> -- 
>> Thanks,
>>   
>> David / dhildenb
>>   
> Dear David.
> 
> I tried to check on time for memblocks_present, but when I tested with mobile
> phones with 8GB ram, the original binary took 0us either as well as the
> patched binary.
> I'm not sure how the results would differ on huge systems with bigger ram.
> I agree that it could turn out to be just a noise, as you expected.
> 
> However as you also mentioned, the patches will be straight forward when all
> codes using __section_nr() are cleaned up nicely.
> 
> Below are the two patches that you asked for.
> Please tell me if you need me to send the patches in separate e-mails.

Yes, please send them separately. Maybe sent all 3 patches combined in a 
single series, so Andrew can pick them easily, and reviewers can review 
more easily.

Thanks!

-- 
Thanks,

David / dhildenb

