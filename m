Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA78542066A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 09:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhJDHIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 03:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229486AbhJDHI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 03:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633331200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8lCksJRtX0u+VbcUh0hKrD32i6xYPDyS9k9I9FVhxU=;
        b=d0nlEguyJJ89t+fxyR9Fm4P7pN7yHVXwtdrYk89FLu2orn7gVttu2ODDT2+UfZLI+kDy7H
        Nq/FYnJ6QPmMw9Py4lY6yoDHUqSdZFWEBNr+BeKI8NNS+9u1Uan0h8VXy9RSYCzR87OTY/
        mC0yuBc6sHmc1SSvV4eSWN7OVu9KZOQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-WH7C2K8IPH-Be6Nfx4Pr7A-1; Mon, 04 Oct 2021 03:06:39 -0400
X-MC-Unique: WH7C2K8IPH-Be6Nfx4Pr7A-1
Received: by mail-wr1-f69.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso4277635wrb.20
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 00:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J8lCksJRtX0u+VbcUh0hKrD32i6xYPDyS9k9I9FVhxU=;
        b=MHnbzeRMKTOhCBCnBXmiB+9oEYuIcBp0sJ2303EqsHdedSsdp6hkhir5o2A9XAin39
         Sxryi4Na941cJb5hFercTGEotahCOOnBMuLM9xY70/sOuqpn3/YJWIZYCiYLlu+aNEVS
         m5qjSubDo1cQE7UY1ojNBhotd3dIobvGjHUDD2BGiPyV1lacDaVUgUov2Gz95MHHJQHO
         QSiYauTwwtylq7EkdaeVWcscdimrKxZqHvlvQLTJFZ+r6u70WB3+wQeUO6hbyorqd2VD
         qOlxz5pKffthydjT4tIKGbs3kUNxY3QeEjJGmMW4NmYzOtkIsgAgEmvAiLA4O8cX++Xc
         ClaA==
X-Gm-Message-State: AOAM530wCP8I6xCaa3cts8f9Ugujpa52Q3rGASH4/D2+OqyFc1v7STq4
        nnV3BmhmbQpi4b6Hu7/OKwRB3irkNohWpjun6mzDQreYYyzhYqfEp2oRDayXE3TV9lQOfxSY1g5
        rHhFiJ3GV076Hd+8DNV1FSOyz
X-Received: by 2002:adf:fa0d:: with SMTP id m13mr12440265wrr.418.1633331198607;
        Mon, 04 Oct 2021 00:06:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDwZqY8dudcifEv67bXO534NI07bAtFg3nwbODq1J0657xqcQ3hj8M+0Gb6cf5QcBwzR/IvA==
X-Received: by 2002:adf:fa0d:: with SMTP id m13mr12440232wrr.418.1633331198304;
        Mon, 04 Oct 2021 00:06:38 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id y8sm10013022wrr.21.2021.10.04.00.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 00:06:37 -0700 (PDT)
Date:   Mon, 4 Oct 2021 09:06:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH] perf report: Output non-zero offset for decompressed
 records
Message-ID: <YVqn/FZ544RAV6Mq@krava>
References: <20210929091445.18274-1-alexey.v.bayduraev@linux.intel.com>
 <YVqiS0lzxuVlblrN@krava>
 <6ab9dd72-ccac-4ce1-6456-ef7786911639@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab9dd72-ccac-4ce1-6456-ef7786911639@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 10:00:52AM +0300, Bayduraev, Alexey V wrote:
> 
> On 04.10.2021 9:42, Jiri Olsa wrote:
> > On Wed, Sep 29, 2021 at 12:14:45PM +0300, Alexey Bayduraev wrote:
> >> Print offset of PERF_RECORD_COMPRESSED record instead of zero for
> >> decompressed records in raw trace dump (-D option of perf-report):
> >>
> >> 0x17cf08 [0x28]: event: 9
> >>
> >> instead of:
> >>
> >> 0 [0x28]: event: 9
> >>
> >> The fix is not critical, because currently file_pos for compressed
> >> events is used in perf_session__process_event only to show offsets
> >> in the raw dump.
> > 
> > hi,
> > I don't mind the change just curious, because I see also:
> > 
> >   perf_session__process_event
> >     perf_session__process_user_event
> >       lseek(fd, file_offset, ...
> > 
> > which is not raw dump as the comment suggests
> 
> Hi,
> 
> Yes, but this "lseek" only works for user events, whereas the 
> PERF_RECORD_COMPRESSED record shouln't contain such events.
> Currently, the PERF_RECORD_COMPRESSED container can only pack
> kernel events. 

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Regards,
> Alexey
> 
> > 
> > thanks,
> > jirka
> > 
> >>
> >> This patch was separated from patchset:
> >> https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/
> >> and was already rewieved.
> >>
> >> Acked-by: Namhyung Kim <namhyung@kernel.org>
> >> Acked-by: Andi Kleen <ak@linux.intel.com>
> >> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> >> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> >> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> >> ---
> >>  tools/perf/util/session.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> >> index 069c2cfdd3be..352f16076e01 100644
> >> --- a/tools/perf/util/session.c
> >> +++ b/tools/perf/util/session.c
> >> @@ -2116,7 +2116,7 @@ fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
> >>  static int __perf_session__process_decomp_events(struct perf_session *session)
> >>  {
> >>  	s64 skip;
> >> -	u64 size, file_pos = 0;
> >> +	u64 size;
> >>  	struct decomp *decomp = session->decomp_last;
> >>  
> >>  	if (!decomp)
> >> @@ -2132,7 +2132,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
> >>  		size = event->header.size;
> >>  
> >>  		if (size < sizeof(struct perf_event_header) ||
> >> -		    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
> >> +		    (skip = perf_session__process_event(session, event, decomp->file_pos)) < 0) {
> >>  			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
> >>  				decomp->file_pos + decomp->head, event->header.size, event->header.type);
> >>  			return -EINVAL;
> >> -- 
> >> 2.19.0
> >>
> > 
> 

