Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F86439796
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhJYNc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231302AbhJYNc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:32:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E982E60F46;
        Mon, 25 Oct 2021 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635168606;
        bh=Uy0l7Xr2fzwCMRbtUSSAU7UNyaQatmP0OTN2GIglWiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=u6kqskamokiskEaf1ytTiQ8jmpr5PktLgUYCcDi7GfCoHND8lgGhqcWqjBlw06/AF
         7Tkh9juvollPdVkjHN11qnl9vmKwQJ9ZbeXc5f6qkwHPc9EO12YdNM7wawqCyJ30/V
         T1gAxyEqlXj8MnGpNmcwy1RuJd0KwyJ2WFNvCLNvoPo5VURw5RIw+As2WC2m1BYsL6
         MvCVrHzcvOCTvFrpNKaXIpe0khgQnk28lJrV23TD2Q+/5qFMWE7DwmRglAL2fPnTJo
         wqypsERUyEz5gPVzXW//8QMEgl9ogo3+4NE9MYz8PnxFut6lnQlkyBtm/W4aTUWzXJ
         zb6IJUY2H6iag==
From:   SeongJae Park <sj@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, sj@kernel.org
Subject: Re: [PATCH -next] mm/damon: fix error return code in damon_reclaim_turn()
Date:   Mon, 25 Oct 2021 13:30:02 +0000
Message-Id: <20211025133002.27700-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025124500.2758060-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 20:45:00 +0800 Yang Yingliang <yangyingliang@huawei.com> wrote:

> If damon_reclaim_new_scheme() fails, it should return
> error code in damon_reclaim_turn()
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thank you for this fix!

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/reclaim.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index f5ae4c422555..dc1485044eaf 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -292,8 +292,10 @@ static int damon_reclaim_turn(bool on)
>  
>  	/* Will be freed by 'damon_set_schemes()' below */
>  	scheme = damon_reclaim_new_scheme();
> -	if (!scheme)
> +	if (!scheme) {
> +		err = -ENOMEM;
>  		goto free_region_out;
> +	}
>  	err = damon_set_schemes(ctx, &scheme, 1);
>  	if (err)
>  		goto free_scheme_out;
> -- 
> 2.25.1
> 
