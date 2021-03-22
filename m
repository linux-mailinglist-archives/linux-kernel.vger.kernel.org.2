Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0278B3437A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 04:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCVDxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 23:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCVDxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 23:53:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 20:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=l7NcDFRSpwugQhQwHSm3TGVE0q0YdNxXVQDS4Wcds/Y=; b=iBYu9VMhDlBNVFzZCfszQzV5kR
        RrCzM5D1EK2u5HauLHU0Gvy7MK6vRw5jIAVrhqnWfFfaKYa9aJcHnPRTQh4nDs8TJ9R9mGkASWL3E
        YyODqcc5k1KKvZ9cL1w+CV/moEsi0zC7UYv3M4CmWyeAdm7tphXJ90CqxZ+y3s8/Qw3mTBxExgd1c
        i/AB29peQH8x0WCQ4KVq9TToBegOUIK47H5Kf8TxJhq0Zmz+9OkGteILuo/RiBozGkR8sYlC/gQ4g
        gL35KZkV4+EoMsLQEVcZeRLrLAIPqCyoVTUiZUZREGEQzvpfsSvrUWVliIuVUw8cbY/qyDRpKEPCc
        BGiiqW1w==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOBce-00ApIz-Hx; Mon, 22 Mar 2021 03:52:58 +0000
Subject: Re: [PATCH] mm: Fix typos in comments
To:     Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Rik van Riel <riel@redhat.com>
References: <20210322025152.GA1922846@gmail.com>
 <20210322034408.GD1719932@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2cc83cd7-6fd2-2b4f-b03a-5e1a384aa137@infradead.org>
Date:   Sun, 21 Mar 2021 20:52:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322034408.GD1719932@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/21 8:44 PM, Matthew Wilcox wrote:
> On Mon, Mar 22, 2021 at 03:51:52AM +0100, Ingo Molnar wrote:
>> +++ b/mm/huge_memory.c
>> @@ -1794,7 +1794,7 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
>>  /*
>>   * Returns
>>   *  - 0 if PMD could not be locked
>> - *  - 1 if PMD was locked but protections unchange and TLB flush unnecessary
>> + *  - 1 if PMD was locked but protections unchanged and TLB flush unnecessary
>>   *  - HPAGE_PMD_NR is protections changed and TLB flush necessary
> 
> s/is/if/
> 
>> @@ -5306,7 +5306,7 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>>  
>>  	/*
>>  	 * vma need span at least one aligned PUD size and the start,end range
>> -	 * must at least partialy within it.
>> +	 * must at least partially within it.
> 
> 	 * vma needs to span at least one aligned PUD size, and the range
> 	 * must be at least partially within in.
> 
>>  /*
>>   * swapon tell device that all the old swap contents can be discarded,
>> - * to allow the swap device to optimize its wear-levelling.
>> + * to allow the swap device to optimize its wear-leveling.
>>   */
> 
> Levelling is british english, leveling is american english.  we don't
> usually "correct" one into the other.

How about "labelled" (from mm/kasan/shadow.c):

@@ -384,7 +384,7 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
  * How does this work?
  * -------------------
  *
- * We have a region that is page aligned, labelled as A.
+ * We have a region that is page aligned, labeled as A.
  * That might not map onto the shadow in a way that is page-aligned:


-- 
~Randy

