Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F14B395383
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 02:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhEaAz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 20:55:59 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2412 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhEaAz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 20:55:56 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FtcCZ1L77z662n;
        Mon, 31 May 2021 08:50:34 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 08:54:16 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 08:54:15 +0800
Subject: Re: [PATCH] uprobes: Use better bitmap_zalloc()
To:     <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20210529111553.186630-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <d0adc27d-0654-385b-0f07-2232aa65c576@huawei.com>
Date:   Mon, 31 May 2021 08:54:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210529111553.186630-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for the mistake,  will fix.

On 2021/5/29 19:15, Kefeng Wang wrote:
> Use better bitmap_zalloc() to allocate bitmap.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   kernel/events/uprobes.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 907d4ee00cb2..8160d2e53219 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1487,8 +1487,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>   	if (unlikely(!area))
>   		goto out;
>   
> -	area->bitmap = kcalloc(BITS_TO_LONGS(UINSNS_PER_PAGE), sizeof(long),
> -			       GFP_KERNEL);
> +	area->bitmap = bitmap_kzalloc(UINSNS_PER_PAGE, GFP_KERNEL);
>   	if (!area->bitmap)
>   		goto free_area;
>   
> @@ -1512,7 +1511,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>   
>   	__free_page(area->pages[0]);
>    free_bitmap:
> -	kfree(area->bitmap);
> +	bitmap_kfree(area->bitmap);
>    free_area:
>   	kfree(area);
>    out:
> @@ -1553,7 +1552,7 @@ void uprobe_clear_state(struct mm_struct *mm)
>   		return;
>   
>   	put_page(area->pages[0]);
> -	kfree(area->bitmap);
> +	bitmap_kfree(area->bitmap);
>   	kfree(area);
>   }
>   
