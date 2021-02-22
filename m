Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D7E321363
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBVJrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:47:32 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:41651 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhBVJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:47:21 -0500
Received: by mail-lj1-f173.google.com with SMTP id e17so56111133ljl.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4IhNxvaEzerjfy9TDwo9/XQFb4xj9POVW73cIDqBPXE=;
        b=YKT0MOsGktSLFBBcL0dWhf6JU9x3WdG+ReSjIdHFdi+sKDPUzK8CpkIZHBNkbC5TTn
         yLCK1/8ivadAsRK6vrH6C4XES+q4o4LA63zUOKsewFN3lFssHzpD/YS49vTSXqO1KCCI
         p+gNbUhZ8dZTUQLy1ECJoyNR6lm9fI1eIBm7rjacsV6i6TplIH3PTo/OoxVaXOEe2WWH
         cjcVqfW1QOCx2B4+fAHqeN7NYFEHzvNSqF6EO+uIDeJS4/8AKZwBSN5AwxUugAW39Mwv
         3Dep4VwO/n7eHfWHdOLb/SSQwhdyoR/IXfmDx/wjIgN777zQajsqEelTDkSB4j21pVb9
         yPXw==
X-Gm-Message-State: AOAM530BFRFGPv62RCtbFtUBwUPwMSkKEshoSfilHNBVQNgZuxN3WYGa
        kRNMF1enXJ4TMxZZIhUY6P6eWciHAXaNtukrrsU=
X-Google-Smtp-Source: ABdhPJyVt0cliP/Ol1/vMZiZv/yLAjQZTNc7QhNFxHnphtJD+O5mMlIUKDb/uyX+uSYWYpCJ6gEZ97s139asX0wOj5Q=
X-Received: by 2002:a05:651c:2042:: with SMTP id t2mr13146997ljo.233.1613987199129;
 Mon, 22 Feb 2021 01:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
 <20201130193842.10569-3-kan.liang@linux.intel.com> <20201201172903.GT3040@hirez.programming.kicks-ass.net>
 <CAM9d7ciukm4RAH+44YWhZRummKzk1HTbnZ0Sc4Xd5ZyCo=x0xQ@mail.gmail.com>
 <CAM9d7ciBO=cmgnBVJWpyJ75VHjoxuEA=ck=V1+k8KRBkh23+nw@mail.gmail.com>
 <c868c6f7-c89f-ecc5-b771-2701b6029788@linux.intel.com> <20201210142515.GR2414@hirez.programming.kicks-ass.net>
 <CAM9d7chme3WFQzsqHeQx+1vaLpCG7qL=D6QO4+_Vnt=byzC5sQ@mail.gmail.com> <CAM9d7chAvc5cfNsJZnJ2bwuNMp4L929it++riuNHw6VsGpHDuA@mail.gmail.com>
In-Reply-To: <CAM9d7chAvc5cfNsJZnJ2bwuNMp4L929it++riuNHw6VsGpHDuA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 22 Feb 2021 18:46:27 +0900
Message-ID: <CAM9d7ciACrxqgWv0A-gxGpqmBFOkqrn8wPhVUUhm8bh2SPk8Lg@mail.gmail.com>
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

On Wed, Jan 27, 2021 at 1:41 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi,
>
> On Mon, Jan 18, 2021 at 4:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Peter and Kan,
> >
> > On Thu, Dec 10, 2020 at 11:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Dec 10, 2020 at 08:52:55AM -0500, Liang, Kan wrote:
> > > >
> > > >
> > > > On 12/10/2020 2:13 AM, Namhyung Kim wrote:
> > > > > Hi Peter and Kan,
> > > > >
> > > > > How can we move this forward?
> > > >
> > > > Hi Namhyung,
> > > >
> > > > Thanks for the test. The changes look good to me.
> > > >
> > > > Hi Peter,
> > > >
> > > > Should we resend the patch set for further review?
> > >
> > > I've not yet seen a coherent replacement of #3, what I send was just a
> > > PoC.
>
> If it's the only problem of #3 which is an optimization,
> can we merge the actual fixes in #1 and #2 first?
>
> I know some people waiting for the fix..

Ping again...

Thanks,
Namhyung
