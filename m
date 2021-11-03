Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E07444744
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhKCRhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhKCRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:37:52 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E586C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 10:35:16 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s14so3341349ilv.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnyetX0QyZqi2Iq5USlzrtlzkMWEd3Rn8ntmHLRK+94=;
        b=FK7PXiKwlAEuydEpz5g67Hb5FwusaOXT6NGyZ5VSKuxVPEDcZJuvfBm4ZtrDigrG3l
         2IncnecNqtTW/QJXzMCih23eLPLCajo/iI+8qCZU4YBJX2rOU/+XHhTL8mDyJCOGmNiW
         6dlHbgy7vwb8Xsb51cbtxu2iL02CN9CtqxmPYmaxbWhwFcwBr/364d2k+yg8jKLmeYym
         mpqck1V2pOyArZZf66VC8TQlcMKCq9FRYQKo/unDf7HMO0fKMPqpwHw1xN0r0+hyF9U8
         2cVjZpbDqmtWSk/bIya6v97RIr+hCHsxD883tN0FVNF05Y0RzNtA4sNgaAOE9qV08xUR
         rnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnyetX0QyZqi2Iq5USlzrtlzkMWEd3Rn8ntmHLRK+94=;
        b=IV6EMt51jU6nfH0Z/OY5uOMqHiOJ3MPbsZoNvMSC13Kj6NOXaQDPFnLAR591awZPoa
         P5k5/j2L6o1ilInfsD3p8kOSfPUYPqelgmeELLhnh2+CyEpod+vdjTzm61Q2iqis8Xar
         l44wzcFZiLXflCW1GrwyApMxJ0/vmzCHNXjgwrqAAZVES1IJDylDiQ8FgI8kQrIAtB9H
         XlvdzpQibUXHPzdjZFXMvs5c1qsvTANv1uwArMbTvcReMpP4fg4I9RLgi41jPH9ux7bv
         AqkbVdpHEEPjj7bKpaBnttk1HLVct7uz50csZAbBcOqQJbsDy18qWWtBSYS3Ib0BMTuL
         G6EQ==
X-Gm-Message-State: AOAM530NTD6d4OQ/d5sCifoabM91SQeeebh5HYnmRE0lXAGsCYmFHdmz
        hIAp9dJ1VlmDlz0ddfLCsdJ5+IvW9Ck8K8qkH21GAA==
X-Google-Smtp-Source: ABdhPJzhxR1n7Vooe0175TQ0cTn6e3legTe4HaUJiFdyBv27MHJjb0KJpPCbf5Ddn40VWgb5JDDqRG7NpGkiKGEXi5Q=
X-Received: by 2002:a05:6e02:20ca:: with SMTP id 10mr15101347ilq.310.1635960915564;
 Wed, 03 Nov 2021 10:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211029224929.379505-1-namhyung@kernel.org> <YYFGxwFMvTRN5KBI@krava>
 <CAM9d7cjPq7=HoPAi3Cd3crcNJO8hWu0cU8j4qOTqSMxd7M6BqQ@mail.gmail.com>
 <YYI5EwCjBojR+1QW@krava> <CABPqkBSHo3Gznor1e8M_Ue0XO8Z-HZt326q8N9kLWz4+jKkt-w@mail.gmail.com>
 <YYJzPkcUz2pcuspX@kernel.org>
In-Reply-To: <YYJzPkcUz2pcuspX@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 3 Nov 2021 10:35:04 -0700
Message-ID: <CABPqkBQkqehAvpfJk77WZpXezrVO6cAj=9ktKFgL=C_m84_Dgg@mail.gmail.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 4:32 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Nov 03, 2021 at 12:44:12AM -0700, Stephane Eranian escreveu:
> > On Wed, Nov 3, 2021 at 12:24 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > On Tue, Nov 02, 2021 at 04:21:21PM -0700, Namhyung Kim wrote:
> > > > On Tue, Nov 2, 2021 at 7:10 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > > we were discussing this with Arnaldo yesterday and he had an idea to use
> > > > > evsel->pmu link to store this info instead of hash.. I first thought we
> > > > > needed 'evsel' related data, but after I gave it some thought I think that
> > > > > might actually work
>
> > > > I don't get it.. do we have evsel->pmu already?  Or do you want to add it?
> > > > Yeah, the filtering facility (attr.exclude_*) should be kept in a PMU data
> > > > not in the evsel.  So I added a hashmap to find the pmu data from attr.type.
> > > > How do I use evsel->pmu to store the info then?
>
> > > evsel->pmu is not there yet (only evsel->pmu_name) so that
> > > would need to be added.. we have evsel__find_pmu available
>
> > > then the idea is to use evsel->pmu instead of the hasmap,
> > > like add:
>
> > >   struct pmu {
> > >     ...
> > >     bool missing_exclude_guest;
> > >   };
>
> yeah, or more generaly:
>
>         struct pmu {
>                 ...
>                 struct {
>                         bool exclude_guess;
>                 } missing_features;
>         };
>
> > > set it when the guest filtering fails and and check it
> > > instead of the hashmap__find call
>
> > > > > my argument was following usecase:
>
> > > > >   cycles:G,instructions:G,pmu/bla1/:G,pmu/bla2/
>
> > > > > that we would falsely clear pmu/bla1/:G if we used the 'evsel->pmu' data..
> > > > > but then I realized it's detection if pmu support :G and so if the :G is
> > > > > not there, none of the events should have it
>
> > > > > thoughts?
>
> > > > I don't think I'm following well... ;-p
>
> > > > If the pmu doesn't support host/guest filtering, pmu/bla1/G
> > > > may count something.  Not sure if it's better to error out.
> > > > But the cycles:G and instructions:G should result in 0
> > > > in case there's no VM running.
>
> > > hm, I think if pmu doesn't support host/guest filtering then
> > > I think 'pmu/bla1/G' should error, no? better no number than
> > > bad number
>
> > Yes, it should in my opinion.
>
> Yeah, I thought about this yesterday (holiday here).
>
Otherwise you create the illusion that you are monitoring in guest
mode when you are not.
The question is: how can the tool know which modifiers are supported
per pmu model?
