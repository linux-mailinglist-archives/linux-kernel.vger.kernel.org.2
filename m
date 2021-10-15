Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24BB42E8FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhJOGbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:31:20 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:34405 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhJOGbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:31:19 -0400
Received: by mail-lf1-f51.google.com with SMTP id t9so36600152lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 23:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSexlnSfHHqSZ1JMsDFapEU6NoUx9lAdrel84RuUOqM=;
        b=MKAMkTXE52FBwUZsS0OzWJ9SzQ3Y2Pkw+lLMiSke6EV1YZqxe+pkTtmHzRrZX6eJJj
         eClY+pMb7ZTud0fBtTuBxTdNMy7Jjsv1isWZvOsaBDzE/MsqecbaikSw9nYeukXZ9Xr9
         uZ2DYDXKMPkCJ3yXrhMmLoYnE0S2RcGkGN1RzLQm0Rnl+ZYTM4/SvqrJF6dveI6iNk7e
         pbYDJyjgw78hR9Zhyl+nRWiRl2NFPcHKZiRyEpfrkF7WTUcqNwSwaHDgY+BlcDFB79K5
         0JzfTLtesFg17HDKaKj/ldOsTJukVoCmcCDx1/J0/OJ3fwFdMTEOyAb+eq8Uvtp98vJd
         Sd3A==
X-Gm-Message-State: AOAM533Nnu+MJfnig73NLlvTENv9unioVSr0zuC/UQQNo3yDYfz4tLHe
        7ACNB/Ui0e6w/vtRpFn4TVP3z+lKKeVB8lESojYuXVbi
X-Google-Smtp-Source: ABdhPJz72cBsZnGYGPvk1ocWFo/8K1qJ8rhfdKfjtJy3BRrp2epXhkOksBd5opSWxA2tlaaM7mHiIm/uNJiuJBbD4To=
X-Received: by 2002:a05:6512:68b:: with SMTP id t11mr1889368lfe.586.1634279352587;
 Thu, 14 Oct 2021 23:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210908172420.879240-1-namhyung@kernel.org> <YTvRNj09IwVfyZr1@krava>
 <CAM9d7cjjjV0uNCNLohFMFizRxvu2vwJBgE-Cge1Y6F3jDuPLNg@mail.gmail.com> <CAM9d7cg_=EFQNVvEWsmNiQ_jjjiRSXjc=uH=4uQzuVbVNzuLDw@mail.gmail.com>
In-Reply-To: <CAM9d7cg_=EFQNVvEWsmNiQ_jjjiRSXjc=uH=4uQzuVbVNzuLDw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 14 Oct 2021 23:29:01 -0700
Message-ID: <CAM9d7cj5z=OqAB1jr14XJvrmAyWjJPEx9LXdmyUR3zFPR_pc3g@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Add a new read format to get a number of
 lost samples
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping!

On Wed, Sep 22, 2021 at 12:34 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Peter,
>
> On Fri, Sep 10, 2021 at 3:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Sep 10, 2021 at 2:42 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Wed, Sep 08, 2021 at 10:24:20AM -0700, Namhyung Kim wrote:
> > > > Sometimes we want to know an accurate number of samples even if it's
> > > > lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
> > > > might be shared with other events.  So it's hard to know per-event
> > > > lost count.
> > > >
> > > > Add event->lost_samples field and PERF_FORMAT_LOST to retrieve it from
> > > > userspace.
> > >
> > > hi,
> > > looks good.. will there be some tools/perf change using this?
> >
> > Sure, I'll work on the userspace part after this is merged.
> > I'm thinking about adding LOST_SAMPLES records at the end
> > of the data section as if they came from the kernel.
>
> Can I get your feedback?
>
> Thanks,
> Namhyung
