Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1698B3B9702
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 22:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhGAUOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 16:14:17 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:36530 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbhGAUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 16:14:14 -0400
Received: by mail-lf1-f42.google.com with SMTP id d16so13978829lfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 13:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75g2PFx7kdnTyLTbpkbeecVRMngGlMc1mxlgm3OY/nE=;
        b=pQiW4yqM/1t40p6rrppCdZkGjqU7fCF7EA+NBz1NtlG3FRKl07deaggAuuHpzQJlGu
         Jv6xMrsfXkEHMFUFQNXCyjXWcXaMeUfaP2JV7IkQnvLzPP9uKceIC56dSRjoMe/VfMvo
         gMDUSIGTRDcJqbwshnUk7fqqMPS6TlURz1bZqLZRPHMJyDv+kc+m6eyey1R0Uyu76rJ7
         d3i4Rjvc4n1ohB6p74+Fo3e6U951t+dMIJxyWiBYXn+YpWY9U32h5uNYk1gEq89DIPZX
         6NrnzMLlAxxkqIl6j5lYm0UT+2eCcxRpC7IUJNIlC8vJcU4bCsa/XpD1kSzXbcwhtcT9
         UD1A==
X-Gm-Message-State: AOAM532ehoI+S3srRGZY2YCu5ZFWIjRjFRXEMEXxwtgbWyds3nC9RK6b
        nMRiVuXrYLO71+okzvT8Cmt0cmC+S+yq4TszaOg=
X-Google-Smtp-Source: ABdhPJw6ucf0OfCWwMykMvqGBv4Pn34O/7hYMslOrUYzNVom5l48M1AE3uZHWAjycrdG4miwU0tbwjeyBKo5vb9Byj0=
X-Received: by 2002:a19:4916:: with SMTP id w22mr1059868lfa.374.1625170301664;
 Thu, 01 Jul 2021 13:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210625071826.608504-1-namhyung@kernel.org> <20210625071826.608504-4-namhyung@kernel.org>
 <YN4S154hd454cAWh@kernel.org>
In-Reply-To: <YN4S154hd454cAWh@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Jul 2021 13:11:30 -0700
Message-ID: <CAM9d7ciwDq4dWDNCTdLGrmibsFGA1WY8hkfEX82BzX=S8zyj=Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf tools: Move common bpf functions to bpf_counter.h
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 12:09 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Jun 25, 2021 at 12:18:25AM -0700, Namhyung Kim escreveu:
> > Some helper functions will be used for cgroup counting too.
> > Move them to a header file for sharing.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/bpf_counter.c | 52 -----------------------------------
> >  tools/perf/util/bpf_counter.h | 52 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 52 insertions(+), 52 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> > index 974f10e356f0..1af81e882eb6 100644
> > --- a/tools/perf/util/bpf_counter.c
> > +++ b/tools/perf/util/bpf_counter.c
> > @@ -7,12 +7,8 @@
> >  #include <unistd.h>
> >  #include <sys/file.h>
> >  #include <sys/time.h>
> > -#include <sys/resource.h>
> >  #include <linux/err.h>
> >  #include <linux/zalloc.h>
> > -#include <bpf/bpf.h>
> > -#include <bpf/btf.h>
> > -#include <bpf/libbpf.h>
> >  #include <api/fs/fs.h>
> >  #include <perf/bpf_perf.h>
> >
> > @@ -37,13 +33,6 @@ static inline void *u64_to_ptr(__u64 ptr)
> >       return (void *)(unsigned long)ptr;
> >  }
> >
> > -static void set_max_rlimit(void)
> > -{
> > -     struct rlimit rinf = { RLIM_INFINITY, RLIM_INFINITY };
> > -
> > -     setrlimit(RLIMIT_MEMLOCK, &rinf);
> > -}
> > -
> >  static struct bpf_counter *bpf_counter_alloc(void)
> >  {
> >       struct bpf_counter *counter;
> > @@ -297,33 +286,6 @@ struct bpf_counter_ops bpf_program_profiler_ops = {
> >       .install_pe = bpf_program_profiler__install_pe,
> >  };
> >
> > -static __u32 bpf_link_get_id(int fd)
> > -{
> > -     struct bpf_link_info link_info = {0};
>
> Moving this from bpf_counter.c to the header made this code be compiled
> in places where it wasn't before, as bpf_counter.c is built only when:
>
> perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
>
> For instance, this got broken:
>
>   23    33.62 debian:9                      : FAIL clang version 3.8.1-24 (tags/RELEASE_381/final)
>     In file included from builtin-stat.c:71:
>     /git/perf-5.13.0/tools/perf/util/bpf_counter.h:92:37: error: missing field 'id' initializer [-Werror,-Wmissing-field-initializers]
>             struct bpf_link_info link_info = {0};
>                                                ^
>     /git/perf-5.13.0/tools/perf/util/bpf_counter.h:101:37: error: missing field 'id' initializer [-Werror,-Wmissing-field-initializers]
>             struct bpf_link_info link_info = {0};
>                                                ^
>     /git/perf-5.13.0/tools/perf/util/bpf_counter.h:110:35: error: missing field 'id' initializer [-Werror,-Wmissing-field-initializers]
>             struct bpf_map_info map_info = {0};
>
> ITs mostly older systems, but I'll fix it anyway.

Thanks a lot for fixing all the messes.
Assuming you're fixed the preparation patches.
I'll just update the last one next time.

Thanks,
Namhyung


>
> > -     __u32 link_info_len = sizeof(link_info);
> > -
> > -     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > -     return link_info.id;
> > -}
> > -
> > -static __u32 bpf_link_get_prog_id(int fd)
> > -{
> > -     struct bpf_link_info link_info = {0};
> > -     __u32 link_info_len = sizeof(link_info);
> > -
> > -     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > -     return link_info.prog_id;
> > -}
> > -
> > -static __u32 bpf_map_get_id(int fd)
> > -{
> > -     struct bpf_map_info map_info = {0};
> > -     __u32 map_info_len = sizeof(map_info);
> > -
> > -     bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> > -     return map_info.id;
> > -}
> > -
> >  static bool bperf_attr_map_compatible(int attr_map_fd)
> >  {
> >       struct bpf_map_info map_info = {0};
> > @@ -385,20 +347,6 @@ static int bperf_lock_attr_map(struct target *target)
> >       return map_fd;
> >  }
> >
> > -/* trigger the leader program on a cpu */
> > -static int bperf_trigger_reading(int prog_fd, int cpu)
> > -{
> > -     DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> > -                         .ctx_in = NULL,
> > -                         .ctx_size_in = 0,
> > -                         .flags = BPF_F_TEST_RUN_ON_CPU,
> > -                         .cpu = cpu,
> > -                         .retval = 0,
> > -             );
> > -
> > -     return bpf_prog_test_run_opts(prog_fd, &opts);
> > -}
> > -
> >  static int bperf_check_target(struct evsel *evsel,
> >                             struct target *target,
> >                             enum bperf_filter_type *filter_type,
> > diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
> > index d6d907c3dcf9..185555a9c1db 100644
> > --- a/tools/perf/util/bpf_counter.h
> > +++ b/tools/perf/util/bpf_counter.h
> > @@ -3,6 +3,10 @@
> >  #define __PERF_BPF_COUNTER_H 1
> >
> >  #include <linux/list.h>
> > +#include <sys/resource.h>
> > +#include <bpf/bpf.h>
> > +#include <bpf/btf.h>
> > +#include <bpf/libbpf.h>
> >
> >  struct evsel;
> >  struct target;
> > @@ -76,4 +80,52 @@ static inline int bpf_counter__install_pe(struct evsel *evsel __maybe_unused,
> >
> >  #endif /* HAVE_BPF_SKEL */
> >
> > +static inline void set_max_rlimit(void)
> > +{
> > +     struct rlimit rinf = { RLIM_INFINITY, RLIM_INFINITY };
> > +
> > +     setrlimit(RLIMIT_MEMLOCK, &rinf);
> > +}
> > +
> > +static inline __u32 bpf_link_get_id(int fd)
> > +{
> > +     struct bpf_link_info link_info = {0};
> > +     __u32 link_info_len = sizeof(link_info);
> > +
> > +     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > +     return link_info.id;
> > +}
> > +
> > +static inline __u32 bpf_link_get_prog_id(int fd)
> > +{
> > +     struct bpf_link_info link_info = {0};
> > +     __u32 link_info_len = sizeof(link_info);
> > +
> > +     bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
> > +     return link_info.prog_id;
> > +}
> > +
> > +static inline __u32 bpf_map_get_id(int fd)
> > +{
> > +     struct bpf_map_info map_info = {0};
> > +     __u32 map_info_len = sizeof(map_info);
> > +
> > +     bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> > +     return map_info.id;
> > +}
> > +
> > +/* trigger the leader program on a cpu */
> > +static inline int bperf_trigger_reading(int prog_fd, int cpu)
> > +{
> > +     DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
> > +                         .ctx_in = NULL,
> > +                         .ctx_size_in = 0,
> > +                         .flags = BPF_F_TEST_RUN_ON_CPU,
> > +                         .cpu = cpu,
> > +                         .retval = 0,
> > +             );
> > +
> > +     return bpf_prog_test_run_opts(prog_fd, &opts);
> > +}
> > +
> >  #endif /* __PERF_BPF_COUNTER_H */
> > --
> > 2.32.0.93.g670b81a890-goog
> >
>
> --
>
> - Arnaldo
