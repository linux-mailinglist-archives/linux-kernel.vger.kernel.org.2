Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E3A3701F3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhD3URW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbhD3URR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:17:17 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C948AC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:16:28 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t17so43567233qkg.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=418LuZVb96KeBroUoNBO/Ka2cAOhu5+UpkObObtMrmg=;
        b=GjpWCEb1KmimqRmuj7zRxJd42iWbVWtHE6af0lobM99yfQteIp+Aj83tGNywqZkPmY
         z9ujmdtMusJnX3yFulMZaOQ0J3TGrPZsNwjCD9dkpDggTcSn2TWDwcM2oVSamgUcmNmA
         /ZBfnDkRwoJStNvj9O01xahs2IPyfYWqOVqDXuaC08pbMz06PWLrXQ9WngqiX/3LcnEI
         xT49UXwHbiWUZsR92ZOwWMBmzXmVnfxM+Rqy8Mx45S4vRC+LiXMLlfQdnoJajJz9pcKh
         TeE6o9K8Ws6o9HZLHw9yzFR9pcThVExV/c012NIayENd3L4F7LawELV1H8UHm2t9KJCa
         /DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=418LuZVb96KeBroUoNBO/Ka2cAOhu5+UpkObObtMrmg=;
        b=Vm6oJaboENxQwDOFT28sPCbU6eLz3BXRXJIGGXIWsKGBPaCN1enCqN0fhAOw3+lRY3
         fUJTwrWcC7v03KMyxgkawY5c6ntcn4KY3yRa1jsDdr42NpQm2ZD2tWd8PYovnQO5jxJk
         QAgIV6ld67CQtI9NDi7/bJwQ/z6TUULxzqwMgYIvK9oEoApjnAWgvzuE6FhNYCMUnxvP
         xAac2GO+hYP66hgpmcdJnBPNd+Ykf9hpL0HkNLwevNAbfAjbI1w0H4frWBfHDtaxrD+g
         yitqk4/8/TwYCXvCozzUI/nd1ldpaFkHsR6rwsFhOuDW2Ad44vLS5kPOROJH/cUAxAOO
         EnhQ==
X-Gm-Message-State: AOAM531FYRLIbWKyzXcPGc8yDktUE0aTKZ2Svg4CIx6kFMEp87ItY58w
        8voUnonwOTfyu35nl0YrIA==
X-Google-Smtp-Source: ABdhPJw+PYJVdy/b4DcfipUKlwneSI6SQhn7z0gM1sjg6Jg7K1bzdihxcO7bnGWX5paTyfA4WopyEw==
X-Received: by 2002:a05:620a:4c3:: with SMTP id 3mr7246058qks.282.1619813788033;
        Fri, 30 Apr 2021 13:16:28 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id o189sm2350100qka.86.2021.04.30.13.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:16:27 -0700 (PDT)
Date:   Fri, 30 Apr 2021 16:16:25 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 7/9] perf: arm64: Add test for userspace counter
 access on heterogeneous systems
Message-ID: <20210430201625.mpxeop6niyxnnvbk@gabell>
References: <20210420031511.2348977-1-robh@kernel.org>
 <20210420031511.2348977-8-robh@kernel.org>
 <20210430164616.pzb7yxrsugexso25@gabell>
 <CAL_JsqLtkik656hjHMqvPc3Ta6qR+nWx1BxPcj8GvzYypTUVWQ@mail.gmail.com>
 <CAL_JsqLvHh5Ekpmb_au8Y9a7zF4w_izgaVnhzi9255XuqQUjrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLvHh5Ekpmb_au8Y9a7zF4w_izgaVnhzi9255XuqQUjrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 01:20:58PM -0500, Rob Herring wrote:
> On Fri, Apr 30, 2021 at 1:17 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Apr 30, 2021 at 11:46 AM Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> > >
> > > On Mon, Apr 19, 2021 at 10:15:09PM -0500, Rob Herring wrote:
> > > > Userspace counter access only works on heterogeneous systems with some
> > > > restrictions. The userspace process must be pinned to a homogeneous
> > > > subset of CPUs and must open the corresponding PMU for those CPUs. This
> > > > commit adds a test implementing these requirements.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > > v6:
> > > >  - Add a check on cap_user_rdpmc
> > > > v5:
> > > >  - Adapt to libperf mmap API changes
> > > > v4:
> > > >  - Update perf_evsel__mmap params
> > > > v2:
> > > >  - Drop all but heterogeneous test as others covered by libperf tests
> > > >  - Rework to use libperf
> > > > ---
> > > >  tools/perf/arch/arm64/include/arch-tests.h |   7 +
> > > >  tools/perf/arch/arm64/tests/Build          |   1 +
> > > >  tools/perf/arch/arm64/tests/arch-tests.c   |   4 +
> > > >  tools/perf/arch/arm64/tests/user-events.c  | 177 +++++++++++++++++++++
> > > >  4 files changed, 189 insertions(+)
> > > >  create mode 100644 tools/perf/arch/arm64/tests/user-events.c
> > > >
> > > > diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
> > > > index 90ec4c8cb880..380ad34a3f09 100644
> > > > --- a/tools/perf/arch/arm64/include/arch-tests.h
> > > > +++ b/tools/perf/arch/arm64/include/arch-tests.h
> > > > @@ -2,11 +2,18 @@
> > > >  #ifndef ARCH_TESTS_H
> > > >  #define ARCH_TESTS_H
> > > >
> > > > +#include <linux/compiler.h>
> > > > +
> > > >  #ifdef HAVE_DWARF_UNWIND_SUPPORT
> > > >  struct thread;
> > > >  struct perf_sample;
> > > > +int test__arch_unwind_sample(struct perf_sample *sample,
> > > > +                          struct thread *thread);
> > > >  #endif
> > >
> > > Hello,
> > >
> > > I got the following compile error with aarch64 on Fedora33.
> > >
> > >     # make tools/perf
> > >     ...
> > >     In file included from arch/arm64/tests/arch-tests.c:4:
> > >     /root//libperf_v7/tools/perf/arch/arm64/include/arch-tests.h:10:5: error: redundant redeclaration of ‘test__arch_unwind_sample’ [-Werror=redundant-decls]
> > >        10 | int test__arch_unwind_sample(struct perf_sample *sample,
> > >           |     ^~~~~~~~~~~~~~~~~~~~~~~~
> > >     In file included from arch/arm64/tests/arch-tests.c:3:
> > >     /root//libperf_v7/tools/perf/tests/tests.h:140:5: note: previous declaration of ‘test__arch_unwind_sample’ was here
> > >       140 | int test__arch_unwind_sample(struct perf_sample *sample,
> > >           |     ^~~~~~~~~~~~~~~~~~~~~~~~
> > >     cc1: all warnings being treated as errors
> > >     make[8]: *** [/root//libperf_v7/tools/build/Makefile.build:97: /root/libperf_v7/tools/perf/arch/arm64/tests/arch-tests.o] Error 1
> > >     make[8]: *** Waiting for unfinished jobs....
> > >     In file included from arch/arm64/tests/user-events.c:13:
> > >     /root//libperf_v7/tools/perf/arch/arm64/include/arch-tests.h:10:5: error: redundant redeclaration of ‘test__arch_unwind_sample’ [-Werror=redundant-decls]
> > >        10 | int test__arch_unwind_sample(struct perf_sample *sample,
> > >           |     ^~~~~~~~~~~~~~~~~~~~~~~~
> > >     In file included from arch/arm64/tests/user-events.c:12:
> > >     /root//libperf_v7/tools/perf/tests/tests.h:140:5: note: previous declaration of ‘test__arch_unwind_sample’ was here
> > >       140 | int test__arch_unwind_sample(struct perf_sample *sample,
> > >           |     ^~~~~~~~~~~~~~~~~~~~~~~~
> > >     cc1: all warnings being treated as errors
> > >     ...
> > >
> > > The error is gone after the following patch is applied.
> >
> > Thanks. Honestly, I'm not sure why it was there in the first place.
> > Looking at the git history and this series history doesn't give any
> > clues.
> 
> Well, except that both x86 and powerpc have the same hunk in their
> arch-tests.h. Do you see errors on those arches?

I didn't see the errors on x86_64.
It seems that the errors happen on aarch64 because 
test__arch_unwind_sample() is defined only if the arch
is arm or arm64 in tools/perf/tests/tests.h:

    #if defined(__arm__) || defined(__aarch64__)
    #ifdef HAVE_DWARF_UNWIND_SUPPORT
    struct thread;
    struct perf_sample;
    int test__arch_unwind_sample(struct perf_sample *sample,
                                 struct thread *thread);
    #endif
    #endif

The following patch may be another solution which is same way as
commit d8b167f9d8af ("perf tests: Move x86 tests into arch directory").

---
 tools/perf/arch/arm64/tests/dwarf-unwind.c | 1 +
 tools/perf/tests/dwarf-unwind.c            | 2 +-
 tools/perf/tests/tests.h                   | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
index 46147a483..02ba87f2b 100644
--- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
+++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
@@ -7,6 +7,7 @@
 #include "event.h"
 #include "debug.h"
 #include "tests/tests.h"
+#include "arch-tests.h"
 
 #define STACK_SIZE 8192
 
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 83638097c..daffe2d66 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -17,7 +17,7 @@
 #include "callchain.h"
 #include "util/synthetic-events.h"
 
-#if defined (__x86_64__) || defined (__i386__) || defined (__powerpc__)
+#if defined (__x86_64__) || defined (__i386__) || defined (__powerpc__) || defined(__aarch64__)
 #include "arch-tests.h"
 #endif
 
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index b85f00530..40cbdfa46 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -133,7 +133,7 @@ bool test__bp_account_is_supported(void);
 bool test__wp_is_supported(void);
 bool test__tsc_is_supported(void);
 
-#if defined(__arm__) || defined(__aarch64__)
+#if defined(__arm__)
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
 struct perf_sample;
-- 

Thanks,
Masa
