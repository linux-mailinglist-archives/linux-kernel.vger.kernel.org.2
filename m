Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D10343E51
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCVKs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:48:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:58064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhCVKrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:47:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616410066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4JtCXG1rJOroT9L7CmBbvZhIM6yyyU87x9CpZZfzFsk=;
        b=Ye+G6PxX6i61dHAO9FGjbjKpwX7959c8L5jlc92IzihDvTiRPeKyxc0slp7tdYsza5QNDU
        TN32DZcIQI6y0zIp0NfV1Exdm2oxWFSiH0xPgcCseP4ZnMSvBZVmsxCI2zwyjqs1++I/eH
        2E7D16QuzlNUq3cxc4NYwSlFK4UDdsM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43533AD38;
        Mon, 22 Mar 2021 10:47:46 +0000 (UTC)
Date:   Mon, 22 Mar 2021 11:47:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: try oom if reclaim is unable to make
 forward progress
Message-ID: <YFh10eSTKY5lbE9u@dhcp22.suse.cz>
References: <20210315165837.789593-1-atomlin@redhat.com>
 <YFN8wXwJA59w9twA@dhcp22.suse.cz>
 <20210319172901.cror2u53b7caws3a@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319172901.cror2u53b7caws3a@ava.usersys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 17:29:01, Aaron Tomlin wrote:
> Hi Michal,
> 
> On Thu 2021-03-18 17:16 +0100, Michal Hocko wrote:
> > On Mon 15-03-21 16:58:37, Aaron Tomlin wrote:
> > > In the situation where direct reclaim is required to make progress for
> > > compaction but no_progress_loops is already over the limit of
> > > MAX_RECLAIM_RETRIES consider invoking the oom killer.
> 
> Firstly, thank you for your response.
> 
> > What is the problem you are trying to fix?
> 
> If I understand correctly, in the case of a "costly" order allocation
> request that is permitted to repeatedly retry, it is possible to exceed the
> maximum reclaim retry threshold as long as "some" progress is being made
> even at the highest compaction priority.

Costly orders already do have heuristics for the retry in place. Could
you be more specific what kind of problem you see with those?

> Furthermore, if the allocator has a fatal signal pending, this is not
> considered.

Fatal signals pending are usually not a strong reason to cut retries
count or fail allocations.

> In my opinion, it might be better to just give up straight away or try and
> use the OOM killer only in the non-costly order allocation scenario to
> assit reclaim. Looking at __alloc_pages_may_oom() the current logic is to
> entirely skip the OOM killer for a costly order request, which makes sense.

Well, opinions might differ of course. The main question is whether
there are workloads which are unhappy about the existing behavior.

-- 
Michal Hocko
SUSE Labs
