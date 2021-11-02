Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06FB44395B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhKBXLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:11:30 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:37756 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhKBXL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:11:28 -0400
Received: by mail-lj1-f169.google.com with SMTP id y8so763453ljm.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 16:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=axqqCgDc0zLKZYFe0E+oIe0KfNTY1wneESMS3LuNr28=;
        b=SkDFX1yzm1kEqoruu8qg5/VbwGv8lUuagrJo0KpdZCSGBKuzHkX4YGA4iHyS7vHgXm
         c5/MJ/ozQvxcCgH+F0c/0RXYkWP7XhuyHyLXnzibkvRj39Pw7WuTNtBFc6t+7DKfX0Ch
         jjIomFugVn1kaO0XidwDnk4V8APIn80pZwzweC8wXmUAIjXRURCgy8p0xXIOsOC523tv
         2aHzfhAshlCu8zR3eW0qAbKBEEWaxolZ5gLcwwOx5P8v8wBUcMSCS7aTJR0QH47SC8Ie
         tPEgAShvzWWuNzrae53tZcCLIXmVU7PfbF0KelDIzOkZjmKhWMl0OrLk7++QSmLXkCz0
         nMNQ==
X-Gm-Message-State: AOAM530BcXANCz5UBtDcrx8CQl4oQHFPAqVnUI22s13XMRv9aBvKzTYM
        ko0nyHbqois1aePKrluosdDrAkfc6TqXx8j34J0=
X-Google-Smtp-Source: ABdhPJxiwwaln10jm5kSeCsCVViU1WjBqYUYkApLGzf0w7/3uFSdRjhpfOxeAz2R36kDB7Rmmof9qRMS2bvMj/L7EEc=
X-Received: by 2002:a05:651c:515:: with SMTP id o21mr9050371ljp.90.1635894532179;
 Tue, 02 Nov 2021 16:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211029224929.379505-1-namhyung@kernel.org> <YYBXeVFPfm1ZWgBG@kernel.org>
In-Reply-To: <YYBXeVFPfm1ZWgBG@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 2 Nov 2021 16:08:40 -0700
Message-ID: <CAM9d7ch4Qj3oX1ocWenxiO2xN8UtQP3EGhUGimyntc8Spc+0Tg@mail.gmail.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, Nov 1, 2021 at 2:09 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Oct 29, 2021 at 03:49:29PM -0700, Namhyung Kim escreveu:
> > @@ -1900,10 +1935,17 @@ bool evsel__detect_missing_features(struct evsel *evsel)
> >               perf_missing_features.mmap2 = true;
> >               pr_debug2_peo("switching off mmap2\n");
> >               return true;
> > -     } else if (!perf_missing_features.exclude_guest &&
> > -                (evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host)) {
> > -             perf_missing_features.exclude_guest = true;
> > -             pr_debug2_peo("switching off exclude_guest, exclude_host\n");
> > +     } else if ((evsel->core.attr.exclude_guest || evsel->core.attr.exclude_host) &&
> > +                perf_missing_features.pmu != NULL &&
> > +                !hashmap__find(perf_missing_features.pmu, evsel, NULL)) {
> > +             uintptr_t pmu_features = PERF_MISSING_PMU_EXCLUDE_GUEST;
> > +
> > +             hashmap__add(perf_missing_features.pmu, evsel, (void *)pmu_features);
>
> Can't hashmap__add() fail?

It can.  I will add a check.

Thanks,
Namhyung
