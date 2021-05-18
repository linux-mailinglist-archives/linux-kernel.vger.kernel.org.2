Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101553873C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbhERIJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:09:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:39820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240297AbhERIJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:09:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621325304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kk1qPoYDlAPLLLIO1VeWEWT4R+gGs203SDLCkqqdSaI=;
        b=RsrOe6xMlviX5zjBCwXuWiWlz3EvIoz3OSBP3LCcwmMPwY/A0kUTBz5H0o1q827/xtqF9s
        pjmFwRcQRNPWvtHD+fKZHwScCwuPjnNkBa7TzNac/Bz5idRVLnD+c0OZkPqhA1QZ2GwUNK
        IivDIZ+AmPIqxgOyFcnMhGqwUL1Rv9w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D521CAD5C;
        Tue, 18 May 2021 08:08:23 +0000 (UTC)
Date:   Tue, 18 May 2021 10:08:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     wenhuizhang <wenhui@gwmail.gwu.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcontrol: use flexible-array member
Message-ID: <YKN19XI/6Wpk9+Eh@dhcp22.suse.cz>
References: <20210518052038.491-1-wenhui@gwmail.gwu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518052038.491-1-wenhui@gwmail.gwu.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-05-21 01:20:36, wenhuizhang wrote:
> 
> Change depracated zero-length-and-one-element-arrays into flexible 
> array member.
> Zero-length and one-element arrays detected by Lukas's CodeChecker.
> Zero/one element arrays causes undefined behaviours if sizeof() used.
> 
> https://www.kernel.org/doc/html/latest/processd/deprecated.html

I do understand why zero-length structures are discouraged for trail
space but does the same concern apply to internal padding inside
structures to enforce alignment to different cache lines? AFAIK this is
a trick we use at other places and I do not remember having heard about
any problems.

nodeinfo is a different case where flexible arrays seems reasonable to
me.

> Signed-off-by: wenhuizhang<wenhui@gwmail.gwu.edu>
> ---
>  include/linux/memcontrol.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0ce97eff79e2..f879efb1bc6e 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -190,7 +190,7 @@ enum memcg_kmem_state {
>  
>  #if defined(CONFIG_SMP)
>  struct memcg_padding {
> -	char x[0];
> +	char x[];
>  } ____cacheline_internodealigned_in_smp;
>  #define MEMCG_PADDING(name)      struct memcg_padding name;
>  #else
> @@ -349,7 +349,7 @@ struct mem_cgroup {
>  	struct deferred_split deferred_split_queue;
>  #endif
>  
> -	struct mem_cgroup_per_node *nodeinfo[0];
> +	struct mem_cgroup_per_node *nodeinfo[];
>  	/* WARNING: nodeinfo must be the last member here */
>  };
>  
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
