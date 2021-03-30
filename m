Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7305D34E331
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhC3IdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:33:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231512AbhC3IdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:33:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617093179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UcYc6tW2INSLLFfW3LxW2mAtxYuyO+4ndCyVPY/GEpU=;
        b=a+o7PoeNqAdn83N55RziM54wGk8lAbwLSMiRP6nIFq4y3xIZiVhjoFffz3ZnqEmdNEdfCO
        yEoAe5VrhIqrvDInc3pEAcmI2UIPhjVcKVFMSqTNzw0da2gRv/Fli8IQrWXQgWZ+wUqdTt
        LzzpZJUVXwIsgHbD9t3lFUu2v3Ic1Ls=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B909B162;
        Tue, 30 Mar 2021 08:32:59 +0000 (UTC)
Date:   Tue, 30 Mar 2021 10:32:47 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] linux/memcontrol.h: Remove duplicate struct declaration
Message-ID: <YGLiL4CTvLQRSXy/@dhcp22.suse.cz>
References: <20210330020246.2265371-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330020246.2265371-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-03-21 10:02:36, Wan Jiabing wrote:
> struct mem_cgroup is declared twice. One has been declared
> at forward struct declaration. Remove the duplicate.

Duplicate declaration shouldn't really cause any problems. You are right
that there is one which is independent on CONFIG_MEMCG so the below one
is not needed though. It would be great if the changelog mentioned that
so that.

> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c04d39a7967..f0ae33a0f175 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1068,8 +1068,6 @@ void split_page_memcg(struct page *head, unsigned int nr);
>  #define MEM_CGROUP_ID_SHIFT	0
>  #define MEM_CGROUP_ID_MAX	0
>  
> -struct mem_cgroup;
> -
>  static inline struct mem_cgroup *page_memcg(struct page *page)
>  {
>  	return NULL;
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
