Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561DF4345A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJTHDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhJTHDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:03:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD480610EA;
        Wed, 20 Oct 2021 07:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634713276;
        bh=4/mLAWSfmQ5N31lrDoW0CUf2EeHX/XzEZDiUHcEYofA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=trC3nGm37uTj0pLjFOOKHVFeGWNBCxoncvyCXP2r9DZ/1lyppCKqzus+tvvQ7JQe4
         EOoIqrsgkNkC4NiggbsPses73JgAfai8uSSE/n/a5WwHmu26Ud2gz8PJe37g8ZEviU
         1yxGbuS2GU+Lxuz3SA9562V08FBIAdXItzAPpoDiNLtthThW144czrnD0wOjosxQe3
         Eo6x13DSvM9KIqilb20miV1f2fd2Bh4mf4eszz9CGq+egmNuyJh9sid5cY+EAYgBG/
         e2wbbVvlZ7de9p3q/r7pdwKAxsoh59KDJMCtFva2jQQvhLzzXYvN0lz9b8OdeIufLx
         J9jrkbnYfFrcA==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/damon: Remove unnecessary variable initialization
Date:   Wed, 20 Oct 2021 07:01:13 +0000
Message-Id: <20211020070113.18392-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a2ddd67548879fe8f386f8daf522b47fdf99f581.1634693911.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 09:42:32 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In 'damon_va_apply_three_regions', There is no
> need to set variable 'i' as 0
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

I gave you my 'Reviewed-by:' for the last version of this patch, but seems you
missed putting it here.  So, I'm giving it here again ;)

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
