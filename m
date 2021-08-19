Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6943F172B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbhHSKSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 06:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhHSKSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:18:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68018C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:18:12 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o10so3694819plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YWzpA6GpiUj9DNafhyNnVYqFrxHaZDDWl5LsHjc0VZo=;
        b=nJW65GAjl7D58Tk4x3AWNw+vUkgL7jOiuXD2nezoZq/Ch6lRzc0SVRGhIpfViaAXii
         aKW4Nm497bc9RrWJ4RBDAJPmbwAMsIYXvxDCeLtkPoR5q8Q/4IMsmLhwrejMuPs74DXI
         dlrboN0usqfK+kgTp/42Ui2QqTYIKpYq+p63m8Kv9qkVlFWHndSOvGwioPcQMkz/A3j7
         temEF7jTY9AUcS54LQD4NmXq+0swWWloea6N7m6vUlLnqQoVH5Bt6wzXjHtCeO5b9++n
         ZSJQRR3l5Gjl8DL0bBPLvRNqX9Q8c3iRDJfyxdZS9MUWVoV+I9w7qkNRUaKMDPOddWbV
         P6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YWzpA6GpiUj9DNafhyNnVYqFrxHaZDDWl5LsHjc0VZo=;
        b=sTXB+gBkFuRaK+cVlyn7uIz7QhF2jho3ARs8w0L37PZDhebviOXIH7nNasiNVaiKrN
         Z09ekHrzI8lhwBFVbvNjRKX+gSvc+PxUDfTqA6KFQKOGlLnoTDhEcQzi4QUdSXw2r2qo
         y8yIX3nCvl+tuovWVZ0eZ8KefJMyuebT9I1L/ku8DOF+EDWD8mCT3uV9FoE/C0kvSjLS
         jRVMbyT6yWcCYjzXk0eBc9g2sEidraeYr+LtC0SzO7oqlXWfKh4Qmaz7LCc49JTPYbvZ
         ex4lIVnNl5C7MJwyBENEsD8sT8xECXGZBG4ynfaRlNK6jUpCq044pjN8EMNOLE8I4UTB
         nB/g==
X-Gm-Message-State: AOAM531vQUp8ma2wkaYBOop9z6R+88OyjUVtQjULC3rYZCUDJ+N1xGzG
        tNNSmiZtPZ0juTjcuQAFN6z0Sg==
X-Google-Smtp-Source: ABdhPJxpvI4seUV1ElylKWY6jlwJA1pr0aOdH/FokCyrtOSpqe/37r8Qycw3jq1alEYdVBeEpzD08w==
X-Received: by 2002:a17:902:76cb:b029:12b:2fb8:7c35 with SMTP id j11-20020a17090276cbb029012b2fb87c35mr11126355plt.16.1629368291977;
        Thu, 19 Aug 2021 03:18:11 -0700 (PDT)
Received: from [10.254.207.146] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id i5sm7762302pjk.47.2021.08.19.03.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 03:18:11 -0700 (PDT)
Subject: Re: [External] Re: [PATCH v2 6/9] mm: free user PTE page table pages
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <20210819031858.98043-7-zhengqi.arch@bytedance.com>
 <5aa3020c-fcf2-87bd-31fe-e2b5c2aafcf2@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <74bfdf9c-f054-906c-f533-9b5e53ba057d@bytedance.com>
Date:   Thu, 19 Aug 2021 18:18:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5aa3020c-fcf2-87bd-31fe-e2b5c2aafcf2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/19 PM3:01, David Hildenbrand wrote:
>>
>> In this patch series, we add a pte_refcount field to the
>> struct page of page table to track how many users of PTE page
>> table. Similar to the mechanism of page refcount, the user of
>> PTE page table should hold a refcount to it before accessing.
>> The PTE page table page will be freed when the last refcount
>> is dropped.
>>
>> While we access ->pte_refcount of a PTE page table, any of the
>> following ensures the pmd entry corresponding to the PTE page
>> table stability:
>>
>>     - mmap_lock
>>     - anon_lock
>>     - i_mmap_lock
>>     - parallel threads are excluded by other means which
>>       can make ->pmd stable(e.g. gup case)
>>
>> This patch does not support THP temporarily, it will be
>> supported in the next patch.
> 
> Can you clarify (and document here) who exactly takes a reference on the 
> page table? Do I understand correctly that
> 
> a) each !pte_none() entry inside a page table take a reference to the 
> page it's containted in.
> b) each page table walker temporarily grabs a page table reference
> c) The PMD tables the PTE is referenced in (->currently only ever a 
> single one) does *not* take a reference.

Yes, both of the !pte_none() entry and the page table walker can be
regarded as users of the PTE page table, so they need to hold a
->pte_refcount during their life cycle. And the pte_refcount field
of struct page is only for PTE page table, so the PMD page tables does
*not* take a ->pte_refcount.

> 
> So if there are no PTE entries left and nobody walks the page tables, 
> you can remove it? You should really extend the 

Yes, if there are no PTE entries left and nobody walks the page tables,
which means there is no user, then we can remove it when we drop the
last ->pte_refcount.

> description/documentation to make it clearer how exactly it's supposed 
> to work
I'm sorry that there is no clear description of the usage of
pte_refcount, i will make a documentation to describe it.

> 
> 
> It feels kind of strange to not introduce the CONFIG_FREE_USER_PTE 
> Kconfig option in this patch. At least it took me a while to identify it 
> in the previous patch.

The introduction of the CONFIG_FREE_USER_PTE and related APIs are all
place in the previous patch ([PATCH v2 5/9] mm: pte_refcount
infrastructure). And in this and next patch, we use these
infrastructures to free user PTE page table pages.

> 
> Maybe you should introduce the empty stubs and use them in a separate 
> patch, and then have this patch just introduce CONFIG_FREE_USER_PTE 
> along with the actual refcounting magic inside the !stub implementation.
> 
Hmm, let me think about this suggestion.

Thanks,

Qi

