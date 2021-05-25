Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B0038FFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhEYLaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:30:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:47560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhEYL36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:29:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621942107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ef9ucsK0g/tI2SALrOq9vcT1XTsfoCx6o4ek/N9MD8=;
        b=PIw8G33rjVFLD8+MN4DG2iyIMT6F7/t24ZSIUdRD0zw+Vj3AldPEhXhOOBPlnzyLOSJGMZ
        qkCidy/e1mYulim0wVq5+kacUZzXwusKHGiqB8s2otvZC7f1ziNQBZQiGVbn+Rd+NWs7CQ
        F+WEKF3pZtnYIzWdyotlysFBq7DAAr8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46D2EAF16;
        Tue, 25 May 2021 11:28:27 +0000 (UTC)
Date:   Tue, 25 May 2021 13:28:26 +0200
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
Subject: Re: [PATCH v2] memcontrol: use flexible-array member
Message-ID: <YKzfWhcraThWtwy9@dhcp22.suse.cz>
References: <20210518200910.29912-1-wenhui@gwmail.gwu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518200910.29912-1-wenhui@gwmail.gwu.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-05-21 16:09:08, wenhuizhang wrote:
> Change depracated zero-length-and-one-element-arrays into flexible
> array member.Zero-length and one-element arrays detected by Lukas's CodeChecker.
> Zero/one element arrays causes undefined behaviours if sizeof() used.
> 
> Signed-off-by: wenhuizhang <wenhui@gwmail.gwu.edu>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  include/linux/memcontrol.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0ce97eff79e2..3cc18c2176e7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -349,8 +349,7 @@ struct mem_cgroup {
>  	struct deferred_split deferred_split_queue;
>  #endif
>  
> -	struct mem_cgroup_per_node *nodeinfo[0];
> -	/* WARNING: nodeinfo must be the last member here */
> +	struct mem_cgroup_per_node *nodeinfo[];
>  };
>  
>  /*
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
