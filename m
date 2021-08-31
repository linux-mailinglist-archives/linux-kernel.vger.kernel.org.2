Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D203FC7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhHaMxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhHaMxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:53:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6686C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:52:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so1950131pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 05:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=WabTdj9An5z5ILEGVeAkv4WhYJoKZFzGY2Bi+4jqu40=;
        b=QtbFCBQwB7vEOOjsNeuQm4+4/dYAfMe3yCq4qGgDMPEP2HtgL0c0UNl/2IPOdesOwR
         HDN5aoeyLSKvd+pOu/bNSqj8hw6KjAf4fMtcvarHbALjsd0qhaiAcfKjFl/s6XmzbDuw
         vLl3jBaDIzoMLuMw5BwFwqtLcpVMUyTzUszMSRvVcSFXLn4/4JEu/EVetR9Z6cTOAjY5
         cdOVD9RO944Bt20RgMPPgjxMYbMVnck3LxIogxCXaDIWuG4hPo5ECGXyanqvTrD7gEgS
         X9pMjDGgKSHs87IlIUdATLZY0ETAiGXiePf2ln3VFdMx1NnXGtSG8wHIgXcvGnketO+E
         hRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=WabTdj9An5z5ILEGVeAkv4WhYJoKZFzGY2Bi+4jqu40=;
        b=qd+GFUUYFCXycviCO4ZAPHXtuHEKV3Pf2IMVr+IvnoTpS/oXJPc8PHFk4Sca0VFXCV
         gcQ+Yq5qfJ6+FGXenhxo89khvud/TB2xmyECxBT/F6E5MTNS0raaVRGIve7YjCXNWBl1
         UCN3yyYXHTKZ0/+dzmFJFGJZoukZZEkFk1NhqeVHKm26olKUveAMTTAYeIrRamnMY+TO
         41gTifMOJpz7S45nrlBPhWn1ZTxIuzwWdUWnO5Go3Jn/M5SFp00yk6gdFRpIkaOxkeWo
         W6gAjf2zIrkMhVYFeM0znjtMnVBNjhXu68TTzcq2CGb+oE9NVW9+xJB7lvYz5PirsX5F
         N/Qw==
X-Gm-Message-State: AOAM531IHvM8OwYdpeH4IYtN0042aiwFkNMkGtlrm8u91cL/QqMH5iyg
        VRu3yFtG0ze/VQ00nz7jOxdCSg==
X-Google-Smtp-Source: ABdhPJzUHSDAap4VmW6faAIG74gQrS2lCsqGRTOMEhdKrHauFD9+QCaCpWYcdIqu3MWTwEcslg6jEA==
X-Received: by 2002:a17:902:c643:b0:138:b603:f944 with SMTP id s3-20020a170902c64300b00138b603f944mr4593654pls.45.1630414371312;
        Tue, 31 Aug 2021 05:52:51 -0700 (PDT)
Received: from [10.254.46.235] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id s29sm20965758pgl.38.2021.08.31.05.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 05:52:50 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] mm: remove redundant smp_wmb()
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210828042306.42886-1-zhengqi.arch@bytedance.com>
 <20210828042306.42886-3-zhengqi.arch@bytedance.com>
 <17a36dfc-cbd1-56c5-46a9-9f4043bb56e6@suse.cz>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <766d0039-02c9-4511-6421-9d2ccfd0cfb2@bytedance.com>
Date:   Tue, 31 Aug 2021 20:52:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <17a36dfc-cbd1-56c5-46a9-9f4043bb56e6@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/31 PM6:20, Vlastimil Babka wrote:
> On 8/28/21 06:23, Qi Zheng wrote:
>> The smp_wmb() which is in the __pte_alloc() is used to
>> ensure all ptes setup is visible before the pte is made
>> visible to other CPUs by being put into page tables. We
>> only need this when the pte is actually populated, so
>> move it to pte_install(). __pte_alloc_kernel(),
> 
> It's named pmd_install()?

Yes, I will update it in the next version.

> 
>> __p4d_alloc(), __pud_alloc() and __pmd_alloc() are similar
>> to this case.
>>
>> We can also defer smp_wmb() to the place where the pmd entry
>> is really populated by preallocated pte. There are two kinds
>> of user of preallocated pte, one is filemap & finish_fault(),
>> another is THP. The former does not need another smp_wmb()
>> because the smp_wmb() has been done by pte_install().
> 
> Same here.
> 
>> Fortunately, the latter also does not need another smp_wmb()
>> because there is already a smp_wmb() before populating the
>> new pte when the THP uses a preallocated pte to split a huge
>> pmd.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   mm/memory.c         | 47 ++++++++++++++++++++---------------------------
>>   mm/sparse-vmemmap.c |  2 +-
>>   2 files changed, 21 insertions(+), 28 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index ef7b1762e996..9c7534187454 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -439,6 +439,20 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
>>   
>>   	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
>>   		mm_inc_nr_ptes(mm);
>> +		/*
>> +		 * Ensure all pte setup (eg. pte page lock and page clearing) are
>> +		 * visible before the pte is made visible to other CPUs by being
>> +		 * put into page tables.
>> +		 *
>> +		 * The other side of the story is the pointer chasing in the page
>> +		 * table walking code (when walking the page table without locking;
>> +		 * ie. most of the time). Fortunately, these data accesses consist
>> +		 * of a chain of data-dependent loads, meaning most CPUs (alpha
>> +		 * being the notable exception) will already guarantee loads are
>> +		 * seen in-order. See the alpha page table accessors for the
>> +		 * smp_rmb() barriers in page table walking code.
>> +		 */
>> +		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
> 
> So, could it? :)
> 

Yes, it could, but we don't have smp_wmb__after_spin_lock() now.


