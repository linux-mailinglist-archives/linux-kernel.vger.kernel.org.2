Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04A4365627
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhDTK3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhDTK3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:29:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E323C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 03:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7yvM6pYzBdl1pwAS1vOZXn92e4fG6hqABm03un7jGEY=; b=DySRbJzxWjR3dFFRXhVsSB9n7X
        lFEfEUPPX/Zn3KLaDEmuq1i5niTBWj7Skf73DDQWesSlHL2w2sBbonaMdsWGynZz1oBjK+BP06cgN
        hoikbJ+jArK00fe5kK/1h7CRVg9r+Jf9Xj6eXzj3eSGiJLukVmCrcspSl/nTuKhJ6Xi2T9Bc/HaIg
        MsCVfSCBbJ3Pmbaz7QnTSnVWxawIycpV3e4DiPYf5AHwIeaSL+bG8MlgfeBry3m656r6HyVMBLuR0
        UPTld7lc6pQ0H1n1YrYJZ3bh7p0T0lUPz6LfixxbNkwUwiMmsUnIwW+MgiII7OrmfQOUEfxTqNOra
        UUu7yKhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYncb-00Bsln-U2; Tue, 20 Apr 2021 10:28:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD73F30020C;
        Tue, 20 Apr 2021 12:28:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B736D2C48E3A3; Tue, 20 Apr 2021 12:28:44 +0200 (CEST)
Date:   Tue, 20 Apr 2021 12:28:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] perf/core: Share an event with multiple cgroups
Message-ID: <YH6s3P/3hQxI21eO@hirez.programming.kicks-ass.net>
References: <20210413155337.644993-1-namhyung@kernel.org>
 <20210413155337.644993-2-namhyung@kernel.org>
 <YHhS6kjeA8AvcFgz@hirez.programming.kicks-ass.net>
 <CAM9d7civd59i4hquyxExQALcxOeDxk_ODpJwCRr-Rm3iMeahxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7civd59i4hquyxExQALcxOeDxk_ODpJwCRr-Rm3iMeahxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 06:49:09PM +0900, Namhyung Kim wrote:
> On Thu, Apr 15, 2021 at 11:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > +static void perf_update_cgroup_node(struct perf_event *event, struct cgroup *cgrp)
> > > +{
> > > +     u64 delta_count, delta_time_enabled, delta_time_running;
> > > +     int i;
> > > +
> > > +     if (event->cgrp_node_count == 0)
> > > +             goto out;
> > > +
> > > +     delta_count = local64_read(&event->count) - event->cgrp_node_count;

From here...

> > > +     delta_time_enabled = event->total_time_enabled - event->cgrp_node_time_enabled;
> > > +     delta_time_running = event->total_time_running - event->cgrp_node_time_running;
> > > +
> > > +     /* account delta to all ancestor cgroups */
> > > +     for (i = 0; i <= cgrp->level; i++) {
> > > +             struct perf_cgroup_node *node;
> > > +
> > > +             node = find_cgroup_node(event, cgrp->ancestor_ids[i]);
> > > +             if (node) {
> > > +                     node->count += delta_count;
> > > +                     node->time_enabled += delta_time_enabled;
> > > +                     node->time_running += delta_time_running;
> > > +             }
> > > +     }

... till here, NMI could hit and increment event->count, which then
means that:

> > > +
> > > +out:
> > > +     event->cgrp_node_count = local64_read(&event->count);

This load doesn't match the delta_count load and events will go missing.

Obviously correct solution is:

	event->cgrp_node_count += delta_count;


> > > +     event->cgrp_node_time_enabled = event->total_time_enabled;
> > > +     event->cgrp_node_time_running = event->total_time_running;

And while total_time doesn't have that problem, consistency would then
have you do:

	event->cgrp_node_time_foo += delta_time_foo;

> >
> > This is wrong; there's no guarantee these are the same values you read
> > at the begin, IOW you could be loosing events.
> 
> Could you please elaborate?

You forgot NMI.
