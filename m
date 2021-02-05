Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201943117D8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhBFAff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231337AbhBEKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612521982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8W5aA2/ldyxIET2uorgffoDtm1Z/G7yMZz0AeIoZ4/U=;
        b=H+/odHbs+6fR9KIeMaUuSWrIknkIdTAJIVnmPf0vzypdeZzPtRBoqsim2vBcRt4+YzHHEA
        CueIGbE7Yagp034aBynyoABubrkaBMgmEvq3MydmnsVO1M9V6KoGirkdnmtHP1q96XrAnJ
        8radsmN/FRifOfENqAuSVdSYF2sztH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-4USS5JMsO1iR8se2hfn6jw-1; Fri, 05 Feb 2021 05:46:18 -0500
X-MC-Unique: 4USS5JMsO1iR8se2hfn6jw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA495C2B1;
        Fri,  5 Feb 2021 10:46:16 +0000 (UTC)
Received: from krava (unknown [10.40.195.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 838CA12D7E;
        Fri,  5 Feb 2021 10:46:13 +0000 (UTC)
Date:   Fri, 5 Feb 2021 11:46:12 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>, amistry@google.com,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhangjinhao2@huawei.com
Subject: Re: [PATCH] perf record: Fix continue profiling after draining the
 buffer
Message-ID: <YB0h9Gj5lpcuqndo@krava>
References: <20210205065001.23252-1-yangjihong1@huawei.com>
 <CAM9d7cgGGWtTkReghATVmMnOd=0dBrghBLgEc9AqT_PF-UP1Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgGGWtTkReghATVmMnOd=0dBrghBLgEc9AqT_PF-UP1Rg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 07:35:22PM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Feb 5, 2021 at 3:50 PM Yang Jihong <yangjihong1@huawei.com> wrote:
> >
> > commit da231338ec9c098707c8a1e4d8a50e2400e2fe17 uses eventfd to solve rare race
> > where the setting and checking of 'done' which add done_fd to pollfd.
> > When draining buffer, revents of done_fd is 0 and evlist__filter_pollfd
> > function returns a non-zero value.
> > As a result, perf record does not stop profiling.
> >
> > The following simple scenarios can trigger this condition:
> >
> > sleep 10 &
> > perf record -p $!
> >
> > After the sleep process exits, perf record should stop profiling and exit.
> > However, perf record keeps running.
> >
> > If pollfd revents contains only POLLERR or POLLHUP,
> > perf record indicates that buffer is draining and need to stop profiling.
> > Use fdarray_flag__nonfilterable to set done eventfd to nonfilterable objects,
> > so that evlist__filter_pollfd does not filter and check done eventfd.
> >
> > Fixes: da231338ec9c (perf record: Use an eventfd to wakeup when done)
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> > ---
> >  tools/perf/builtin-record.c | 2 +-
> >  tools/perf/util/evlist.c    | 8 ++++++++
> >  tools/perf/util/evlist.h    | 4 ++++
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index fd3911650612..51e593e896ea 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1663,7 +1663,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >                 status = -1;
> >                 goto out_delete_session;
> >         }
> > -       err = evlist__add_pollfd(rec->evlist, done_fd);
> > +       err = evlist__add_wakeup_eventfd(rec->evlist, done_fd);
> >         if (err < 0) {
> >                 pr_err("Failed to add wakeup eventfd to poll list\n");
> >                 status = err;
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 05363a7247c4..fea4c1e8010d 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -572,6 +572,14 @@ int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
> >         return perf_evlist__filter_pollfd(&evlist->core, revents_and_mask);
> >  }
> >
> > +#ifdef HAVE_EVENTFD_SUPPORT
> > +int evlist__add_wakeup_eventfd(struct evlist *evlist, int fd)
> > +{
> > +       return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN,
> > +                                      fdarray_flag__nonfilterable);
> > +}
> > +#endif
> 
> Does it build when HAVE_EVENTFD_SUPPORT is not defined?

yea, I was wondering the same.. but it's called only from
code within HAVE_EVENTFD_SUPPORT ifdef

jirka

> 
> Thanks,
> Namhyung
> 
> 
> > +
> >  int evlist__poll(struct evlist *evlist, int timeout)
> >  {
> >         return perf_evlist__poll(&evlist->core, timeout);
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index 1aae75895dea..6d4d62151bc8 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -142,6 +142,10 @@ struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, const char
> >  int evlist__add_pollfd(struct evlist *evlist, int fd);
> >  int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
> >
> > +#ifdef HAVE_EVENTFD_SUPPORT
> > +int evlist__add_wakeup_eventfd(struct evlist *evlist, int fd);
> > +#endif
> > +
> >  int evlist__poll(struct evlist *evlist, int timeout);
> >
> >  struct evsel *evlist__id2evsel(struct evlist *evlist, u64 id);
> > --
> > 2.17.1
> >
> 

