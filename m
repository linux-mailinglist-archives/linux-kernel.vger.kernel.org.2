Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CDB39E9ED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 01:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhFGXMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 19:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhFGXMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:12:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A0A860C3E;
        Mon,  7 Jun 2021 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623107411;
        bh=9UuCN+TnLjTrMeiN8mN4PXlQmkc7yNBRa8Ows9g7YbA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ulg7njePPNVdiIQya2C8UglI1v15Su5q3iMtCmHB6wIw7/3pU7BzlF9U2stDWalIU
         ie+6/oB5j8Nb0FVJP/iz5rAsnsEhJVKXwXEulZzSYjBLY54vo34RJrQiMIw6pCnb74
         eNJUX9vAs3zPZEcVxS2Ml87diJiHh8GOICbrQjug=
Date:   Mon, 7 Jun 2021 16:10:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <sjenning@redhat.com>, <ddstreet@ieee.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] mm/zbud: reuse unbuddied[0] as buddied in zbud_pool
Message-Id: <20210607161010.94168ddc8128da6af1e45cea@linux-foundation.org>
In-Reply-To: <20210605075141.1359969-2-linmiaohe@huawei.com>
References: <20210605075141.1359969-1-linmiaohe@huawei.com>
        <20210605075141.1359969-2-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jun 2021 15:51:40 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> Since commit 9d8c5b5284e4 ("mm: zbud: fix condition check on allocation
> size"), zbud_pool.unbuddied[0] is always unused. We can reuse it as buddied
> field to save some possible memory.
> 
> ...
>
> --- a/mm/zbud.c
> +++ b/mm/zbud.c
> @@ -96,7 +96,7 @@
>  struct zbud_pool {
>  	spinlock_t lock;
>  	struct list_head unbuddied[NCHUNKS];
> -	struct list_head buddied;
> +#define buddied unbuddied[0]
>  	struct list_head lru;
>  	u64 pages_nr;
>  	const struct zbud_ops *ops;

That looks a bit hacky.  Can we at least have a comment explaining
what's going on?

Would it be better to implement this with a union, rather than a #define?
