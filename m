Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6C4407376
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 00:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhIJWmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 18:42:13 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:44602 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhIJWmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 18:42:12 -0400
Received: by mail-lf1-f50.google.com with SMTP id s10so7028498lfr.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tybn1JJZvA+Ce9/R67eZt0UWxuTntQ8ckWZHQerPDP4=;
        b=hqu5anktT3jag6yvQFgES+zhc0M5gUTv45AaZKoO7t/sPl3tO8ZiadhuLN3vs/4NYh
         io0kwx+n2KP9Rmk1dgE+Kd9deDJymBdxiNc1kD7hM7ixG4Pl/TtM3I4CmCX538O4D3iT
         iyEpyQ3/jCaf6pvdokxeHQCW42NCGSYrqsywrkiNwGLxzPukeDaboifoNb5Iu8Xsbe3d
         dlBfTxUHztKUFrsknHD81O89+yyaWpvUe8EiodR0NxapOBR+XptFUuDeb+K4n89odUSy
         +X86PSrj3gh9Yf05+BRRfmHmnHZN+H1h34X7lNmfHNcNtXJXgqpyxbjRm0YEwBJTRI5V
         d2Ig==
X-Gm-Message-State: AOAM531UixfdF/ytSaZ9MYJ4akMQQPWDKZKJvS9Aev/RNWbvMMZVQUAT
        D2+PDhi9guNTormAyytNKVhMwoeJ77RbEGu2Hh5ad0iu
X-Google-Smtp-Source: ABdhPJw19pmVBGo3jgdwr6zP0n1P7A64zYt/uP5w+hVttkiR3QSSpDlLU4HHlzqVSgY13tAXlUlT9l5ims0SshfppBM=
X-Received: by 2002:a05:6512:1528:: with SMTP id bq40mr5562866lfb.71.1631313659550;
 Fri, 10 Sep 2021 15:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210908172420.879240-1-namhyung@kernel.org> <YTvRNj09IwVfyZr1@krava>
In-Reply-To: <YTvRNj09IwVfyZr1@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 10 Sep 2021 15:40:48 -0700
Message-ID: <CAM9d7cjjjV0uNCNLohFMFizRxvu2vwJBgE-Cge1Y6F3jDuPLNg@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Add a new read format to get a number of
 lost samples
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 2:42 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 08, 2021 at 10:24:20AM -0700, Namhyung Kim wrote:
> > Sometimes we want to know an accurate number of samples even if it's
> > lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
> > might be shared with other events.  So it's hard to know per-event
> > lost count.
> >
> > Add event->lost_samples field and PERF_FORMAT_LOST to retrieve it from
> > userspace.
>
> hi,
> looks good.. will there be some tools/perf change using this?

Sure, I'll work on the userspace part after this is merged.
I'm thinking about adding LOST_SAMPLES records at the end
of the data section as if they came from the kernel.

Thanks,
Namhyung
