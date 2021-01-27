Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB07E3051C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhA0FNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:13:41 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:39426 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhA0Emj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:42:39 -0500
Received: by mail-qk1-f182.google.com with SMTP id k193so658412qke.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5j9D+/U9aAgrXd3LWzWk4nGfTmqsxamWFm+S2CE5wNw=;
        b=S4VEJvImd2DF1vCsYDFNmGs078dFFM+UXHz/wX4KS8EGbJXY82WVe4cxEQyQ3WhWHg
         c8YhxwGq2SXuqiuzRnZBUyYPBL09HxrG3JjZs35E3hYFiKxhjkcutxFLV6MwSEJ+rq33
         uqTcwHCrZQxVsQUU+jgc30Gooi5Evrde7TOrnBGPIt5SD6ut0lGqeCmp/Qdne07OuA2o
         UCIfYAHncz8RmNXIMNxGFgic2oPs/jPA/jsw9FbScgGc+zrcuDo5KqNQuM6bDxe0weUO
         v2kirwCnbmOrqlpSzR+5DKmITq2I3qwJa5ALfio7IDEiO+EGXBTeWIStKzQ+LA33d1nR
         Y9TA==
X-Gm-Message-State: AOAM531/XU8eEXH1RpyAUj6ccLZYouYqeBdFmuAvx1MihHelsfETaGK7
        KQZYu8HeOjf3KxCc/p5NZXgRo9lYaKVIx0ewZmQ=
X-Google-Smtp-Source: ABdhPJwQ5mO0DuujWVQtwb32GXf7sZ1yeghiy+eSoGkdzlWbMjPKIk8kakXjd2yUZsNPBQ4WuZE7h9uJrYbWcbAPAfY=
X-Received: by 2002:a37:aec5:: with SMTP id x188mr9191438qke.144.1611722516279;
 Tue, 26 Jan 2021 20:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
 <20201130193842.10569-3-kan.liang@linux.intel.com> <20201201172903.GT3040@hirez.programming.kicks-ass.net>
 <CAM9d7ciukm4RAH+44YWhZRummKzk1HTbnZ0Sc4Xd5ZyCo=x0xQ@mail.gmail.com>
 <CAM9d7ciBO=cmgnBVJWpyJ75VHjoxuEA=ck=V1+k8KRBkh23+nw@mail.gmail.com>
 <c868c6f7-c89f-ecc5-b771-2701b6029788@linux.intel.com> <20201210142515.GR2414@hirez.programming.kicks-ass.net>
 <CAM9d7chme3WFQzsqHeQx+1vaLpCG7qL=D6QO4+_Vnt=byzC5sQ@mail.gmail.com>
In-Reply-To: <CAM9d7chme3WFQzsqHeQx+1vaLpCG7qL=D6QO4+_Vnt=byzC5sQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Jan 2021 13:41:44 +0900
Message-ID: <CAM9d7chAvc5cfNsJZnJ2bwuNMp4L929it++riuNHw6VsGpHDuA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] perf: Optimize sched_task() in a context switch
To:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Gabriel Marin <gmx@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 18, 2021 at 4:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Peter and Kan,
>
> On Thu, Dec 10, 2020 at 11:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Dec 10, 2020 at 08:52:55AM -0500, Liang, Kan wrote:
> > >
> > >
> > > On 12/10/2020 2:13 AM, Namhyung Kim wrote:
> > > > Hi Peter and Kan,
> > > >
> > > > How can we move this forward?
> > >
> > > Hi Namhyung,
> > >
> > > Thanks for the test. The changes look good to me.
> > >
> > > Hi Peter,
> > >
> > > Should we resend the patch set for further review?
> >
> > I've not yet seen a coherent replacement of #3, what I send was just a
> > PoC.

If it's the only problem of #3 which is an optimization,
can we merge the actual fixes in #1 and #2 first?

I know some people waiting for the fix..

Thanks,
Namhyung
