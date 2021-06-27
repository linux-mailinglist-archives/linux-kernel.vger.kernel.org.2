Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446303B5481
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 19:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhF0R2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 13:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230321AbhF0R2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 13:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624814742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=skkCw+d70S8mPiaDpBZWLn4AB4OWi8yTP0vz6O9rIOA=;
        b=fVcFr+2mocqysKN8IGhV+RZfgpppB8LhLiaQ4DzZkfWMijg7B5XoGAQp/+Xt5Qqn45iS3P
        dSkUEUW+IsZftZMdYQIqnyonKZ9mdwJOvseMLgsW0WSBCwFJoWmC+3SUl5mGd0N0AhrMUE
        nuynb1TLMuHykD1f9LLGOrn4Raz3HqA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-ZAegjDv4PGmA68SFODuLIA-1; Sun, 27 Jun 2021 13:25:40 -0400
X-MC-Unique: ZAegjDv4PGmA68SFODuLIA-1
Received: by mail-ed1-f72.google.com with SMTP id p13-20020a05640210cdb029039560ff6f46so381032edu.17
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 10:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=skkCw+d70S8mPiaDpBZWLn4AB4OWi8yTP0vz6O9rIOA=;
        b=LCLc29zAmm4TFFwpy5N245GypdFmMrLX4mXKGj3Xr1GScGXwBtiOWE9wesD73Sq7AH
         IDM2u5XEvp+Hrg0FXdgYWO83OGJE7SsffiLFfqEGVGZ72GlCbtLoVaQhptpU8dVgzZ3r
         Uben1YLf1BklpEgmFVmGY0OMSRT4T22yzqGr1sU4EoG8EFavMNXOkZGuZ7zd78+cgc9V
         4oK4oZkjimfGYpzIUO+0fR+CRoxhc3coGw1voyfTspS2cTJ74ADJuGT/3wd3x1xMahvB
         71dIv5UVpfSiaBqlVkm0KwCu4l7IfEkYrz1ST9pDLQ6pPBME9uCM7a3ikarpA19STm2m
         27pA==
X-Gm-Message-State: AOAM531KmjcnPteR+6iO7mgrH0/6/CVihE2N9jAcC1jxMj2OSATO4Cvg
        rd+GcvM53m+9HRhcxN6KWUoKiLmJwvx7g7zSYJqZlIH6K6P1X6WqT7jxpqT7AyDDahMn+XeeesC
        3cR00OXoUmcABIQdfiQCZJutz
X-Received: by 2002:a17:906:bc2:: with SMTP id y2mr20526572ejg.489.1624814739769;
        Sun, 27 Jun 2021 10:25:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuAhSq9JI6L+1VcEEN2VLsdzIO1R05EKrvLXsiFCq2QQiCEKw94fJ3Q8fyh2tfr5PtyR5POA==
X-Received: by 2002:a17:906:bc2:: with SMTP id y2mr20526564ejg.489.1624814739600;
        Sun, 27 Jun 2021 10:25:39 -0700 (PDT)
Received: from krava ([5.171.209.125])
        by smtp.gmail.com with ESMTPSA id v5sm8066134edt.55.2021.06.27.10.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 10:25:39 -0700 (PDT)
Date:   Sun, 27 Jun 2021 19:25:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [RFC 00/10] perf: Add build id parsing fault detection/fix
Message-ID: <YNi0j8nhh8X6j/ZE@krava>
References: <20210622153918.688500-1-jolsa@kernel.org>
 <YNIgXkH1xaF7H3Tr@kernel.org>
 <CAP-5=fU=AAJ0_s1orsF=OCO0=bSmr9BhAmtN251bU_pf0ZFJ6Q@mail.gmail.com>
 <YNIobHgfVbiiNscn@kernel.org>
 <YNJT0wvghSZzPJ8Y@krava>
 <CAM9d7chs=4mdRG389G8eDzeKmvB7PDuWp7mxd_ScuFiy0hYt3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chs=4mdRG389G8eDzeKmvB7PDuWp7mxd_ScuFiy0hYt3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 12:48:30PM -0700, Namhyung Kim wrote:
> Hi Jiri,
> 
> Thanks for your work!
> 
> On Tue, Jun 22, 2021 at 2:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Jun 22, 2021 at 03:14:04PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Jun 22, 2021 at 10:47:54AM -0700, Ian Rogers escreveu:
> > > > On Tue, Jun 22, 2021 at 10:39 AM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > Em Tue, Jun 22, 2021 at 05:39:08PM +0200, Jiri Olsa escreveu:
> > > > > > hi,
> > > > > > this *RFC* patchset adds support to detect faults during
> > > > > > mmap2's build id parsing and a way to fix such maps in
> > > > > > generated perf.data.
> > > > > >
> > > > > > It adds support to record build id faults count for session
> > > > > > and store it in perf.data and perf inject support to find
> > > > > > these maps and reads build ids for them in user space.
> > > > >
> > > > > > It's probably best explained by the workflow:
> > > > > >
> > > > > >   Record data with --buildid-mmap option:
> > > > > >
> > > > > >     # perf record --buildid-mmap ...
> > > > > >     ...
> > > > > >     [ perf record: Woken up 1 times to write data ]
> > > > > >     [ perf record: Failed to parse 4 build ids]
> > > > > >     [ perf record: Captured and wrote 0.008 MB perf.data ]
> > > > > >
> > > > > >   Check if there's any build id fault reported:
> > > > > >
> > > > > >     # perf report --header-only
> > > > > >     ...
> > > > > >     # build id mmap stats: FAULTS 4, LOST 0, NOT FIXED
> > > > > >
> > > > > >   There is, check the stats:
> > > > > >
> > > > > >     # perf report --stat
> > > > > >
> > > > > >     Aggregated stats:
> > > > > >              TOTAL events:        104
> > > > > >                       ....
> > > > > >            BUILD_ID fails:          4  (14.3%)
> > > > > >
> > > > > >   Yep, let's fix it:
> > > > > >
> > > > > >     # perf inject --buildid-mmap2 -i perf.data -o perf-fixed.data
> > > > >
> > > > > Can we make it possible to automate this with --fixup-buildids or a
> > > > > perfconfig 'record' knob?
> > > > >
> > > > > This would entail requesting that build-ids that _fail_ be sent to the
> > > > > side-band thread we have in 'perf record', this way we wouldn't have to
> > > > > traverse the whole perf.data file, be it with 'perf-record' at the end
> > > > > of a session with faulty build ids, or in a similar fashion using 'perf
> > > > > inject' as you suggest.
> > > > >
> > > > > I even think that we can have all these modes and let the user to decide
> > > > > how important is this for them and how convenient they want the whole
> > > > > process to be.
> >
> > right, that might be good to decide first.. because as I said,
> > I never hit faulted build id, so it probably needs the special
> > setup you guys are using.. could you try on your setup and check
> > how many faulted build ids you see?
> 
> Did you check data mmaps?  It might be easy to get faults
> from data files and we don't know if it's an ELF or not
> before reading the ELF header in the first page.

well, AFAICS the mmap event is sent right after the elf file
is loaded, so it does not have a chance to be swapped out

> 
> I'm not sure if we can limit it to exec mappings, there might
> be data-only DSOs and we may want to symbolize them too.

hum, I haven't checked the data-only DSO, which we'd load
manually, not the loader.. will check

thanks,
jirka

