Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CAF310970
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhBEKrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:47:14 -0500
Received: from mail-qv1-f54.google.com ([209.85.219.54]:40806 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhBEKoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:44:44 -0500
Received: by mail-qv1-f54.google.com with SMTP id u20so3181115qvx.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOGsFRkken9J2+ZbCvl0mBH8sLwFif//a+Scmq0+cME=;
        b=hO8VmuTVt++aWHpHYhwCIMZ7adbUgMSDu7i+c+1IA+NlRDGjJmLYwfgy4gX9saE3fY
         w/C6h4FBMa/H7/18aZX4NP4O3ZWHqT0VLBwhlXxIdjTiuZYpUyANpRXOEQXvTgxyf0PH
         MAKj/flikiZ3CgTbPEpgP3/ySX2Acnil3vfH5Bzmaq2nzPwxLKBLh9AVW+7t6HOaX2r7
         xl83Wm3yJRdqxH3ysCOFJulIGTOtJjp3ZEnpHHbqUYGM6OiQk/XP/TrFtFlAj3hA05Pn
         fgPo56svjW9fQI5CS0t4ofK1GLz1XW+tCVP8uR941lZjF/3AP01J+WnmPj5nVu/M0D6Q
         BkQA==
X-Gm-Message-State: AOAM532ii5csU4mIl4jJzbGkci1GdWpl/KmItvec3VTSOEymx6SCT0Gp
        MyDgzrTpbtmBRxsi49voGmgZyvm2I5H55ffu73Q=
X-Google-Smtp-Source: ABdhPJyGmWlQWYHvSHhgswwTQH0YdPedWBW/AmnV7okkAb7dMqXbUZIe0dsZSISgUfyYqoA0zyg5c+SVLcc7oSAC52U=
X-Received: by 2002:a05:6214:21a5:: with SMTP id t5mr3490469qvc.20.1612521843402;
 Fri, 05 Feb 2021 02:44:03 -0800 (PST)
MIME-Version: 1.0
References: <1611873611-156687-1-git-send-email-kan.liang@linux.intel.com>
 <1611873611-156687-2-git-send-email-kan.liang@linux.intel.com>
 <b970c739-6783-34d6-8676-44632c7c9428@linux.intel.com> <CAM9d7chzwnmSeKydv0Fb_iopcuMZxRsx2mZ66uVwcu_RMw+Vyg@mail.gmail.com>
 <4723a1de-9caa-e192-7b0d-8aced00b8f50@linux.intel.com>
In-Reply-To: <4723a1de-9caa-e192-7b0d-8aced00b8f50@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 5 Feb 2021 19:43:51 +0900
Message-ID: <CAM9d7ciaCgebmGd98GrngY-he6LGwKeFKJeCqyTBnJ30-tSghQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/5] perf/core: Add PERF_SAMPLE_WEIGHT_STRUCT
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>, maddy@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 12:24 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
> On 2/4/2021 9:00 AM, Namhyung Kim wrote:
> > Hi Kan,
> >
> > On Sat, Jan 30, 2021 at 2:25 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > [SNIP]
> >> diff --git a/include/uapi/linux/perf_event.h
> >> b/include/uapi/linux/perf_event.h
> >> index b15e344..c50718a 100644
> >> --- a/include/uapi/linux/perf_event.h
> >> +++ b/include/uapi/linux/perf_event.h
> >> @@ -145,12 +145,14 @@ enum perf_event_sample_format {
> >>          PERF_SAMPLE_CGROUP                      = 1U << 21,
> >>          PERF_SAMPLE_DATA_PAGE_SIZE              = 1U << 22,
> >>          PERF_SAMPLE_CODE_PAGE_SIZE              = 1U << 23,
> >> +       PERF_SAMPLE_WEIGHT_STRUCT               = 1U << 24,
> >>
> >> -       PERF_SAMPLE_MAX = 1U << 24,             /* non-ABI */
> >> +       PERF_SAMPLE_MAX = 1U << 25,             /* non-ABI */
> >>
> >>          __PERF_SAMPLE_CALLCHAIN_EARLY           = 1ULL << 63, /* non-ABI; internal use */
> >>    };
> >>
> >> +#define PERF_SAMPLE_WEIGHT_TYPE        (PERF_SAMPLE_WEIGHT |
> >> PERF_SAMPLE_WEIGHT_STRUCT)
> >
> > I'm not sure you want to expose it in the uapi header as it's not
> > intended to be used IMHO.
> >
>
> I'm not sure I understood, but it's indeed used in the tool patch set.
>
> https://lore.kernel.org/lkml/1612296553-21962-6-git-send-email-kan.liang@linux.intel.com/

Well, it's not a big deal.. but I just worried if some users might do

  event.attr.sample_type = PERF_SAMPLE_WEIGHT_TYPE;

Thanks,
Namhyung
