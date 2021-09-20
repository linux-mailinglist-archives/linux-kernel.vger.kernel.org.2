Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72B441274E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 22:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhITUdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 16:33:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53466 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhITUbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 16:31:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9CCFC21DF7;
        Mon, 20 Sep 2021 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632169813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BqPXGLxBTE8qoccsVMO4rB8AvTGsYllp8B25Awtj3T8=;
        b=ijDkGCb15uUNE6To4BOCCB+9rkupV1KEgJf5DHafl2WXLO9CqsTq3Khkt9ihhfa2YepUE1
        VxoBfzgvS8hdZFcwhOjY8jw95/L1BU33VYNiT++jDHdjboDuDi8eQP7K9WxBXYTzhYcLE6
        h8tftd7o73eNusxrtA8tQJw2qdGMKhY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 64D9FA3B99;
        Mon, 20 Sep 2021 20:30:13 +0000 (UTC)
Date:   Mon, 20 Sep 2021 22:30:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Mark the OOM reaper thread as freezable
Message-ID: <YUjvVP8pFL3Be9Jv@dhcp22.suse.cz>
References: <20210918233920.9174-1-sultan@kerneltoast.com>
 <YUiBRdrkjIdB/rSN@dhcp22.suse.cz>
 <YUiu42krQjSTVPnc@sultan-box.localdomain>
 <YUjGIuQciY7HNj+Y@dhcp22.suse.cz>
 <YUjeF6YsHKljSFis@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUjeF6YsHKljSFis@sultan-box.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-09-21 12:16:39, Sultan Alsawaf wrote:
> On Mon, Sep 20, 2021 at 07:34:26PM +0200, Michal Hocko wrote:
> > The intention and the scope of the patch should be in the changelog.
> > Your Fixes tag suggests there is a problem to fixed.
> 
> I guess References would be more appropriate here? I'm not familiar with every
> subsystem's way of doing things, so I just rolled with Fixes to leave a
> breadcrumb trail to the original commit implicated in my change. What would you
> suggest in a case like this for mm patches?

We usually tend to provide Fixes where there has been something fixed.
It seems just confusing if it is used for non functional changes,
cleanups etc. Thera are gray zones of course.

> > My memory has faded but I suspect it was to make sure that the oom
> > reaper is not blocking the system wide freezing. The operation mode of
> > the thread is to wait for oom victims and then do the unmapping without
> > any blocking. While it can be frozen during the operation I do not
> > remember that causing any problems and the waiting is exactly the point
> > when that is obviously safe - hence wait_event_freezable which I believe
> > is the proper API to use.
> 
> This isn't clear to me. Kthreads come with PF_NOFREEZE set by default, so the
> system-wide freezing will already ignore the reaper thread as-is, although it
> will make that determination from inside freeze_task() and thus
> freezing_slow_path(), which involves acquiring a lock. You could set
> PF_FREEZER_SKIP to skip the slowpath evaluation entirely.

I am not sure I follow. My understanding is that we need to make sure
oom_reaper is not running after the quiescent state as it is changing
user space address space. For that I believe we need to freeze the
kthread at a proper moment. That is currently the entry point and maybe
we can extend that even to the reaping loop but I haven't really
explored that. PF_FREEZER_SKIP would skip over the reaper and that could
result in it racing with the snapshotting no?

> Furthermore, the use of wait_event_freezable() will make the reaper thread enter
> try_to_freeze() every time it's woken up. This seems wasteful considering that
> the reaper thread will never actually freeze.

Is this something to really worry about?

-- 
Michal Hocko
SUSE Labs
