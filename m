Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10543FB49F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhH3LeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:34:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38584 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhH3LeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:34:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C4FBF220FD;
        Mon, 30 Aug 2021 11:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630323194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbtIM/v0tAoR2oZYjGEg40bXhpo80BebKdAbqKmN8do=;
        b=Lp5XNbGdjWfYGvXx9OPoXj2ke48ZaSuF4sCVstvFcEQAql7EY7rBKIXyX6KCkgj5MuWvH2
        N+pQsDJPwmhl0OpHeDYBDhJc3RaliARw8U4lsUcOSmfFuRrl8iQHGvX0uhSfcLe2l/fybS
        tTTtVLsoEJNMY1lA6UyIV2yZnYGLpz8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 67799A3B8C;
        Mon, 30 Aug 2021 11:33:14 +0000 (UTC)
Date:   Mon, 30 Aug 2021 13:33:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        stable@kernel.org, Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm,vmscan: fix divide by zero in get_scan_count
Message-ID: <YSzB9q1kVjKce7ly@dhcp22.suse.cz>
References: <20210826220149.058089c6@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826220149.058089c6@imladris.surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-08-21 22:01:49, Rik van Riel wrote:
> Changeset f56ce412a59d ("mm: memcontrol: fix occasional OOMs due to
> proportional memory.low reclaim") introduced a divide by zero corner
> case when oomd is being used in combination with cgroup memory.low
> protection.
> 
> When oomd decides to kill a cgroup, it will force the cgroup memory
> to be reclaimed after killing the tasks, by writing to the memory.max
> file for that cgroup, forcing the remaining page cache and reclaimable
> slab to be reclaimed down to zero.
> 
> Previously, on cgroups with some memory.low protection that would result
> in the memory being reclaimed down to the memory.low limit, or likely not
> at all, having the page cache reclaimed asynchronously later.
> 
> With f56ce412a59d the oomd write to memory.max tries to reclaim all the
> way down to zero, which may race with another reclaimer, to the point of
> ending up with the divide by zero below.
> 
> This patch implements the obvious fix.

I must be missing something but how can cgroup_size be ever 0 when it is
max(cgroup_size, protection) and protection != 0?
-- 
Michal Hocko
SUSE Labs
