Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B353F32DFE7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 04:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhCEDHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 22:07:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12694 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhCEDHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 22:07:37 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DsCKJ1x5yzlT2D;
        Fri,  5 Mar 2021 11:05:24 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 5 Mar 2021
 11:07:31 +0800
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: compress: add compress_inode to cache
 compressed blockst
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210202080056.51658-1-yuchao0@huawei.com>
 <46e9924c-0086-cd2a-2e93-7149b92ba27e@huawei.com>
 <YDsleDjeIcpuBXKA@google.com> <YEFBAuP26t0RzVHZ@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <01a0ff76-6fa7-3196-8760-e7f6f163ef64@huawei.com>
Date:   Fri, 5 Mar 2021 11:07:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YEFBAuP26t0RzVHZ@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/5 4:20, Jaegeuk Kim wrote:
> On 02/27, Jaegeuk Kim wrote:
>> On 02/04, Chao Yu wrote:
>>> Jaegeuk,
>>>
>>> On 2021/2/2 16:00, Chao Yu wrote:
>>>> -	for (i = 0; i < dic->nr_cpages; i++) {
>>>> +	for (i = 0; i < cc->nr_cpages; i++) {
>>>>    		struct page *page = dic->cpages[i];
>>>
>>> por_fsstress still hang in this line?
>>
>> I'm stuck on testing the patches, since the latest kernel is panicking somehow.
>> Let me update later, once I can test a bit. :(
> 
> It seems this works without error.
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=4e6e1364dccba80ed44925870b97fbcf989b96c9

Ah, good news.

Thanks for helping to test the patch. :)

Thanks,

> 
>>
>>>
>>> Thanks,
>>>
>>>>    		block_t blkaddr;
>>>>    		struct bio_post_read_ctx *ctx;
>>>> @@ -2201,6 +2207,14 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>>>>    		blkaddr = data_blkaddr(dn.inode, dn.node_page,
>>>>    						dn.ofs_in_node + i + 1);
>>>> +		f2fs_wait_on_block_writeback(inode, blkaddr);
>>>> +
>>>> +		if (f2fs_load_compressed_page(sbi, page, blkaddr)) {
>>>> +			if (atomic_dec_and_test(&dic->remaining_pages))
>>>> +				f2fs_decompress_cluster(dic);
>>>> +			continue;
>>>> +		}
>>>> +
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
