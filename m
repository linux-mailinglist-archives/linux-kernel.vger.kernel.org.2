Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDE84131ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhIUKuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:50:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37790 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhIUKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:50:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 00F9B22107;
        Tue, 21 Sep 2021 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632221320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oTrnXcZ3GhNgBeR9otu2CjH85yvge7Ji7nxVtXw19PQ=;
        b=iKaC7kwTRfYXGgddBAYmg48b6yu6Z5uetdZn7PHw7PdcbCZyz/Qu/KHmQgn/z3XawPpr4k
        nnS6T8DlF0uw4KG3co8xgOKOBBes3l3dGHuV8q0KIxd5AaUUtDsdYao0KJBR8tHgVjO6OG
        XK73OiQb7kdw7sSrJL/xlt1j5e+1FBg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BFB2EA3BA2;
        Tue, 21 Sep 2021 10:48:39 +0000 (UTC)
Date:   Tue, 21 Sep 2021 12:48:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Mark the OOM reaper thread as freezable
Message-ID: <YUmSe8s1vvh80ZP9@dhcp22.suse.cz>
References: <20210918233920.9174-1-sultan@kerneltoast.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918233920.9174-1-sultan@kerneltoast.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 18-09-21 16:39:20, Sultan Alsawaf wrote:
> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> The OOM reaper thread uses wait_event_freezable() without actually being
> marked as freezable. Fix it by adding a set_freezable() call.

After the follow up discussion it is clear what the patch does and why
it is needed. The changelog really begs for some clarification. I would
propose something like

"
The OOM reaper kthread uses wait_event_freezable while it is waiting for
any work. It is safe to freeze it while waiting. We, however, need to
prevent any activity after global freezer quiescent state because the
oom reaping is altering address space and this might alter the snapshot
theoretically (please note that this is mostly a theoretical concern not
being observed in practice so far) so the freezer has to wait for an
explicit freezing.

The current implementation doesn't work that way though because all
kernel threads are created with PF_NOFREEZE flag so they are
automatically excluded from freezing operation. This means that
oom_reaper can race with the system snapshoting if it was processing
while the system is being frozen. Fix that by set_freezable which will
make the oom_reaper visible to the freezer.
"

> 
> Fixes: aac453635549 ("mm, oom: introduce oom reaper")
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>

With the above or otherwise improved changelog feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/oom_kill.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 831340e7ad8b..46a742b57735 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -641,6 +641,8 @@ static void oom_reap_task(struct task_struct *tsk)
>  
>  static int oom_reaper(void *unused)
>  {
> +	set_freezable();
> +
>  	while (true) {
>  		struct task_struct *tsk = NULL;
>  
> -- 
> 2.33.0

-- 
Michal Hocko
SUSE Labs
