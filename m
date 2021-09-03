Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648853FFADA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347522AbhICHIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234713AbhICHI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630652847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mZDuU7BAOLBhLJY4HPiW+0aRj9rBKIKaHcL++uG3Fy0=;
        b=UHENwNCnw6a6eVy4EcFXo8yCLPWvtk20sSCtkDd8rfsdtPgeDYWj6WbLRJZ11CeExRVXX4
        USIBRW6tFtcQE1hn1K6IDfAkIl8X7ZHM8rKOWqgleVVPsgGvEgak3EyqCZ9RHMz4UmDlDw
        /QtrXkfDV9gR0464Bxk/4RLQKwubOvI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-9LNSyrHWPP2v0_JVDZlFcg-1; Fri, 03 Sep 2021 03:07:26 -0400
X-MC-Unique: 9LNSyrHWPP2v0_JVDZlFcg-1
Received: by mail-wr1-f72.google.com with SMTP id y13-20020adfe6cd000000b00159694c711dso67719wrm.17
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 00:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mZDuU7BAOLBhLJY4HPiW+0aRj9rBKIKaHcL++uG3Fy0=;
        b=oWotSlmVi85IFesyS/u+Hw9+87lwn+f56tz9zjI76M/liNz2kv91sLpuBcMJhBdQuk
         gs9vXki5IlUCtcoLIRPVGZxVPewdkYR8/JVxTLl6pc0fJX6hCrRyuusaYnq1l6krxe6J
         R5Afk9OHD/HCuMMRCCwYdy4HzzDUj6B9Iw+bP//YCnfoRzadNXMy0NAbW0doFMU5dvpO
         rd0bbepnRylnWRd0sSdtKqeNGgn0kc6CvFcjYEDAKkFJeIgne5I2jhEiDLmHZrs83ODD
         KbVSPobMkQBhxY+kcsDUUL+b1yLdksvXnX+ji66XrhPb4kND3Je4SKWgTWJXacQNooFs
         ywNg==
X-Gm-Message-State: AOAM532pPa8o3qXYTxjM3aYO85UTxtcTCpuC9mv7KIDnX1ywEr0mgQmK
        q6XrlDp0V7N2wTnwoGGyM0IQ8hPev+o6aa0AD8tkQVgAggUrlLWY2HoTi4/NiuQ+CTvuilHZ0d+
        82zfUv5Zk04lZL5R9re6RoXfj
X-Received: by 2002:a1c:f:: with SMTP id 15mr1799423wma.67.1630652844945;
        Fri, 03 Sep 2021 00:07:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoBIf2qQq69J5mO2W3iddq5WUEfks7zCZdnJCrDBdBsVF0mOIsUfZqxsH9o1bzM4XnwJhf/g==
X-Received: by 2002:a1c:f:: with SMTP id 15mr1799404wma.67.1630652844762;
        Fri, 03 Sep 2021 00:07:24 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e05.dip0.t-ipconnect.de. [79.242.62.5])
        by smtp.gmail.com with ESMTPSA id o7sm3384838wmc.46.2021.09.03.00.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 00:07:24 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] mm: Add zap_skip_check_mapping() helper
To:     Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210902201721.52796-1-peterx@redhat.com>
 <1771631.QAr93JHi05@nvdebian> <YTF81ItjDYpHUe1J@t490s>
 <2306207.EELmk4mpEQ@nvdebian>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <072aa3aa-e4f8-96f0-50b5-92707404926d@redhat.com>
Date:   Fri, 3 Sep 2021 09:07:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2306207.EELmk4mpEQ@nvdebian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.09.21 03:50, Alistair Popple wrote:
> On Friday, 3 September 2021 11:39:32 AM AEST Peter Xu wrote:
>> On Fri, Sep 03, 2021 at 10:58:53AM +1000, Alistair Popple wrote:
>>> On Friday, 3 September 2021 6:18:19 AM AEST Peter Xu wrote:
>>>> Use the helper for the checks.  Rename "check_mapping" into "zap_mapping"
>>>> because "check_mapping" looks like a bool but in fact it stores the mapping
>>>> itself.  When it's set, we check the mapping (it must be non-NULL).  When it's
>>>> cleared we skip the check, which works like the old way.
>>>>
>>>> Move the duplicated comments to the helper too.
>>>>
>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>> ---
>>>>   include/linux/mm.h | 15 ++++++++++++++-
>>>>   mm/memory.c        | 29 ++++++-----------------------
>>>>   2 files changed, 20 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index 69259229f090..81e402a5fbc9 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -1720,10 +1720,23 @@ extern void user_shm_unlock(size_t, struct ucounts *);
>>>>    * Parameter block passed down to zap_pte_range in exceptional cases.
>>>>    */
>>>>   struct zap_details {
>>>> -	struct address_space *check_mapping;	/* Check page->mapping if set */
>>>> +	struct address_space *zap_mapping;	/* Check page->mapping if set */
>>>>   	struct page *single_page;		/* Locked page to be unmapped */
>>>>   };
>>>>   
>>>> +/*
>>>> + * We set details->zap_mappings when we want to unmap shared but keep private
>>>> + * pages. Return true if skip zapping this page, false otherwise.
>>>> + */
>>>> +static inline bool
>>>> +zap_skip_check_mapping(struct zap_details *details, struct page *page)
>>>> +{
>>>> +	if (!details || !page)
>>>> +		return false;
>>>> +
>>>> +	return details->zap_mapping != page_rmapping(page);
>>>
>>> Shouldn't this check still be
>>> details->zap_mapping && details->zap_mapping != page_rmapping(page)?
>>>
>>> Previously we wouldn't skip zapping pages if even_cows == true (ie.
>>> details->check_mapping == NULL). With this change the check when
>>> even_cows == true becomes NULL != page_rmapping(page). Doesn't this mean we
>>> will now skip zapping any pages with a mapping when even_cows == true?
>>
>> Yes I think so.  Thanks for pointing that out, Alistair, I'll fix in v3.
>>
>> But frankly I really think we should simply have that flag I used to introduce.
>> It'll make everything much clearer.
> 
> Yeah, I think a flag would also be fine.

I still don't see the need for a flag quite frankly. Just factor out the 
checks we already have ... no change in behavior.


-- 
Thanks,

David / dhildenb

