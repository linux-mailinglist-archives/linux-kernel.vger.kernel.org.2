Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7C3CD62E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbhGSNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239352AbhGSNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:14:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB37C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:18:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g24so11491409pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=lm5IvueyUucmK9+B2ni/XxO2ccY0iQ71cX0W8b88G5Q=;
        b=sz8XlcoTWg7QOOThmUdhRqfOEh4bAF0RlzrOKRYgVCfmfoVxnb8ki1w6R53afZMNIX
         bdT96FHA+buGLamd0coIbTgd1GQ3t1yjKojeNpnVbMJvzSf2gR0qrBByfAbk+THN1JZd
         X2mw0ixNrQROBuEP5APK+cpPDxTIO/WKx3lP7kEsnFd6y5pEtP5lfPIxDhzWJBdwtcx5
         GjY4Zme5iIpEf8bkZtTghuxAvMYfZ0/K9zz5+1j/9HqrkIGESdvj0nneVVNfNPJwcAPE
         cKoV/FkhkpHt6nJVzZO6xK6C8xqF/TVafiNXd27Ob3GJSP2/QsRMzgIzVOWVqFkPY/AP
         SJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=lm5IvueyUucmK9+B2ni/XxO2ccY0iQ71cX0W8b88G5Q=;
        b=UikLWz+yOkbtP2BfSs7tI6cl3f3SzYabu9Ckki8iNeMvqvxuFVDI3gJPQhP9WdQHzU
         PCJ/iepfDQMJYIkb+NGgNx1Bd/gAJpdavBy9LDEVJRjVpbdELkVs2NXcNF6eLLjg2T+t
         OU9D4whaA2SKmf3odMMwzzRjV0eV0yMxxE/CfKbv/tEWfopAi0PGJGtW9dboCFPfeT8K
         5kLLNOdVi2STpsm51OVUfeu3vOZ19hciFjXlwGxh7FfKTuTOTup1Q3zs3c3fXLLmp8qj
         ymuDnrVGVbeIbysAJlmZJTxuTnIn5A/Wzu98lynGsxEgeN8wqDbOIvzHfrfKFp32a0/m
         R41w==
X-Gm-Message-State: AOAM530IspQWugbEy+SF3A7wwEMtRy4Z9mkBl27OCbaDHGDiNfwy+l6k
        osJvgBsCkJeIJRGIbIFVyLMICg==
X-Google-Smtp-Source: ABdhPJwS87p0XskdKotYAQaKNw4ZH1KiJK6VQskISM1Uku2ELfoNfsYxzKc/JhHKwxYL7E/GWjYh8g==
X-Received: by 2002:a17:902:bb83:b029:120:512b:86c0 with SMTP id m3-20020a170902bb83b0290120512b86c0mr19562256pls.32.1626702911622;
        Mon, 19 Jul 2021 06:55:11 -0700 (PDT)
Received: from [10.200.196.235] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v69sm20867208pfc.118.2021.07.19.06.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 06:55:11 -0700 (PDT)
Subject: Re: [PATCH 5/7] mm: free user PTE page table pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <20210718043034.76431-6-zhengqi.arch@bytedance.com>
 <20210718220110.nqcd73luncf3v7mk@box.shutemov.name>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <fa819293-7b0b-0b80-699a-63c1ad0469c2@bytedance.com>
Date:   Mon, 19 Jul 2021 21:55:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210718220110.nqcd73luncf3v7mk@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 6:01 AM, Kirill A. Shutemov wrote:
> On Sun, Jul 18, 2021 at 12:30:31PM +0800, Qi Zheng wrote:
>> Some malloc libraries(e.g. jemalloc or tcmalloc) usually
>> allocate the amount of VAs by mmap() and do not unmap
>> those VAs. They will use madvise(MADV_DONTNEED) to free
>> physical memory if they want. But the page tables do not
>> be freed by madvise(), so it can produce many page tables
>> when the process touches an enormous virtual address space.
>>
>> The following figures are a memory usage snapshot of one
>> process which actually happened on our server:
>>
>>          VIRT:  55t
>>          RES:   590g
>>          VmPTE: 110g
>>
>> As we can see, the PTE page tables size is 110g, while the
>> RES is 590g. In theory, the process only need 1.2g PTE page
>> tables to map those physical memory. The reason why PTE page
>> tables occupy a lot of memory is that madvise(MADV_DONTNEED)
>> only empty the PTE and free physical memory but doesn't free
>> the PTE page table pages. So we can free those empty PTE page
>> tables to save memory. In the above cases, we can save memory
>> about 108g(best case). And the larger the difference between
>> the size of VIRT and RES, the more memory we save.
>>
>> In this patch series, we add a pte_refcount field to the
>> struct page of page table to track how many users of PTE page
>> table. Similar to the mechanism of page refcount, the user of
>> PTE page table should hold a refcount to it before accessing.
>> The PTE page table page will be freed when the last refcount
>> is dropped.
> 
> The patch is very hard to review.
> 
> Could you split up introduction of the new API in the separate patch? With
> a proper documentation of the API.

Good idea, i will do it.

> 
> Why pte_refcount is atomic? Looks like you do everything under pmd_lock().
> Do I miss something?

When we do pte_get_unless_zero(), we hold pmd_lock to protect against
free_pte_table(). But we don't need to hold the pmd lock when we do
pte_get()/pte_put() in mapping/unmapping routine.

> 
> And performance numbers should be included. I don't expect pmd_lock() in
> all hotpaths to scale well.
> 

Yeah, so we use rcu lock to replace the pmd lock in some routines in the
subsequent patch (mm: defer freeing PTE page table for a grace period).

Thanks,

Qi
