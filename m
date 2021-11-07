Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C461E4474E8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 19:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhKGSRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 13:17:24 -0500
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:64285 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbhKGSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 13:17:23 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id jmggmUEOWf6fnjmggmDhcI; Sun, 07 Nov 2021 19:14:39 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 07 Nov 2021 19:14:39 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] nvdimm/pmem: Fix an error handling path in
 'pmem_attach_disk()'
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <f1933a01d9cefe24970ee93d741babb8fe9c1b32.1636219557.git.christophe.jaillet@wanadoo.fr>
 <20211107171157.GC3538886@iweiny-DESK2.sc.intel.com>
 <050385c3-7707-76cb-c580-c64d43456462@wanadoo.fr>
 <22d5172f-2d13-0ce2-2029-9cf46f203792@wanadoo.fr>
Message-ID: <d791466d-56db-7dc3-342b-73db0de48b68@wanadoo.fr>
Date:   Sun, 7 Nov 2021 19:14:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <22d5172f-2d13-0ce2-2029-9cf46f203792@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 07/11/2021 à 18:25, Marion & Christophe JAILLET a écrit :
> 
> 
> Le 07/11/2021 à 18:20, Christophe JAILLET a écrit :
>> Le 07/11/2021 à 18:11, Ira Weiny a écrit :
>>> On Sat, Nov 06, 2021 at 06:27:11PM +0100, Christophe JAILLET wrote:
>>>> If 'devm_init_badblocks()' fails, a previous 'blk_alloc_disk()' call 
>>>> must
>>>> be undone.
>>>
>>> I think this is a problem...
>>>
>>>>
>>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>> ---
>>>> This patch is speculative. Several fixes on error handling paths 
>>>> have been
>>>> done recently, but this one has been left as-is. There was maybe a good
>>>> reason that I have missed for that. So review with care!
>>>>
>>>> I've not been able to identify a Fixes tag that please me :(
>>>> ---
>>>>   drivers/nvdimm/pmem.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>>>> index fe7ece1534e1..c37a1e6750b3 100644
>>>> --- a/drivers/nvdimm/pmem.c
>>>> +++ b/drivers/nvdimm/pmem.c
>>>> @@ -490,8 +490,9 @@ static int pmem_attach_disk(struct device *dev,
>>>>       nvdimm_namespace_disk_name(ndns, disk->disk_name);
>>>>       set_capacity(disk, (pmem->size - pmem->pfn_pad - 
>>>> pmem->data_offset)
>>>>               / 512);
>>>> -    if (devm_init_badblocks(dev, &pmem->bb))
>>>> -        return -ENOMEM;
>>>> +    rc = devm_init_badblocks(dev, &pmem->bb);
>>>> +    if (rc)
>>>> +        goto out;
>>>
>>> But I don't see this 'out' label in the function currently?  Was that 
>>> part of
>>> your patch missing?
>>
>> Hi,
>> the patch is based on the latest linux-next.
>> See [1]. The 'out' label exists there and is already used.
>>
>> In fact, I run an own-made coccinelle script which tries to spot 
>> mix-up between return and goto.
>> In this case, we have a 'return -ENOMEM' after a 'goto out' which 
>> looks spurious. Hence, my patch.
>>
>> [1]:https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/nvdimm/pmem.c#n512 
>>
> 
> Lol, the #n512 above is in fact another place that should be updated as 
> well. I missed it and only fixed #n494!

In fact, no, line 512 should be left as-is. The clean-up wilol be made 
by 'pmem_release_disk()'.

The patch attached at the very first mail of this thread looks good to me.

CJ

> 
> CJ
> 
>>
>> CJ
>>
>>>
>>> Ira
>>>
>>>>       nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_range);
>>>>       disk->bb = &pmem->bb;
>>>> -- 
>>>> 2.30.2
>>>>
>>>
>>
>>
> 
