Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5424A457A54
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 02:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhKTBJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 20:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhKTBJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 20:09:41 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 17:06:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t30so20927862wra.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 17:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2ZXwgD1avbUpsT9LjlrOqzyHiYDFqKfLtdB7fg+tq1Y=;
        b=YupP1qbI4oqzV9w3OGrmhhqRzltSayxjdQgEprIt/s+4EErLRxYoTVeBWNtchpEemN
         jZiss7xLvo1csVX3P1Ps4R2N7hE5sRSjwc2hTrK2WgxtbfN0YjXNWph1+qa+7QZfl+gk
         61gtLzF+7jMRcu/jPJc3NLwUwNUGO1p3+m7cmcHEHQNalP4Qn+gUdF/0Mxi9wmsl17A7
         b1efSq8RcRmGND4sFjj79/BJktK5g0YnYePkMRVZDRuq6uTPWNZz9ox7pTCHnr8L0BjK
         dMOY8xSIzAaMfkKwI8D4CN+2bBFQQi90FtFFu2W8+bBm1No5A8YEElVlWBTOtMnNZacx
         1fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2ZXwgD1avbUpsT9LjlrOqzyHiYDFqKfLtdB7fg+tq1Y=;
        b=Lx98IjKxKju1OTkUGKwRaXuDy7n2hqKqvwhjQLVxo0VuV10u8Wei1v8MfP6wl9/XRj
         7/TLhyvNIsYHaNPS52tNxK9KyYsdCo7nmWCtKnBzeSWU4OV8zj0mZ3/whcrrpS98FenK
         NZZM72oo3ZV9/HD/WPbIG19M6LwheR8ppeE0eChSIsAYuILjH7vZRp19P4sG7ZWqKWma
         O0Jp+9Q2L196kVnTO1SXdcDmujijncNX6z2J/OqDCegTRX3MFkjjhalXv4q+pF4oaoqb
         jF0l8JcCas5EwVKej5ph79bEP5a3BG3YXBpMzTD0lNpJhsn3DScrvQbzHJHqfvn7PvRu
         4Lxw==
X-Gm-Message-State: AOAM532CwQ3IxHsmoQg7aZnUUX0lJwv+ZObKLtJBqTQwL+cYUknbNZoe
        pti2U5m1tGHfAc4sH8hrVoo=
X-Google-Smtp-Source: ABdhPJyNqOnsnd35KafVcArOd73okFQ/SgXw4ZGiAll1kqApkUhJ3/ynNeCodA/CGza3xTY5B9xhfQ==
X-Received: by 2002:a5d:6347:: with SMTP id b7mr12653321wrw.36.1637370395972;
        Fri, 19 Nov 2021 17:06:35 -0800 (PST)
Received: from pc ([197.49.250.127])
        by smtp.gmail.com with ESMTPSA id b11sm13499048wmj.35.2021.11.19.17.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 17:06:35 -0800 (PST)
Date:   Sat, 20 Nov 2021 03:06:33 +0200
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 'perf stat --bpf-counters test' failures
Message-ID: <20211120010633.mdbpjfouowhw35oa@pc>
References: <YZeYX305gA0ut9N8@kernel.org>
 <YZev7KClb/ud43Lc@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZev7KClb/ud43Lc@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jiri

On Fri, Nov 19, 2021 at 03:08:44PM +0100, Jiri Olsa wrote:
> On Fri, Nov 19, 2021 at 09:28:15AM -0300, Arnaldo Carvalho de Melo wrote:
> >
> > After I updated to fedora 35 I started seeing the errors below,
> > it may well not be related to that, maybe something on libbpf, haven't
> > investigated, have you seen this?
>
> yep, it seems the perf bench is broken so the counts won't correlated
> if I revert this one:
>   92723ea0f11d perf bench: Fix two memory leaks detected with ASan
>
> it works for me again.. it seems to break -t option
>
> Sohaib, could you please check on that?
>
> 	[root@dell-r440-01 perf]# ./perf bench sched messaging -g 1 -l 100 -t
> 	# Running 'sched/messaging' benchmark:
> 	RRRperf: CLIENT: ready write: Bad file descriptor
> 	Rperf: SENDER: write: Bad file descriptor
>

It seems that this patch fixes this:
$ perf bench sched all
and break:
$ perf bench sched messaging -g 1 -l 100 -t

I'll try to fix this now, apologies

Thanks,
- Sohaib

> thanks,
> jirka
>
> >
> > ⬢[acme@toolbox perf]$ perf -vv
> > perf version 5.16.rc1.gfa2b5229b222
> >                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> >     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> >                  glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
> >          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> >                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
> >                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> >                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> >                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
> >              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> >               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> >              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> >              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> >     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> >                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> >                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> >              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> >                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> >                    aio: [ on  ]  # HAVE_AIO_SUPPORT
> >                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> >                libpfm4: [ OFF ]  # HAVE_LIBPFM
> > ⬢[acme@toolbox perf]$
> >
> > This is with what I have now in my perf/urgent branch, the csets there
> > aren't related:
> >
> > ⬢[acme@toolbox perf]$ git log --oneline torvalds/master..
> > b194c9cd09dd98af (HEAD -> perf/urgent, quaco/perf/urgent, acme/tmp.perf/urgent, acme/perf/urgent) perf evsel: Fix memory leaks relating to unit
> > d9fc706108c15f8b perf report: Fix memory leaks around perf_tip()
> > 0ca1f534a776cc7d perf hist: Fix memory leak of a perf_hpp_fmt
> > 8b8dcc3720d57d88 tools headers UAPI: Sync MIPS syscall table file changed by new futex_waitv syscall
> > e8c04ea0fef5731d tools build: Fix removal of feature-sync-compare-and-swap feature detection
> > 9e1a8d9f683260d5 perf inject: Fix ARM SPE handling
> > 92723ea0f11d9249 perf bench: Fix two memory leaks detected with ASan
> > cb5a63feae2d963c perf test sample-parsing: Fix branch_stack entry endianness check
> > 162b944598344fd7 tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
> > db4b284029099224 perf sort: Fix the 'p_stage_cyc' sort key behavior
> > 4d03c75363eeca86 perf sort: Fix the 'ins_lat' sort key behavior
> > 784e8adda4cdb3e2 perf sort: Fix the 'weight' sort key behavior
> > 70f9c9b2df1dd12c perf tools: Set COMPAT_NEED_REALLOCARRAY for CONFIG_AUXTRACE=1
> > ccb05590c4325ce5 perf tests wp: Remove unused functions on s390
> > 346e91998cba46b6 tools headers UAPI: Sync linux/kvm.h with the kernel sources
> > b075c1d81e7d0e96 tools headers cpufeatures: Sync with the kernel sources
> > ⬢[acme@toolbox perf]$
> >
> > - Arnaldo
> >
> > [acme@quaco perf]$ uname -a
> > Linux quaco 5.14.17-301.fc35.x86_64 #1 SMP Mon Nov 8 13:57:43 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> >
> > 91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRR FAILED!
> > 92: Check Arm CoreSight trace data recording and synthesized samples: Skip
> > 93: Check Arm SPE trace data recording and synthesized samples      : Skip
> > 94: Check open filename arg using perf trace + vfs_getname          : Ok
> > [root@quaco ~]# perf test 91
> > 91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRR FAILED!
> > [root@quaco ~]# perf test 91
> > 91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRR FAILED!
> > [root@quaco ~]# perf test 91
> > 91: perf stat --bpf-counters test                                   :RRRRRRRRRRRR FAILED!
> > [root@quaco ~]# perf test 91
> > 91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRRRRRRR Ok
> > [root@quaco ~]# perf test 91
> > 91: perf stat --bpf-counters test                                   :RRRRRRRRR FAILED!
> > [root@quaco ~]# perf test 91
> > 91: perf stat --bpf-counters test                                   :RRRRRRRRRRR Ok
> > [root@quaco ~]# perf test 91
> > 91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRRRR Ok
> > [root@quaco ~]# uname -a
> > Linux quaco 5.14.17-301.fc35.x86_64 #1 SMP Mon Nov 8 13:57:43 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> > [root@quaco ~]# set -o vi
> > [root@quaco ~]# perf test -v 91
> > 91: perf stat --bpf-counters test                                   :
> > --- start ---
> > test child forked, pid 30079
> > RRRRRRRRRRRRRRRRRThe difference between 31599305 and 36265639 are greater than 10%.
> > test child finished with -1
> > ---- end ----
> > perf stat --bpf-counters test: FAILED!
> > [root@quaco ~]# perf test -v 91
> > 91: perf stat --bpf-counters test                                   :
> > --- start ---
> > test child forked, pid 30170
> > RRRRRRRRRRRRRRRRRRRRRRRRThe difference between 33311934 and 36973889 are greater than 10%.
> > test child finished with -1
> > ---- end ----
> > perf stat --bpf-counters test: FAILED!
> > [root@quaco ~]# perf test -v 91
> > 91: perf stat --bpf-counters test                                   :
> > --- start ---
> > test child forked, pid 30257
> > RRRRRRRRRRRRRRRRRThe difference between 31420157 and 36680527 are greater than 10%.
> > test child finished with -1
> > ---- end ----
> > perf stat --bpf-counters test: FAILED!
> > [root@quaco ~]# perf test -v 91
> > 91: perf stat --bpf-counters test                                   :
> > --- start ---
> > test child forked, pid 30341
> > RRRRRRRRRRRRRRRRRRRThe difference between 32451720 and 36750342 are greater than 10%.
> > test child finished with -1
> > ---- end ----
> > perf stat --bpf-counters test: FAILED!
> > [root@quaco ~]# perf test -v 91
> > 91: perf stat --bpf-counters test                                   :
> > --- start ---
> > test child forked, pid 30433
> > RRRRRRRRRRRRRRRRRRtest child finished with 0
> > ---- end ----
> > perf stat --bpf-counters test: Ok
> > [root@quaco ~]#
> >
>
