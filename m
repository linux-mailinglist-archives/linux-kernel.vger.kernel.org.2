Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59485316183
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhBJIyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:54:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12167 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhBJIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:52:27 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DbD3T2wpGzlHrV;
        Wed, 10 Feb 2021 16:49:57 +0800 (CST)
Received: from [10.174.179.149] (10.174.179.149) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Feb 2021 16:51:41 +0800
Subject: Re: [PATCH] mm/hugetlb: use some helper functions to cleanup code
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
References: <20210210065346.21958-1-linmiaohe@huawei.com>
 <4bb381fc-eae5-effd-214d-8d62e66da272@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ccdf2213-651c-ae04-1a2f-4e69fdd2faa8@huawei.com>
Date:   Wed, 10 Feb 2021 16:51:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4bb381fc-eae5-effd-214d-8d62e66da272@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/10 16:35, David Hildenbrand wrote:
> On 10.02.21 07:53, Miaohe Lin wrote:
>> We could use pages_per_huge_page to get the number of pages per hugepage,
>> use get_hstate_idx to calculate hstate index, and use hstate_is_gigantic
>> to check if a hstate is gigantic to make code more succinct.
>>
> 
> Another suggestion, please collect and group your cleanups for a subsystem and send them in a single cleanup patch series where possible. Again, makes life easier for reviewers and maintainers.
> 

Many thanks for your suggestion again. I will keep it in mind. :)

> Thanks!
> 

Thanks a lot.

> 

