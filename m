Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E5531E455
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 03:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhBRC1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 21:27:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12551 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhBRC1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 21:27:51 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dgz7t493bzMZP5;
        Thu, 18 Feb 2021 10:25:14 +0800 (CST)
Received: from [10.174.179.144] (10.174.179.144) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 18 Feb 2021 10:27:06 +0800
Subject: Re: [PATCH] mm/hugetlb: remove redundant reservation check condition
 in alloc_huge_page()
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210210075443.26238-1-linmiaohe@huawei.com>
 <32f628d5-fa0c-2a81-2de4-d0a76d1c3e45@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9cd0da77-65c3-5ba2-f882-b54a1950bf39@huawei.com>
Date:   Thu, 18 Feb 2021 10:27:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <32f628d5-fa0c-2a81-2de4-d0a76d1c3e45@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/13 9:15, Mike Kravetz wrote:
> On 2/9/21 11:54 PM, Miaohe Lin wrote:
>> If there is no reservation corresponding to a vma, map_chg is always != 0,
>> i.e. we can not meet the condition where a vma does not have reservation
>> while map_chg = 0.
> 
> This commit message might be easier to understand?
> 
> vma_resv_map(vma) checks if a reserve map is associated with the vma.  The
> routine vma_needs_reservation() will check vma_resv_map(vma) and return 1
> if no reserv map is present.  map_chg is set to the return value of
> vma_needs_reservation().  Therefore, !vma_resv_map(vma) is redundant in the
> expression:
> 	map_chg || avoid_reserve || !vma_resv_map(vma);
> Remove the redundant check.
> 

Sorry for late respond! I will use this wonderful commit message. Many thanks! :)
