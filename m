Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2840C3CD655
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 16:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbhGSNbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbhGSNba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:31:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E817C061762
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:37:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d1so9661569plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zPPoyHSUpxCfW2xlkYhOq6mDYE3xjGota4xo6DJybww=;
        b=JTmcB5jXc/DDz7eOwJwJsql6oWlrfqV/PwmKWqHuwK0L0Z52XnaFyrK2X2kflNTvkU
         mPTh1Mvg0GB9aYkz2DRk/VB3HQCSmXx8CiKVjsAEc57BZSztBDlgapjgkXDKvVGnWkzi
         gf047ZBIDMZI7R129nmnqLLRRebhAT4TLWMLxqm8xDsGwP1R0u36si3oK2qqQ7mkYG6j
         1qSAaysEQO+damp6WtgBZMQe8Qw1KIdyoB3V9iUKpaMb2ph5aZEJYk4w+FEdigQUta22
         BrlrRvz+DHJjehUFDrYwumr69VVhfasH/+9UZtjr/PMsqyCRkioVe31xvjtlD4MDTlgK
         RMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zPPoyHSUpxCfW2xlkYhOq6mDYE3xjGota4xo6DJybww=;
        b=q7eXpVtcbN4UAIpuUBVxxwc7/IVN+e/4y0LORfx2o05wDR09qTrhA/791qNE1MmmMB
         NIYPBpSHJ1lvASURuj475683Vyyqib8OhAnVrgbLo5ZPFc6FXlUabWz3PrkMpVeJbghl
         ycT+3P3ViVcwFMyu9dGeKimz5XTlleQg5qUz0ZcXZw+c2mqy0VvlF2GCcI3ju8ITIDi4
         xdPkEKUhgnDLjJCsfVHfFMOMN6q9zQr2cokYVES0pEHeal96cnq6AysRb8kkh+Hftwk/
         ggndN3KdpmGFKiv/+h3gOl17tvfs4nrwXjwQo4nvLd+x8NVM2XX97rltK7UWBl3S95Bd
         7eFA==
X-Gm-Message-State: AOAM532WnJnu2EHgtW/nOBMSLbDJOTHtJgL9zanHlVm/BiYoV5DMOI4V
        CxurTdSBy2DZg2TQoDaNwon5kQ==
X-Google-Smtp-Source: ABdhPJzZNum/3ukd8jgO5Wv4AAt34cxFPOoKLNKvMdahVU8I0uGolb9wiu4+jV6H39fl7bWfqs0eeQ==
X-Received: by 2002:a17:902:c40a:b029:12b:45c1:21b5 with SMTP id k10-20020a170902c40ab029012b45c121b5mr19464022plk.17.1626703930130;
        Mon, 19 Jul 2021 07:12:10 -0700 (PDT)
Received: from [10.200.196.235] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id u24sm20804070pfm.200.2021.07.19.07.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 07:12:09 -0700 (PDT)
Subject: Re: [PATCH 5/7] mm: free user PTE page table pages
To:     =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <20210718043034.76431-6-zhengqi.arch@bytedance.com>
 <9c3c87d5-e64e-f13f-ef36-b438e4de1e66@nextfour.com>
 <80b7d7fc-9d6d-0d1b-a333-b0ccd856e7c1@bytedance.com>
 <7fe2dd75-9b48-9685-8986-27a4cecc840f@nextfour.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <5ffff30c-59d7-fbb0-e3c2-fe9e47fc4658@bytedance.com>
Date:   Mon, 19 Jul 2021 22:12:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7fe2dd75-9b48-9685-8986-27a4cecc840f@nextfour.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 9:55 PM, Mika Penttilä wrote:
> 
> 
> On 19.7.2021 15.56, Qi Zheng wrote:
>> On 7/18/21 2:19 PM, Mika Penttilä wrote:
>>
>>>> +
>>>> +/*
>>>> + * returns true if the pmd has been populated with PTE page table,
>>>> + * or false for all other cases.
>>>> + */
>>>> +bool pte_install_try_get(struct mm_struct *mm, pmd_t *pmd, 
>>>> pgtable_t *pte)
>>>> +{
>>>> +    spinlock_t *ptl;
>>>> +    bool retval = true;
>>>> +
>>>> +retry:
>>>> +    ptl = pmd_lock(mm, pmd);
>>>> +    if (likely(pmd_none(*pmd))) {
>>>> +        __pte_install(mm, pmd, pte);
>>>> +    } else if (pmd_leaf(*pmd) || !pmd_present(*pmd)) {
>>>> +        retval = false;
>>>> +    } else if (!pte_get_unless_zero(pmd)) {
>>>> +        spin_unlock(ptl);
>>>> +        goto retry;
>>>> +    }
>>>> +    spin_unlock(ptl);
>>>> +    return retval;
>>>> +}
>>>> +
>>>
>>> Can pte_get_unless_zero() return true above? Can the pmd have been by 
>>> populated by others? In that case the ref count is wrongly incremented.
>>>
>>
>> Here we only have mmap_read_lock(mm), so the pmd can be populated with
>> other PTE page table page after a page fault in a different thread B 
>> of this mm. In this case, thread B already hold a pte_refcount of the 
>> PTE page table page populated in the pmd, so pte_get_unless_zero() can
>> return true above.
>>
> 
> Yes but if thread B populates the page table page and pte, then we also 
> increase the refcount with pte_get_unless_zero() , but dont decrease it 
> when notice !pte_none().
> And in the pte_none() case, the refcount is increased again, so double 
> accounting. see finish_fault().

The semantics of this function is to hold the pte_refcount count when it
returns 1, and its caller is responsible for decrease the pte_refcount
by calling pte_put(), like the following pattern:

	do_anonymous_page()

	--> pte_alloc_try_get()

	    do something about pte

	    pte_put()

Similarly in finish_fault().

Thanks,

Qi

> 
>> Similarly, if THP is enabled, the pmd also can be populated with a THP 
>> page, we can see more detail in comment in handle_pte_fault(). The
>> pmd_leaf() above is to detect this situation.
> 
