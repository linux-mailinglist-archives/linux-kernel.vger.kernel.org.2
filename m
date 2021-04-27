Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3336C61A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbhD0MeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236025AbhD0MeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619526813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rAZOEw5kyolSBTQNCRpWBawO5YE3hHJy2M4opdsr4O8=;
        b=gbvZ/9O6dgLNarRv4NRsX0zZlaV9VBrfqe5vrhWN7duDTsS3bqlazb7Ku3Nt+9vgU9PnHs
        bSaZyjqoja6vXk59Qkx61tHnzjKcAenbsIFdsnNh6IpGjPIAm7pFPH5NtP1mQgSy808I95
        mkIeuF9zpSedjRn62EKFuw9fYHs+66o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-Fn1v6tzAOJa83HGLpr1BjQ-1; Tue, 27 Apr 2021 08:33:30 -0400
X-MC-Unique: Fn1v6tzAOJa83HGLpr1BjQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 750CA8189C4;
        Tue, 27 Apr 2021 12:33:29 +0000 (UTC)
Received: from krava (unknown [10.40.192.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id A3E2060CC6;
        Tue, 27 Apr 2021 12:33:27 +0000 (UTC)
Date:   Tue, 27 Apr 2021 14:33:26 +0200
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
Message-ID: <YIgElir6KJCoygX5@krava>
References: <20210425214333.1090950-1-song@kernel.org>
 <20210425214333.1090950-6-song@kernel.org>
 <YIcwRj4WtsZln4SR@krava>
 <CDBE5630-F7F0-494D-BFA8-33742D831C2D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CDBE5630-F7F0-494D-BFA8-33742D831C2D@fb.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 10:18:57PM +0000, Song Liu wrote:
> 
> 
> > On Apr 26, 2021, at 2:27 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Sun, Apr 25, 2021 at 02:43:33PM -0700, Song Liu wrote:
> > 
> > SNIP
> > 
> >> +static inline int bpf_counter__disable(struct evsel *evsel __maybe_unused)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> static inline int bpf_counter__read(struct evsel *evsel __maybe_unused)
> >> {
> >> 	return -EAGAIN;
> >> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> >> index d29a8a118973c..e71041c890102 100644
> >> --- a/tools/perf/util/evlist.c
> >> +++ b/tools/perf/util/evlist.c
> >> @@ -17,6 +17,7 @@
> >> #include "evsel.h"
> >> #include "debug.h"
> >> #include "units.h"
> >> +#include "bpf_counter.h"
> >> #include <internal/lib.h> // page_size
> >> #include "affinity.h"
> >> #include "../perf.h"
> >> @@ -421,6 +422,9 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
> >> 	if (affinity__setup(&affinity) < 0)
> >> 		return;
> >> 
> >> +	evlist__for_each_entry(evlist, pos)
> >> +		bpf_counter__disable(pos);
> > 
> > I was wondering why you don't check evsel__is_bpf like
> > for the enable case.. and realized that we don't skip
> > bpf evsels in __evlist__enable and __evlist__disable
> > like we do in read_affinity_counters
> > 
> > so I guess there's extra affinity setup and bunch of
> > wrong ioctls being called?
> 
> We actually didn't do wrong ioctls because the following check:
> 
>        if (... || !pos->core.fd)
>                 continue;
> 
> in __evlist__enable and __evlist__disable. That we don't allocate 
> core.fd for is_bpf events. 
> 
> It is probably good to be more safe with an extra check of 
> evsel__is_bpf(). But it is not required with current code. 

hum, but it will do all the affinity setup no? for no reason,
if there's no non-bpb event

jirka

> 
> Thanks,
> Song
> 
> [...]
> 

