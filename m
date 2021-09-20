Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18558411F27
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 19:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244569AbhITRiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 13:38:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55442 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351892AbhITRgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 13:36:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7FB6D1FD59;
        Mon, 20 Sep 2021 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632159270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fcviXv9Vg3lihYydgrTXaFZRd5Ie7N10yUs37zQE7Eg=;
        b=pLlaFHHB0xQ535CYbSGyPaRvnEGObFKDhtxRtgwiUNj74sY8IG00qnyqAQs2JpWle6hytg
        cT+yWqJ4F1VaSel2sfWyjgJJa3B6X4Nd25ecGPly/D+YQ95m6fpJerAAfAl9xweMSNlNg6
        C+EeTpOYjFSaT4sMPKvc6V68WLgvi+A=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A70BA3E08;
        Mon, 20 Sep 2021 17:34:30 +0000 (UTC)
Date:   Mon, 20 Sep 2021 19:34:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Mark the OOM reaper thread as freezable
Message-ID: <YUjGIuQciY7HNj+Y@dhcp22.suse.cz>
References: <20210918233920.9174-1-sultan@kerneltoast.com>
 <YUiBRdrkjIdB/rSN@dhcp22.suse.cz>
 <YUiu42krQjSTVPnc@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUiu42krQjSTVPnc@sultan-box.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-09-21 08:55:15, Sultan Alsawaf wrote:
> On Mon, Sep 20, 2021 at 02:40:37PM +0200, Michal Hocko wrote:
> > What is the actual problem you are trying to solve here.
> 
> There isn't any specific problem I'm trying to solve here; simply that, it
> appeared as though you intended for the reaper thread to be freezable when it
> actually isn't. The OOM killer is disabled after processes are frozen though so
> I guess it could be considered a matter of consistency to freeze the reaper
> thread too.

The intention and the scope of the patch should be in the changelog.
Your Fixes tag suggests there is a problem to fixed.
 
> Do you remember why you used wait_event_freezable()?

My memory has faded but I suspect it was to make sure that the oom
reaper is not blocking the system wide freezing. The operation mode of
the thread is to wait for oom victims and then do the unmapping without
any blocking. While it can be frozen during the operation I do not
remember that causing any problems and the waiting is exactly the point
when that is obviously safe - hence wait_event_freezable which I believe
is the proper API to use.

> > Freezer details are hairy and I have to re-learn them each time again and
> > again but from what I remember wait_event_freezable doesn't really depend on
> > tyask being freezable. It tells the freezer that the task is OK to exclude
> > while it is sleeping and that should be just the case for the oom reaper. Or
> > am I missing something?
> 
> The task indeed doesn't need to be freezable, but the rest of what you remember
> isn't quite true. It tells the freezer to exclude the task only because the task
> will handle entering the freezer on its own. When a task sleeps on
> wait_event_freezable(), it will be woken up when system-wide freezing starts,
> and then it will try to freeze itself (see freezable_schedule() and
> freezer_count()).

Thanks for the clarification.

> If the freezer bits here are undesired then I think wait_event_interruptible()
> should be used instead.

I am not saying it is undesired. The crux is to be clear in the
reasoning.
-- 
Michal Hocko
SUSE Labs
