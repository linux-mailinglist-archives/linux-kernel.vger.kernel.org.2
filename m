Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384624153AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbhIVXA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238364AbhIVXA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:00:56 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94221C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:59:25 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y197so5564784iof.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pqGlaeTi7J15oAmFBMcDMPPmFmeEf7zfAbebDrPl/s=;
        b=MRYTHsccewbb3d4zqHwXXdEQ9gJeP/w9TbjygW246JnXhIu3haJmwhHY36GaMlXHun
         w+OudQ6FNF4FC4anwDSDdDnnIG95TlRU/UafK4AuzzgoAZm0JQwQB70WnFIAP2nxQ5ZZ
         4SgllZda6UofFCsikq/3FQ+xgwSoe99QI+VOqKpVNLjCN8nhJSR4qtwZfTaFnm474HAj
         JGeHy7OsTk3fMPGgskcwDehPbgh7g75M92SHIN92vhxQ3PMyPBehdHbwLHe/bryUEwPG
         UpCviIpJAWtXt8Q5s77bUvnGP9XoJcDJZOQNeaL6l9jTeePLYvIMdxkf6DSejEwYUeOP
         37Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pqGlaeTi7J15oAmFBMcDMPPmFmeEf7zfAbebDrPl/s=;
        b=mc79agpy2sBjQkJ8E4krfoAnq27BFx1RG9qtqDeQinviVQcJF+kZCzUPCen3SUzp7x
         5A8SsALujuxByIt9sdOVoTdlbRJINkv7RadDLE3AJgRQN7IP7faOGhpDqiXa4HJTMWHu
         R0+TySt5XSubdAgTMr8jQe832z8Y1UAU9XQhV/blIG6JFUNA+W2hXDaGxO9DGN39FVWn
         kz2rvcCl4HckpWaPzhqXWhS2/JcDzP53UqcH4y1PXk/qIN+LAbXFMLJF8pl5OvSkMCg+
         zx4fBvs9lnli0go5nprvCI5HXD4Dz0/w25j4JK8w0Aek+CjWva2c4GsE9X5bndYoHovm
         TEqg==
X-Gm-Message-State: AOAM530s1pspnroLgXSDLHF7PdfI4rPiwoh3xHHI6DCZTeOKxY2vUQTQ
        rJC8qHy36qO2Hl7Rcb9yWcTbPA7C7SalVDQKMAMUXA==
X-Google-Smtp-Source: ABdhPJzyjNZvscMgFOYtdkguz4v/LcpUwFymfOfQDg9/qcs0gFxDMyCitkVXlLtetOMwLNSMbaDhrNj8WLIkU0uIrjA=
X-Received: by 2002:a05:6602:3403:: with SMTP id n3mr1236381ioz.35.1632351564722;
 Wed, 22 Sep 2021 15:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210921181349.199780-1-irogers@google.com> <YUudR8ST7qGYdFQE@krava>
In-Reply-To: <YUudR8ST7qGYdFQE@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Sep 2021 15:59:11 -0700
Message-ID: <CAP-5=fVWGT0=0k0eG0c-6wEGod=49SVsumJRN2=SxmgOo5A4dw@mail.gmail.com>
Subject: Re: [PATCH v2] perf evlist: Remove group option.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 2:17 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Sep 21, 2021 at 11:13:49AM -0700, Ian Rogers wrote:
>
> SNIP
>
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index 8feef3a05af7..9cd79513eebb 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -1109,14 +1109,6 @@ static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
> >                                  PyObject *args, PyObject *kwargs)
> >  {
> >       struct evlist *evlist = &pevlist->evlist;
> > -     int group = 0;
> > -     static char *kwlist[] = { "group", NULL };
> > -
> > -     if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|OOii", kwlist, &group))
> > -             return NULL;
> > -
> > -     if (group)
> > -             evlist__set_leader(evlist);
> >
> >       if (evlist__open(evlist) < 0) {
> >               PyErr_SetFromErrno(PyExc_OSError);
> > diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> > index bff669b615ee..9e694db7c7ee 100644
> > --- a/tools/perf/util/record.c
> > +++ b/tools/perf/util/record.c
> > @@ -99,13 +99,6 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
> >       bool use_comm_exec;
> >       bool sample_id = opts->sample_id;
> >
> > -     /*
> > -      * Set the evsel leader links before we configure attributes,
> > -      * since some might depend on this info.
> > -      */
> > -     if (opts->group)
> > -             evlist__set_leader(evlist);
> > -
>
> I don't mind erasing that, but just curious if you're going
> to add something which would clash with this? it does not
> look too complex for the code.. but still, let's remove it
> if it's in 'legacy mode' for this long ;-)

I've nothing conflicting but I came across old tutorials describing it
and I suspect usage of it is likely broken - in particular mixing
--group with -e {}.

Thanks,
Ian

> thanks,
> jirka
>
>
> >       if (evlist->core.cpus->map[0] < 0)
> >               opts->no_inherit = true;
> >
> > diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
> > index 68f471d9a88b..d71dee9ce41c 100644
> > --- a/tools/perf/util/record.h
> > +++ b/tools/perf/util/record.h
> > @@ -13,7 +13,6 @@ struct option;
> >
> >  struct record_opts {
> >       struct target target;
> > -     bool          group;
> >       bool          inherit_stat;
> >       bool          no_buffering;
> >       bool          no_inherit;
> > --
> > 2.33.0.464.g1972c5931b-goog
> >
>
