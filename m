Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761333052EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 07:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhA0GBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 01:01:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11610 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhA0D17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:27:59 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DQRnG6QC1z1607m;
        Wed, 27 Jan 2021 10:07:14 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 10:08:22 +0800
Subject: Re: [PATCH] mm/hugetlb: Fix use after free when subpool max_hpages
 accounting is not enabled
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210126115510.53374-1-linmiaohe@huawei.com>
 <a5952a6f-aaf4-b542-f9f1-5603658a602a@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d8dfb9e4-1823-cc79-3d8c-18240fdd0567@huawei.com>
Date:   Wed, 27 Jan 2021 10:08:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a5952a6f-aaf4-b542-f9f1-5603658a602a@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/27 8:06, Mike Kravetz wrote:
> On 1/26/21 3:55 AM, Miaohe Lin wrote:
>> When subpool max_hpages accounting is not enabled, used_hpages is always 0
>> and might lead to release subpool prematurely because it indicates no pages
>> are used now while there might be.
> 
> It might be good to say that you need min_hpages accounting (min_size mount
> option) enabled for this issue to occur.  Or, perhaps say this is possible
> if a hugetlbfs filesystem is created with the min_size option and without
> the size option.
> 
> That might better explain the conditions in which a user could see the issue.

So commit log might looks like this ?
"""
If a hugetlbfs filesystem is created with the min_size option and without
the size option, used_hpages is always 0 and might lead to release subpool
prematurely because it indicates no pages are used now while there might
be.

In order to fix this issue, we should check used_hpages == 0 iff max_hpages
accounting is enabled. As max_hpages accounting should be enabled in most
common case, this is not worth a Cc stable.
"""

If so, should I send a V2 or Andrew would kindly do this?
Many thanks.

> 
>> In order to fix this issue, we should check used_hpages == 0 iff max_hpages
>> accounting is enabled. As max_hpages accounting should be enabled in most
>> common case, this is not worth a Cc stable.
> 
> I agree that such a combination of mount options is very uncommon.
> 
>>
>> Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/hugetlb.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> Thanks,
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 

Many thanks for review.
