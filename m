Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C7341B7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 22:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbhI1UJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 16:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242563AbhI1UJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 16:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632859640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bk6tb6Ct537XzJhdSUGj/GNTfjhpoUwK2pWLiL4w+xw=;
        b=KJWmK+9OXy+yg5KPP3GY/ldgrqbIQgVw2rjRBlyG2BGqnf4/ENBWqzDMWRFOww2VE28AXi
        ygGtOJzC5YCQ2rzJnk3wlzESmBqzPMVHBOKkeIbHuFonmCaYHeBA0fVkxiDTLXFD+fClL/
        QQxSNO/SQIJGDg76YRPIb9vpoBLUIIw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-czZybVIJPlOQZY1drpMuAQ-1; Tue, 28 Sep 2021 16:07:19 -0400
X-MC-Unique: czZybVIJPlOQZY1drpMuAQ-1
Received: by mail-ed1-f70.google.com with SMTP id s12-20020a05640217cc00b003cde58450f1so23192007edy.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 13:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bk6tb6Ct537XzJhdSUGj/GNTfjhpoUwK2pWLiL4w+xw=;
        b=jA+YANvENSjK61V08W2rBEmDfzXgDtfbzTPLJSyYxiD0ejh0ZuTVQ7JxQk/T1s4dv/
         UzN/uqWWVfGyHeuIzvcWTrX6U5eid5Hh0AGYgf2Epa0Ib0kcckQFVgswjYaR6vNCtuoq
         HakQkuL1LjyhBdY1ZVP+udkCuvng1M6QadiLz1M9QrDc8+EwtfosdoLUtpq+krmrAxHS
         pog4abB7BlEIMF1VqEIxc1umo+eVvJAaZxi19Xs3kjmm7AsBWXAgGUW/zUHpmu7FrQoD
         QjR8RknngXlLEO1mWhHFEr2UfVj19wvj4PIEyebbwOnQMx/95vgUIuYXaJhZNA1XiAan
         50hw==
X-Gm-Message-State: AOAM531s/yu2N3OZGxyqUFGdJMkfLLw8rOpkrgCLm7u2O1Jecq7TTRyW
        zzL9ariMJeDW155o0CzQFlCS4NXjyjNvbJ4SZE5CDy/0sbrvXu+TcGX/eHA5i/VIKXNeSEN/evc
        izg+OAIj2t8XEDYEtFXOeEJQF
X-Received: by 2002:a50:8d85:: with SMTP id r5mr2768009edh.312.1632859638184;
        Tue, 28 Sep 2021 13:07:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWTOpT3bmqoWPQtevCOSt6HiSKoNt3ldOdQym4CIAEfcKKVcaEFtNEQFgNyQAYVjfWzV/H3g==
X-Received: by 2002:a50:8d85:: with SMTP id r5mr2767987edh.312.1632859638039;
        Tue, 28 Sep 2021 13:07:18 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id ck10sm46109edb.43.2021.09.28.13.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 13:07:17 -0700 (PDT)
Date:   Tue, 28 Sep 2021 22:07:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, eranian@google.com
Subject: Re: [RFC PATCH 3/5] perf test: Make each test/suite its own struct.
Message-ID: <YVN18yh1N5luKGen@krava>
References: <20210922081959.390059-1-irogers@google.com>
 <20210922081959.390059-4-irogers@google.com>
 <YVDiMDoD2dr312KY@krava>
 <CAP-5=fWONeXLa=r4uJ1TM4K+E1moBMrV29LzfbciTfVVHvorsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWONeXLa=r4uJ1TM4K+E1moBMrV29LzfbciTfVVHvorsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 09:08:53AM -0700, Ian Rogers wrote:
> On Sun, Sep 26, 2021 at 2:12 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Sep 22, 2021 at 01:19:56AM -0700, Ian Rogers wrote:
> > > By switching to an array of pointers to tests (later to be suites)
> > > the definition of the tests can be moved to the file containing the
> > > tests.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/arch/arm/include/arch-tests.h     |   2 +-
> > >  tools/perf/arch/arm/tests/arch-tests.c       |  21 +-
> > >  tools/perf/arch/arm64/include/arch-tests.h   |   2 +-
> > >  tools/perf/arch/arm64/tests/arch-tests.c     |  15 +-
> > >  tools/perf/arch/powerpc/include/arch-tests.h |   2 +-
> > >  tools/perf/arch/powerpc/tests/arch-tests.c   |  15 +-
> > >  tools/perf/arch/x86/include/arch-tests.h     |   2 +-
> > >  tools/perf/arch/x86/tests/arch-tests.c       |  47 ++--
> > >  tools/perf/tests/builtin-test.c              | 273 ++++++++++++-------
> > >  tools/perf/tests/tests.h                     |   6 +
> > >  10 files changed, 220 insertions(+), 165 deletions(-)
> > >
> > > diff --git a/tools/perf/arch/arm/include/arch-tests.h b/tools/perf/arch/arm/include/arch-tests.h
> > > index c62538052404..37039e80f18b 100644
> > > --- a/tools/perf/arch/arm/include/arch-tests.h
> > > +++ b/tools/perf/arch/arm/include/arch-tests.h
> > > @@ -2,6 +2,6 @@
> > >  #ifndef ARCH_TESTS_H
> > >  #define ARCH_TESTS_H
> > >
> > > -extern struct test arch_tests[];
> > > +extern struct test *arch_tests[];
> > >
> > >  #endif
> > > diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
> > > index 6848101a855f..4374b0293177 100644
> > > --- a/tools/perf/arch/arm/tests/arch-tests.c
> > > +++ b/tools/perf/arch/arm/tests/arch-tests.c
> > > @@ -3,18 +3,15 @@
> > >  #include "tests/tests.h"
> > >  #include "arch-tests.h"
> > >
> > > -struct test arch_tests[] = {
> > >  #ifdef HAVE_DWARF_UNWIND_SUPPORT
> > > -     {
> > > -             .desc = "DWARF unwind",
> > > -             .func = test__dwarf_unwind,
> > > -     },
> > > +DEFINE_SUITE("DWARF unwind", dwarf_unwind);
> >
> > why not having this and other in here DEFINE_SUITE in
> > tests/dwarf-unwind.c ? it seems to get compiled in only
> > for supported arch
> 
> Not sure I follow. In these changes I've just tried to move things
> around without changing the logic behind things. This sounds like a
> sensible follow up clean up.

ah ok, maybe I mixed the proper patch to adress this, sry

the question I have is why DEFINE_SUITE("DWARF unwind" ..
is not moved to dwarf unwind test object, like you did for
other tests

thanks,
jirka

> 
> Thanks,
> Ian
> 
> > jirka
> >
> > >  #endif
> > > -     {
> > > -             .desc = "Vectors page",
> > > -             .func = test__vectors_page,
> > > -     },
> > > -     {
> > > -             .func = NULL,
> > > -     },
> > > +DEFINE_SUITE("Vectors page", vectors_page);
> > > +
> > > +struct test *arch_tests[] = {
> > > +#ifdef HAVE_DWARF_UNWIND_SUPPORT
> > > +     &dwarf_unwind,
> > > +#endif
> > > +     &vectors_pages,
> > > +     NULL,
> > >  };
> >
> > SNIP
> >
> 

