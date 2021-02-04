Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153D530F77C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbhBDQRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbhBDQPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:15:49 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C39C06178C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 08:15:08 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id r77so3770638qka.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 08:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0rhTk5izLatoFfIDNxmz1fyaLshSZ+6LLZBve6XjOzQ=;
        b=O4ZVUwRrPSmt03J6wBFbrAwKR8DigcweNeGpjQBAT542zJXom/F8N0kM5lXk+AOpAz
         lkEqie3XYPUxu/MymMBqjyYRKYWigI816jCPhNr1e907EDJ6OXubQrfNVJizoLGIlbv1
         sXK3IjOgSrrdcit8dHEAFEjRAmzd28hArjzv69QYDfjsiT0VwXNP/mr2Dn3OKxdd3o6U
         8rykm84xwcu5321Sid2AN+avO0Ad5tnKkoMCTX2BEAg0UiQ1L0RRQmz3uHhW8MULkxy2
         gGGYZPxIOmxMRqo45RSrHCREyaqZuMRHgMDKQhWwUIS/Imgu4yXVukgdiiRVb2odb0q3
         iJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0rhTk5izLatoFfIDNxmz1fyaLshSZ+6LLZBve6XjOzQ=;
        b=IA+Bvx6tRU/vy74+HniJFnmNRaS7E598QBoRKe6yyXkAJBi35K9O8HmT3yXCGNXSLl
         /HYR2h4obht3ti8lFNOr43kVs7iKxJgmVMxvL+3omJCR2riqEMefd4OnDh5RXik1UxXT
         Da3OpZklyWOKrZpZRdA7mOSYAH2j17YOt6y6WMxR4iKqYkMREX5F9Si1wm9qh95DpXCX
         tNDpAHASpfmZ3OTHCzGAMZqSEwmvN2KiVzvN8hL4sA8ZGF4YgI4NLlgBFkq0UocVyUJM
         n1N77Y07Ps0d/C/d2gtbBmNPG5Ws+SJuLWj8SwcCQA68OqhlsZlnGEVDFSnZ14KvND5j
         lDIg==
X-Gm-Message-State: AOAM53000M9LGFKKRs5lDfQO152NTDL1xyLqbJcBXUs4CH0d+LCBflqU
        3cfvAamTgZ47EURUE4ns5qz3TZaPyb4U6w==
X-Google-Smtp-Source: ABdhPJxYWWQMP2WKabbIu6NX0M63DryEWNKDcsggcNFgrnT4GLgkWOrNv90Sem4qr5H7wW5OLfy1/g==
X-Received: by 2002:a37:aa09:: with SMTP id t9mr8022967qke.214.1612455308240;
        Thu, 04 Feb 2021 08:15:08 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id k14sm4756805qtj.40.2021.02.04.08.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 08:15:07 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:15:06 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/7] mm: memcontrol: switch to rstat
Message-ID: <YBwdiu2Fj4JHgqhQ@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-7-hannes@cmpxchg.org>
 <YBwCZYWsQOFAGUar@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBwCZYWsQOFAGUar@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal,

On Thu, Feb 04, 2021 at 03:19:17PM +0100, Michal Hocko wrote:
> On Tue 02-02-21 13:47:45, Johannes Weiner wrote:
> > Replace the memory controller's custom hierarchical stats code with
> > the generic rstat infrastructure provided by the cgroup core.
> > 
> > The current implementation does batched upward propagation from the
> > write side (i.e. as stats change). The per-cpu batches introduce an
> > error, which is multiplied by the number of subgroups in a tree. In
> > systems with many CPUs and sizable cgroup trees, the error can be
> > large enough to confuse users (e.g. 32 batch pages * 32 CPUs * 32
> > subgroups results in an error of up to 128M per stat item). This can
> > entirely swallow allocation bursts inside a workload that the user is
> > expecting to see reflected in the statistics.
> > 
> > In the past, we've done read-side aggregation, where a memory.stat
> > read would have to walk the entire subtree and add up per-cpu
> > counts. This became problematic with lazily-freed cgroups: we could
> > have large subtrees where most cgroups were entirely idle. Hence the
> > switch to change-driven upward propagation. Unfortunately, it needed
> > to trade accuracy for speed due to the write side being so hot.
> > 
> > Rstat combines the best of both worlds: from the write side, it
> > cheaply maintains a queue of cgroups that have pending changes, so
> > that the read side can do selective tree aggregation. This way the
> > reported stats will always be precise and recent as can be, while the
> > aggregation can skip over potentially large numbers of idle cgroups.
> > 
> > This adds a second vmstats to struct mem_cgroup (MEMCG_NR_STAT +
> > NR_VM_EVENT_ITEMS) to track pending subtree deltas during upward
> > aggregation. It removes 3 words from the per-cpu data. It eliminates
> > memcg_exact_page_state(), since memcg_page_state() is now exact.
> 
> I am still digesting details and need to look deeper into how rstat
> works but removing our own stats is definitely a good plan. Especially
> when there are existing limitations and problems that would need fixing.
> 
> Just to check that my high level understanding is correct. The
> transition is effectivelly removing a need to manually sync counters up
> the hierarchy and partially outsources that decision to rstat core. The
> controller is responsible just to tell the core how that syncing is done
> (e.g. which specific counters etc).

Yes, exactly.

rstat implements a tree of cgroups that have local changes pending,
and a flush walk on that tree. But it's all driven by the controller.

memcg needs to tell rstat 1) when stats in a local cgroup change
e.g. when we do mod_memcg_state() (cgroup_rstat_updated), 2) when to
flush, e.g. before a memory.stat read (cgroup_rstat_flush), and 3) how
to flush one cgroup's per-cpu state and propagate it upward to the
parent during rstat's flush walk (.css_rstat_flush).

> Excplicit flushes are needed when you want an exact value (e.g. when
> values are presented to the userspace). I do not see any flushes to
> be done by the core pro-actively except for clean up on a release.
> 
> Is the above correct understanding?

Yes, that's correct.
