Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E5931204F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 23:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhBFWhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 17:37:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhBFWhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 17:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612650947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iJib8QmcQN441HQKmyRBb3QUCGJFYljU9JWOnR3h8NU=;
        b=ad1zfKS6pigcejNKfWHQwKd03ImchAKoU5kwe7DPmBp216Q9+xWh+GPgzvEhJRKWFC9ESy
        Z1fom1dgDrJX4a4JPpdMRPY85lBk1fvkBplznw8LAMeDEB/uUlnI2lLh0eKLg6aaGgIPcX
        cclpOfYp8SglIEVzr+AT5RLQwUhK0Yo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-M5WN5igeOZmaBEYG4mSGmg-1; Sat, 06 Feb 2021 17:35:44 -0500
X-MC-Unique: M5WN5igeOZmaBEYG4mSGmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD6689126F;
        Sat,  6 Feb 2021 22:35:41 +0000 (UTC)
Received: from krava (unknown [10.40.192.19])
        by smtp.corp.redhat.com (Postfix) with SMTP id ED96E61F59;
        Sat,  6 Feb 2021 22:35:38 +0000 (UTC)
Date:   Sat, 6 Feb 2021 23:35:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <YB8ZuV6SS3T8Y/Ul@krava>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-7-jolsa@kernel.org>
 <CAM9d7cg6qEeq--PPxyC9Bq8VNw91O_M+PgnNQ-Sk7n_tKOE1yg@mail.gmail.com>
 <YB1AihrsetqhIYIc@krava>
 <CAM9d7chedaB7-ZsqpUYGnG9LBYOspd59Nq842Q_yCR4YWDQL9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chedaB7-ZsqpUYGnG9LBYOspd59Nq842Q_yCR4YWDQL9g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 06, 2021 at 05:05:04PM +0900, Namhyung Kim wrote:
> On Fri, Feb 5, 2021 at 9:56 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Feb 05, 2021 at 09:14:54PM +0900, Namhyung Kim wrote:
> > > On Sun, Jan 31, 2021 at 8:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > [SNIP]
> > > > @@ -263,9 +605,16 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
> > > >         signal(SIGTERM, sig_handler);
> > > >
> > > >         while (!done && !err) {
> > > > -               if (fdarray__poll(&fda, -1)) {
> > > > +               err = daemon__reconfig(daemon);
> > >
> > > I think it's confusing since you put the reconfig function here.
> > > What not split normal and reconfig passes?
> >
> > hum, not sure what's confusing in here? I've been known to
> > produce confusing code, but this one seems clear to me
> 
> Maybe it's because of the name.  I thought reconfig is a
> special case when it detects some change.  But you call
> it in the loop unconditionally.
> 
> >
> > >
> > > I mean something like below
> > >
> > >  __cmd_start()
> > > {
> > >     setup_server_config();
> > >     daemon__run();
> >
> > what's daemon__run? the daemon operates in the while loop below
> 
> I thought about starting the sessions in the config.
> 
> >
> > >
> > >     while (!done && !err) {
> > >         ...
> > >         if (reconfig) {
> > >             daemon__kill();
> >
> > you don't kill daemon for each reconfig change,
> > we detect changed sessions and kill/restart only them
> 
> Yep, we can make it that way.
> 
> >
> > >             setup_server_config();
> > >             daemon__reconfig();
> > >         }
> > >     }
> >
> >
> > so basically the current workflow is:
> >
> >         setup_server_config                                     <--- reads config file, prepares session objects
> >
> >         while (!done) {
> >                 daemon__reconfig                                <--- check session objects states and run/stop them
> 
> Hmm.. then how about rename it to daemon__handle_state()
> or daemon__do_loop() or something?

well it handles reconfig, so I don't think that there's
better name than daemon__reconfig ;-)

apart from handle_server_socket, all the other functions
we call after poll can change session state, so we need
to 'reconfig' sessions each time we do a loop

jirka

