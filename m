Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18747321208
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 09:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhBVIbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 03:31:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:33944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhBVIbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 03:31:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613982633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zmWkGYIaCCw8mtQmi1p4MTfm8qVfNgEdPbexW0q29RI=;
        b=tnEsNhyRIjzJkTMRqIuFVbxRwqFGqW2Ix9CuVlIeg9mhaTDSqcB3pLKarLARUPu24SmjKn
        1PYw2Bc7YKtKNy/rPni/YyBYrJsCxtDaP9H8QXWewiqA531v4pV6MyXBJOlSEtTqT+qf4B
        RfTLKj3qXLYIWsFyWSpiOXecE0yiYwE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6D0AAAD73;
        Mon, 22 Feb 2021 08:30:33 +0000 (UTC)
Date:   Mon, 22 Feb 2021 09:30:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Use rcu_dereference in in_vfork
Message-ID: <YDNroxxiy/Rox3LS@dhcp22.suse.cz>
References: <20210221194207.1351703-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210221194207.1351703-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 21-02-21 19:42:06, Matthew Wilcox wrote:
> Fix a sparse warning by using rcu_dereference().  Technically this is a
> bug and a sufficiently aggressive compiler could reload the `real_parent'
> pointer outside the protection of the rcu lock (and access freed memory),
> but I think it's pretty unlikely to happen.
> 
> Fixes: b18dc5f291c0 ("mm, oom: skip vforked tasks from being selected")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I must have missed the RCU part.
Thanks!

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/sched/mm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 1ae08b8462a4..90b2a0bce11c 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -140,7 +140,8 @@ static inline bool in_vfork(struct task_struct *tsk)
>  	 * another oom-unkillable task does this it should blame itself.
>  	 */
>  	rcu_read_lock();
> -	ret = tsk->vfork_done && tsk->real_parent->mm == tsk->mm;
> +	ret = tsk->vfork_done &&
> +			rcu_dereference(tsk->real_parent)->mm == tsk->mm;
>  	rcu_read_unlock();
>  
>  	return ret;
> -- 
> 2.29.2
> 

-- 
Michal Hocko
SUSE Labs
