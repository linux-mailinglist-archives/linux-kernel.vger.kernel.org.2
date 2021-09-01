Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908A13FDD90
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbhIAN7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232598AbhIAN7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630504696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AtcCp/E1mJH1qo6IRVdtwg5GdGZiUHZsdrfrSmluGPA=;
        b=Ldk0iK3NYp/7XndnaOxxAF42saYLUAHkZ8s3iJUQRl0bRrS7m/kIXtXLS3mSAws3tEMxZR
        /+WxwY/rfjTr23FmJafobFNzU3rp6b67aNngl6Fmafu0U07xBelN1+EAnKI3IDHKaWf0NG
        mBgfVVLNPeRuV1gnI99Do9McdyViqLA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-OkIPh8snPE-S-gmu3U7yUg-1; Wed, 01 Sep 2021 09:57:12 -0400
X-MC-Unique: OkIPh8snPE-S-gmu3U7yUg-1
Received: by mail-wm1-f69.google.com with SMTP id a201-20020a1c7fd2000000b002e748bf0544so2875032wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 06:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AtcCp/E1mJH1qo6IRVdtwg5GdGZiUHZsdrfrSmluGPA=;
        b=pZkaWM1hda9rlueS7CJqzeuOnkisxeWOit5w1lclG9dGlIsrAtSTNONvJKOYahmFtb
         eaXFukx2vELJIMBVjgENzdeG9Yws6biU9s7SugV8gJwotuMS3hj4y7QRByoQoy7//Mh5
         4pdju9aj7cAjg0q+q6g/o1SgVwzOklZ4iVnKpyvbfX44QXgzt/svqHayDIGzsP6aflba
         WkAjFWooSe5Xp02wv1mZ3Rn1bwXRKlYZu7A1fa9QLwj5+ZcMWdI9tWtWRsUyoBLFLAXa
         SROUUVEUjM/H5R6BhFxfc8JKOmWv3KfBX0wKLEWAI4a/WpenCi11rlVNeOodscPNlf1v
         QA2g==
X-Gm-Message-State: AOAM530BcxHLsHL4odTK4KoF2cXalmIln8CSD/hZKOxgFMoJwSx/H91s
        wckVhIsNEffubN5U3j2FqJ+JgNH3sL0I5sq6l5QFQn1LzR2umiNwAJ9TXu4IAVWOSot05pmRytG
        f5PUzhgc+A+EEP1e6c0JXvQO6
X-Received: by 2002:adf:f403:: with SMTP id g3mr36321521wro.206.1630504631348;
        Wed, 01 Sep 2021 06:57:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8AAzCiaIzpXWN507TidFNNd5TOET80fPvXM2IZjrsm98BojK/EWo12Z9GfuLAARluEbknaA==
X-Received: by 2002:adf:f403:: with SMTP id g3mr36321499wro.206.1630504631115;
        Wed, 01 Sep 2021 06:57:11 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23f71.dip0.t-ipconnect.de. [79.242.63.113])
        by smtp.gmail.com with ESMTPSA id u16sm5978489wmc.41.2021.09.01.06.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 06:57:10 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] mm: free user PTE page table pages
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-7-zhengqi.arch@bytedance.com>
 <20210901135314.GA1859446@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0c9766c9-6e8b-5445-83dc-9f2b71a76b4f@redhat.com>
Date:   Wed, 1 Sep 2021 15:57:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901135314.GA1859446@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 15:53, Jason Gunthorpe wrote:
> On Thu, Aug 19, 2021 at 11:18:55AM +0800, Qi Zheng wrote:
> 
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 2630ed1bb4f4..30757f3b176c 100644
>> +++ b/mm/gup.c
>> @@ -500,6 +500,9 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>>   	if (unlikely(pmd_bad(*pmd)))
>>   		return no_page_table(vma, flags);
>>   
>> +	if (!pte_try_get(mm, pmd))
>> +		return no_page_table(vma, flags);
>> +
>>   	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
> 
> This is not good on a performance path, the pte_try_get() is
> locking/locking the same lock that pte_offset_map_lock() is getting.

Yes, and we really need patch #8, anything else is just confusing reviewers.

> 
> This would be much better if the map_lock infra could manage the
> refcount itself.
> 
> I'm also not really keen on adding ptl level locking to all the
> currently no-lock paths. If we are doing that then the no-lock paths
> should rely on the ptl for alot more of their operations and avoid the
> complicatred no-lock data access we have. eg 'pte_try_get()' should
> also copy the pte_t under the lock.
> 
> Also, I don't really understand how this scheme works with
> get_user_pages_fast.

With the RCU change it in #8 it should work just fine, because RCU 
synchronize has to wait either until all other CPUs have left the RCU 
read section, or re-enabled interrupts.

-- 
Thanks,

David / dhildenb

