Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222343AA16A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFPQgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:36:51 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:34713 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFPQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:36:00 -0400
Received: by mail-lf1-f42.google.com with SMTP id f30so5365470lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bk7gyyJ971of6oKSmwZ2gnQxPtz67qnueVXzAGbW/QQ=;
        b=osOksEM3EOrdFhMRZslmjnkAH3hKqweOyvMw7BUzWMjbjtvHbtWTCM+7+Q9lv7muPP
         wBTQc+UZOrLPMxvIjwPy+fQP2scVuPRJ8lc1ae0vJLIudIG5NPvOd7UDZcBRecApUyPD
         HKRR3bckyNUOOgxSw8wSBsdkdfAdpOIBv7KU98MKXf706djxNrcXI3QVLXsuCMjCpTKF
         BoMeUGUcwxNt39TWYKJliM668HLKx/1ZU81/bTonoUFdDOYteqUF/J0PdHsQ9R4iDspG
         6yNbt021y/UJ6JtpzdaiLAs2YQtHm4bUSjb20pliKp5tG0S/5MmnD5Rqkjk/jsuhCYXz
         +Kyg==
X-Gm-Message-State: AOAM5337haXQnAb9ldyRwQeczd3ymhcXIrnwHtmLglzEFCWrSBqdxhrt
        z5ApjFKb34ww6GiznjDltFtuSfiLKEyuQYak/XU=
X-Google-Smtp-Source: ABdhPJztxXqzh1q/P/s19USQJMvSUSqMoPAaDfGOR/ZFJBLUB1fowqG75/B/XHLd9W7kFPWuSJv9JKm+FdL7fbBFQo8=
X-Received: by 2002:a05:6512:20ce:: with SMTP id u14mr408701lfr.300.1623861233152;
 Wed, 16 Jun 2021 09:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210615011724.672612-1-namhyung@kernel.org> <YMoVOp4+TIUViBb7@hirez.programming.kicks-ass.net>
In-Reply-To: <YMoVOp4+TIUViBb7@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 16 Jun 2021 09:33:42 -0700
Message-ID: <CAM9d7cj2UhQsd2vx8_C8C_CEW2QQbzs741jCn7f7g-e0i9OiOg@mail.gmail.com>
Subject: Re: [PATCHSET v2 0/3] perf stat: Enable BPF counters with --for-each-cgroup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, Jun 16, 2021 at 8:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jun 14, 2021 at 06:17:21PM -0700, Namhyung Kim wrote:
> > Current limitations are:
> >  * it doesn't support cgroup hierarchy
>
> That seems unfortunate; there's no bpf helper to iterate cgroup
> hierarchy?

I couldn't find one..

>
> >  * there's no reliable way to trigger running the BPF program
>
> You can't attach to the PERF_COUNT_SW_CGROUP_SWITCHES event?

I did it.  But the BPF test run seems not to work with perf_event.
So it needs to trigger a cgroup switch manually..

Thanks,
Namhyung
