Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D583120BA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 02:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhBGBj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 20:39:26 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:33014 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGBjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 20:39:24 -0500
Received: by mail-lj1-f176.google.com with SMTP id a25so12437686ljn.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 17:39:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mL9d9Wqg5g+wwMLVDrn7VkCf+Ey0d26fPVchp2XF76c=;
        b=CA7ELk+kIOZ7RqkdW4D5mjF2YxZCPmFIO3t4T2JPddqky0onDvtdX1dVtp/hHb479H
         bDdGNGsArJ7Lfaujh1VeDfNs88aYSKC2Iw2+pQK9omU55mTMIpjPyW91lC0YWNPmP3Kc
         Zkxz+DtqoDyR/aDcN5JPQVzROEMmElA/nE8iwSCxqfP74F8rX2rENqWgVRqXxeNDDJAt
         Sv51BA78feY4TZ4UDaGUgkBXWVHcWsKZI0338BDkcvAZF+xBLJ3ZQCEqVfFMdb/2d0oo
         r8CNAictjpd4oMPhylBXwHBlsyjrZIiTAnsc/X7XFGtNFhDdls8iQdXyrWAO9dDMTbJR
         GiAA==
X-Gm-Message-State: AOAM5319SrlWgp7zWvpRCUOt+eG9djmJwDR4DrBDaVxwZ+g4qJ6XqYTB
        U8oknjSO++HyxqTz+5txp8l8o6DGc1lk/7C5bA4=
X-Google-Smtp-Source: ABdhPJwRVj0u1xMmtaHeYD712f2jabL47pF6ImI11krM4G/acsBk+vTIHW7zXEMsII85qzCGAcI7J3KeZRTDLsh5bh0=
X-Received: by 2002:a2e:9949:: with SMTP id r9mr6359921ljj.393.1612661922481;
 Sat, 06 Feb 2021 17:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20210129134855.195810-1-jolsa@redhat.com> <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-7-jolsa@kernel.org> <CAM9d7cg6qEeq--PPxyC9Bq8VNw91O_M+PgnNQ-Sk7n_tKOE1yg@mail.gmail.com>
 <YB1AihrsetqhIYIc@krava> <CAM9d7chedaB7-ZsqpUYGnG9LBYOspd59Nq842Q_yCR4YWDQL9g@mail.gmail.com>
 <YB8ZuV6SS3T8Y/Ul@krava>
In-Reply-To: <YB8ZuV6SS3T8Y/Ul@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 7 Feb 2021 10:38:31 +0900
Message-ID: <CAM9d7cjmbrTiCjJjdfhBFCm8GhT-_fZE3DzWQLUMPj3a_6XJOw@mail.gmail.com>
Subject: Re: [PATCH 06/24] perf daemon: Add config file support
To:     Jiri Olsa <jolsa@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 7:35 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sat, Feb 06, 2021 at 05:05:04PM +0900, Namhyung Kim wrote:
> > On Fri, Feb 5, 2021 at 9:56 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Fri, Feb 05, 2021 at 09:14:54PM +0900, Namhyung Kim wrote:
> > > > On Sun, Jan 31, 2021 at 8:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > [SNIP]
> > > > > @@ -263,9 +605,16 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
> > > > >         signal(SIGTERM, sig_handler);
> > > > >
> > > > >         while (!done && !err) {
> > > > > -               if (fdarray__poll(&fda, -1)) {
> > > > > +               err = daemon__reconfig(daemon);
> > > >
> > > > I think it's confusing since you put the reconfig function here.
> > > > What not split normal and reconfig passes?
> > >
> > > hum, not sure what's confusing in here? I've been known to
> > > produce confusing code, but this one seems clear to me
> >
> > Maybe it's because of the name.  I thought reconfig is a
> > special case when it detects some change.  But you call
> > it in the loop unconditionally.
> >
> > >
> > > >
> > > > I mean something like below
> > > >
> > > >  __cmd_start()
> > > > {
> > > >     setup_server_config();
> > > >     daemon__run();
> > >
> > > what's daemon__run? the daemon operates in the while loop below
> >
> > I thought about starting the sessions in the config.
> >
> > >
> > > >
> > > >     while (!done && !err) {
> > > >         ...
> > > >         if (reconfig) {
> > > >             daemon__kill();
> > >
> > > you don't kill daemon for each reconfig change,
> > > we detect changed sessions and kill/restart only them
> >
> > Yep, we can make it that way.
> >
> > >
> > > >             setup_server_config();
> > > >             daemon__reconfig();
> > > >         }
> > > >     }
> > >
> > >
> > > so basically the current workflow is:
> > >
> > >         setup_server_config                                     <--- reads config file, prepares session objects
> > >
> > >         while (!done) {
> > >                 daemon__reconfig                                <--- check session objects states and run/stop them
> >
> > Hmm.. then how about rename it to daemon__handle_state()
> > or daemon__do_loop() or something?
>
> well it handles reconfig, so I don't think that there's
> better name than daemon__reconfig ;-)
>
> apart from handle_server_socket, all the other functions
> we call after poll can change session state, so we need
> to 'reconfig' sessions each time we do a loop

OK then.  Thanks for the explanation!

Thanks,
Namhyung
