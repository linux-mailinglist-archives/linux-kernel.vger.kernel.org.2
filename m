Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506B7311C14
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 09:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBFIGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 03:06:07 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33970 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhBFIF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 03:05:58 -0500
Received: by mail-lf1-f45.google.com with SMTP id a12so13927889lfb.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 00:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2c02oGcqajn71CZBW4vnCCBPytWY5m2465JnwumXBXE=;
        b=pybtnFsTBx+tiErldkwOPW7TSkTMlaMypC4mjuKI8YnpZkUrAGtPMWtVt6j+qB+FCz
         M3ywXR8qtQFU2rPkKQ6+h1wEDBDRDIYhkh8jA7MUf6HePaaY0myHlcuge4bwpsPgcp0C
         qojNCXKGxNCM+T1Yxya67KvZcPhekV+dEQqZ04g/0MvmuRw75se/eTrcYpp1jxkBavau
         j17OfowQ+2armx3ojxy7pnV5RWZcBGChsPctkAmh3IX2RnqB1lLE0mggZqgiHChlB/kI
         SyRBsR7Y4jNKw1/FsSHeE7SEGfHug5FW59w/aTSvzXA9zrwDOuKeW4zaaPPtbl9qDbqm
         XHjQ==
X-Gm-Message-State: AOAM533yP5gSIYv0UDlR/U3cy8giq2JPPjEo6+A8nLFuBDMj5wwUFg98
        QQr/BhT3LPOE+8jZSQQtLM1il+4kFVK/ccvCN60=
X-Google-Smtp-Source: ABdhPJx9xfMSPulw1nk72FT1O0OC6KbobEhvSVgp7HblGWuV0CDwXTKq0w5YkC/xSUiwmxl2LRA7EAjHOUox3yM1aCQ=
X-Received: by 2002:a19:5c6:: with SMTP id 189mr4536671lff.300.1612598715736;
 Sat, 06 Feb 2021 00:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20210129134855.195810-1-jolsa@redhat.com> <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-7-jolsa@kernel.org> <CAM9d7cg6qEeq--PPxyC9Bq8VNw91O_M+PgnNQ-Sk7n_tKOE1yg@mail.gmail.com>
 <YB1AihrsetqhIYIc@krava>
In-Reply-To: <YB1AihrsetqhIYIc@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 6 Feb 2021 17:05:04 +0900
Message-ID: <CAM9d7chedaB7-ZsqpUYGnG9LBYOspd59Nq842Q_yCR4YWDQL9g@mail.gmail.com>
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

On Fri, Feb 5, 2021 at 9:56 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Feb 05, 2021 at 09:14:54PM +0900, Namhyung Kim wrote:
> > On Sun, Jan 31, 2021 at 8:49 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > [SNIP]
> > > @@ -263,9 +605,16 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
> > >         signal(SIGTERM, sig_handler);
> > >
> > >         while (!done && !err) {
> > > -               if (fdarray__poll(&fda, -1)) {
> > > +               err = daemon__reconfig(daemon);
> >
> > I think it's confusing since you put the reconfig function here.
> > What not split normal and reconfig passes?
>
> hum, not sure what's confusing in here? I've been known to
> produce confusing code, but this one seems clear to me

Maybe it's because of the name.  I thought reconfig is a
special case when it detects some change.  But you call
it in the loop unconditionally.

>
> >
> > I mean something like below
> >
> >  __cmd_start()
> > {
> >     setup_server_config();
> >     daemon__run();
>
> what's daemon__run? the daemon operates in the while loop below

I thought about starting the sessions in the config.

>
> >
> >     while (!done && !err) {
> >         ...
> >         if (reconfig) {
> >             daemon__kill();
>
> you don't kill daemon for each reconfig change,
> we detect changed sessions and kill/restart only them

Yep, we can make it that way.

>
> >             setup_server_config();
> >             daemon__reconfig();
> >         }
> >     }
>
>
> so basically the current workflow is:
>
>         setup_server_config                                     <--- reads config file, prepares session objects
>
>         while (!done) {
>                 daemon__reconfig                                <--- check session objects states and run/stop them

Hmm.. then how about rename it to daemon__handle_state()
or daemon__do_loop() or something?

Thanks,
Namhyung


>
>                 if (fdarray__poll(&fda, -1)) {
>
>                         handle_config_changes(&reconfig)        <--- was there a config file change?
>
>                         if (reconfig)                           <--- yes,
>                                 setup_server_config             <---      change session objects/states
>                 }
>         }
>
> thanks,
> jirka
>
