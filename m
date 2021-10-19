Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A814339F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhJSPPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhJSPPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:15:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4B2860FDA;
        Tue, 19 Oct 2021 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634656421;
        bh=Ph3L3ROWzUXZd5aNMX2ea0Ma/VqirN/nUACXx0Cn39o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=by9L8Lqy4IdC7k1SO8beXKphcYzIZC45I46BlYUaQ4he4C2hT4tNiA4TG/4fEDtQ5
         KocFL9OvPiN91aZZDJIJ1e6cvlw972e0Lz9ZtFdsdTJKH1LFoQ25LPBgI1hQiWDnVr
         cCJsuJcgH+zqVLqqz7EzkbqvY3Y2m+h9TgPBp3/qrxuaX4C2lp5qz6Q0/krvSzuEb0
         lYsRa4DP6zFy1wmG9L6/0hQYIh8ABx3mR/CaqLoG+UxX5fJ3V8Xfk6duvATOKQhJGs
         Kkt6qcbP2AgpjzZLZtvOtih0/jSlyPy0tJ2/IC3WAm6tSIvzKKLKoJBOeWfp6OWB48
         wBVkz8f2LF/QQ==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon: Remove unnecessary variable initialization
Date:   Tue, 19 Oct 2021 15:13:38 +0000
Message-Id: <20211019151338.17052-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a2ddd67548879fe8f386f8daf522b47fdf99f581.1634653088.git.bier@B-X3VXMD6M-2058.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 22:26:03 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In 'damon_va_apply_three_regions', There is no
> need to set variable 'i' as 0
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/vaddr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index b8ba44f69db6..90be463efff7 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -305,7 +305,7 @@ static void damon_va_apply_three_regions(struct damon_target *t,
>  		struct damon_addr_range bregions[3])
>  {
>  	struct damon_region *r, *next;
> -	unsigned int i = 0;
> +	unsigned int i;
>  
>  	/* Remove regions which are not in the three big regions now */
>  	damon_for_each_region_safe(r, next, t) {
> -- 
> 2.31.0
