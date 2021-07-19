Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03AE3CD536
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbhGSMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 08:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhGSMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 08:15:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA95C061767
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 05:14:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b2so4967417plx.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pJ4knqJr8MCDWuPshU9F5K+EeAL4qKb9eJnyIRFa9hM=;
        b=Gie9aHoUo6wyrEfk0yUJ4HChlgLtj36K7r+9gR1sk6mMB9vtxtnoQemP4/b1OCld6s
         0ks63IT2NW5TAw2oeEN2C62RG39VUbz1jixYLXxoTLLdpDBRUSuUSVWEV/IXfZDPYk6R
         +WT2bHmI8w3Xdz57wKU9ne22rjwox+48hsrTCsPwyrCvqWae5EgUQ9ti//amKiqMzDRZ
         ORYN2icrfBc3L/CaX80twbLD4z6htpBjscOdCZYWHsVKe4MUhE2zpsi36tcNPwSA/YSG
         CRFmnEkU4qwSOdpVdbJLz+1DPJhu5P+7SWpAd4Uo0KoPCx4I7yXtxp2tfmo9ljTQOm5p
         Bp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pJ4knqJr8MCDWuPshU9F5K+EeAL4qKb9eJnyIRFa9hM=;
        b=j0HO2tZlIzi4PRhLzWVWCarL1skegz1elmYb/yCGyWOwhsJnJ/oAV8SEQAaYApwB/D
         ivx3/p1FXUwn+wEdlhYuw91dwqj7p0KwXoNtY10OBwRCtadWGo3qZsh0rSMRWqev7CYW
         djwsxFfIhGX8D0fT1Nof94LbnhFquLX5UGl2EGNDKQs/lY51IsCNCHNNubdgkkEUtC3J
         aQZ1pQRAd+kwXdpUFtjocdbYoct5w6aU8X6BvXbi52AGxuOjcRIduRxYACu0yjN2rvtC
         HhK7x93Ts4jNPvzL696KLLazcBp7c5fmyrRK0RapDUTuztoXWVcu0cG1qWWgk5AzYtm2
         syNQ==
X-Gm-Message-State: AOAM5311nQTQUj7ZiUOF3O1WRDxuDcXZad0BOTJ8lEMNIaq9kY8yi/ez
        Bmj5Zorvj7S6mpT6N9zyrX25Tw==
X-Google-Smtp-Source: ABdhPJxxfMgmlkmA3fYZj8+mEySDfeFvzJFp79PujQnVxefD888uqUHVWaGq65dyFsXBNNNl6c5Kng==
X-Received: by 2002:a17:90b:1041:: with SMTP id gq1mr29619799pjb.222.1626699366674;
        Mon, 19 Jul 2021 05:56:06 -0700 (PDT)
Received: from [10.200.196.235] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id a18sm19970441pfi.6.2021.07.19.05.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 05:56:06 -0700 (PDT)
Subject: Re: [PATCH 5/7] mm: free user PTE page table pages
To:     =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>,
        akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <20210718043034.76431-6-zhengqi.arch@bytedance.com>
 <9c3c87d5-e64e-f13f-ef36-b438e4de1e66@nextfour.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <80b7d7fc-9d6d-0d1b-a333-b0ccd856e7c1@bytedance.com>
Date:   Mon, 19 Jul 2021 20:56:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9c3c87d5-e64e-f13f-ef36-b438e4de1e66@nextfour.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/21 2:19 PM, Mika Penttilä wrote:

>> +
>> +/*
>> + * returns true if the pmd has been populated with PTE page table,
>> + * or false for all other cases.
>> + */
>> +bool pte_install_try_get(struct mm_struct *mm, pmd_t *pmd, pgtable_t 
>> *pte)
>> +{
>> +    spinlock_t *ptl;
>> +    bool retval = true;
>> +
>> +retry:
>> +    ptl = pmd_lock(mm, pmd);
>> +    if (likely(pmd_none(*pmd))) {
>> +        __pte_install(mm, pmd, pte);
>> +    } else if (pmd_leaf(*pmd) || !pmd_present(*pmd)) {
>> +        retval = false;
>> +    } else if (!pte_get_unless_zero(pmd)) {
>> +        spin_unlock(ptl);
>> +        goto retry;
>> +    }
>> +    spin_unlock(ptl);
>> +    return retval;
>> +}
>> +
> 
> Can pte_get_unless_zero() return true above? Can the pmd have been by 
> populated by others? In that case the ref count is wrongly incremented.
> 

Here we only have mmap_read_lock(mm), so the pmd can be populated with
other PTE page table page after a page fault in a different thread B of 
this mm. In this case, thread B already hold a pte_refcount of the PTE 
page table page populated in the pmd, so pte_get_unless_zero() can
return true above.

Similarly, if THP is enabled, the pmd also can be populated with a THP 
page, we can see more detail in comment in handle_pte_fault(). The
pmd_leaf() above is to detect this situation.
