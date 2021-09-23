Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C77B4161D0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbhIWPPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241833AbhIWPPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:15:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E3DE61107;
        Thu, 23 Sep 2021 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632410012;
        bh=mOC7FdQdjTIAxxIgBlh19xNgYctoW/1KW2f4ltIRwOs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QzbPTYuE/Ex9WyYsMRH5XreZ9GDgqJZtLVs7qppdnE3vytbbX06zTCivHQSSDGOmv
         vtfDFdG08lIEwEptWL/PinvZCMgLqCEOPLxeCZ/o3LHWd1mmpBtH277oUXrgKrW1KZ
         WjsL79EjIEXassRiWyDePshre5rskXK/T5rul5ATD9ygh6XqtM52AFFKHsSb6maU8C
         fCwMZRmNxV9T0e9W4CO/ph8OsOYof8ms9DycXLzmH/T19FejcF2Km/KFxR6+eExzG8
         mDNGkLMW/GVfB2/ofPJCkSDy1wDMiYr25DfCN2Vas7XwrKX2+NUhtuZXB4ilBrF7p3
         UfQtnhXUX963Q==
Subject: Re: [PATCH] erofs: fix compacted_2b if compacted_4b_initial >
 totalidx
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Yue Hu <zbestahu@gmail.com>
Cc:     xiang@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zhangwen@yulong.com, zbestahu@163.com
References: <20210914035915.1190-1-zbestahu@gmail.com>
 <YUAm+kOdKcCzgcEy@B-P7TQMD6M-0146.local>
 <20210914125748.00003cd2.zbestahu@gmail.com>
 <YUxp1rsN0Ce88YQI@B-P7TQMD6M-0146.local>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f9f2e7a1-7248-c5b2-64b4-2d5f91d68b6c@kernel.org>
Date:   Thu, 23 Sep 2021 23:13:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUxp1rsN0Ce88YQI@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/23 19:49, Gao Xiang wrote:
> On Tue, Sep 14, 2021 at 12:57:48PM +0800, Yue Hu wrote:
>> On Tue, 14 Sep 2021 12:37:14 +0800
>> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>> On Tue, Sep 14, 2021 at 11:59:15AM +0800, Yue Hu wrote:
>>>> From: Yue Hu <huyue2@yulong.com>
>>>>
>>>> Currently, the whole indexes will only be compacted 4B if
>>>> compacted_4b_initial > totalidx. So, the calculated compacted_2b
>>>> is worthless for that case. It may waste CPU resources.
>>>>
>>>> No need to update compacted_4b_initial as mkfs since it's used to
>>>> fulfill the alignment of the 1st compacted_2b pack and would handle
>>>> the case above.
>>>>
>>>> We also need to clarify compacted_4b_end here. It's used for the
>>>> last lclusters which aren't fitted in the previous compacted_2b
>>>> packs.
>>>>
>>>> Some messages are from Xiang.
>>>>
>>>> Signed-off-by: Yue Hu <huyue2@yulong.com>
>>>
>>> Looks good to me,
>>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>>
>>> (although I think the subject title would be better changed into
>>>   "clear compacted_2b if compacted_4b_initial > totalidx"
>>
>> Yeah, 'clear' is much better for this change.
>>
>> Thanks.
>>
>>>   since 'fix'-likewise words could trigger some AI bot for stable
>>>   kernel backporting..)
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>> ---
>>>>   fs/erofs/zmap.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>>>> index 9fb98d8..aeed404 100644
>>>> --- a/fs/erofs/zmap.c
>>>> +++ b/fs/erofs/zmap.c
>>>> @@ -369,7 +369,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>>>>   	if (compacted_4b_initial == 32 / 4)
>>>>   		compacted_4b_initial = 0;
>>>>   
>>>> -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
>>>> +	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
>>>> +	    compacted_4b_initial <= totalidx) {
> 
> btw, I've fixed up the build error due to redundant brace '{' when
> applying...

It looks good to me after above fix.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
