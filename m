Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B3F39A1A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhFCM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:58:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59512 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhFCM56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:57:58 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 55DBE219E6;
        Thu,  3 Jun 2021 12:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622724973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z7m/LCBx78+c6nHqpE0hXxafCQ4I1Zl45KbB0XxDwUk=;
        b=sWtgksJAHHOa9OHr4ZMgmPhisMy0ckAewux7uBO3zJuvRQ4kxqMVlUzea39oHQaTq52hq7
        6jmwZrQbPB+9fxFkZupZ/fzdD4hKuQ4a89VEHLxUPWpJA6UW6QNqhSFDS2D1aTT1+qxVNL
        S4k/iQxdSMVPNGBlflXk5MZJzEJLs+I=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2ACA1A3B8A;
        Thu,  3 Jun 2021 12:56:13 +0000 (UTC)
Date:   Thu, 3 Jun 2021 14:56:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     chenguanyou <chenguanyou9338@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        keescook@chromium.org, lukas.bulwahn@gmail.com, vbabka@suse.cz,
        gpiccoli@canonical.com, chenguanyou <chenguanyou@xiaomi.com>
Subject: Re: [PATCH] [fuse] alloc_page nofs avoid deadlock
Message-ID: <YLjRbEekFbjZXqiI@dhcp22.suse.cz>
References: <20210603124105.29052-1-chenguanyou@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603124105.29052-1-chenguanyou@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-06-21 20:41:05, chenguanyou wrote:
> ABA deadlock
> 
> PID: 17172 TASK: ffffffc0c162c000 CPU: 6 COMMAND: "Thread-21"
> 
> PID: 9652 TASK: ffffffc0c9ce0000 CPU: 4 COMMAND: "kworker/u16:8"

Please be much more specific about the underlying issue and what the
actual lock dependency during the reclaim is. The above is essentially
void of any relevant information.

> Signed-off-by: chenguanyou <chenguanyou@xiaomi.com>
> ---
>  fs/fuse/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index c0fee830a34e..d36125ff0405 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -721,7 +721,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>  			if (cs->nr_segs >= cs->pipe->max_usage)
>  				return -EIO;
>  
> -			page = alloc_page(GFP_HIGHUSER);
> +			page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
>  			if (!page)
>  				return -ENOMEM;
>  
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
