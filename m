Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E28330616
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhCHCwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:52:44 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13446 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhCHCwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:52:24 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Dv2sC28CJzjWWH;
        Mon,  8 Mar 2021 10:50:55 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 8 Mar 2021
 10:52:20 +0800
Subject: Re: [PATCH v2] erofs: fix bio->bi_max_vecs behavior change
To:     Gao Xiang <hsiangkao@redhat.com>
CC:     Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, <linux-kernel@vger.kernel.org>,
        Martin DEVERA <devik@eaxlabs.cz>
References: <20210306033109.28466-1-hsiangkao@aol.com>
 <20210306040438.8084-1-hsiangkao@aol.com>
 <6525c63c-a6e2-8c39-6c9a-1ca9b54632d8@huawei.com>
 <20210308023650.GA3537842@xiangao.remote.csb>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <7a96c4f3-128b-6248-b25c-a838ef16a4e5@huawei.com>
Date:   Mon, 8 Mar 2021 10:52:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210308023650.GA3537842@xiangao.remote.csb>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/8 10:36, Gao Xiang wrote:
> Hi Chao,
> 
> On Mon, Mar 08, 2021 at 09:29:30AM +0800, Chao Yu wrote:
>> On 2021/3/6 12:04, Gao Xiang wrote:
>>> From: Gao Xiang <hsiangkao@redhat.com>
>>>
>>> Martin reported an issue that directory read could be hung on the
>>> latest -rc kernel with some certain image. The root cause is that
>>> commit baa2c7c97153 ("block: set .bi_max_vecs as actual allocated
>>> vector number") changes .bi_max_vecs behavior. bio->bi_max_vecs
>>> is set as actual allocated vector number rather than the requested
>>> number now.
>>>
>>> Let's avoid using .bi_max_vecs completely instead.
>>>
>>> Reported-by: Martin DEVERA <devik@eaxlabs.cz>
>>> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
>>
>> Looks good to me, btw, it needs to Cc stable mailing list?
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
> 
> Thanks for your review. <= 5.11 kernels are not impacted.
> For now, this only impacts 5.12-rc due to a bio behavior
> change (see commit baa2c7c97153). So personally I think
> just leave as it is is fine.

Okay, so that's fine if you send pull request before 5.12 formal release. ;)

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>> Thanks,
>>
> 
> .
> 
