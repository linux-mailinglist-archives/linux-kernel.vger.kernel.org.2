Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97573E93A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhHKOZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:25:46 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:5989 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231872AbhHKOZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628691922; x=1660227922;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9YgSar484NeNBfbw/ejSJ4MnW1zeRnwCa6czWiKgnAg=;
  b=rVYx1gRtBZ8FpV159B8YI51hmyRVH6XSHZZTjJ25bWMEe/H63/ilbvzZ
   904qGrqMqGc7TxtfF74x0v9il3JR6tAuHk6zo01DM6/9V1iIFSeeAoiOH
   a1Ls3VSE+28fEHijD4vu2Qr/aN3YUg5JWmv20Eg9j08LmC8T6fmXULe46
   g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Aug 2021 07:25:21 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 11 Aug 2021 07:25:18 -0700
Received: from [10.111.172.174] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Wed, 11 Aug
 2021 07:25:17 -0700
Subject: Re: Linux-next: crash in alloc_huge_page()
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <846c4502-3332-0d25-87f5-cb3b71afc38f@quicinc.com>
 <YRM+qm66PfTUQNFL@casper.infradead.org> <YRPaeQYHPwI9r5a/@linux.ibm.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <8379f7d5-5d89-ac37-be83-aaa185dd6c3c@quicinc.com>
Date:   Wed, 11 Aug 2021 10:25:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRPaeQYHPwI9r5a/@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03e.na.qualcomm.com (10.85.0.48) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2021 10:11 AM, Mike Rapoport wrote:
> On Wed, Aug 11, 2021 at 04:06:18AM +0100, Matthew Wilcox wrote:
>> On Tue, Aug 10, 2021 at 10:22:37PM -0400, Qian Cai wrote:
>>> and the page->lru has an address fffffffffffffffc for some reasons. Does it sound like some error code
>>> had not been handled properly and had been propagated here instead? I tried reverting a few recent
>>> commits for mm/hugetlb.c and mm/memblock.c without luck so far.
>>
>> Yes, ff..fc is going to be at offset 8 from the actual address, so
>> that's -12 and -12 is ...
>>
>> #define ENOMEM          12      /* Out of memory */
>>
>> so something's returning ERR_PTR(-ENOMEM) instead of NULL.
> 
> page is not initialized in alloc_buddy_huge_page_with_mpol() and after
> commit 2cfa8b23744f ("mm-hugetlb-add-support-for-mempolicy-mpol_preferred_many-fix") we have 

Good catch, Mike! Pretty sure I missed to test that commit thought that was an old commit along
with the rest of the mpol_preferred series.

It is a dream that one day mm tree could like other subsystem trees where "git tag --contains"
would work to indicate which linux-next tags contains a particular commit to tell the timeline
of it. Right now, we have those commits ID always changed and commit date is meaningless for
mm commits in linux-next.

> 
> 	struct page *page;
> 
> 	...
> 
> 	if (mpol_is_preferred_many(mpol)) {
> 		gfp_t gfp = gfp_mask | __GFP_NOWARN;
> 
> 		gfp &=  ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
> 		page = alloc_surplus_huge_page(h, gfp, nid, nodemask, false);
> 
> 		/* Fallback to all nodes if page==NULL */
> 		nodemask = NULL;
> 	}
> 
> 	if (!page)
> 		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask, false
> 
> 	mpol_cond_put(mpol);
> 	return page;
> 
> so for !mpol_is_preferred_many() we return an uninitialized variable.
> 
> This should fix it:
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 008662083fec..6337697f7ee4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2152,7 +2152,7 @@ static
>  struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>  		struct vm_area_struct *vma, unsigned long addr)
>  {
> -	struct page *page;
> +	struct page *page = NULL;
>  	struct mempolicy *mpol;
>  	gfp_t gfp_mask = htlb_alloc_mask(h);
>  	int nid;
>  
> 
