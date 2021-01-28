Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580D8306AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhA1BrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:47:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11521 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhA1BrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:47:20 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DR3Fd0gHvzjFLj;
        Thu, 28 Jan 2021 09:45:25 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 09:46:33 +0800
Subject: Re: [PATCH] mm/hugetlb: Fix use after free when subpool max_hpages
 accounting is not enabled
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210126115510.53374-1-linmiaohe@huawei.com>
 <a5952a6f-aaf4-b542-f9f1-5603658a602a@oracle.com>
 <d8dfb9e4-1823-cc79-3d8c-18240fdd0567@huawei.com>
 <20210127161755.68bf43047007a8a2889e302a@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e90d5d7d-17b3-4c8e-68d6-8f07513502bb@huawei.com>
Date:   Thu, 28 Jan 2021 09:46:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210127161755.68bf43047007a8a2889e302a@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/28 8:17, Andrew Morton wrote:
> On Wed, 27 Jan 2021 10:08:22 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> On 2021/1/27 8:06, Mike Kravetz wrote:
>>> On 1/26/21 3:55 AM, Miaohe Lin wrote:
>>>> When subpool max_hpages accounting is not enabled, used_hpages is always 0
>>>> and might lead to release subpool prematurely because it indicates no pages
>>>> are used now while there might be.
>>>
>>> It might be good to say that you need min_hpages accounting (min_size mount
>>> option) enabled for this issue to occur.  Or, perhaps say this is possible
>>> if a hugetlbfs filesystem is created with the min_size option and without
>>> the size option.
>>>
>>> That might better explain the conditions in which a user could see the issue.
>>
>> So commit log might looks like this ?
>> """
>> If a hugetlbfs filesystem is created with the min_size option and without
>> the size option, used_hpages is always 0 and might lead to release subpool
>> prematurely because it indicates no pages are used now while there might
>> be.
>>
>> In order to fix this issue, we should check used_hpages == 0 iff max_hpages
>> accounting is enabled. As max_hpages accounting should be enabled in most
>> common case, this is not worth a Cc stable.
>> """
>>
>> If so, should I send a V2 or Andrew would kindly do this?
>> Many thanks.
> 
> I made that change, thanks.>

It's very kind of you. Many thanks.:)

> .
> 

