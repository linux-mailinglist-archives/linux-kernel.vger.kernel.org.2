Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFBA37005F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 20:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhD3SWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 14:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhD3SWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:22:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FE6F613D9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619806871;
        bh=RmbbiAkH4JmT/dChtltom/gbGZbNXlnFFpa0oAzvEHY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jb8+CroDi15WxNlFfeN6QehcgAP0ZzVbNlwkyhc2zDdYtMr8cwocIXDdOqut6Zlxo
         tx/N1emgcE7kYkBmG9DxjdjhndwlNSeP1wugzci9jE7KXbYRDphjNz0B4i4oINfQkx
         PUlEwFkKBazlEZd6kCldqrINVecD8fzujKlJ8X/j3IYt3WcZVbdObJJxD7kYYSzLL7
         G8aZ1iCe11VBd6jTgRJKmwb4PmiCba1H6jm5r3779x3RidY7Rvw6B1CnFBOwG/P7Oi
         /bIcSmXB/mMwNkO6pUMRFw4aGIRyF4+kUwG1YUgVblbc9ZnVLJhot3GVuPrItcrHt7
         Lub3yC+RSAFtQ==
Received: by mail-ej1-f41.google.com with SMTP id l4so106591911ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 11:21:11 -0700 (PDT)
X-Gm-Message-State: AOAM530FOacHfLe6wcTEviy70e8eareLUM8Sq4hGzh8wdop4vbK/UJAP
        8cd9m8xKvzb2uM7mEbVjMFjDrciO7GKnUFy9SQ==
X-Google-Smtp-Source: ABdhPJwHkSMe/mYVAAVGPC2+KXlI3GNhx6kzDKqwhEBQ/HpLosIGDYaVeGF82y8WrsP5K6BzDlRPTrhGsfr5/OKSV40=
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr5746788ejf.341.1619806870144;
 Fri, 30 Apr 2021 11:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210420031511.2348977-1-robh@kernel.org> <20210420031511.2348977-8-robh@kernel.org>
 <20210430164616.pzb7yxrsugexso25@gabell> <CAL_JsqLtkik656hjHMqvPc3Ta6qR+nWx1BxPcj8GvzYypTUVWQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLtkik656hjHMqvPc3Ta6qR+nWx1BxPcj8GvzYypTUVWQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Apr 2021 13:20:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLvHh5Ekpmb_au8Y9a7zF4w_izgaVnhzi9255XuqQUjrQ@mail.gmail.com>
Message-ID: <CAL_JsqLvHh5Ekpmb_au8Y9a7zF4w_izgaVnhzi9255XuqQUjrQ@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] perf: arm64: Add test for userspace counter access
 on heterogeneous systems
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 1:17 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Apr 30, 2021 at 11:46 AM Masayoshi Mizuma <msys.mizuma@gmail.com>=
 wrote:
> >
> > On Mon, Apr 19, 2021 at 10:15:09PM -0500, Rob Herring wrote:
> > > Userspace counter access only works on heterogeneous systems with som=
e
> > > restrictions. The userspace process must be pinned to a homogeneous
> > > subset of CPUs and must open the corresponding PMU for those CPUs. Th=
is
> > > commit adds a test implementing these requirements.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > v6:
> > >  - Add a check on cap_user_rdpmc
> > > v5:
> > >  - Adapt to libperf mmap API changes
> > > v4:
> > >  - Update perf_evsel__mmap params
> > > v2:
> > >  - Drop all but heterogeneous test as others covered by libperf tests
> > >  - Rework to use libperf
> > > ---
> > >  tools/perf/arch/arm64/include/arch-tests.h |   7 +
> > >  tools/perf/arch/arm64/tests/Build          |   1 +
> > >  tools/perf/arch/arm64/tests/arch-tests.c   |   4 +
> > >  tools/perf/arch/arm64/tests/user-events.c  | 177 +++++++++++++++++++=
++
> > >  4 files changed, 189 insertions(+)
> > >  create mode 100644 tools/perf/arch/arm64/tests/user-events.c
> > >
> > > diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/=
arch/arm64/include/arch-tests.h
> > > index 90ec4c8cb880..380ad34a3f09 100644
> > > --- a/tools/perf/arch/arm64/include/arch-tests.h
> > > +++ b/tools/perf/arch/arm64/include/arch-tests.h
> > > @@ -2,11 +2,18 @@
> > >  #ifndef ARCH_TESTS_H
> > >  #define ARCH_TESTS_H
> > >
> > > +#include <linux/compiler.h>
> > > +
> > >  #ifdef HAVE_DWARF_UNWIND_SUPPORT
> > >  struct thread;
> > >  struct perf_sample;
> > > +int test__arch_unwind_sample(struct perf_sample *sample,
> > > +                          struct thread *thread);
> > >  #endif
> >
> > Hello,
> >
> > I got the following compile error with aarch64 on Fedora33.
> >
> >     # make tools/perf
> >     ...
> >     In file included from arch/arm64/tests/arch-tests.c:4:
> >     /root//libperf_v7/tools/perf/arch/arm64/include/arch-tests.h:10:5: =
error: redundant redeclaration of =E2=80=98test__arch_unwind_sample=E2=80=
=99 [-Werror=3Dredundant-decls]
> >        10 | int test__arch_unwind_sample(struct perf_sample *sample,
> >           |     ^~~~~~~~~~~~~~~~~~~~~~~~
> >     In file included from arch/arm64/tests/arch-tests.c:3:
> >     /root//libperf_v7/tools/perf/tests/tests.h:140:5: note: previous de=
claration of =E2=80=98test__arch_unwind_sample=E2=80=99 was here
> >       140 | int test__arch_unwind_sample(struct perf_sample *sample,
> >           |     ^~~~~~~~~~~~~~~~~~~~~~~~
> >     cc1: all warnings being treated as errors
> >     make[8]: *** [/root//libperf_v7/tools/build/Makefile.build:97: /roo=
t/libperf_v7/tools/perf/arch/arm64/tests/arch-tests.o] Error 1
> >     make[8]: *** Waiting for unfinished jobs....
> >     In file included from arch/arm64/tests/user-events.c:13:
> >     /root//libperf_v7/tools/perf/arch/arm64/include/arch-tests.h:10:5: =
error: redundant redeclaration of =E2=80=98test__arch_unwind_sample=E2=80=
=99 [-Werror=3Dredundant-decls]
> >        10 | int test__arch_unwind_sample(struct perf_sample *sample,
> >           |     ^~~~~~~~~~~~~~~~~~~~~~~~
> >     In file included from arch/arm64/tests/user-events.c:12:
> >     /root//libperf_v7/tools/perf/tests/tests.h:140:5: note: previous de=
claration of =E2=80=98test__arch_unwind_sample=E2=80=99 was here
> >       140 | int test__arch_unwind_sample(struct perf_sample *sample,
> >           |     ^~~~~~~~~~~~~~~~~~~~~~~~
> >     cc1: all warnings being treated as errors
> >     ...
> >
> > The error is gone after the following patch is applied.
>
> Thanks. Honestly, I'm not sure why it was there in the first place.
> Looking at the git history and this series history doesn't give any
> clues.

Well, except that both x86 and powerpc have the same hunk in their
arch-tests.h. Do you see errors on those arches?

Rob
