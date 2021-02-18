Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD031EC03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 17:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhBRQHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 11:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhBRNbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 08:31:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C81F64E6F;
        Thu, 18 Feb 2021 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613654458;
        bh=Kuqf2NInYXNr+gfhAndoPFe/SnE6eqArm4wmmi3RI2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COoc+IbYJGzdkwv/6guRpEoek8w7TlM/69ZNG1DrfzgMozaI2wdGnYVliCnJECNYo
         RuyB35Ukjx6nC0wzsMXwbSRDCK35PuBRRhr/CVvNAS2Ak/sStwJsl96QgHovJEoy3f
         wkB3l6SpCKdcPLJOeBY8ZDOXdcxw9cv4lOOqymPV1KP9099qE74ECF43Nat6/Zd29s
         pV8sJ/LzV53e6JmLipqPPdkkGPjn1oaIhwF1j7vS4V7VFPAA9a+55oyWeeGTPBeEXC
         7P1NNwP+/HqR+KDkEZ72zpwW7E92vHFSKkr5oMLoKWnAGQY/Rptth+EESOaspO+9ts
         O4H3ezuMg3AWw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BFC9240CD9; Thu, 18 Feb 2021 10:20:53 -0300 (-03)
Date:   Thu, 18 Feb 2021 10:20:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Yang Jihong <yangjihong1@huawei.com>, amistry@google.com,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhangjinhao2@huawei.com
Subject: Re: [PATCH] perf record: Fix continue profiling after draining the
 buffer
Message-ID: <YC5ptbU8Mavb1a/t@kernel.org>
References: <20210205065001.23252-1-yangjihong1@huawei.com>
 <CAM9d7cgGGWtTkReghATVmMnOd=0dBrghBLgEc9AqT_PF-UP1Rg@mail.gmail.com>
 <YB0h9Gj5lpcuqndo@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YB0h9Gj5lpcuqndo@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 05, 2021 at 11:46:12AM +0100, Jiri Olsa escreveu:
> On Fri, Feb 05, 2021 at 07:35:22PM +0900, Namhyung Kim wrote:
> > Hello,
> > 
> > On Fri, Feb 5, 2021 at 3:50 PM Yang Jihong <yangjihong1@huawei.com> wrote:
> > >
> > > commit da231338ec9c098707c8a1e4d8a50e2400e2fe17 uses eventfd to solve rare race
> > > where the setting and checking of 'done' which add done_fd to pollfd.
> > > When draining buffer, revents of done_fd is 0 and evlist__filter_pollfd
> > > function returns a non-zero value.
> > > As a result, perf record does not stop profiling.
> > >
> > > The following simple scenarios can trigger this condition:
> > >
> > > sleep 10 &
> > > perf record -p $!
> > >
> > > After the sleep process exits, perf record should stop profiling and exit.
> > > However, perf record keeps running.
> > >
> > > If pollfd revents contains only POLLERR or POLLHUP,
> > > perf record indicates that buffer is draining and need to stop profiling.
> > > Use fdarray_flag__nonfilterable to set done eventfd to nonfilterable objects,
> > > so that evlist__filter_pollfd does not filter and check done eventfd.
> > >
> > > Fixes: da231338ec9c (perf record: Use an eventfd to wakeup when done)
> > > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> > > ---
> > >  tools/perf/builtin-record.c | 2 +-
> > >  tools/perf/util/evlist.c    | 8 ++++++++
> > >  tools/perf/util/evlist.h    | 4 ++++
> > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > > index fd3911650612..51e593e896ea 100644
> > > --- a/tools/perf/builtin-record.c
> > > +++ b/tools/perf/builtin-record.c
> > > @@ -1663,7 +1663,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> > >                 status = -1;
> > >                 goto out_delete_session;
> > >         }
> > > -       err = evlist__add_pollfd(rec->evlist, done_fd);
> > > +       err = evlist__add_wakeup_eventfd(rec->evlist, done_fd);
> > >         if (err < 0) {
> > >                 pr_err("Failed to add wakeup eventfd to poll list\n");
> > >                 status = err;
> > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > index 05363a7247c4..fea4c1e8010d 100644
> > > --- a/tools/perf/util/evlist.c
> > > +++ b/tools/perf/util/evlist.c
> > > @@ -572,6 +572,14 @@ int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
> > >         return perf_evlist__filter_pollfd(&evlist->core, revents_and_mask);
> > >  }
> > >
> > > +#ifdef HAVE_EVENTFD_SUPPORT
> > > +int evlist__add_wakeup_eventfd(struct evlist *evlist, int fd)
> > > +{
> > > +       return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN,
> > > +                                      fdarray_flag__nonfilterable);
> > > +}
> > > +#endif
> > 
> > Does it build when HAVE_EVENTFD_SUPPORT is not defined?
> 
> yea, I was wondering the same.. but it's called only from
> code within HAVE_EVENTFD_SUPPORT ifdef

Yes, this can't work on systems without eventfd, it will simply not
build, and why do we have to make the definition of this function
conditional on HAVE_EVENTFD_SUPPORT?

I'm missing something :-\

Yeah, this whole call to evlist__add_pollfd is already surrounded by
#ifdef HAVE_EVENTFD_SUPPORT:

1656         if (zstd_init(&session->zstd_data, rec->opts.comp_level) < 0) {
1657                 pr_err("Compression initialization failed.\n");
1658                 return -1;
1659         }
1660 #ifdef HAVE_EVENTFD_SUPPORT
1661         done_fd = eventfd(0, EFD_NONBLOCK);
1662         if (done_fd < 0) {
1663                 pr_err("Failed to create wakeup eventfd, error: %m\n");
1664                 status = -1;
1665                 goto out_delete_session;
1666         }
1667         err = evlist__add_pollfd(rec->evlist, done_fd);
1668         if (err < 0) {
1669                 pr_err("Failed to add wakeup eventfd to poll list\n");
1670                 status = err;
1671                 goto out_delete_session;
1672         }
1673 #endif // HAVE_EVENTFD_SUPPORT
1674 
1675         session->header.env.comp_type  = PERF_COMP_ZSTD;
1676         session->header.env.comp_level = rec->opts.comp_level;

Jiri, does your Acked-by stands? Namhyung?

- Arnaldo
 
> jirka
> 
> > 
> > Thanks,
> > Namhyung
> > 
> > 
> > > +
> > >  int evlist__poll(struct evlist *evlist, int timeout)
> > >  {
> > >         return perf_evlist__poll(&evlist->core, timeout);
> > > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > > index 1aae75895dea..6d4d62151bc8 100644
> > > --- a/tools/perf/util/evlist.h
> > > +++ b/tools/perf/util/evlist.h
> > > @@ -142,6 +142,10 @@ struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, const char
> > >  int evlist__add_pollfd(struct evlist *evlist, int fd);
> > >  int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
> > >
> > > +#ifdef HAVE_EVENTFD_SUPPORT
> > > +int evlist__add_wakeup_eventfd(struct evlist *evlist, int fd);
> > > +#endif
> > > +
> > >  int evlist__poll(struct evlist *evlist, int timeout);
> > >
> > >  struct evsel *evlist__id2evsel(struct evlist *evlist, u64 id);
> > > --
> > > 2.17.1
> > >
> > 
> 

-- 

- Arnaldo
