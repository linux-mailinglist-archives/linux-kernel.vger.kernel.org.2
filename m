Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8896D443DCC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhKCHrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhKCHrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:47:00 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A13BC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 00:44:24 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id v65so1694428ioe.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0DJBogUqt10i4GpWGP9Og6KdVgW72FI0vHWe9QGbr8M=;
        b=s5Jg83eMNjb6xEXiyCNvbJ9Gyqv48Q4m7oEaHmXyD1Jn0yw344YgmXZX1c1+R+6drV
         9rgF79lur6Yqs3ehFsCv0Jy79EyWCqrvYIiE81HZVoNhkLvDGUO8eTIguDyr+6504vXU
         jJYasLf1T7EYXSFGR/nKHqmbfE/1afojMvxQ2rX2Ae7tjT3rtwYOPM4LxXPXCle8+gFx
         1+AIwvCQdUIIOxAXWnSOAuuS8YBRimlLDtdT+neaoCTct2Do40R/kMyhS95n7d2MgHUC
         3tUAMJCMj5j/1By8VvbMmSOEzvYuLW/i7SzsvJZwbM0APtd6jtLukP+RAU8WB2Uddq93
         xBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DJBogUqt10i4GpWGP9Og6KdVgW72FI0vHWe9QGbr8M=;
        b=3mIMNgnY1ic5WIjL4W/u8OrpPagl4YIDNfJhn+XPMa//ASfCx9Y4wcw+vqLg/Hlx/0
         3rhUkCJUdLTbsfQ+q6TpTTFoqoIWt4iyzqtYOcTdEVr62PKM2ZX02PH56pM4sb74lNSt
         3Y4MQHva2/XiKJwzjoWrygWfr4k5pO4KAIqJfvnmv/x16Iz3LG/PpjC5YWWo8YGYvHZV
         a+tC7Oi5+M4bKdcOyLC3xWmLVBu4V+SNqRpd97Zmx6fJ3L2f5D9uLDVSuG4lyhBdaq+6
         zrzflZq3skSkbO4UWeR1On6MNaANmahU8Prl9o/RteZkad7aml8LM+NUKG76XxZIET9P
         /2/g==
X-Gm-Message-State: AOAM530gixjNm48HFQUCUX5rs2Xpg5ClqrBTd4SIgAerms6kYJ6iXGd+
        YnGWSnxCzCWTdTGfZFIoqs9BoSnJ/6e/0SlnUsuc9A==
X-Google-Smtp-Source: ABdhPJx1T/W8ArsNsSjtN243LG2QQW1pUc6ddWL3rOLHLx58PP5sY0aYf1Niw5LXKBGQ/19yrC69AGWYNDkYtTjTRJw=
X-Received: by 2002:a6b:6f0d:: with SMTP id k13mr839001ioc.49.1635925463934;
 Wed, 03 Nov 2021 00:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211029224929.379505-1-namhyung@kernel.org> <YYFGxwFMvTRN5KBI@krava>
 <CAM9d7cjPq7=HoPAi3Cd3crcNJO8hWu0cU8j4qOTqSMxd7M6BqQ@mail.gmail.com> <YYI5EwCjBojR+1QW@krava>
In-Reply-To: <YYI5EwCjBojR+1QW@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 3 Nov 2021 00:44:12 -0700
Message-ID: <CABPqkBSHo3Gznor1e8M_Ue0XO8Z-HZt326q8N9kLWz4+jKkt-w@mail.gmail.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 12:24 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Nov 02, 2021 at 04:21:21PM -0700, Namhyung Kim wrote:
> > Hi Jiri,
> >
> > On Tue, Nov 2, 2021 at 7:10 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Fri, Oct 29, 2021 at 03:49:29PM -0700, Namhyung Kim wrote:
> > > > The current logic for the perf missing feature has a bug that it can
> > > > wrongly clear some modifiers like G or H.  Actually some PMUs don't
> > > > support any filtering or exclusion while others do.  But we check it
> > > > as a global feature.
> > > >
> > > > For example, the cycles event can have 'G' modifier to enable it only
> > > > in the guest mode on x86.  When you don't run any VMs it'll return 0.
> > > >
> > > >   # perf stat -a -e cycles:G sleep 1
> > > >
> > > >     Performance counter stats for 'system wide':
> > > >
> > > >                     0      cycles:G
> > > >
> > > >           1.000721670 seconds time elapsed
> > > >
> > > > But when it's used with other pmu events that don't support G modifier,
> > > > it'll be reset and return non-zero values.
> > > >
> > > >   # perf stat -a -e cycles:G,msr/tsc/ sleep 1
> > > >
> > > >     Performance counter stats for 'system wide':
> > > >
> > > >           538,029,960      cycles:G
> > > >        16,924,010,738      msr/tsc/
> > > >
> > > >           1.001815327 seconds time elapsed
> > > >
> > > > This is because of the missing feature detection logic being global.
> > > > Add a hashmap to set pmu-specific exclude_host/guest features.
> > > >
> > > > Reported-by: Stephane Eranian <eranian@google.com>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > > v3 changes)
> > > >  * check memory allocation failure
> > > >  * add more NULL check
> > >
> > > we were discussing this with Arnaldo yesterday and he had an idea to use
> > > evsel->pmu link to store this info instead of hash.. I first thought we
> > > needed 'evsel' related data, but after I gave it some thought I think that
> > > might actually work
> >
> > I don't get it.. do we have evsel->pmu already?  Or do you want to add it?
> > Yeah, the filtering facility (attr.exclude_*) should be kept in a PMU data
> > not in the evsel.  So I added a hashmap to find the pmu data from attr.type.
> > How do I use evsel->pmu to store the info then?
>
> evsel->pmu is not there yet (only evsel->pmu_name) so that
> would need to be added.. we have evsel__find_pmu available
>
> then the idea is to use evsel->pmu instead of the hasmap,
> like add:
>
>   struct pmu {
>     ...
>     bool missing_exclude_guest;
>   };
>
> set it when the guest filtering fails and and check it
> instead of the hashmap__find call
>
> >
> > >
> > > my argument was following usecase:
> > >
> > >   cycles:G,instructions:G,pmu/bla1/:G,pmu/bla2/
> > >
> > > that we would falsely clear pmu/bla1/:G if we used the 'evsel->pmu' data..
> > > but then I realized it's detection if pmu support :G and so if the :G is
> > > not there, none of the events should have it
> > >
> > > thoughts?
> >
> > I don't think I'm following well... ;-p
> >
> > If the pmu doesn't support host/guest filtering, pmu/bla1/G
> > may count something.  Not sure if it's better to error out.
> > But the cycles:G and instructions:G should result in 0
> > in case there's no VM running.
>
> hm, I think if pmu doesn't support host/guest filtering then
> I think 'pmu/bla1/G' should error, no? better no number than
> bad number
>
Yes, it should in my opinion.

> jitka
>
> >
> > Thanks,
> > Namhyung
> >
>
