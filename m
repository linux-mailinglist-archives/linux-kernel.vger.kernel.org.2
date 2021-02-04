Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE530F390
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhBDM7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:59:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236199AbhBDM7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:59:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A656364E34;
        Thu,  4 Feb 2021 12:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612443502;
        bh=5owyyqCeecObLZ9wP00L9AytPREc090DMKKlghFC8JM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVyqCoybEIZlYacBScQQHbQoffv2WMOHey0NKsjgIwuVSUu+OQ89QPWZQNVVhdE3M
         OJcklxaLlNwNMf+79sjJlNa9dJjiz0d4YqXiq0TZMVNWe9ITAFPqlAvkCh0P4wX/TK
         MP8q9cx6r04SGNOUhys4+Wkuz8x4+P2i1rrizlR8gvJjqJvfOun4kvQs/G6H6c81fu
         OrTwL8GoB1wO4ZNLsu6Vgj53tn3tM1fnQD2QwyG8iN0DQFV4bRyV/UqMgxcziSpHRS
         9id/EB6qywvEKPx1uPAhTA7D3ExAGDEvl01SRcdjbX/O2dG5vWarEeoie8m37jXBwP
         U6sdPxd+liIAQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5450140513; Thu,  4 Feb 2021 09:58:19 -0300 (-03)
Date:   Thu, 4 Feb 2021 09:58:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 06/24] perf daemon: Add config file support
Message-ID: <20210204125819.GA910119@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-7-jolsa@kernel.org>
 <CAM9d7cjuPHh6j2H5-M-5=4MSujoJH7rWUYwKbypOk7_Jt-6QTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjuPHh6j2H5-M-5=4MSujoJH7rWUYwKbypOk7_Jt-6QTg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 04, 2021 at 09:42:35PM +0900, Namhyung Kim escreveu:
> Hi Jiri,
> 
> On Sun, Jan 31, 2021 at 8:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
> [SNIP]
> > +#define SESSION_OUTPUT  "output"
> > +
> > +/*
> > + * Session states:
> > + *
> > + *   OK       - session is up and running
> > + *   RECONFIG - session is pending for reconfiguration,
> > + *              new values are already loaded in session object
> > + *   KILL     - session is pending to be killed
> > + *
> > + * Session object life and its state is maintained by
> > + * following functions:
> > + *
> > + *  setup_server_config
> > + *    - reads config file and setup session objects
> > + *      with following states:
> > + *
> > + *      OK       - no change needed
> > + *      RECONFIG - session needs to be changed
> > + *                 (run variable changed)
> > + *      KILL     - session needs to be killed
> > + *                 (session is no longer in config file)
> > + *
> > + *  daemon__reconfig
> > + *    - scans session objects and does following actions
> > + *      for states:
> > + *
> > + *      OK       - skip
> > + *      RECONFIG - session is killed and re-run with new config
> > + *      KILL     - session is killed
> > + *
> > + *    - all sessions have OK state on the function exit
> > + */
> > +enum session_state {
> > +       SESSION_STATE__OK,
> > +       SESSION_STATE__RECONFIG,
> > +       SESSION_STATE__KILL,
> > +};
> > +
> > +struct session {
> > +       char                    *base;
> > +       char                    *name;
> > +       char                    *run;
> > +       int                      pid;
> > +       struct list_head         list;
> > +       enum session_state       state;
> > +};
> 
> Although I think calling it 'session' is intuitive, it's also confusing
> as we already have struct perf_session...

Maybe 'struct server_session' ? If this ends up in tools/lib/perf, then
it gets renamed to 'struct perf_server_session', just like we have
'struct perf_evsel' in libperf and 'struct evsel' in tools/perf/, right?

- Arnaldo
