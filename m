Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4253457050
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhKSOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:11:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229879AbhKSOLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637330929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jN4WjOAkWoUtiKPZNQoaUJG8avVgmC/Le66zQC7VoVM=;
        b=Zg3H8pIztwHyelH88IQ85apSWckcvPeVlmRdYTmhJ7T/uZf18Gza1HsoaYE2feY3TT++VU
        0xtAmLBsItqnehpLXd6UQQoa95MSfioi1ZjjiAwDRNsZ9TvXTJc7neyUjhVLXb0BjXgrlU
        w1LMc6aIbdVesWX6N3Ag0DhtQ1G+mGM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-EG0xHOs0NpCQnFi7czoBrQ-1; Fri, 19 Nov 2021 09:08:47 -0500
X-MC-Unique: EG0xHOs0NpCQnFi7czoBrQ-1
Received: by mail-ed1-f71.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso8519750edj.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jN4WjOAkWoUtiKPZNQoaUJG8avVgmC/Le66zQC7VoVM=;
        b=AZC4XSesOWHF1xnCLYUo4dGzKnUZ6BzEW8zj6+v/30TFagqTXyNt06et6NBbd6quWV
         pqCryx59898LclLWbLM/vXvJBrZEkcGk76pm4KikIjnPiovHzl0krJl3mH0tKTDikGae
         W7i1NwtorMcJLSnGDhodkVPzTEOyMnfKOz0PwPMgiDae1Fs6MiPx8E0+jrXRfCKISCRL
         5iw17xPeoFDu7hM47IWJ7G9FPgs8SV3rv9Zd3k5WM3pvnqXix1JK+4GqOJaxyXMZWxqp
         7GLI6755x3wm/i+JRi4Y1D0UP3lgKlwWVbfuO4oU8uJA8BfjtbwY6nObjS/pljocrxU+
         lDSg==
X-Gm-Message-State: AOAM530H83x3IyUk1dZc5wYuubhtTE4IbDgAq/a3vpxnJXe0iYo0JDn6
        ePrTT69y2CNaZHi22dY8IoT+AEUoaGa2OLHpqnviPzZkvZaFvzymL3M8Wlj+7MdVKxcUqgLSRN5
        F5S+psWs2GVw+gvX2nkeWKPNZ
X-Received: by 2002:a05:6402:1d52:: with SMTP id dz18mr614079edb.285.1637330926393;
        Fri, 19 Nov 2021 06:08:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBBDJqXXbkTVKaY1hTFb+riWuY9Gq0S04kV0V25hqYzTj3o1w2ICeUTTcTTFdU3c8meCEo5w==
X-Received: by 2002:a05:6402:1d52:: with SMTP id dz18mr614043edb.285.1637330926170;
        Fri, 19 Nov 2021 06:08:46 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id y17sm1702342edd.31.2021.11.19.06.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 06:08:45 -0800 (PST)
Date:   Fri, 19 Nov 2021 15:08:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 'perf stat --bpf-counters test' failures
Message-ID: <YZev7KClb/ud43Lc@krava>
References: <YZeYX305gA0ut9N8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZeYX305gA0ut9N8@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 09:28:15AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> After I updated to fedora 35 I started seeing the errors below,
> it may well not be related to that, maybe something on libbpf, haven't
> investigated, have you seen this?

yep, it seems the perf bench is broken so the counts won't correlated
if I revert this one:
  92723ea0f11d perf bench: Fix two memory leaks detected with ASan

it works for me again.. it seems to break -t option

Sohaib, could you please check on that?

	[root@dell-r440-01 perf]# ./perf bench sched messaging -g 1 -l 100 -t
	# Running 'sched/messaging' benchmark:
	RRRperf: CLIENT: ready write: Bad file descriptor
	Rperf: SENDER: write: Bad file descriptor

thanks,
jirka

> 
> ⬢[acme@toolbox perf]$ perf -vv
> perf version 5.16.rc1.gfa2b5229b222
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>                  glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                libpfm4: [ OFF ]  # HAVE_LIBPFM
> ⬢[acme@toolbox perf]$
> 
> This is with what I have now in my perf/urgent branch, the csets there
> aren't related:
> 
> ⬢[acme@toolbox perf]$ git log --oneline torvalds/master..
> b194c9cd09dd98af (HEAD -> perf/urgent, quaco/perf/urgent, acme/tmp.perf/urgent, acme/perf/urgent) perf evsel: Fix memory leaks relating to unit
> d9fc706108c15f8b perf report: Fix memory leaks around perf_tip()
> 0ca1f534a776cc7d perf hist: Fix memory leak of a perf_hpp_fmt
> 8b8dcc3720d57d88 tools headers UAPI: Sync MIPS syscall table file changed by new futex_waitv syscall
> e8c04ea0fef5731d tools build: Fix removal of feature-sync-compare-and-swap feature detection
> 9e1a8d9f683260d5 perf inject: Fix ARM SPE handling
> 92723ea0f11d9249 perf bench: Fix two memory leaks detected with ASan
> cb5a63feae2d963c perf test sample-parsing: Fix branch_stack entry endianness check
> 162b944598344fd7 tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
> db4b284029099224 perf sort: Fix the 'p_stage_cyc' sort key behavior
> 4d03c75363eeca86 perf sort: Fix the 'ins_lat' sort key behavior
> 784e8adda4cdb3e2 perf sort: Fix the 'weight' sort key behavior
> 70f9c9b2df1dd12c perf tools: Set COMPAT_NEED_REALLOCARRAY for CONFIG_AUXTRACE=1
> ccb05590c4325ce5 perf tests wp: Remove unused functions on s390
> 346e91998cba46b6 tools headers UAPI: Sync linux/kvm.h with the kernel sources
> b075c1d81e7d0e96 tools headers cpufeatures: Sync with the kernel sources
> ⬢[acme@toolbox perf]$
> 
> - Arnaldo
> 
> [acme@quaco perf]$ uname -a
> Linux quaco 5.14.17-301.fc35.x86_64 #1 SMP Mon Nov 8 13:57:43 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> 
> 91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRR FAILED!
> 92: Check Arm CoreSight trace data recording and synthesized samples: Skip
> 93: Check Arm SPE trace data recording and synthesized samples      : Skip
> 94: Check open filename arg using perf trace + vfs_getname          : Ok
> [root@quaco ~]# perf test 91
> 91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRR FAILED!
> [root@quaco ~]# perf test 91
> 91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRR FAILED!
> [root@quaco ~]# perf test 91
> 91: perf stat --bpf-counters test                                   :RRRRRRRRRRRR FAILED!
> [root@quaco ~]# perf test 91
> 91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRRRRRRR Ok
> [root@quaco ~]# perf test 91
> 91: perf stat --bpf-counters test                                   :RRRRRRRRR FAILED!
> [root@quaco ~]# perf test 91
> 91: perf stat --bpf-counters test                                   :RRRRRRRRRRR Ok
> [root@quaco ~]# perf test 91
> 91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRRRR Ok
> [root@quaco ~]# uname -a
> Linux quaco 5.14.17-301.fc35.x86_64 #1 SMP Mon Nov 8 13:57:43 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> [root@quaco ~]# set -o vi
> [root@quaco ~]# perf test -v 91
> 91: perf stat --bpf-counters test                                   :
> --- start ---
> test child forked, pid 30079
> RRRRRRRRRRRRRRRRRThe difference between 31599305 and 36265639 are greater than 10%.
> test child finished with -1
> ---- end ----
> perf stat --bpf-counters test: FAILED!
> [root@quaco ~]# perf test -v 91
> 91: perf stat --bpf-counters test                                   :
> --- start ---
> test child forked, pid 30170
> RRRRRRRRRRRRRRRRRRRRRRRRThe difference between 33311934 and 36973889 are greater than 10%.
> test child finished with -1
> ---- end ----
> perf stat --bpf-counters test: FAILED!
> [root@quaco ~]# perf test -v 91
> 91: perf stat --bpf-counters test                                   :
> --- start ---
> test child forked, pid 30257
> RRRRRRRRRRRRRRRRRThe difference between 31420157 and 36680527 are greater than 10%.
> test child finished with -1
> ---- end ----
> perf stat --bpf-counters test: FAILED!
> [root@quaco ~]# perf test -v 91
> 91: perf stat --bpf-counters test                                   :
> --- start ---
> test child forked, pid 30341
> RRRRRRRRRRRRRRRRRRRThe difference between 32451720 and 36750342 are greater than 10%.
> test child finished with -1
> ---- end ----
> perf stat --bpf-counters test: FAILED!
> [root@quaco ~]# perf test -v 91
> 91: perf stat --bpf-counters test                                   :
> --- start ---
> test child forked, pid 30433
> RRRRRRRRRRRRRRRRRRtest child finished with 0
> ---- end ----
> perf stat --bpf-counters test: Ok
> [root@quaco ~]#
> 

