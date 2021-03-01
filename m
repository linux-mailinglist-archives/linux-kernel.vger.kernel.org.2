Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E2532A00B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575197AbhCBDyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245122AbhCAWJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:09:47 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FB5C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 14:09:06 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id f33so18030558otf.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 14:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Og6LUavDt+OG4SGQrgLFpZJxNNTz6tmp7HOJDZDJ1xU=;
        b=boKdmhhVglqyH3x2SwJtdSPRESqRj+XFpHZ19kWLcLuk3PdvxHt5zGQP6dOT0EaDeo
         UAhRXu1N9DnBApCp3gGBf4LBn0n8Dai32ehLTW6H5D/Cel9MKczU4C+4Zt1d03cv4kmc
         Skm3GeaiLYp3OoNm0qX5meZzXHLtPNrlrcgF6rSqTE/44tNm2ZDPlleBJK24R8W683cy
         /oXOq4iaPmrlk/zAgkLX0OC8ptv8Q1XKXrRKIZZx11lY1uJX+u+lIIeDKaAwIW+arfFp
         Js5fQtozihwy2btyyCKRZqJ1Yeg3j797Swlt5sFfA05bvQtdYkFZd1M07DA21Z84MYuY
         lk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Og6LUavDt+OG4SGQrgLFpZJxNNTz6tmp7HOJDZDJ1xU=;
        b=qk8qN/V1gAREkL92UPR1Ch4TdXR7gbOf7gVuazqRlxZOpwPZpEbb0czcjWCNMpLyhR
         4BoMHdtldCda0yiAvKMiHz+OmFBN48vMq5aWQlfOz81b7hT0GI+H4Yo8aVWH9yQugrdt
         GxjXF3WhjWmkos72tFCnb8ghXY92FoTYJ/DtYlUqsyNp1lujEcA1aiw2M7+g6Eu+AyQo
         GhDKDEm30y+4QFXZced9UasbtJELYPsv9zFhd7/Ea3iNS3/qq38C68shZTmnLOFGdDXQ
         ZRxjp/NYf71833zE/kr59WIYeBk9u8gT8P0YwtgFUr7Z1o79jTwMsClaquYcJ1MKvQEY
         5b7Q==
X-Gm-Message-State: AOAM53130qMoJzE3jbTeelNMETsyL0T5ZG70U2Xk+u40bs7zJsRzcLDp
        QpqOnZv6SHE+QEooN3RQatoxIA==
X-Google-Smtp-Source: ABdhPJw4VVTKDPyHM3gxFOWW4ZbqCUOWW/KT4E7UF/D7mb7eZGiYr3VyqVCVYwwACXFbW0aYyyiHCg==
X-Received: by 2002:a9d:7a88:: with SMTP id l8mr15019090otn.289.1614636545715;
        Mon, 01 Mar 2021 14:09:05 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p12sm3735344oon.12.2021.03.01.14.09.04
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 01 Mar 2021 14:09:05 -0800 (PST)
Date:   Mon, 1 Mar 2021 14:08:17 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Roman Gushchin <guro@fb.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: /proc/sys/vm/stat_refresh skip checking known
 negative stats
In-Reply-To: <YDw67lSx5vLTgx/O@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.LSU.2.11.2103011301010.4832@eggly.anvils>
References: <alpine.LSU.2.11.2102251502240.13363@eggly.anvils> <alpine.LSU.2.11.2102251512170.13363@eggly.anvils> <YDw67lSx5vLTgx/O@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Feb 2021, Roman Gushchin wrote:
> On Thu, Feb 25, 2021 at 03:14:03PM -0800, Hugh Dickins wrote:
> > vmstat_refresh() can occasionally catch nr_zone_write_pending and
> > nr_writeback when they are transiently negative.  The reason is partly
> > that the interrupt which decrements them in test_clear_page_writeback()
> > can come in before __test_set_page_writeback() got to increment them;
> > but transient negatives are still seen even when that is prevented, and
> > we have not yet resolved why (Roman believes that it is an unavoidable
> > consequence of the refresh scheduled on each cpu).  But those stats are
> > not buggy, they have never been seen to drift away from 0 permanently:
> > so just avoid the annoyance of showing a warning on them.
> > 
> > Similarly avoid showing a warning on nr_free_cma: CMA users have seen
> > that one reported negative from /proc/sys/vm/stat_refresh too, but it
> > does drift away permanently: I believe that's because its incrementation
> > and decrementation are decided by page migratetype, but the migratetype
> > of a pageblock is not guaranteed to be constant.
> > 
> > Use switch statements so we can most easily add or remove cases later.
> 
> I'm OK with the code, but I can't fully agree with the commit log. I don't think
> there is any mystery around negative values. Let me copy-paste the explanation
> from my original patch:
> 
>     These warnings* are generated by the vmstat_refresh() function, which
>     assumes that atomic zone and numa counters can't go below zero.  However,
>     on a SMP machine it's not quite right: due to per-cpu caching it can in
>     theory be as low as -(zone threshold) * NR_CPUs.
>     
>     For instance, let's say all cma pages are in use and NR_FREE_CMA_PAGES
>     reached 0.  Then we've reclaimed a small number of cma pages on each CPU
>     except CPU0, so that most percpu NR_FREE_CMA_PAGES counters are slightly
>     positive (the atomic counter is still 0).  Then somebody on CPU0 consumes
>     all these pages.  The number of pages can easily exceed the threshold and
>     a negative value will be committed to the atomic counter.
> 
>     * warnings about negative NR_FREE_CMA_PAGES

Hi Roman, thanks for your Acks on the others - and indeed this
is the one on which disagreement was more to be expected.

I certainly wanted (and included below) a Link to your original patch;
and even wondered whether to paste your description into mine.
But I read it again and still have issues with it.

Mainly, it does not convey at all, that touching stat_refresh adds the
per-cpu counts into the global atomics, resetting per-cpu counts to 0.
Which does not invalidate your explanation: races might still manage
to underflow; but it does take the "easily" out of "can easily exceed".

Since I don't use CMA on any machine, I cannot be sure, but it looked
like a bad example to rely upon, because of its migratetype-based
accounting.  If you use /proc/sys/vm/stat_refresh frequently enough,
without suppressing the warning, I guess that uncertainty could be
resolved by checking whether nr_free_cma is seen with negative value
in consecutive refreshes - which would tend to support my migratetype
theory - or only singly - which would support your raciness theory.

> 
> Actually, the same is almost true for ANY other counter. What differs CMA, dirty
> and write pending counters is that they can reach 0 value under normal conditions.
> Other counters are usually not reaching values small enough to see negative values
> on a reasonable sized machine.

Looking through /proc/vmstat now, yes, I can see that there are fewer
counters which hover near 0 than I had imagined: more have a positive
bias, or are monotonically increasing.  And I'd be lying if I said I'd
never seen any others than nr_writeback or nr_zone_write_pending caught
negative.  But what are you asking for?  Should the patch be changed, to
retry the refresh_vm_stats() before warning, if it sees any negative?
Depends on how terrible one line in dmesg is considered!

> 
> Does it makes sense?

I'm not sure: you were not asking for the patch to be changed, but
its commit log: and I better not say "Roman believes that it is an
unavoidable consequence of the refresh scheduled on each cpu" if
that's untrue (or unclear: now it reads to me as if we're accusing
the refresh of messing things up, whereas it's the non-atomic nature
of the refresh which leaves it vulnerable to races).

Hugh

> 
> > 
> > Link: https://lore.kernel.org/linux-mm/20200714173747.3315771-1-guro@fb.com/
> > Reported-by: Roman Gushchin <guro@fb.com>
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> > 
> >  mm/vmstat.c |   15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > --- vmstat2/mm/vmstat.c	2021-02-25 11:56:18.000000000 -0800
> > +++ vmstat3/mm/vmstat.c	2021-02-25 12:42:15.000000000 -0800
> > @@ -1840,6 +1840,14 @@ int vmstat_refresh(struct ctl_table *tab
> >  	if (err)
> >  		return err;
> >  	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
> > +		/*
> > +		 * Skip checking stats known to go negative occasionally.
> > +		 */
> > +		switch (i) {
> > +		case NR_ZONE_WRITE_PENDING:
> > +		case NR_FREE_CMA_PAGES:
> > +			continue;
> > +		}
> >  		val = atomic_long_read(&vm_zone_stat[i]);
> >  		if (val < 0) {
> >  			pr_warn("%s: %s %ld\n",
> > @@ -1856,6 +1864,13 @@ int vmstat_refresh(struct ctl_table *tab
> >  	}
> >  #endif
> >  	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> > +		/*
> > +		 * Skip checking stats known to go negative occasionally.
> > +		 */
> > +		switch (i) {
> > +		case NR_WRITEBACK:
> > +			continue;
> > +		}
> >  		val = atomic_long_read(&vm_node_stat[i]);
> >  		if (val < 0) {
> >  			pr_warn("%s: %s %ld\n",
> 
