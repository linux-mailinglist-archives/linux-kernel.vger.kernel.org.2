Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F77D33CA94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 02:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhCPBLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 21:11:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13539 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCPBLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:11:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DzwCb2v1nzPjn8;
        Tue, 16 Mar 2021 09:08:43 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 16 Mar
 2021 09:11:03 +0800
Subject: Re: [PATCH v5 1/2] erofs: avoid memory allocation failure during
 rolling decompression
To:     Huang Jianan <huangjianan@oppo.com>
CC:     <zhangshiming@oppo.com>, <guoweichao@oppo.com>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20210305062219.557128-1-huangjianan@oppo.com>
 <20210305095840.31025-1-huangjianan@oppo.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <110aa688-515d-7569-80fc-546bbeedc8c5@huawei.com>
Date:   Tue, 16 Mar 2021 09:11:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210305095840.31025-1-huangjianan@oppo.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/5 17:58, Huang Jianan via Linux-erofs wrote:
> Currently, err would be treated as io error. Therefore, it'd be
> better to ensure memory allocation during rolling decompression
> to avoid such io error.
> 
> In the long term, we might consider adding another !Uptodate case
> for such case.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> ---
>   fs/erofs/decompressor.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index 1cb1ffd10569..3d276a8aad86 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -73,7 +73,8 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
>   			victim = availables[--top];
>   			get_page(victim);
>   		} else {
> -			victim = erofs_allocpage(pagepool, GFP_KERNEL);
> +			victim = erofs_allocpage(pagepool,
> +						 GFP_KERNEL | __GFP_NOFAIL);
>   			if (!victim)
>   				return -ENOMEM;

A little bit weird that we still need to check return value of erofs_allocpage()
after we pass __GFP_NOFAIL parameter.

Thanks,

>   			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
> 
