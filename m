Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A78341507F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbhIVTgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:36:03 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:37726 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbhIVTgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:36:02 -0400
Received: by mail-lf1-f53.google.com with SMTP id i4so16269636lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Vnkrcw4DR2JdIAuglIphbFW5KXKuuI/s8yEeAhjVjE=;
        b=BatiLWrhX5hWvh9w0Kx+RnN0M74cPJ+DkoqVAQrttYYBkuA3Hx68momTXIpXphRYCh
         qKWDcI3JQTUsSl6h0O827zEtkGnCLWnjtgFkexVspApAUm+XVyPjDtS69iKjk2oWPpM/
         gC6VQI/aMALo5mR/BVS6asK7ML3sSpzrWAH/FHbz01/2djVjJIbGjSfUbItvNp+YokIY
         5Xu3BjAtUl05NhNJEtetWljNSsQHPcDKZ4h8j6enrJk5eN4p9LN5GLErr9hi+7OTcToz
         1BGiBQCUmQk+5oRvVnAYoieCK9/REmcXpV+zy5JuUGbLr8YV59Ur3TNNmsSfR3Hp07wL
         f0pg==
X-Gm-Message-State: AOAM532PmC4tXyMDJ5hkrndRDaM0JMpuLF5s82xnDBWlr+IrlByFsiQG
        QR5ZEtm9AHtSZpETYkY5IVP719mt7NJLGIjZ+BgKWY7f
X-Google-Smtp-Source: ABdhPJwKEAxF1wD1uwICkEz5isiffF5KrNIHWcoWcC4H6gOoFM5+pECQVFRb9lzMIk072bT+lpIxAzu83Mh5VTlD1Fg=
X-Received: by 2002:a05:6512:128f:: with SMTP id u15mr650392lfs.528.1632339271292;
 Wed, 22 Sep 2021 12:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210908172420.879240-1-namhyung@kernel.org> <YTvRNj09IwVfyZr1@krava>
 <CAM9d7cjjjV0uNCNLohFMFizRxvu2vwJBgE-Cge1Y6F3jDuPLNg@mail.gmail.com>
In-Reply-To: <CAM9d7cjjjV0uNCNLohFMFizRxvu2vwJBgE-Cge1Y6F3jDuPLNg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Sep 2021 12:34:20 -0700
Message-ID: <CAM9d7cg_=EFQNVvEWsmNiQ_jjjiRSXjc=uH=4uQzuVbVNzuLDw@mail.gmail.com>
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

Hi Peter,

On Fri, Sep 10, 2021 at 3:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, Sep 10, 2021 at 2:42 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Sep 08, 2021 at 10:24:20AM -0700, Namhyung Kim wrote:
> > > Sometimes we want to know an accurate number of samples even if it's
> > > lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
> > > might be shared with other events.  So it's hard to know per-event
> > > lost count.
> > >
> > > Add event->lost_samples field and PERF_FORMAT_LOST to retrieve it from
> > > userspace.
> >
> > hi,
> > looks good.. will there be some tools/perf change using this?
>
> Sure, I'll work on the userspace part after this is merged.
> I'm thinking about adding LOST_SAMPLES records at the end
> of the data section as if they came from the kernel.

Can I get your feedback?

Thanks,
Namhyung
