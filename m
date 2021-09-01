Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7833FD776
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhIAKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhIAKQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:16:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2280C061760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 03:15:51 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so4280722pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=a9Kfb7wAmZrrrmnSPc65CnKgobH9A43eRy/F3HVanHY=;
        b=ktBaN4pw4D94xBPBGtv47AE7E824CWAXMo/jdRdOir8ofINSsb4P4J8usLGA+5daAn
         e7kbuazNA5QrGI2mMsSamMzJrp0UQU/Yu7wJVUZLkKsAsghAFE4hVv45uKBG+lMKbmJx
         p3u4DS5023sQ9mlY7jjUTNZHqHiCdD+rtxWLuSg84CpRbNbeyH9rYXUfJ4EEMx3Xm8qN
         lErC5DHTpeGiLTLHMwXr+SCdjtG1LDD1QN+9niCTEitmNcRUflaZC9umWsC2AXc1fR1v
         dTtVoVWnFcPVj6qz3TWZKs29xnLeSqns+EGqA+cEUyrA7HTDgGZXpsR2u5uxEZSsteAT
         Chug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=a9Kfb7wAmZrrrmnSPc65CnKgobH9A43eRy/F3HVanHY=;
        b=t3kItZ9wFDFxTReJwkAc4Y8u7YN470juCfLKbPYqaA5eDxnIMVl3WJroTWNS/O10Cp
         mhKjvtz/AN2BNITDP+cAbEXIXffMmBaKu9RGusT26nGRfTuqafUAkg7CLmaJBsn6mNiY
         BcUUUxwqnqfojODckFcdLrotd9bq4rAKFfnwt55L8qoitpACipuNU509Dbd9aEy20CuG
         REeOOgRsf8pqSLe7MhySBs1XZJ659YlEKKTTyEuOF28aP9PEefBb2lILjEh++xzu9fE1
         +GMtP4dUO2KiIY50TC0yBiBs2QNgYvfb1mVRoldVedy8PBgny1QuP218iZNbDeziREKv
         UVow==
X-Gm-Message-State: AOAM530nxQ0o+GGPcnT1EJt276ou/mEgRGURNFrARhf1oEzZt5hKt8OT
        ZqW05l8s1CR6KhSsID6M5fLalQ==
X-Google-Smtp-Source: ABdhPJxhe4FVoyyM9qgNUA7XB+DpgXLzpJWFs6gAwpaqEhpUPZjBR7TbfzzWilv9WL7YEhcES/OhIw==
X-Received: by 2002:a17:90a:ae18:: with SMTP id t24mr10895503pjq.92.1630491351412;
        Wed, 01 Sep 2021 03:15:51 -0700 (PDT)
Received: from [10.254.210.255] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id y12sm23232967pgl.65.2021.09.01.03.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 03:15:51 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] mm: introduce pmd_install() helper
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, vbabka@suse.cz, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
References: <20210831132111.85437-1-zhengqi.arch@bytedance.com>
 <20210831132111.85437-2-zhengqi.arch@bytedance.com>
 <20210831232301.ilehcpc3n5bqodsz@box.shutemov.name>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <cd4e882a-ecbb-6688-1288-112312e9251c@bytedance.com>
Date:   Wed, 1 Sep 2021 18:15:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831232301.ilehcpc3n5bqodsz@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/1 AM7:23, Kirill A. Shutemov wrote:
> On Tue, Aug 31, 2021 at 09:21:10PM +0800, Qi Zheng wrote:
>> Currently we have three times the same few lines repeated in the
>> code. Deduplicate them by newly introduced pmd_install() helper.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   include/linux/mm.h |  1 +
>>   mm/filemap.c       | 11 ++---------
>>   mm/memory.c        | 34 ++++++++++++++++------------------
>>   3 files changed, 19 insertions(+), 27 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index a3cc83d64564..0af420a7e382 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2463,6 +2463,7 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
>>   	return ptl;
>>   }
>>   
>> +extern void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
>>   extern void __init pagecache_init(void);
>>   extern void __init free_area_init_memoryless_node(int nid);
>>   extern void free_initmem(void);
> 
> mm/internal.h would be a better fit for the declaration.

OK, I will update it in the next version.

> 
> Otherwise:
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 

Thanks,
Qi

