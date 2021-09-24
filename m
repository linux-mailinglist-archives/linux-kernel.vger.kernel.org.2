Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9F74175D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346512AbhIXNdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346656AbhIXNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:33:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA724C06179A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=VBRsK0SSRvHCFbayLyP3uRuuQ077zpOLss/VrwsUtnc=; b=lyQTVewCCcj05GDBeN+J7X5zxj
        6f3fp+YqGOdyPJ0gHBUF5XNo0zh1gDka9AGAr1Sl4zXBE4TagmW/Od/lBx6RWmRACAn1uD4gGYphi
        wCazH5TX09wcSpTTlkpAOqCix4LhU+FJoQtJUCIpLcgO7kGLfWoliK38S980lRymqOQG5aCJMgzJ6
        k0kJPoKt1lKm48S/ZiH4mlybLpQ59dAC5lOAE4Kc6i/KD4PVavjFJ8jpN9kStRDo6BZF8dNZXKcq6
        ATRiQwrxE6i7W8fsyLqkEP1ym+WsPu0Ig3GVvMDUxYLDjBClf86guWNqdOJ2uI9LKDYl6ylO01Zs9
        4Il0AgQg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTl8d-007DhW-Dy; Fri, 24 Sep 2021 13:21:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DD64430026F;
        Fri, 24 Sep 2021 15:21:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A95BD2CABDE9F; Fri, 24 Sep 2021 15:21:13 +0200 (CEST)
Date:   Fri, 24 Sep 2021 15:21:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Lucian Grijincu <lucian@fb.com>
Subject: Re: [PATCH] perf/core: fix userpage->time_enabled of inactive events
Message-ID: <YU3QyTz5Lo0L+6fg@hirez.programming.kicks-ass.net>
References: <20210922011715.4154119-1-songliubraving@fb.com>
 <YUxSMqrJK/rKPZS3@hirez.programming.kicks-ass.net>
 <4F8CB003-C047-41DB-85D7-233369D23E31@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4F8CB003-C047-41DB-85D7-233369D23E31@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 05:47:40PM +0000, Song Liu wrote:

> >=20
> > So we already iterate all the right events. So I'm thinking we can do
> > something like the below, hmm?
> >=20
> >=20
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 0c000cb01eeb..4d1e962c2ebe 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -3707,6 +3712,28 @@ static noinline int visit_groups_merge(struct pe=
rf_cpu_context *cpuctx,
> > 	return 0;
> > }
> >=20
> > +static inline bool event_update_userpage(struct perf_event *event)
> > +{
> > +	if (!atomic_read(&event->mmap_count))
> > +		return false;
>=20
> Technically, the user could mmap a sibling but not the group leader, righ=
t?
> It is weird though.=20

Yeah, I went with the same logic that a disabled leader disables the
whole group, I suppose we can revisit if anybody ever gets a sane
use-case for this.

> There is also a corner case we didn't cover. If the user enable the event
> before mmap it. The event is first scheduled in via:
>=20
> __perf_event_enable (or __perf_install_in_context)
>    -> ctx_resched
>       -> perf_event_sched_in
>           -> ctx_sched_in
>=20
> but it doesn't have mmap_count yet. =10And we won't call perf_event_updat=
e_userpage
> for it before the first rotation after mmap. As a result, the user page w=
ill
> contain garbage data before the first rotation.=20

That was already a problem, because without the mmap, the event->rb will
be NULL and perf_event_update_userpage() will not actually do anything.

Should not the mmap() itself update the state before populating those
fields for the first time?

> Other than this corner case, this version works well in my tests. Shall I=
 send=20
> v2 in this version?

Please,
