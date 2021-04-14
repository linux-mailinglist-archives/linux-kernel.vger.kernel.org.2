Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2D935FA02
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhDNRpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:45:52 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:46811 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhDNRpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:45:51 -0400
Received: by mail-lf1-f53.google.com with SMTP id 12so34447109lfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzvRDyOuIyeck+tSs9EJfCB1Y5RstqTjR3ghvYaUV18=;
        b=d+2LNLbMvQKLLmPnAxAHA4xSjgnIM+neLuv1iZZy0h4Ju7HhMW4ZLoE4iwZH1SP5yl
         cuoBNyolvlYtCmucXKhuYNGFYWCUofgGO5ZFEMz4+pOrLgjtq5CHCigUAZBscnJKI78R
         Bop+Dwzc/lZcChufbNyKMUa+Mx1e44kd9OCK/WW+uAM0VC2g6MeF2Gac2y/LyMW8t1H2
         /WqGQvJyTHlyY4jUTu4HiToA3EQ5pMvCnInA0VTIc1Mz3IrB5SPBSy0lBIcbxU0tBQjV
         wEkuoTafTsescIqK49CjBGIAty/s3EWxnsp5QFXk2vG4GHkqFqziHsmT8K6vbKOqhfWM
         x6/A==
X-Gm-Message-State: AOAM531QsNV7zywXTUGkXoExC+ALK8Obd4TdxGdGVThvCX+IJ7+2puiP
        kj43PS6xFGeRVR0zjaOtVkp/sLm2UxgydDt+U+1Z+Ze1KUk=
X-Google-Smtp-Source: ABdhPJzXVvModV+yFNmSilmeg1EjEE7EXFak22D33E16xJemBxojSTaYDxzzemmyBb5A+EGkrchEgMzOp6NRh51PBrw=
X-Received: by 2002:a05:6512:3d8d:: with SMTP id k13mr14132604lfv.494.1618422328623;
 Wed, 14 Apr 2021 10:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210414155412.3697605-1-robh@kernel.org> <20210414155412.3697605-2-robh@kernel.org>
 <CAM9d7cibppJUQuqcxEO9gU-KcHJNsoMJQw=1+_Fw3oXXHEKUCA@mail.gmail.com> <CAL_JsqLEEeJjP1TmSLt=ruQUureSw1gk5sxP7RvMSm=jXAeOtw@mail.gmail.com>
In-Reply-To: <CAL_JsqLEEeJjP1TmSLt=ruQUureSw1gk5sxP7RvMSm=jXAeOtw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 15 Apr 2021 02:45:17 +0900
Message-ID: <CAM9d7ci2c97dcv9pn3tcZWgYtyipxG1ApFz-wPXOTxQyXfaxXA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] libperf: Add evsel mmap support
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 1:53 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Apr 14, 2021 at 11:41 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Thu, Apr 15, 2021 at 1:07 AM Rob Herring <robh@kernel.org> wrote:
> > > +void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
> > > +{
> > > +       if (FD(evsel, cpu, thread) < 0 || MMAP(evsel, cpu, thread) == NULL)
> > > +               return NULL;
> >
> > I think you should check the cpu and the thread is in
> > a valid range.  Currently xyarray__entry() simply accesses
> > the content without checking the boundaries.
>
> Happy to add a patch to do that if desired, but I think that's
> separate from this series. That would be something to add to
> xyarray__entry().

Sure, we can do that separately.

Thanks,
Namhyung
