Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF2930B4C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhBBBgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:36:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12000 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhBBBgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:36:33 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DV6mn14TQzjH0Y;
        Tue,  2 Feb 2021 09:34:33 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 09:35:44 +0800
Subject: Re: [PATCH] mm/swap_state: Constify static struct attribute_group
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210201233254.91809-1-rikard.falkeborn@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8c500328-fda5-7a13-64d4-5d0bd292fcfa@huawei.com>
Date:   Tue, 2 Feb 2021 09:35:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210201233254.91809-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/2 7:32, Rikard Falkeborn wrote:
> The only usage of swap_attr_group is to pass its address to
> sysfs_create_group() which takes a pointer to const attribute_group.
> Make it const to allow the compiler to put it in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Looks good to me. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  mm/swap_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index d0d417efeecc..3cdee7b11da9 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -901,7 +901,7 @@ static struct attribute *swap_attrs[] = {
>  	NULL,
>  };
>  
> -static struct attribute_group swap_attr_group = {
> +static const struct attribute_group swap_attr_group = {
>  	.attrs = swap_attrs,
>  };
>  
> 

