Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B50D30BA12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhBBIia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:38:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11670 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhBBIiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:38:10 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DVJ6p2NvszlDB6;
        Tue,  2 Feb 2021 16:35:46 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 16:37:20 +0800
Subject: Re: mm/hugetlb.c: Fix typos in comments
To:     Zhiyuan Dai <daizhiyuan@phytium.com.cn>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mike.kravetz@oracle.com>, <akpm@linux-foundation.org>
References: <1612254842-6894-1-git-send-email-daizhiyuan@phytium.com.cn>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e6d087ef-53c4-a38f-9664-3dd16b573c02@huawei.com>
Date:   Tue, 2 Feb 2021 16:37:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1612254842-6894-1-git-send-email-daizhiyuan@phytium.com.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/2 16:34, Zhiyuan Dai wrote:
> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>

No patch description ?

> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 18f6ee3..35db386 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3990,7 +3990,7 @@ void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
>  
>  /*
>   * This is called when the original mapper is failing to COW a MAP_PRIVATE
> - * mappping it owns the reserve page for. The intention is to unmap the page
> + * mapping it owns the reserve page for. The intention is to unmap the page
>   * from other VMAs and let the children be SIGKILLed if they are faulting the
>   * same region.
>   */
> 

