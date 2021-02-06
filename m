Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F790311C15
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 09:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhBFIHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 03:07:53 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:37776 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBFIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 03:07:47 -0500
Received: by mail-lf1-f41.google.com with SMTP id w36so262148lfu.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 00:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9yOc7rfBWs1DmuQ0L3Wb5z5dxZA/cnES2iTyyBl0jU=;
        b=JLLLiNVrZS805FREyG5movqdhulzseXnZf2P8rx9YXkYwO34NfVqBgx09UguO9ij/g
         xXt7HSPJCXnrcjsZvrlSz4ZXjfuCkY18+RNGtvb8I59VzypAev9m/PubSc68S0XNqsgK
         aS/aaooumyfKMx8ejk+Omto3O1pDeIZznMEdNHI/Ab7r34pOexzjqNyV6Iy7nShR5b4o
         u8Wrph3mnoixpkBnf9XwzizBdxWs2drO4OzrbPw5lMiG181wELflQrUQnrC7GJroGIQe
         +4kk0UAOhO7HYYePWSHmfbNFfjlYIpcv5gaCqqAJy5O5p55zh7hOFNyMisjHi1LV8kSH
         nFPw==
X-Gm-Message-State: AOAM532fhyfky1nw0keHF2+I7TU1d4vwaEobFdCHyqgR0CseeBUryPym
        nHbuVLG7dYPLsPSxozkY5UDmBkGKSFZ8hb2UJXo=
X-Google-Smtp-Source: ABdhPJxQtdYs++ui2YPMRF6vp23sHOkInIz4QL5zlJlncoYzideUTCjDB7JS5bsTqmI9mFmJ0BhwaR6DIYY9SHfTNqQ=
X-Received: by 2002:a05:6512:2342:: with SMTP id p2mr4664069lfu.509.1612598825457;
 Sat, 06 Feb 2021 00:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20210129134855.195810-1-jolsa@redhat.com> <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-7-jolsa@kernel.org> <CAM9d7cjuPHh6j2H5-M-5=4MSujoJH7rWUYwKbypOk7_Jt-6QTg@mail.gmail.com>
 <20210204125819.GA910119@kernel.org> <YBwOXnK/RIEzPFPm@krava>
In-Reply-To: <YBwOXnK/RIEzPFPm@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 6 Feb 2021 17:06:54 +0900
Message-ID: <CAM9d7cgDFfAM0YWUEt9CCJ2n5w+AcC-HB0gVZ=3EuxoapT75+w@mail.gmail.com>
Subject: Re: [PATCH 06/24] perf daemon: Add config file support
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 12:10 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Feb 04, 2021 at 09:58:19AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Feb 04, 2021 at 09:42:35PM +0900, Namhyung Kim escreveu:
> > > Hi Jiri,
> > >
> > > On Sun, Jan 31, 2021 at 8:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > [SNIP]
> > > > +#define SESSION_OUTPUT  "output"
> > > > +
> > > > +/*
> > > > + * Session states:
> > > > + *
> > > > + *   OK       - session is up and running
> > > > + *   RECONFIG - session is pending for reconfiguration,
> > > > + *              new values are already loaded in session object
> > > > + *   KILL     - session is pending to be killed
> > > > + *
> > > > + * Session object life and its state is maintained by
> > > > + * following functions:
> > > > + *
> > > > + *  setup_server_config
> > > > + *    - reads config file and setup session objects
> > > > + *      with following states:
> > > > + *
> > > > + *      OK       - no change needed
> > > > + *      RECONFIG - session needs to be changed
> > > > + *                 (run variable changed)
> > > > + *      KILL     - session needs to be killed
> > > > + *                 (session is no longer in config file)
> > > > + *
> > > > + *  daemon__reconfig
> > > > + *    - scans session objects and does following actions
> > > > + *      for states:
> > > > + *
> > > > + *      OK       - skip
> > > > + *      RECONFIG - session is killed and re-run with new config
> > > > + *      KILL     - session is killed
> > > > + *
> > > > + *    - all sessions have OK state on the function exit
> > > > + */
> > > > +enum session_state {
> > > > +       SESSION_STATE__OK,
> > > > +       SESSION_STATE__RECONFIG,
> > > > +       SESSION_STATE__KILL,
> > > > +};
> > > > +
> > > > +struct session {
> > > > +       char                    *base;
> > > > +       char                    *name;
> > > > +       char                    *run;
> > > > +       int                      pid;
> > > > +       struct list_head         list;
> > > > +       enum session_state       state;
> > > > +};
> > >
> > > Although I think calling it 'session' is intuitive, it's also confusing
> > > as we already have struct perf_session...
>
> ok, how about daemon_session then?

I'm ok with it.

>
> >
> > Maybe 'struct server_session' ? If this ends up in tools/lib/perf, then
> > it gets renamed to 'struct perf_server_session', just like we have
> > 'struct perf_evsel' in libperf and 'struct evsel' in tools/perf/, right?
>
> let's have our grand-grand-grandkids worry about that ;-)

:)

Thanks,
Namhyung
