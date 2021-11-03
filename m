Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEB9443DAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhKCH0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232117AbhKCH0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635924248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZJsErKlgOid2dgGzkeHMVCtfIFqJ3fNoFD5zA+9Z4Ao=;
        b=RVHw7D+58p4jkBPyN+2KQcqpDHT9g4qkKJJuGw/bh52wgW1qFXLQG162yefPfxwc/o0QmF
        5fvISjV5AXaAJ867SSfKseqQdiX3+M0DKZntjwhAwSGYCx2imXQpM9FzNCqRkvktvzMap9
        06lOuMOA+npEZETEKWZ1iN1zR+Cuobc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-SGSLTQQ9OSqzvVwGm9YKyw-1; Wed, 03 Nov 2021 03:24:07 -0400
X-MC-Unique: SGSLTQQ9OSqzvVwGm9YKyw-1
Received: by mail-ed1-f69.google.com with SMTP id g3-20020a056402424300b003e2981e1edbso1666384edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 00:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZJsErKlgOid2dgGzkeHMVCtfIFqJ3fNoFD5zA+9Z4Ao=;
        b=U4ezGGudodEhp8fgpA/hqmMn6sgem7adzLrb3bBNq2obIbizZ2YWB23wNB+dT7eEPs
         MEGjirFP3etyrgqVh/nPjHnlAc+ikWuqt5qKqZ+biErdGSssbMaCZSsdec0WWUJcTD2w
         nd3/eExVERYyMqNOSVgJpOv/GstAqheI6j52aTqeaI3sfe0bcEo0gwfBvxQ67YftMP46
         6ZLbNEGgBhokiRBrDaNhS0z80u5i3tTsspnZ/Xr+MBPKqeuMYjL9iogbRO9rDf6st6IG
         j1K57JyplZ7mEySXbq7P4ju0p7Xj2j8efvsjbOaLAu8GpN4sDQVv5cGISt1KuH0u8+ii
         2zjA==
X-Gm-Message-State: AOAM530YwTIlPnmvk3JUFbnijj2fXSmbitCHufGlqwuH7tj/BMDujIsA
        lapH3K6N6j0H3+OaKgRvSVPhsOSBVpiyhuMfGexr3Z8OWo5SJ79eoATsPULZfe+gAZ+OQfMuTDj
        NhIbNjvJ90JQq+kHye9forXgk
X-Received: by 2002:aa7:cd6a:: with SMTP id ca10mr54572622edb.79.1635924246010;
        Wed, 03 Nov 2021 00:24:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlO+b3tfg/k1spcUTKa1n0g9XTsOcf6a6lwmi4Eixf6TkFEsJ0xIEF4JiUWwjNCQv/dZdRXw==
X-Received: by 2002:aa7:cd6a:: with SMTP id ca10mr54572600edb.79.1635924245822;
        Wed, 03 Nov 2021 00:24:05 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t15sm613532ejx.75.2021.11.03.00.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 00:24:05 -0700 (PDT)
Date:   Wed, 3 Nov 2021 08:24:03 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YYI5EwCjBojR+1QW@krava>
References: <20211029224929.379505-1-namhyung@kernel.org>
 <YYFGxwFMvTRN5KBI@krava>
 <CAM9d7cjPq7=HoPAi3Cd3crcNJO8hWu0cU8j4qOTqSMxd7M6BqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjPq7=HoPAi3Cd3crcNJO8hWu0cU8j4qOTqSMxd7M6BqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 04:21:21PM -0700, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Tue, Nov 2, 2021 at 7:10 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Oct 29, 2021 at 03:49:29PM -0700, Namhyung Kim wrote:
> > > The current logic for the perf missing feature has a bug that it can
> > > wrongly clear some modifiers like G or H.  Actually some PMUs don't
> > > support any filtering or exclusion while others do.  But we check it
> > > as a global feature.
> > >
> > > For example, the cycles event can have 'G' modifier to enable it only
> > > in the guest mode on x86.  When you don't run any VMs it'll return 0.
> > >
> > >   # perf stat -a -e cycles:G sleep 1
> > >
> > >     Performance counter stats for 'system wide':
> > >
> > >                     0      cycles:G
> > >
> > >           1.000721670 seconds time elapsed
> > >
> > > But when it's used with other pmu events that don't support G modifier,
> > > it'll be reset and return non-zero values.
> > >
> > >   # perf stat -a -e cycles:G,msr/tsc/ sleep 1
> > >
> > >     Performance counter stats for 'system wide':
> > >
> > >           538,029,960      cycles:G
> > >        16,924,010,738      msr/tsc/
> > >
> > >           1.001815327 seconds time elapsed
> > >
> > > This is because of the missing feature detection logic being global.
> > > Add a hashmap to set pmu-specific exclude_host/guest features.
> > >
> > > Reported-by: Stephane Eranian <eranian@google.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > > v3 changes)
> > >  * check memory allocation failure
> > >  * add more NULL check
> >
> > we were discussing this with Arnaldo yesterday and he had an idea to use
> > evsel->pmu link to store this info instead of hash.. I first thought we
> > needed 'evsel' related data, but after I gave it some thought I think that
> > might actually work
> 
> I don't get it.. do we have evsel->pmu already?  Or do you want to add it?
> Yeah, the filtering facility (attr.exclude_*) should be kept in a PMU data
> not in the evsel.  So I added a hashmap to find the pmu data from attr.type.
> How do I use evsel->pmu to store the info then?

evsel->pmu is not there yet (only evsel->pmu_name) so that
would need to be added.. we have evsel__find_pmu available

then the idea is to use evsel->pmu instead of the hasmap,
like add:

  struct pmu {
    ...
    bool missing_exclude_guest;
  };

set it when the guest filtering fails and and check it
instead of the hashmap__find call

> 
> >
> > my argument was following usecase:
> >
> >   cycles:G,instructions:G,pmu/bla1/:G,pmu/bla2/
> >
> > that we would falsely clear pmu/bla1/:G if we used the 'evsel->pmu' data..
> > but then I realized it's detection if pmu support :G and so if the :G is
> > not there, none of the events should have it
> >
> > thoughts?
> 
> I don't think I'm following well... ;-p
> 
> If the pmu doesn't support host/guest filtering, pmu/bla1/G
> may count something.  Not sure if it's better to error out.
> But the cycles:G and instructions:G should result in 0
> in case there's no VM running.

hm, I think if pmu doesn't support host/guest filtering then
I think 'pmu/bla1/G' should error, no? better no number than
bad number

jitka

> 
> Thanks,
> Namhyung
> 

