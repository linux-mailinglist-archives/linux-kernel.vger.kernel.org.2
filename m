Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7339335D533
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 04:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245524AbhDMCX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 22:23:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15670 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbhDMCXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 22:23:24 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FK8T82twXzpXr7;
        Tue, 13 Apr 2021 10:20:12 +0800 (CST)
Received: from [10.174.176.162] (10.174.176.162) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 10:22:58 +0800
Subject: Re: [PATCH v2 5/5] mm/hugetlb: remove unused variable pseudo_vma in
 remove_inode_hugepages()
To:     Mike Kravetz <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210410072348.20437-1-linmiaohe@huawei.com>
 <20210410072348.20437-6-linmiaohe@huawei.com>
 <1c079255-180e-6002-45d3-a5742d4c3346@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <02371319-5120-7124-0230-d5637910d87e@huawei.com>
Date:   Tue, 13 Apr 2021 10:22:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1c079255-180e-6002-45d3-a5742d4c3346@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/4/13 2:51, Mike Kravetz wrote:
> On 4/10/21 12:23 AM, Miaohe Lin wrote:
>> The local variable pseudo_vma is not used anymore.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thanks,
> 
> That should have been removed with 1b426bac66e6 ("hugetlb: use same fault
> hash key for shared and private mappings").
> 

Yep. Many thanks for Reviewed-by tag! :)

> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 

