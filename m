Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684E537166B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhECOKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229900AbhECOKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620050994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lTUcMzd5Nf+frprwDIaCDinkx4BHLgItG4wFaCZjUcM=;
        b=RqyWgy5WF271jFkrOiPvM5aI44mdEV/glq4ks6q6evPSSNg27A97ej1M7K6DRIq3kSQIOL
        otsjfCDDcAsn4AoR7qZpm0J55fzoYQ9F/nIgnIiuYlch4/ZUJTqqdlgPul8A4k9ZZIU4Qy
        F+1ipXzKvVCsH80i0n1OHcmIp1pmI7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-z_XFjwjLOBSjOkl3aheTGg-1; Mon, 03 May 2021 10:09:51 -0400
X-MC-Unique: z_XFjwjLOBSjOkl3aheTGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C8868042C7;
        Mon,  3 May 2021 14:09:49 +0000 (UTC)
Received: from krava (unknown [10.40.195.47])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3E9092BFE2;
        Mon,  3 May 2021 14:09:46 +0000 (UTC)
Date:   Mon, 3 May 2021 16:09:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: Re: [PATCH v5 5/5] perf-stat: introduce bpf_counter_ops->disable()
Message-ID: <YJAEKfvUXFPCik5+@krava>
References: <20210425214333.1090950-1-song@kernel.org>
 <20210425214333.1090950-6-song@kernel.org>
 <YIcwRj4WtsZln4SR@krava>
 <CDBE5630-F7F0-494D-BFA8-33742D831C2D@fb.com>
 <YIgElir6KJCoygX5@krava>
 <5257A59A-CC47-4CA7-9C15-CD6E20DC4BD0@fb.com>
 <7DBDECAE-D100-44C0-B5D3-DE48631430B5@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7DBDECAE-D100-44C0-B5D3-DE48631430B5@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:40:01PM +0000, Song Liu wrote:

SNIP

> >>>>> #include "../perf.h"
> >>>>> @@ -421,6 +422,9 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
> >>>>> 	if (affinity__setup(&affinity) < 0)
> >>>>> 		return;
> >>>>> 
> >>>>> +	evlist__for_each_entry(evlist, pos)
> >>>>> +		bpf_counter__disable(pos);
> >>>> 
> >>>> I was wondering why you don't check evsel__is_bpf like
> >>>> for the enable case.. and realized that we don't skip
> >>>> bpf evsels in __evlist__enable and __evlist__disable
> >>>> like we do in read_affinity_counters
> >>>> 
> >>>> so I guess there's extra affinity setup and bunch of
> >>>> wrong ioctls being called?
> >>> 
> >>> We actually didn't do wrong ioctls because the following check:
> >>> 
> >>>      if (... || !pos->core.fd)
> >>>               continue;
> >>> 
> >>> in __evlist__enable and __evlist__disable. That we don't allocate 
> >>> core.fd for is_bpf events. 
> >>> 
> >>> It is probably good to be more safe with an extra check of 
> >>> evsel__is_bpf(). But it is not required with current code. 
> >> 
> >> hum, but it will do all the affinity setup no? for no reason,
> >> if there's no non-bpb event
> > 
> > Yes, it will do the affinity setup. Let me see how to get something
> > like all_counters_use_bpf here (or within builtin-stat.c).
> > 
> 
> Would something like the following work? It is not clean (skipping some 
> useful logic in __evlist__[enable|disable]). But it seems to work in the
> tests.

sorry for late reply, but I can't no longer apply this:

	patching file tools/perf/builtin-stat.c
	Hunk #1 FAILED at 572.
	Hunk #2 FAILED at 581.
	2 out of 2 hunks FAILED -- saving rejects to file tools/perf/builtin-stat.c.rej
	patching file tools/perf/util/evlist.c
	Hunk #1 FAILED at 425.
	1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/evlist.c.rej

ah, I see the patchset got already merged.. not sure why I'm doing review then ;-)

thanks,
jirka

