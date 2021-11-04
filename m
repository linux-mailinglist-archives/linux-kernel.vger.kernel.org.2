Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F88445BBB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 22:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhKDVlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 17:41:31 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:38846 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhKDVla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 17:41:30 -0400
Received: by mail-lj1-f182.google.com with SMTP id v23so11786978ljk.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 14:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t33HpEEnk1etvqqIlmlIbAYJ4j6h+BHbpRH2GGqHboQ=;
        b=LKdQBFzsTeqe7e8rEYbE9xyQ7zF4P8Kzo5/Ws3tk/QeOC2qvaaMJ3sMMIqaIn2WNvh
         X4J4TsnUxm5QvW8/RVq8Qdqc5WGjgV8y5mnZAryePQsRqKAnPmIgLA8p6DH3f2YXGrtX
         ueFX8dis8MCGDwxQrkfjY6DZrMMZTaiYPSpft1C89eekojAIcnjETcc+1OsJ28z/KjK6
         HwivEm3CAa3niA8Io6v8S4CI51cdIpBVqtNZ8h22afWOkWFpXSzNNnW4d++WTMAkywNk
         Z5o0pzF5H9oDleIk7g+87079OKV8OhDlbgPGfkNQIFuUbBjWYeacFJgFgnehWHVXmhmr
         9Ueg==
X-Gm-Message-State: AOAM5311ObdTchQAh2GmPYVPi9DHTCDzydb6MnXwqIgZWfFjpzN31EJ/
        MJhtroUICo3ulOyr7Xl97akyhlRRHNoDB4TGMb0=
X-Google-Smtp-Source: ABdhPJw7gTmI3BLQvB9plj4miJz25+sxiRNJ2FKHPhRWYAxiYGMy1gNB0pgdZi0DIPPVNAxJ1sDiDiiUxlfCeNdb+MY=
X-Received: by 2002:a2e:8841:: with SMTP id z1mr55299282ljj.180.1636061930567;
 Thu, 04 Nov 2021 14:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211029224929.379505-1-namhyung@kernel.org> <YYFGxwFMvTRN5KBI@krava>
 <CAM9d7cjPq7=HoPAi3Cd3crcNJO8hWu0cU8j4qOTqSMxd7M6BqQ@mail.gmail.com>
 <YYI5EwCjBojR+1QW@krava> <CABPqkBSHo3Gznor1e8M_Ue0XO8Z-HZt326q8N9kLWz4+jKkt-w@mail.gmail.com>
 <YYJzPkcUz2pcuspX@kernel.org> <CABPqkBQkqehAvpfJk77WZpXezrVO6cAj=9ktKFgL=C_m84_Dgg@mail.gmail.com>
 <YYL5FaKQ1ZvGwd08@kernel.org> <CABPqkBTr10pcbY0v5mM23PKDWdWg3CNywH4HLSGfy4ab8d6+=g@mail.gmail.com>
 <YYQa8xeUuaRqyTDD@kernel.org>
In-Reply-To: <YYQa8xeUuaRqyTDD@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 4 Nov 2021 14:38:39 -0700
Message-ID: <CAM9d7chA3p4wPfurzbq_hFovv-GQVg6u-CyuBq7RBE5uL6Bp7Q@mail.gmail.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 10:40 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 03, 2021 at 03:29:50PM -0700, Stephane Eranian escreveu:
> > On Wed, Nov 3, 2021 at 2:03 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Wed, Nov 03, 2021 at 10:35:04AM -0700, Stephane Eranian escreveu:
> > > > On Wed, Nov 3, 2021 at 4:32 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > > Em Wed, Nov 03, 2021 at 12:44:12AM -0700, Stephane Eranian escreveu:
> > > > > > On Wed, Nov 3, 2021 at 12:24 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > > > > If the pmu doesn't support host/guest filtering, pmu/bla1/G
> > > > > > > > may count something.  Not sure if it's better to error out.
> > > > > > > > But the cycles:G and instructions:G should result in 0
> > > > > > > > in case there's no VM running.
>
> > > > > > > hm, I think if pmu doesn't support host/guest filtering then
> > > > > > > I think 'pmu/bla1/G' should error, no? better no number than
> > > > > > > bad number
>
> > > > > > Yes, it should in my opinion.
>
> > > > > Yeah, I thought about this yesterday (holiday here).
>
> > > > Otherwise you create the illusion that you are monitoring in guest
> > > > mode when you are not.
>
> > > > The question is: how can the tool know which modifiers are supported
> > > > per pmu model?
>
> > > As things stand kernel-wise, we should just do capability querying, i.e.
> > > if the user asks for a feature not available for a specific PMU, we
> > > should refuse and provide a helpful error message to the user.
>
> > > If the PMUs in the kernel had some kind of mask that stated what of the
> > > 'struct perf_event_attr' selectable features are supported, then we
> > > would just be able to avoid bothering the kernel asking for unsupported
> > > stuff.
>
> > I think we could add something like that in the sysfs entry for each
> > PMU instance.
> > that would avoid all these perf_event_open() calls and trying to
> > decipher the error
> > code.
>
> That would speed up these checks with newer kernels, yeah, with older
> kernels we'd fall back to what we have now + bailing out in the current
> case (PMUs not supporting exclude_guest).

Agreed.

>
> > > Just for exclude_guest we don't even need to have
> > > evsel->pmu->missing_features.exclude_guest, as this is a hard error, no
> > > point in caching previous capability queries.

But we set attr.exclude_guest by default so we should check
if the user set the modifier explicitly or not.

With the explicit G modifier, it should fail immediately.
If it's implicit, then we should remove it from the attr
and proceed.  So it's worth it to cache the result.

I think we don't need to fill evsel->pmu link unnecessarily.
I mean we can set it only if needed (for exclude_guest)
and keep a NULL pointer when it has no problem.

Thanks,
Namhyung
