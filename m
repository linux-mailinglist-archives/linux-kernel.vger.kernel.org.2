Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A6435F34B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350731AbhDNMPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232338AbhDNMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618402516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fFtVeYRBrjEQY4H1xhMi03RQAo6ksAC16iLETUn+lv4=;
        b=SMZtDfhMJbPpXVJEsMiR9n1bFBVM4GZj8s/X6FzuIgkybyYp/qudaBpY4ojFW2Ys1ngRXj
        fiN+u1qZfILEknsB2p3zoN9ZQJpp85v2+0p7oC/bV2CrA8Z++EGc47Ukr5mrWrwY0unhi8
        4Mn76D7Gq44tepM2lzPfwlFbwzVau+I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409--_3Q0odePkSiAi23m4i8Lg-1; Wed, 14 Apr 2021 08:15:14 -0400
X-MC-Unique: -_3Q0odePkSiAi23m4i8Lg-1
Received: by mail-wr1-f71.google.com with SMTP id f15-20020adffccf0000b02901028c7339ccso992933wrs.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fFtVeYRBrjEQY4H1xhMi03RQAo6ksAC16iLETUn+lv4=;
        b=CwQ7AuFsBJo2v3IYZ7CX/AnkZiSH7ZXHPIo8O18RyF95vv5UQyqkJXhhzXReOeDTp7
         e1jwWk+TmBK71j1Ek3SHTdWvqXXDiR3dv9jNmjFiNhQ4wxyF8Evz9BJEkAMD9I4SnAtA
         7oYmHfFhq8stNctpQAfWQjGpHZAeW2tnClEBKjDvZQsb1q/8fY9akQKGTjwY13cfI/JG
         FQ20lNlv8JyA6P7yMjW4FmmR0syheJFpjWI6RMug/dBiP0lajhBE9WhjiP4v1Iu/heTs
         NwoaG7O9WORF+eAwwcBILs4HlUVMxuwZnYaqmnnaN2fQcdZdCMS+kj9jomS04V4XTK3z
         z2ew==
X-Gm-Message-State: AOAM531+3pJursMhLCPRH28qJo454peyZ8B74X9+v/mTPVwy+EnSR/L/
        C43EA33Nu0gti4GmTWHetxs8KxxinRQRU6WWPbiHflADaSCFDfsPD2pyliafFuOIOmT7pol2jzC
        qHZESdw+07+44jqoumBTqCzNy0Z5r+bEl4m/WWaTArPLD3PuZLgdOl8Z4TCjiY46ge0tbfuqC
X-Received: by 2002:a1c:4b11:: with SMTP id y17mr2713659wma.72.1618402513794;
        Wed, 14 Apr 2021 05:15:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH0QvK4xqEVaRk4x9rJOmv6sUKwBuhxWh8jHeD5J8xhbLpIv04Fo2Bfk4ww16Ld8EaO83N9g==
X-Received: by 2002:a1c:4b11:: with SMTP id y17mr2713644wma.72.1618402513621;
        Wed, 14 Apr 2021 05:15:13 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6470.dip0.t-ipconnect.de. [91.12.100.112])
        by smtp.gmail.com with ESMTPSA id o17sm11475628wrv.16.2021.04.14.05.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 05:15:13 -0700 (PDT)
Subject: Re: [PATCH v7 4/7] mm,hugetlb: Split prep_new_huge_page functionality
To:     Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-5-osalvador@suse.de>
 <94992151-03fc-dedd-3e09-811908d26d04@oracle.com>
 <YHZ2xCeo+aVgD28c@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <feca0034-3914-6f4e-1260-7c3091639fda@redhat.com>
Date:   Wed, 14 Apr 2021 14:15:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHZ2xCeo+aVgD28c@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.21 06:59, Oscar Salvador wrote:
> On Tue, Apr 13, 2021 at 02:33:41PM -0700, Mike Kravetz wrote:
>>> -static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>>> +/*
>>> + * Must be called with the hugetlb lock held
>>> + */
>>> +static void __prep_account_new_huge_page(struct hstate *h, int nid)
>>> +{
>>> +	h->nr_huge_pages++;
>>> +	h->nr_huge_pages_node[nid]++;
>>
>> I would prefer if we also move setting the destructor to this routine.
>> 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> 
> Uhm, but that is the routine that does the accounting, it feels wrong
> here, plus...

I agree. If we want the final activation separately, it might be better 
to have it as a separate step/function like __active_new_huge_page().

-- 
Thanks,

David / dhildenb

