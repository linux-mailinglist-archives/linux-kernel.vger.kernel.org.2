Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C83B5482
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 19:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhF0R3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 13:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230321AbhF0R3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 13:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624814838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W7oZNI+eB1boUk6htzJPckEmUvX3ZwQ+Y19ev0P4i3Q=;
        b=fk6y+/9OhRix1n1EBj3LIpoU352dGUrJapa9N3MmqtJ7Qiu+wr+62Htw7QbV3Bg+wtuSup
        dKW26hFfdEEnkxP1kyuYrT8ZWBrA6Qjgo8g2GOe5YL8I8KSbQCqb3msHNrMT4CAoqe8tmO
        SZVwBCm7ag383ZR1L9vs9kyzN7IhWIw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-u-XLKSATPTqUC7zKQrcvUA-1; Sun, 27 Jun 2021 13:27:17 -0400
X-MC-Unique: u-XLKSATPTqUC7zKQrcvUA-1
Received: by mail-ed1-f69.google.com with SMTP id o8-20020aa7dd480000b02903954c05c938so1246930edw.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 10:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W7oZNI+eB1boUk6htzJPckEmUvX3ZwQ+Y19ev0P4i3Q=;
        b=o1FgaZIyBxba5QbWszohUB+Ev0hSRpW4xXd8TVfJML92s1GxdEafO6ru96qjPaEjrC
         tAziUFipOseob6CraCWhy08dGCtcmq/FJZWHA3E2w/K1wN0dU0axduVN68U3bSfs1Wve
         OA0S/K44kvf9EGc8IikQIXiXzzmzNrwY21qP855HTaPOC+f9+3qcNqfJO1iPh8vi6otJ
         fGd3proOomtVocwRpYeVTW1A8kJIOA6jDKkNvqunHgf6V0ZzfA7he4ZP/Lz3Ydqezt0x
         THkfn61laRQ4sgN09GTymK4WOEv7or3T7tt6hRGXe5TmKD6gDZa1g7V6W5Pw5rBZ4uhe
         QYcw==
X-Gm-Message-State: AOAM531c+tfE0uTpSr43Fol63yEiIaA+vH8jUGVpIh7eMCKh/DOnMtej
        +qDgSxYkp6IE7zgCg6Hg/7w4mAFmTE818c+iXBoUelA/vrnRLg4mQI7peUEobUH9vFqiG3pExbF
        LDgPb8f/TJzghlv6ZacTbpa6A
X-Received: by 2002:a05:6402:5248:: with SMTP id t8mr28396505edd.110.1624814836183;
        Sun, 27 Jun 2021 10:27:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ11X2Unnd2vnI7F3u5cGhBK+g68ivwDP7x+aG2yeIJRBL7hM0LyDlHZQwEITbl4ndvNM5Iw==
X-Received: by 2002:a05:6402:5248:: with SMTP id t8mr28396491edd.110.1624814836055;
        Sun, 27 Jun 2021 10:27:16 -0700 (PDT)
Received: from krava ([5.171.209.125])
        by smtp.gmail.com with ESMTPSA id bz27sm5864862ejc.15.2021.06.27.10.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 10:27:15 -0700 (PDT)
Date:   Sun, 27 Jun 2021 19:27:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [RFC 00/10] perf: Add build id parsing fault detection/fix
Message-ID: <YNi08CN8VE16d0n2@krava>
References: <20210622153918.688500-1-jolsa@kernel.org>
 <YNIgXkH1xaF7H3Tr@kernel.org>
 <CAP-5=fU=AAJ0_s1orsF=OCO0=bSmr9BhAmtN251bU_pf0ZFJ6Q@mail.gmail.com>
 <YNIobHgfVbiiNscn@kernel.org>
 <YNJT0wvghSZzPJ8Y@krava>
 <CAM9d7chs=4mdRG389G8eDzeKmvB7PDuWp7mxd_ScuFiy0hYt3g@mail.gmail.com>
 <alpine.LRH.2.20.2106241339140.27231@Diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.2106241339140.27231@Diego>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 01:44:43PM +0200, Michael Petlan wrote:
> On Wed, 23 Jun 2021, Namhyung Kim wrote:
> > Hi Jiri,
> > 
> > Thanks for your work!
> > 
> > On Tue, Jun 22, 2021 at 2:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Jun 22, 2021 at 03:14:04PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, Jun 22, 2021 at 10:47:54AM -0700, Ian Rogers escreveu:
> > > > > On Tue, Jun 22, 2021 at 10:39 AM Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> wrote:
> > > > > >
> > > > > > Em Tue, Jun 22, 2021 at 05:39:08PM +0200, Jiri Olsa escreveu:
> > > > > > > hi,
> > > > > > > this *RFC* patchset adds support to detect faults during
> > > > > > > mmap2's build id parsing and a way to fix such maps in
> > > > > > > generated perf.data.
> > > > > > >
> > > > > > > It adds support to record build id faults count for session
> > > > > > > and store it in perf.data and perf inject support to find
> > > > > > > these maps and reads build ids for them in user space.
> > > > > >
> > > > > > > It's probably best explained by the workflow:
> > > > > > >
> > > > > > >   Record data with --buildid-mmap option:
> > > > > > >
> > > > > > >     # perf record --buildid-mmap ...
> > > > > > >     ...
> > > > > > >     [ perf record: Woken up 1 times to write data ]
> > > > > > >     [ perf record: Failed to parse 4 build ids]
> > > > > > >     [ perf record: Captured and wrote 0.008 MB perf.data ]
> > > > > > >
> > > > > > >   Check if there's any build id fault reported:
> > > > > > >
> > > > > > >     # perf report --header-only
> > > > > > >     ...
> > > > > > >     # build id mmap stats: FAULTS 4, LOST 0, NOT FIXED
> > > > > > >
> > > > > > >   There is, check the stats:
> > > > > > >
> > > > > > >     # perf report --stat
> > > > > > >
> > > > > > >     Aggregated stats:
> > > > > > >              TOTAL events:        104
> > > > > > >                       ....
> > > > > > >            BUILD_ID fails:          4  (14.3%)
> > > > > > >
> > > > > > >   Yep, let's fix it:
> > > > > > >
> > > > > > >     # perf inject --buildid-mmap2 -i perf.data -o perf-fixed.data
> > > > > >
> > > > > > Can we make it possible to automate this with --fixup-buildids or a
> > > > > > perfconfig 'record' knob?
> > > > > >
> > > > > > This would entail requesting that build-ids that _fail_ be sent to the
> > > > > > side-band thread we have in 'perf record', this way we wouldn't have to
> > > > > > traverse the whole perf.data file, be it with 'perf-record' at the end
> > > > > > of a session with faulty build ids, or in a similar fashion using 'perf
> > > > > > inject' as you suggest.
> > > > > >
> > > > > > I even think that we can have all these modes and let the user to decide
> > > > > > how important is this for them and how convenient they want the whole
> > > > > > process to be.
> > >
> > > right, that might be good to decide first.. because as I said,
> > > I never hit faulted build id, so it probably needs the special
> > > setup you guys are using.. could you try on your setup and check
> > > how many faulted build ids you see?
> > 
> > Did you check data mmaps?  It might be easy to get faults
> > from data files and we don't know if it's an ELF or not
> > before reading the ELF header in the first page.
> 
> Hi. Long ago, I have noticed samples pointing to purely data files,
> such as if the program execution was sampled just in the middle of
> them. However, these files couldn't certainly contain any executable
> code... It was quite hard to reproduce this.
> 
> Maybe what Namhyung says might have been a culprit for it? Just an
> idea...

yea, that sounds bad.. I guess you can no longer reproduce?

thanks,
jirka

