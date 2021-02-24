Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621C5323BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 13:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhBXMe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 07:34:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232787AbhBXMeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 07:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614169970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FR1wFd6JiCgf9+go0Q566zCF/9BGYKbMwBEb9YnxoXU=;
        b=bKC+f4cjYq53/dLCk2yKgYBSqwwqJYCafes78Drr0JZBSbS+XKsFOVlNr+95WxxwCKy5pv
        uAEJhapDbcUV8CEUrdFWNI/lvwUKb19TmiO0xo/hCqi3e2Wv6T1Wtb3xTsGT+AGUfv7pcu
        yiswMQUTXbE55QrbTPCdISbrUFaaCGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-orb-aA9VPIScBH7eND77pA-1; Wed, 24 Feb 2021 07:32:46 -0500
X-MC-Unique: orb-aA9VPIScBH7eND77pA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9916B193579A;
        Wed, 24 Feb 2021 12:32:44 +0000 (UTC)
Received: from krava (unknown [10.40.193.200])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2D99D2C01F;
        Wed, 24 Feb 2021 12:32:42 +0000 (UTC)
Date:   Wed, 24 Feb 2021 13:32:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] libperf: Add perf_evlist__reset_id_hash()
Message-ID: <YDZHaZ+ku5za4+uD@krava>
References: <20210224081103.715233-1-namhyung@kernel.org>
 <CAM9d7cgMkfZxe+XVoXCBY=t+erpvDjxyk+PYBKCryFDZidBu6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgMkfZxe+XVoXCBY=t+erpvDjxyk+PYBKCryFDZidBu6w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 05:42:15PM +0900, Namhyung Kim wrote:
> On Wed, Feb 24, 2021 at 5:11 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Add the perf_evlist__reset_id_hash() function to libperf API so that
> > it can be called to reset the hash table.  This is necessary for perf
> > stat to run the workload multiple times.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> [SNIP]
> > diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> > index 7be1af8a546c..285100143d89 100644
> > --- a/tools/lib/perf/libperf.map
> > +++ b/tools/lib/perf/libperf.map
> > @@ -42,6 +42,7 @@ LIBPERF_0.0.1 {
> >                 perf_evlist__munmap;
> >                 perf_evlist__filter_pollfd;
> >                 perf_evlist__next_mmap;
> > +               perf_evlist__reset_id_hash;
> >                 perf_mmap__consume;
> >                 perf_mmap__read_init;
> >                 perf_mmap__read_done;
> 
> I saw perf_evsel__free_fd and perf_evsel__free_id is called from
> util/evlist.c without being listed here.  Do we need to add them?

perf is special user of libperf and we link it statically
at the moment, so it's not needed

I think we should add perf_evlist__reset_id_hash to internal
header, because for libperf.so we expose only logical API units
with described usage, not just single (special purpose) function

thanks,
jirka

