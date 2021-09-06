Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46029401827
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 10:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbhIFIl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 04:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhIFIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:41:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF96C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 01:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xT814fvWWw70J/M6nc8pISxm2/K29BOxkkAtfEmol6A=; b=aWOWFIKoKbEgpB/11WlRhs7NYQ
        FgHMpo+La1rd1IhbdPsSy/ThFnQ/LzZgp4+2DE4dokxiyX1VEEPq/LrmKsaZ371Kj8LKQCt1j9Fkb
        tFN323ZT8xcO+nUSRCzetUgtXrwKhZ6AzYoGAdCtBbR5GiGQUFqF10FEKEjQh7wlD1XfXwxCPZfHH
        u1wPRd4/b/LEMImjLvUaPxq8i9T1FFpiXan04sT/OA3eq4vUHNsT0ANcgfA9cD/Y7oNQWl6OF9BA4
        HQg4qk+Honk7uK2k/Ob2CC0ljaEka/p30fhfFY9nTz/EPS3X9dKD889DVyJVGhL0iSEsVaYAsfRXT
        23jHhYQQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNA8x-006mhR-5b; Mon, 06 Sep 2021 08:38:57 +0000
Date:   Mon, 6 Sep 2021 09:38:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     minchan@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ytk.lee@samsung.com,
        jaewon31.kim@gmail.com
Subject: Re: [PATCH] zram_drv: allow reclaim on bio_alloc
Message-ID: <YTXTe3U8RrvSAynl@infradead.org>
References: <CGME20210906052847epcas1p1f53f1ad04ad785d53f64eef150969c34@epcas1p1.samsung.com>
 <20210906052926.6007-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906052926.6007-1-jaewon31.kim@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 02:29:26PM +0900, Jaewon Kim wrote:
> The read_from_bdev_async is not called on atomic context. So GFP_NOIO is
> available rather than GFP_ATOMIC. If there were reclaimable pages with
> GFP_NOIO, we can avoid allocation failure and page fault failure.
> 
> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
>  drivers/block/zram/zram_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index fcaf2750f68f..53be528a39a2 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -587,7 +587,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
>  {
>  	struct bio *bio;
>  
> -	bio = bio_alloc(GFP_ATOMIC, 1);
> +	bio = bio_alloc(GFP_NOIO|__GFP_HIGHMEM, 1);

Passing __GFP_HIGHMEM to bio_alloc does not make any sense whatsoever.
