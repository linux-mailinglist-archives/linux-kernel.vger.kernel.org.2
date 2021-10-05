Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3B54220A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhJEIZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:25:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50094 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhJEIZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:25:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 84E49223F3;
        Tue,  5 Oct 2021 08:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633422217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=638PnP/6kwwudoyNVIZJsQ9+o+u3mFo/jab12QhvCeI=;
        b=fAWIOs1pGrYbnkWvtty7jQ9bNO1FbQafZVSgRf7HPtCnqDqzfIf1bp0MxGP9DUw7igSj+T
        abNl8G8TKi6hJC7FNArV/0zj19FHO3YGAoGrXQiM88p4pWiO2xKUQBt25mfsYY/LRxWHnf
        TgcSoip8WnxY1mgaNoKg7D38hi30lCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633422217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=638PnP/6kwwudoyNVIZJsQ9+o+u3mFo/jab12QhvCeI=;
        b=7JeGGwREoDz7fBzHyEghG964l8KwffNDZ2/VbHY/kwtsoXvtEKgACyFS229lfFafjSW8AO
        rYCrFk+HzBjTRiDQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 334CBA3B85;
        Tue,  5 Oct 2021 08:23:37 +0000 (UTC)
Date:   Tue, 5 Oct 2021 09:23:35 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, riel@redhat.com
Subject: Re: [RFC PATCH 4/4] sched/numa: Don't update mm->numa_next_scan from
 fault path
Message-ID: <20211005082335.GN3891@suse.de>
References: <20211004105706.3669-1-bharata@amd.com>
 <20211004105706.3669-5-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211004105706.3669-5-bharata@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 04:27:06PM +0530, Bharata B Rao wrote:
> p->numa_scan_period is typically scaled up or down from
> the fault path and mm->numa_next_scan is updated during
> scanning from the task_work context using cmpxchg.
> 
> However there is one case where the scan period is increased
> in the fault path, but mm->numa_next_scan
> 
>  - is immediately updated and
>  - updated without using cmpxchg
> 
> Both of the above don't seem intended and hence remove
> the updation of mm->numa_next_scan from the fault path
> Updation should happen from task_work context subsequently.
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>

I believe the update was intended because it aims to reduce scanning
when the task is either completely idle or activity is in memory ranges
that are not influenced by numab. What is the user-visible impact you
observe?

My expectation is that in some cases this will increase the number of
PTE updates and migrations. It may even be a performance gain for some
workloads if it increases locality but in cases where locality is poor
(e.g. heavily shared regions or cross-node migrations), there will be a
loss due to increased numab activity.

Updating via cmpxchg would be ok to avoid potential collisions between
threads updating a shared mm.

-- 
Mel Gorman
SUSE Labs
