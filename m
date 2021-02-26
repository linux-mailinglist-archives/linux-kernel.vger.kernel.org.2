Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58820325E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 08:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhBZHbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 02:31:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:38170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhBZHbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 02:31:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614324623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/HXqAM02hgi7ybH8245YJw1MoO6x4InLvKQoF/F6t3Q=;
        b=HmiQf+eyhJgYGs+fZUOhQlZQxTht6Vo62QPSRWm+lz1V8L1hi+FxfQ5IJexO9L+M/nTKiP
        JbkalI6qrAWfD48UdLhV8T/eui+TOnzvKATapWnlxqlXK409Pxo04fMPfW9HUQcnM/yDkO
        4C6NnFb2szdnoNaFben5RIyY+OiumPk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 91F0EAAAE;
        Fri, 26 Feb 2021 07:30:23 +0000 (UTC)
Date:   Fri, 26 Feb 2021 08:30:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     hannes@cmpxchg.org, guro@fb.com, shakeelb@google.com,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: memcontrol: add description for oom_kill
Message-ID: <YDijjovHAer2tiL5@dhcp22.suse.cz>
References: <20210226021254.3980-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226021254.3980-1-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-02-21 18:12:54, Yang Shi wrote:
> When debugging an oom issue, I found the oom_kill counter of memcg is
> confusing.  At the first glance without checking document, I thought it
> just counts for memcg oom, but it turns out it counts both global and
> memcg oom.

Yes, this is the case indeed. The point of the counter was to count oom
victims from the memcg rather than matching that to the source of the
oom. Rememeber that this could have been a memcg oom up in the
hierarchy as well. Counting victims on the oom origin could be equally
confusing because in many cases there would be no victim counted for the
above mentioned memcg ooms.

> The cgroup v2 documents it, but the description is missed for cgroup v1.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index 0936412e044e..44d5429636e2 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -851,6 +851,9 @@ At reading, current status of OOM is shown.
>  	  (if 1, oom-killer is disabled)
>  	- under_oom	   0 or 1
>  	  (if 1, the memory cgroup is under OOM, tasks may be stopped.)
> +        - oom_kill         integer counter
> +          The number of processes belonging to this cgroup killed by any
> +          kind of OOM killer.
>  
>  11. Memory Pressure
>  ===================
> -- 
> 2.26.2
> 

-- 
Michal Hocko
SUSE Labs
