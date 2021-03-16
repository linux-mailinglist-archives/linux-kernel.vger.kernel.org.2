Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1933CE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 07:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhCPGtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 02:49:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13622 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhCPGtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 02:49:36 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F03kj2D50z17Ltv;
        Tue, 16 Mar 2021 14:47:41 +0800 (CST)
Received: from [10.174.177.131] (10.174.177.131) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 16 Mar 2021 14:49:31 +0800
Subject: Re: [PATCH v2 5/5] mm/hugetlb: avoid calculating fault_mutex_hash in
 truncate_op case
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210316022758.52993-1-linmiaohe@huawei.com>
 <d87264fb-0005-4f8b-7551-a5439108e9e1@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4b3e9ea6-69e3-493c-342e-92117f274e06@huawei.com>
Date:   Tue, 16 Mar 2021 14:49:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <d87264fb-0005-4f8b-7551-a5439108e9e1@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/16 11:07, Mike Kravetz wrote:
> On 3/15/21 7:27 PM, Miaohe Lin wrote:
>> The fault_mutex hashing overhead can be avoided in truncate_op case
>> because page faults can not race with truncation in this routine.  So
>> calculate hash for fault_mutex only in !truncate_op case to save some cpu
>> cycles.
>>
>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>> v1->v2:
>> remove unnecessary initialization for variable hash
>> collect Reviewed-by tag from Mike Kravetz
> 
> My apologies for not replying sooner and any misunderstanding from my
> previous comments.
> 

That's all right.

> If the compiler is going to produce a warning because the variable is
> not initialized, then we will need to keep the initialization.
> Otherwise, this will show up as a build regression.  Ideally, there
> would be a modifier which could be used to tell the compiler the
> variable will used.  I do not know if such a modifier exists.
> 

I do not know if such a modifier exists too. But maybe not all compilers are intelligent
enough to not produce a warning. It would be safe to keep the initialization...

> The patch can not produce a new warning.  So, if you need to initialize

So just drop this version of the patch? Or should I send a new version with your Reviewed-by tag and
keep the initialization?

> the variable then do it.  My Reviewed-by still applies.
>
