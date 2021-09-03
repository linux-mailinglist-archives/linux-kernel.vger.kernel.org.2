Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9C3FF8FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 05:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbhICDHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 23:07:14 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46996 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230499AbhICDHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 23:07:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Un3cJFF_1630638367;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Un3cJFF_1630638367)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Sep 2021 11:06:08 +0800
Date:   Fri, 3 Sep 2021 11:06:06 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>, Chao Yu <chao@kernel.org>
Cc:     xiang@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] erofs: remove the pagepool parameter from
 z_erofs_shifted_transform()
Message-ID: <YTGRHuRsVeiGM8Nq@B-P7TQMD6M-0146.local>
References: <20210831103204.881-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831103204.881-1-zbestahu@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

On Tue, Aug 31, 2021 at 06:32:04PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> We don't use the pagepool for plain format, remove it.

In my LZMA patchset, I'll rearrange such interface to make LZMA
integration easier:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/commit/?h=erofs/lzma&id=3fab9044a4fe9358e95e16780831640caf3de10b

This cleanup patch does no harm to that one, yet I think it has little
real impact (especially applying the patch above)... So I'd like to
hear Chao's suggestion about this as well. I'm fine in either ways.

(p.s. we are in 5.15 merge window, I will set up a new dev branch after
 -rc1 is out.)

Thanks,
Gao Xiang

> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/erofs/decompressor.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index a5bc4b1..8f50a36 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -360,8 +360,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
>  	return ret;
>  }
>  
> -static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq,
> -				     struct list_head *pagepool)
> +static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq)
>  {
>  	const unsigned int nrpages_out =
>  		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
> @@ -403,6 +402,6 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq,
>  		       struct list_head *pagepool)
>  {
>  	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED)
> -		return z_erofs_shifted_transform(rq, pagepool);
> +		return z_erofs_shifted_transform(rq);
>  	return z_erofs_decompress_generic(rq, pagepool);
>  }
> -- 
> 1.9.1
