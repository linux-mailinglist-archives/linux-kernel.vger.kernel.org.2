Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B8330F799
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbhBDQVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:21:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237046AbhBDPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612451429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9zxT8h4krmvEyNeER2GUPcF6dpHJdArDI7rNAQ5/h0=;
        b=VPXKgSKEZ1Z0/rb1EG24L9xZ+h8j2uT2Z+9dEB+7F74dLi2EEtYNB/oyYPZVTVAikJplU7
        F2NoEgC9pax9DxC9P8hKUfBbXlqfDX51eAq/+KMmSpIzzZgohnuXyBj4Qbp3HcSh14fnu+
        FScEXw1it4trtnKsQg64SWYENfS9iRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-_ilwDTvGMuuELD8NYgs6uw-1; Thu, 04 Feb 2021 10:10:27 -0500
X-MC-Unique: _ilwDTvGMuuELD8NYgs6uw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DE9F192CC41;
        Thu,  4 Feb 2021 15:10:25 +0000 (UTC)
Received: from krava (unknown [10.40.194.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1A1915D6D7;
        Thu,  4 Feb 2021 15:10:22 +0000 (UTC)
Date:   Thu, 4 Feb 2021 16:10:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 06/24] perf daemon: Add config file support
Message-ID: <YBwOXnK/RIEzPFPm@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-7-jolsa@kernel.org>
 <CAM9d7cjuPHh6j2H5-M-5=4MSujoJH7rWUYwKbypOk7_Jt-6QTg@mail.gmail.com>
 <20210204125819.GA910119@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204125819.GA910119@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:58:19AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 04, 2021 at 09:42:35PM +0900, Namhyung Kim escreveu:
> > Hi Jiri,
> > 
> > On Sun, Jan 31, 2021 at 8:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > [SNIP]
> > > +#define SESSION_OUTPUT  "output"
> > > +
> > > +/*
> > > + * Session states:
> > > + *
> > > + *   OK       - session is up and running
> > > + *   RECONFIG - session is pending for reconfiguration,
> > > + *              new values are already loaded in session object
> > > + *   KILL     - session is pending to be killed
> > > + *
> > > + * Session object life and its state is maintained by
> > > + * following functions:
> > > + *
> > > + *  setup_server_config
> > > + *    - reads config file and setup session objects
> > > + *      with following states:
> > > + *
> > > + *      OK       - no change needed
> > > + *      RECONFIG - session needs to be changed
> > > + *                 (run variable changed)
> > > + *      KILL     - session needs to be killed
> > > + *                 (session is no longer in config file)
> > > + *
> > > + *  daemon__reconfig
> > > + *    - scans session objects and does following actions
> > > + *      for states:
> > > + *
> > > + *      OK       - skip
> > > + *      RECONFIG - session is killed and re-run with new config
> > > + *      KILL     - session is killed
> > > + *
> > > + *    - all sessions have OK state on the function exit
> > > + */
> > > +enum session_state {
> > > +       SESSION_STATE__OK,
> > > +       SESSION_STATE__RECONFIG,
> > > +       SESSION_STATE__KILL,
> > > +};
> > > +
> > > +struct session {
> > > +       char                    *base;
> > > +       char                    *name;
> > > +       char                    *run;
> > > +       int                      pid;
> > > +       struct list_head         list;
> > > +       enum session_state       state;
> > > +};
> > 
> > Although I think calling it 'session' is intuitive, it's also confusing
> > as we already have struct perf_session...

ok, how about daemon_session then?

> 
> Maybe 'struct server_session' ? If this ends up in tools/lib/perf, then
> it gets renamed to 'struct perf_server_session', just like we have
> 'struct perf_evsel' in libperf and 'struct evsel' in tools/perf/, right?

let's have our grand-grand-grandkids worry about that ;-)

thanks,
jirka

