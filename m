Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A8830E965
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 02:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhBDBWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 20:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhBDBW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 20:22:29 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2DEC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 17:21:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m2so1652877wmm.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 17:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7W9QK0Q8vqKuDjKLwevkeBueA+/ph96knjRpyGO68BU=;
        b=op8vdpBBhoyPKiFkAowp0Pg6RgA6UGueyewssfNbHcF7RylhOfLjWgwqWxoOSfhKGx
         p9OGRCwav+mCgLFJ/j4RXx6nE9hml0iR0nVW/dqxcsXIXYOfF+OV7XLNog25R0bk0Q/S
         qvxj/7xGfu8DsIT8E8h2KIZo+4tM1A6gp4jc6qnnAzg7Sdgcbas5f+vpietuNOTBzCJm
         eUnnRbQqstdtAiuvDv20CkczzOmyhEZ7HRpTGdeKKubkWsSyya3beHKPKlIkO3I9o5+G
         596m2Vo9RK7AAz7emVWGClao2jH0/8whDB4XiJHyBzz9NFBYLTq+iD07c3P7C1UiSxvY
         nWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7W9QK0Q8vqKuDjKLwevkeBueA+/ph96knjRpyGO68BU=;
        b=r363AKSXfkjqxtVxZHWInvkVsS8BF8Chb+7ZeEsq6FlQK0pHN104NQiDtyBOkflqGZ
         zLhNDLoQ5grRjBms4WBFuhSoxx2pR656Viq6vYEbgb8hyRhSRx5SwBJq9jUA5ZUySwL9
         IuXUovamQcF7eX2ITtROJX1EXN6bbqtDdCky+KF05pi9UHdTvjFtLgvqT5BikG12a9L0
         UKfcmir1bbcEm2ZStmquo2e7k9t96oN+QkBpwBFMe9Oih149I5xU6FkBCIcprkCzpFfh
         4SXdMwipsWrFWEk0D7sD6W2CevhIkbIdstsUMEr0SGNrS4EAwxXmAldyIy+h39GXH/Rl
         F4Vg==
X-Gm-Message-State: AOAM531TOO98WS++CDW0bcu45HUL1joUkaexoIqHCek2+nojRcMq9jbJ
        3e2RWM++kWtVasS8cc4BvgK45YRJURzhqbfj/v8BAnpvHCuFRg==
X-Google-Smtp-Source: ABdhPJyFzHx0nIpO2k8RprZIBMwKIllPsazcVMkV6+BD4P31CuZn+9aaI+nKUIvwYHzXvyIAbDkfa44FeAStctp2M3M=
X-Received: by 2002:a7b:c153:: with SMTP id z19mr5103501wmi.87.1612401707120;
 Wed, 03 Feb 2021 17:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20210203052659.2975736-1-irogers@google.com> <20210203052659.2975736-2-irogers@google.com>
 <20210203162058.GE854763@kernel.org> <CAP-5=fVFeT6YtXJGHX0OC1BCa121bTC+ER7XDVO2g5rr8DYfDw@mail.gmail.com>
 <20210203205024.GM854763@kernel.org> <20210204005810.GZ854763@kernel.org>
In-Reply-To: <20210204005810.GZ854763@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 3 Feb 2021 17:21:35 -0800
Message-ID: <CAP-5=fUx-_AhaJaOTYRmxHWDqAX+R9U8rx6jZBHdDF+vdWSS0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf parse-events: Break out tracepoint and printing.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 4:58 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Feb 03, 2021 at 05:50:24PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Feb 03, 2021 at 10:38:41AM -0800, Ian Rogers escreveu:
> > > On Wed, Feb 3, 2021 at 8:21 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> > > wrote:
> > >
> > > > Em Tue, Feb 02, 2021 at 09:26:59PM -0800, Ian Rogers escreveu:
> > > > > Move print_*_events functions out of parse-events.c into a new
> > > > > print-events.c. Move tracepoint code into tracepoint.c or
> > > > > trace-event-info.c (sole user). This reduces the dependencies of
> > > > > parse-events.c and makes it more amenable to being a library in the
> > > > > future.
> > > > > Remove some unnecessary definitions from parse-events.h. Fix a
> > > > > checkpatch.pl warning on using unsigned rather than unsigned int.
> > > >
> > > > Thanks, applied.
> > > >
> > >
> > > Wow, cool :-) I wasn't sure about the macros in the headers. Are you
> > > staging these patches before pushing to your perf/core or using
> > > tmp.perf/core ? I know you mentioned a different approach. When I look at:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/
> > >
> > > I don't see anything newer than 9 days.
> >
> > Right, I'm collecting some more patches, will do build tests and push,
> > till then, lemme push tmp.perf/core with what I have.
>
> Strange, some intermediary versions of Alpine Linux are complaining, I'll continue tomorrow morning :-\
>
> [perfbuilder@five ~]$ time dm
> Wed Feb  3 09:32:47 PM -03 2021
> # export PERF_TARBALL=http://192.168.86.5/perf/perf-5.11.0-rc6.tar.xz
> # dm
>    1    72.90 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
>    2    74.62 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
>    3    76.69 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
>    4    84.43 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
>    5    84.17 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
>    6    16.71 alpine:3.9                    : FAIL gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
>                      from util/print-events.c:10:
>     /usr/include/linux/swab.h:161:8: error: unknown type name '__always_inline'
>      static __always_inline __u16 __swab16p(const __u16 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/swab.h:161:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab16p'
>      static __always_inline __u16 __swab16p(const __u16 *p)
>                                   ^~~~~~~~~
>     /usr/include/linux/swab.h:174:8: error: unknown type name '__always_inline'
>      static __always_inline __u32 __swab32p(const __u32 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/swab.h:174:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab32p'
>      static __always_inline __u32 __swab32p(const __u32 *p)
>                                   ^~~~~~~~~
>     /usr/include/linux/swab.h:187:8: error: unknown type name '__always_inline'
>      static __always_inline __u64 __swab64p(const __u64 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/swab.h:187:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab64p'
>      static __always_inline __u64 __swab64p(const __u64 *p)
>                                   ^~~~~~~~~
>     /usr/include/linux/swab.h:242:23: error: expected ';' before 'void'
>      static __always_inline void __swab32s(__u32 *p)
>                            ^~~~~
>                            ;
>     /usr/include/linux/swab.h:255:23: error: expected ';' before 'void'
>      static __always_inline void __swab64s(__u64 *p)
>                            ^~~~~
>                            ;
>     In file included from /usr/include/asm/byteorder.h:5,
>                      from /git/linux/tools/include/uapi/linux/perf_event.h:20,
>                      from util/print-events.c:10:
>     /usr/include/linux/byteorder/little_endian.h:44:8: error: unknown type name '__always_inline'
>      static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:44:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le64p'
>      static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
>                                    ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:48:8: error: unknown type name '__always_inline'
>      static __always_inline __u64 __le64_to_cpup(const __le64 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:48:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le64_to_cpup'
>      static __always_inline __u64 __le64_to_cpup(const __le64 *p)
>                                   ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:52:8: error: unknown type name '__always_inline'
>      static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:52:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le32p'
>      static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
>                                    ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:56:8: error: unknown type name '__always_inline'
>      static __always_inline __u32 __le32_to_cpup(const __le32 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:56:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le32_to_cpup'
>      static __always_inline __u32 __le32_to_cpup(const __le32 *p)
>                                   ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:60:8: error: unknown type name '__always_inline'
>      static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:60:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le16p'
>      static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
>                                    ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:64:8: error: unknown type name '__always_inline'
>      static __always_inline __u16 __le16_to_cpup(const __le16 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:64:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le16_to_cpup'
>      static __always_inline __u16 __le16_to_cpup(const __le16 *p)
>                                   ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:68:8: error: unknown type name '__always_inline'
>      static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:68:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be64p'
>      static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
>                                    ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:72:8: error: unknown type name '__always_inline'
>      static __always_inline __u64 __be64_to_cpup(const __be64 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:72:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be64_to_cpup'
>      static __always_inline __u64 __be64_to_cpup(const __be64 *p)
>                                   ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:76:8: error: unknown type name '__always_inline'
>      static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:76:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be32p'
>      static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
>                                    ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:80:8: error: unknown type name '__always_inline'
>      static __always_inline __u32 __be32_to_cpup(const __be32 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:80:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be32_to_cpup'
>      static __always_inline __u32 __be32_to_cpup(const __be32 *p)
>                                   ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:84:8: error: unknown type name '__always_inline'
>      static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:84:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be16p'
>      static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
>                                    ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:88:8: error: unknown type name '__always_inline'
>      static __always_inline __u16 __be16_to_cpup(const __be16 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:88:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be16_to_cpup'
>      static __always_inline __u16 __be16_to_cpup(const __be16 *p)
>                                   ^~~~~~~~~~~~~~
>     make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
>    7    16.31 alpine:3.10                   : FAIL gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
>                      from util/print-events.c:10:
>     /usr/include/linux/swab.h:161:8: error: unknown type name '__always_inline'
>      static __always_inline __u16 __swab16p(const __u16 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/swab.h:161:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab16p'
>      static __always_inline __u16 __swab16p(const __u16 *p)
>                                   ^~~~~~~~~
>     /usr/include/linux/swab.h:174:8: error: unknown type name '__always_inline'
>      static __always_inline __u32 __swab32p(const __u32 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/swab.h:174:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab32p'
>      static __always_inline __u32 __swab32p(const __u32 *p)
>                                   ^~~~~~~~~
>     /usr/include/linux/swab.h:187:8: error: unknown type name '__always_inline'
>      static __always_inline __u64 __swab64p(const __u64 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/swab.h:187:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab64p'
>      static __always_inline __u64 __swab64p(const __u64 *p)
>                                   ^~~~~~~~~
>     /usr/include/linux/swab.h:242:23: error: expected ';' before 'void'
>      static __always_inline void __swab32s(__u32 *p)
>                            ^~~~~
>                            ;
>     /usr/include/linux/swab.h:255:23: error: expected ';' before 'void'
>      static __always_inline void __swab64s(__u64 *p)
>                            ^~~~~
>                            ;
>     In file included from /usr/include/asm/byteorder.h:5,
>                      from /git/linux/tools/include/uapi/linux/perf_event.h:20,
>                      from util/print-events.c:10:
>     /usr/include/linux/byteorder/little_endian.h:44:8: error: unknown type name '__always_inline'
>      static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:44:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le64p'
>      static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
>                                    ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:48:8: error: unknown type name '__always_inline'
>      static __always_inline __u64 __le64_to_cpup(const __le64 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:48:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le64_to_cpup'
>      static __always_inline __u64 __le64_to_cpup(const __le64 *p)
>                                   ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:52:8: error: unknown type name '__always_inline'
>      static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:52:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le32p'
>      static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
>                                    ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:56:8: error: unknown type name '__always_inline'
>      static __always_inline __u32 __le32_to_cpup(const __le32 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:56:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le32_to_cpup'
>      static __always_inline __u32 __le32_to_cpup(const __le32 *p)
>                                   ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:60:8: error: unknown type name '__always_inline'
>      static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:60:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le16p'
>      static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
>                                    ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:64:8: error: unknown type name '__always_inline'
>      static __always_inline __u16 __le16_to_cpup(const __le16 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:64:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le16_to_cpup'
>      static __always_inline __u16 __le16_to_cpup(const __le16 *p)
>                                   ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:68:8: error: unknown type name '__always_inline'
>      static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:68:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be64p'
>      static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
>                                    ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:72:8: error: unknown type name '__always_inline'
>      static __always_inline __u64 __be64_to_cpup(const __be64 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:72:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be64_to_cpup'
>      static __always_inline __u64 __be64_to_cpup(const __be64 *p)
>                                   ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:76:8: error: unknown type name '__always_inline'
>      static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:76:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be32p'
>      static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
>                                    ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:80:8: error: unknown type name '__always_inline'
>      static __always_inline __u32 __be32_to_cpup(const __be32 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:80:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be32_to_cpup'
>      static __always_inline __u32 __be32_to_cpup(const __be32 *p)
>                                   ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:84:8: error: unknown type name '__always_inline'
>      static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:84:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be16p'
>      static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
>                                    ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:88:8: error: unknown type name '__always_inline'
>      static __always_inline __u16 __be16_to_cpup(const __be16 *p)
>             ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:88:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be16_to_cpup'
>      static __always_inline __u16 __be16_to_cpup(const __be16 *p)
>                                   ^~~~~~~~~~~~~~
>     make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
>    8    18.59 alpine:3.11                   : FAIL gcc (Alpine 9.3.0) 9.3.0, Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
>                      from util/print-events.c:10:
>     /usr/include/linux/swab.h:161:8: error: unknown type name '__always_inline'
>       161 | static __always_inline __u16 __swab16p(const __u16 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/swab.h:161:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab16p'
>       161 | static __always_inline __u16 __swab16p(const __u16 *p)
>           |                              ^~~~~~~~~
>     /usr/include/linux/swab.h:174:8: error: unknown type name '__always_inline'
>       174 | static __always_inline __u32 __swab32p(const __u32 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/swab.h:174:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab32p'
>       174 | static __always_inline __u32 __swab32p(const __u32 *p)
>           |                              ^~~~~~~~~
>     /usr/include/linux/swab.h:187:8: error: unknown type name '__always_inline'
>       187 | static __always_inline __u64 __swab64p(const __u64 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/swab.h:187:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab64p'
>       187 | static __always_inline __u64 __swab64p(const __u64 *p)
>           |                              ^~~~~~~~~
>     /usr/include/linux/swab.h:242:23: error: expected ';' before 'void'
>       242 | static __always_inline void __swab32s(__u32 *p)
>           |                       ^~~~~
>           |                       ;
>     /usr/include/linux/swab.h:255:23: error: expected ';' before 'void'
>       255 | static __always_inline void __swab64s(__u64 *p)
>           |                       ^~~~~
>           |                       ;
>     In file included from /usr/include/asm/byteorder.h:5,
>                      from /git/linux/tools/include/uapi/linux/perf_event.h:20,
>                      from util/print-events.c:10:
>     /usr/include/linux/byteorder/little_endian.h:44:8: error: unknown type name '__always_inline'
>        44 | static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:44:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le64p'
>        44 | static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
>           |                               ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:48:8: error: unknown type name '__always_inline'
>        48 | static __always_inline __u64 __le64_to_cpup(const __le64 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:48:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le64_to_cpup'
>        48 | static __always_inline __u64 __le64_to_cpup(const __le64 *p)
>           |                              ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:52:8: error: unknown type name '__always_inline'
>        52 | static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:52:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le32p'
>        52 | static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
>           |                               ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:56:8: error: unknown type name '__always_inline'
>        56 | static __always_inline __u32 __le32_to_cpup(const __le32 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:56:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le32_to_cpup'
>        56 | static __always_inline __u32 __le32_to_cpup(const __le32 *p)
>           |                              ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:60:8: error: unknown type name '__always_inline'
>        60 | static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:60:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le16p'
>        60 | static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
>           |                               ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:64:8: error: unknown type name '__always_inline'
>        64 | static __always_inline __u16 __le16_to_cpup(const __le16 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:64:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le16_to_cpup'
>        64 | static __always_inline __u16 __le16_to_cpup(const __le16 *p)
>           |                              ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:68:8: error: unknown type name '__always_inline'
>        68 | static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:68:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be64p'
>        68 | static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
>           |                               ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:72:8: error: unknown type name '__always_inline'
>        72 | static __always_inline __u64 __be64_to_cpup(const __be64 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:72:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be64_to_cpup'
>        72 | static __always_inline __u64 __be64_to_cpup(const __be64 *p)
>           |                              ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:76:8: error: unknown type name '__always_inline'
>        76 | static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:76:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be32p'
>        76 | static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
>           |                               ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:80:8: error: unknown type name '__always_inline'
>        80 | static __always_inline __u32 __be32_to_cpup(const __be32 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:80:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be32_to_cpup'
>        80 | static __always_inline __u32 __be32_to_cpup(const __be32 *p)
>           |                              ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:84:8: error: unknown type name '__always_inline'
>        84 | static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:84:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be16p'
>        84 | static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
>           |                               ^~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:88:8: error: unknown type name '__always_inline'
>        88 | static __always_inline __u16 __be16_to_cpup(const __be16 *p)
>           |        ^~~~~~~~~~~~~~~
>     /usr/include/linux/byteorder/little_endian.h:88:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be16_to_cpup'
>        88 | static __always_inline __u16 __be16_to_cpup(const __be16 *p)
>           |                              ^~~~~~~~~~~~~~
>     make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
>    9   117.31 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0, Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
>   10   124.70 alpine:edge                   : Ok   gcc (Alpine 10.2.0) 10.2.0, Alpine clang version 10.0.1
>   11    72.02 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1), clang version 3.8.0 (tags/RELEASE_380/final)
>   12    87.30 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1), clang version 10.0.0
>   13    87.33 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 10.2.1 20201125 (ALT Sisyphus 10.2.1-alt2), clang version 10.0.1
>   14    70.23 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
>   15   104.56 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-12), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
>   16    23.52 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   17    21.96 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
>   18    27.58 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
>   19    33.35 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
>   20    98.93 centos:8                      : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5), clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)
>   21    69.01 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 10.2.1 20201217 releases/gcc-10.2.0-643-g7cbb07d2fc, clang version 10.0.1
>   22    79.89 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
>

Ugh, sorry for that. I'm reminded of:
https://lore.kernel.org/lkml/20210113223609.3358812-1-irogers@google.com/

On a similar subject, a header file weirdness/rant I have is:
tools/include/uapi/linux/bpf.h

It includes:
#include <linux/types.h>
#include <linux/bpf_common.h>

The include paths for perf are:
 -I${SRC_DIR}/tools/lib/perf/include
 -I${SRC_DIR}/tools/perf/util/include
 -I${SRC_DIR}/tools/perf/arch/x86/include
 -I${SRC_DIR}/tools/include/
 -I${SRC_DIR}/tools/arch/x86/include/uapi
 -I${SRC_DIR}/tools/include/uapi
 -I${SRC_DIR}/tools/arch/x86/include/
 -I${SRC_DIR}/tools/arch/x86/
 -I${DST_DIR}/util -I${DST_DIR}
 -I${SRC_DIR}/tools/perf/util
 -I${SRC_DIR}/tools/perf
 -I${SRC_DIR}/tools/lib/

Note that tools/include is before tools/include/uapi and that
linux/types.h is included with the directory name. From this the
search order is given in:
https://gcc.gnu.org/onlinedocs/gcc/Directory-Options.html
"Directories specified with -I options are scanned in left-to-right order."
So when perf includes linux/bpf.h the types.h is coming from
tools/include/linux/types.h rather than
tools/include/uapi/linux/types.h that normal logic would expect
(prefer headers in the same directory). bpf_common.h is coming from
the uapi directory.

Thanks,
Ian
