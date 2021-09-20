Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0124114B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhITMmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:42:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37686 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhITMmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:42:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2E820200CF;
        Mon, 20 Sep 2021 12:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632141640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D+sTsm/QQvZLDm5RCwun3FTJYNW9+vVqCamEMpO1CSY=;
        b=DIBZ7J1XZk+XwQ4mWtTiP85s3RIiajX/B4peNtjwUwyF56rC7UA7gU+InyLC2EPqxHmKVs
        Bvl62XzpLcAPaMWGUPCrFhq+8JjR4kMlpYXSnWGJFtqKaL0rISMVbrbPTFJot3b54k1D88
        3adrw0hd2KqlqDxZbtwcFkCYNZrsBz8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F40CCA3B98;
        Mon, 20 Sep 2021 12:40:39 +0000 (UTC)
Date:   Mon, 20 Sep 2021 14:40:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Mark the OOM reaper thread as freezable
Message-ID: <YUiBRdrkjIdB/rSN@dhcp22.suse.cz>
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

What is the actual problem you are trying to solve here. Freezer details
are hairy and I have to re-learn them each time again and again but from
what I remember wait_event_freezable doesn't really depend on tyask
being freezable. It tells the freezer that the task is OK to exclude
while it is sleeping and that should be just the case for the oom
reaper. Or am I missing something?
 
> Fixes: aac453635549 ("mm, oom: introduce oom reaper")
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
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
