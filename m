Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A653114FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 23:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbhBEWVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 17:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhBEO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:56:21 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B911DC06121C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:34:22 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id z22so5373280qto.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RW0ONyxKXYjlsRuX7eO/UdLt7OqwnBfWk+dSDdSDYyw=;
        b=fDCx8PML3wpb7Gv9Qhxf/Lmgt8t9paY9PlqQPeev9GAzZIOy9HRlwnhk8Gj2bTe2yf
         0uSHjMJJYfZDMDMboGVMVL98lxLZYKECaPT1YM59+/uoVp+j2yeayauMqi3OZM4d1tEn
         YN/ecY3LDoZFlB6rqTT5ynUD98p8d4ARLnea2R77u3ZWZqfLt+1HcCkt9MhNrCijWhUz
         f4DiXHO0gL1TK9dgWhCoDy3l5Q2bJk2OkxHSBoWy+wJ4rScOFcDJlLvSG/M9tYuP2TdN
         mWVZjPe8sqxDRGKXq+ydF2Mdvz57XMe1jNoelLFF+OdOSt6KcspYQ/F2PQw35OvoRNYe
         +pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RW0ONyxKXYjlsRuX7eO/UdLt7OqwnBfWk+dSDdSDYyw=;
        b=Rid6CfXMlE1Y6SoQtFl1sU5+wplRtqjwyE1kTujKTzDaGbHeElddMUC65sh1xXel/v
         wqLkI+CLTFTV1o711XI30BaVHXtg9pQfFy9JvZxmwuBMYjNniDtAl8BjjzN3fhcuZa44
         bb5FGpugeGZa/1Mtn+MyHfSlMFhzQ3YNlAwj7S2BDEI9iYBzYFlBjWcu0qOu9ULfwJDz
         CngnLirpx305Yz/+jIeaJCCVB89HKM195vVNcgSqNbcVdAjt/D6mjUzYVksRQsFMpzjn
         8EC4+dUia8rPWb9eMsQ7hpen0iaDqQ1VFCLoPG2anWI4TOK1TURvnkaTPZHRhly+3Out
         5y1Q==
X-Gm-Message-State: AOAM532ZUZOzYsX1B78Ru0JkcOzX3KfyHMJZC6/uaAdfDNw1k3RH2SRA
        De78sgOMgw0Bntl1mcYn3afoxg==
X-Google-Smtp-Source: ABdhPJwnNJM/q0Eo2MlbfQjZiTMmgkK3+RzNgscQCLRFoS1nQRPHzBz9vh5zkKqKWZB2ML9LPR2nMQ==
X-Received: by 2002:aed:20a8:: with SMTP id 37mr5172292qtb.362.1612542861989;
        Fri, 05 Feb 2021 08:34:21 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id z5sm9626394qkc.61.2021.02.05.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:34:20 -0800 (PST)
Date:   Fri, 5 Feb 2021 11:34:19 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/7] mm: memcontrol: switch to rstat
Message-ID: <YB1zi/bZdeL2j59I@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-7-hannes@cmpxchg.org>
 <YB1esMKg3QhBDFG2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YB1esMKg3QhBDFG2@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 04:05:20PM +0100, Michal Hocko wrote:
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
> The above confused me a bit. I can see the pcp data size increased by
> adding _prev.  The resulting memory footprint should be increased by
> sizeof(long) * (MEMCG_NR_STAT + NR_VM_EVENT_ITEMS) * (CPUS + 1)
> which is roughly 1kB per CPU per memcg unless I have made any
> mistake. This is a quite a lot and it should be mentioned in the
> changelog.

Not quite, you missed a hunk further below in the patch.

Yes, the _prev arrays are added to the percpu struct. HOWEVER, we used
to have TWO percpu structs in a memcg: one for local data, one for
hierarchical data. In the rstat format, one is enough to capture both:

-       /* Legacy local VM stats and events */
-       struct memcg_vmstats_percpu __percpu *vmstats_local;
-
-       /* Subtree VM stats and events (batched updates) */
        struct memcg_vmstats_percpu __percpu *vmstats_percpu;

This eliminates dead duplicates of the nr_page_events and
targets[MEM_CGROUP_NTARGETS(2)] we used to carry, which means we have
a net reduction of 3 longs in the percpu data with this series.

> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Although the memory overhead is quite large and it scales both with
> memcg count and CPUs so it can grow quite a bit I do not think this is
> prohibitive. Although it would be really nice if this could be optimized
> in the future.
> 
> All that being said, the code looks more manageable now.
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks
