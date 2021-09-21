Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32929412FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhIUHvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:51:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60946 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhIUHvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:51:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9938D21D59;
        Tue, 21 Sep 2021 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632210619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FTiZUwoZLD7CoTiPY7EAa8Ut/2BuzZbrnfa7NhOfH4g=;
        b=WaTWtd/zyEaKy32pCO/ZFivMBrGBsNSSYsOmLfz2N2vNrCNSqUdoJXcC5wAJfcHU1tEjFe
        hLxCmBUc61a4RKr1Zs4/cThVcZfwuJIJ/KE+0hwgql2dctCRltou2hlafJSjc+G8Co/py7
        lAsLJeP1KoKdl9BY+Hob9NW/qbqRgbY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4584EA3B9D;
        Tue, 21 Sep 2021 07:50:19 +0000 (UTC)
Date:   Tue, 21 Sep 2021 09:50:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Mark the OOM reaper thread as freezable
Message-ID: <YUmOup7qwBbUqTJ7@dhcp22.suse.cz>
References: <20210918233920.9174-1-sultan@kerneltoast.com>
 <YUiBRdrkjIdB/rSN@dhcp22.suse.cz>
 <YUiu42krQjSTVPnc@sultan-box.localdomain>
 <YUjGIuQciY7HNj+Y@dhcp22.suse.cz>
 <YUjeF6YsHKljSFis@sultan-box.localdomain>
 <YUjvVP8pFL3Be9Jv@dhcp22.suse.cz>
 <YUkLWuJYrvNp+tMh@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUkLWuJYrvNp+tMh@sultan-box.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-09-21 15:29:46, Sultan Alsawaf wrote:
> On Mon, Sep 20, 2021 at 10:30:12PM +0200, Michal Hocko wrote:
> > We usually tend to provide Fixes where there has been something fixed.
> > It seems just confusing if it is used for non functional changes,
> > cleanups etc. Thera are gray zones of course.
> 
> Got it, thanks. So no tag would be used in such a case?
> 
> > I am not sure I follow. My understanding is that we need to make sure
> > oom_reaper is not running after the quiescent state as it is changing
> > user space address space. For that I believe we need to freeze the
> > kthread at a proper moment. That is currently the entry point and maybe
> > we can extend that even to the reaping loop but I haven't really
> > explored that. PF_FREEZER_SKIP would skip over the reaper and that could
> > result in it racing with the snapshotting no?
> 
> Kthreads cannot be implicitly frozen; it's not like PREEMPT. From what I've read
> in the freezer code, two things must occur for a kthread to freeze: the kthread
> must have PF_NOFREEZE unset (via set_freezable(), as is done in the patch I've
> submitted here), and the kthread must have an explicit call into the freezer,
> such as via wait_event_freezable().
> 
> Right now, oom_reaper is totally ignored by the freezer because PF_NOFREEZE is
> set by default in all kthreads. As such, oom_reaper can keep running while
> system-wide freezing occurs. If you think this can mangle snapshots, then
> perhaps there is a real bug here after all.

OK, now I am getting your point. Sorry for being dense here. Process
freezing has always been kinda muddy to me as I've said earlier. I have
completely misunderstood your earlier PF_NOFREEZE remark.
-- 
Michal Hocko
SUSE Labs
