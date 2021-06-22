Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DEA3B0F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 23:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFVVVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 17:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229625AbhFVVVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 17:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624396762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XlNdNVJJaT0poBG4McRO9fS++ltdFMf7gkDA4rZ1bU4=;
        b=Q8mxc4WjZmPJeQWfI7mU0LwU/cqP8cdOe0HoXA78VUELq3VbfBXFl3uVbJT182Q/1YKvkl
        1EhMTYFkYVd4eKBW9UP0qkKldRy/eZ4Z3RN6R/2svNmvgbz9CjDk2vMvN6noy+3SrecwdQ
        TnnIf1StMAUdD8CdJopqcRfCW4qs0Kw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-wMFrQ2iUMmOTDTsASuVWig-1; Tue, 22 Jun 2021 17:19:21 -0400
X-MC-Unique: wMFrQ2iUMmOTDTsASuVWig-1
Received: by mail-wr1-f71.google.com with SMTP id j2-20020a5d61820000b029011a6a8149b5so73894wru.14
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 14:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XlNdNVJJaT0poBG4McRO9fS++ltdFMf7gkDA4rZ1bU4=;
        b=GMsU5x8UscQHR24qeoyH8dTJeRgpmLFXbzx5nDKvEptZikeRd+MA0wO0ydFIXwOkIO
         jPj8JU7yFQY2IUVJTpKHTbWaX2pw9IeiRzNSqHRa5+/yjyuVqsK7BZ9fjXIKWaSDH9Zy
         pIXJzSArSrPNV6goaggA2tCath0M87sCK7Z3MlOojP0YE6T/oD5cxEOZ1VgMsWAzLTp4
         LsgCXxSt5rMOTBJ0quKKvXyl7m2k+vW7c9qNFyhYbhTnqA8IaldlkOH8SEs1/Rkb6+zS
         E1v1eSJq3UrMglbYu5Cyl8EU2U8iH8QuTTBJvFHst453ACXm3ekh0NMcLRtHlEpcG0Fa
         AVdg==
X-Gm-Message-State: AOAM5300B3b13tEGu7IL53hEQQxsHqyWOPR0vHHxXPz10s3zTxpZFZOn
        AILZkEiT84iVgcTWtPmhYaawfykVgRYltVAwkcae5wChyQPlDETOufeWwuMyoOXK2vl5wf9xA2a
        lsasZcpXmVTVefGfGI7aXZCGQ
X-Received: by 2002:a05:600c:281:: with SMTP id 1mr6434999wmk.171.1624396760252;
        Tue, 22 Jun 2021 14:19:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZyzclexen16GRRF11rovrucoRycvcRVV+FhsLCBCyKB+osnN/XZpx0U6YPpsWaTQRrt3XSg==
X-Received: by 2002:a05:600c:281:: with SMTP id 1mr6434991wmk.171.1624396760055;
        Tue, 22 Jun 2021 14:19:20 -0700 (PDT)
Received: from krava ([5.171.245.189])
        by smtp.gmail.com with ESMTPSA id g17sm680337wrh.72.2021.06.22.14.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 14:19:19 -0700 (PDT)
Date:   Tue, 22 Jun 2021 23:19:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>, rickyman7@gmail.com
Subject: Re: [RFC 00/10] perf: Add build id parsing fault detection/fix
Message-ID: <YNJT0wvghSZzPJ8Y@krava>
References: <20210622153918.688500-1-jolsa@kernel.org>
 <YNIgXkH1xaF7H3Tr@kernel.org>
 <CAP-5=fU=AAJ0_s1orsF=OCO0=bSmr9BhAmtN251bU_pf0ZFJ6Q@mail.gmail.com>
 <YNIobHgfVbiiNscn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNIobHgfVbiiNscn@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 03:14:04PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 22, 2021 at 10:47:54AM -0700, Ian Rogers escreveu:
> > On Tue, Jun 22, 2021 at 10:39 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Tue, Jun 22, 2021 at 05:39:08PM +0200, Jiri Olsa escreveu:
> > > > hi,
> > > > this *RFC* patchset adds support to detect faults during
> > > > mmap2's build id parsing and a way to fix such maps in
> > > > generated perf.data.
> > > >
> > > > It adds support to record build id faults count for session
> > > > and store it in perf.data and perf inject support to find
> > > > these maps and reads build ids for them in user space.
> > >
> > > > It's probably best explained by the workflow:
> > > >
> > > >   Record data with --buildid-mmap option:
> > > >
> > > >     # perf record --buildid-mmap ...
> > > >     ...
> > > >     [ perf record: Woken up 1 times to write data ]
> > > >     [ perf record: Failed to parse 4 build ids]
> > > >     [ perf record: Captured and wrote 0.008 MB perf.data ]
> > > >
> > > >   Check if there's any build id fault reported:
> > > >
> > > >     # perf report --header-only
> > > >     ...
> > > >     # build id mmap stats: FAULTS 4, LOST 0, NOT FIXED
> > > >
> > > >   There is, check the stats:
> > > >
> > > >     # perf report --stat
> > > >
> > > >     Aggregated stats:
> > > >              TOTAL events:        104
> > > >                       ....
> > > >            BUILD_ID fails:          4  (14.3%)
> > > >
> > > >   Yep, let's fix it:
> > > >
> > > >     # perf inject --buildid-mmap2 -i perf.data -o perf-fixed.data
> > >
> > > Can we make it possible to automate this with --fixup-buildids or a
> > > perfconfig 'record' knob?
> > >
> > > This would entail requesting that build-ids that _fail_ be sent to the
> > > side-band thread we have in 'perf record', this way we wouldn't have to
> > > traverse the whole perf.data file, be it with 'perf-record' at the end
> > > of a session with faulty build ids, or in a similar fashion using 'perf
> > > inject' as you suggest.
> > >
> > > I even think that we can have all these modes and let the user to decide
> > > how important is this for them and how convenient they want the whole
> > > process to be.

right, that might be good to decide first.. because as I said,
I never hit faulted build id, so it probably needs the special
setup you guys are using.. could you try on your setup and check
how many faulted build ids you see?

thanks,
jirka

