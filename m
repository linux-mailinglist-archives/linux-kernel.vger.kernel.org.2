Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577573B42BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFYL4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230235AbhFYL4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624622052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DuhrZWYgsHGEDzFkorHdrzg1wXdLu2i4a836EtfS2mY=;
        b=Or1DtRB7rtGU/Hi4ZOh0pVPql9pTJoBlX2kRokBYVZw7wN4eJDPsdMGCRfEbRlm+VHoMHq
        WSU0P/1LeSwmHqSIfmhfObTTQzvNbqssh61ngquW//WSPod7/Leov6WTIn6tYH6NIOH0OR
        Ay9X6JIhcj9/1obSB2qAw0Ptr/rm2tk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-nv-ZmkPQOl6NvsLEKL8D5w-1; Fri, 25 Jun 2021 07:54:08 -0400
X-MC-Unique: nv-ZmkPQOl6NvsLEKL8D5w-1
Received: by mail-ed1-f70.google.com with SMTP id y18-20020a0564022712b029038ffac1995eso5074808edd.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 04:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DuhrZWYgsHGEDzFkorHdrzg1wXdLu2i4a836EtfS2mY=;
        b=b67LSG/CB0DW88Wtjw/iB2SPjtLwarpiW0S84i/HOuFw7kUa/v1au/0DsLsnyf3jbC
         0wFcN+PNhuD5tOtadDAV8Q1F5FQyJ1LFrMn2ktvbpvnIxBEHmgvxla/Yn7MxypDHp6nX
         Q27KAmXuWy8VZ6QbPbdNp8m5jEpBSl4zCj6/WUOIj4ZlGa1KOP6Rk/A+Pn8Ntlhz5b0P
         rSalH70roC9f9FtdF1vH6jKTkJtR6WHWDs919jV3DHIb41RjZFg1rCr5fpE16TNv+Ase
         T5H491xl1GUhM88xerzrZO6rVrK8BqgPPdx0UuI5LQfvwvX2idH8Lwp4V/Z2EXOnzsN7
         qPiw==
X-Gm-Message-State: AOAM531ABO3cb6Sx6rwIXyOacOOJxCRf/BlZ+2CJVbki9D2GZaA6uewg
        p0s3SDpGMplyjsUqynAjW/OWWD2OY9qScaCWwACbSFVsqNdzFwP4G3qaj1VUM9lX06cf1akIvkr
        Dps2+wiU9CkkdE3OOYP3Fw9KN
X-Received: by 2002:a17:906:9bd5:: with SMTP id de21mr10234126ejc.554.1624622046964;
        Fri, 25 Jun 2021 04:54:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF9XnW4/tmgAqs4EjmvNpAiZqVLOokVqJ8Ax/ECJWRnDscvPiygYW2Y2pB9HNMmkM+gNHEIg==
X-Received: by 2002:a17:906:9bd5:: with SMTP id de21mr10234102ejc.554.1624622046705;
        Fri, 25 Jun 2021 04:54:06 -0700 (PDT)
Received: from krava ([5.170.249.192])
        by smtp.gmail.com with ESMTPSA id i6sm2600777ejr.68.2021.06.25.04.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 04:54:06 -0700 (PDT)
Date:   Fri, 25 Jun 2021 13:54:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf session: add missing evlist__delete when
 deleting a session
Message-ID: <YNXD2xN2wrZgdbwO@krava>
References: <20210624231926.212208-1-rickyman7@gmail.com>
 <CAP-5=fVbGZbV3qp27DPD_7r0z-v9hr2m34H294angaEsssKB0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVbGZbV3qp27DPD_7r0z-v9hr2m34H294angaEsssKB0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 10:39:34PM -0700, Ian Rogers wrote:
> On Thu, Jun 24, 2021 at 4:20 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> >
> > ASan reports a memory leak caused by evlist not being deleted on exit in
> > perf-report, perf-script and perf-data.
> > The problem is caused by evlist->session not being deleted, which is
> > allocated in perf_session__read_header, called in perf_session__new if
> > perf_data is in read mode.
> > In case of write mode, the session->evlist is filled by the caller.
> > This patch solves the problem by calling evlist__delete in
> > perf_session__delete if perf_data is in read mode.

ugh, I'm surprised we did not free that.. and can't find
in git log we ever did ;-) I briefly check commands using
sessions and looks like it's correct

Acked-by: Jiri Olsa <jolsa@redhat.com>

> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> It is messy that in read mode the session owns the evlist, but
> otherwise not. Imo, it'd be nice to make the ownership unconditional.

yep, would be nice

thanks,
jirka

> 
> Thanks,
> Ian
> 
> > Changes in v2:
> >  - call evlist__delete from within perf_session__delete
> >
> > v1: https://lore.kernel.org/lkml/20210621234317.235545-1-rickyman7@gmail.com/
> >
> > ASan report follows:
> >
> > $ ./perf script report flamegraph
> > =================================================================
> > ==227640==ERROR: LeakSanitizer: detected memory leaks
> >
> > <SNIP unrelated>
> >
> > Indirect leak of 2704 byte(s) in 1 object(s) allocated from:
> >     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
> >     #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
> >     #2 0x7f999e in evlist__new /home/user/linux/tools/perf/util/evlist.c:77:26
> >     #3 0x8ad938 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3797:20
> >     #4 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
> >     #5 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
> >     #6 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
> >     #7 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> >     #8 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
> >     #9 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> >     #10 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> >     #11 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> >
> > Indirect leak of 568 byte(s) in 1 object(s) allocated from:
> >     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
> >     #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
> >     #2 0x80ce88 in evsel__new_idx /home/user/linux/tools/perf/util/evsel.c:268:24
> >     #3 0x8aed93 in evsel__new /home/user/linux/tools/perf/util/evsel.h:210:9
> >     #4 0x8ae07e in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3853:11
> >     #5 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
> >     #6 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
> >     #7 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
> >     #8 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> >     #9 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
> >     #10 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> >     #11 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> >     #12 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> >
> > Indirect leak of 264 byte(s) in 1 object(s) allocated from:
> >     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
> >     #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
> >     #2 0xbe3e70 in xyarray__new /home/user/linux/tools/lib/perf/xyarray.c:10:23
> >     #3 0xbd7754 in perf_evsel__alloc_id /home/user/linux/tools/lib/perf/evsel.c:361:21
> >     #4 0x8ae201 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3871:7
> >     #5 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
> >     #6 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
> >     #7 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
> >     #8 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> >     #9 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
> >     #10 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> >     #11 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> >     #12 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> >
> > Indirect leak of 32 byte(s) in 1 object(s) allocated from:
> >     #0 0x4f4137 in calloc (/home/user/linux/tools/perf/perf+0x4f4137)
> >     #1 0xbe3d56 in zalloc /home/user/linux/tools/lib/perf/../../lib/zalloc.c:8:9
> >     #2 0xbd77e0 in perf_evsel__alloc_id /home/user/linux/tools/lib/perf/evsel.c:365:14
> >     #3 0x8ae201 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3871:7
> >     #4 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
> >     #5 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
> >     #6 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
> >     #7 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> >     #8 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
> >     #9 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> >     #10 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> >     #11 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> >
> > Indirect leak of 7 byte(s) in 1 object(s) allocated from:
> >     #0 0x4b8207 in strdup (/home/user/linux/tools/perf/perf+0x4b8207)
> >     #1 0x8b4459 in evlist__set_event_name /home/user/linux/tools/perf/util/header.c:2292:16
> >     #2 0x89d862 in process_event_desc /home/user/linux/tools/perf/util/header.c:2313:3
> >     #3 0x8af319 in perf_file_section__process /home/user/linux/tools/perf/util/header.c:3651:9
> >     #4 0x8aa6e9 in perf_header__process_sections /home/user/linux/tools/perf/util/header.c:3427:9
> >     #5 0x8ae3e7 in perf_session__read_header /home/user/linux/tools/perf/util/header.c:3886:2
> >     #6 0x8ec714 in perf_session__open /home/user/linux/tools/perf/util/session.c:109:6
> >     #7 0x8ebe83 in perf_session__new /home/user/linux/tools/perf/util/session.c:213:10
> >     #8 0x60c6de in cmd_script /home/user/linux/tools/perf/builtin-script.c:3856:12
> >     #9 0x7b2930 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
> >     #10 0x7b120f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
> >     #11 0x7b2493 in run_argv /home/user/linux/tools/perf/perf.c:409:2
> >     #12 0x7b0c89 in main /home/user/linux/tools/perf/perf.c:539:3
> >     #13 0x7f5260654b74  (/lib64/libc.so.6+0x27b74)
> >
> > SUMMARY: AddressSanitizer: 3728 byte(s) leaked in 7 allocation(s).
> >
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > ---
> >  tools/perf/util/session.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index e59242c361ce..c36464d94387 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -301,8 +301,11 @@ void perf_session__delete(struct perf_session *session)
> >         perf_session__release_decomp_events(session);
> >         perf_env__exit(&session->header.env);
> >         machines__exit(&session->machines);
> > -       if (session->data)
> > +       if (session->data) {
> > +               if (perf_data__is_read(session->data))
> > +                       evlist__delete(session->evlist);
> >                 perf_data__close(session->data);
> > +       }
> >         free(session);
> >  }
> >
> > --
> > 2.31.1
> >
> 

