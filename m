Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8AA342578
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhCSS4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230473AbhCSSzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616180142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8xhqBj1C2kdr5sJYwc/42X0mlsjXH69Z0Bc0cRPniHE=;
        b=f6Ndekpty7CKF/gGvgCH1qE+xDYdLaepG/xts7QxXcWvJ61iGZ96Y3Uv9OqCUf94kxdEuM
        f4CnAdsQ7lfFIZZb6hi00ZSFxImUnuXmYZyZ02PcQ/balHH5KxYuTcNESRIUvjUSTQ2DV1
        MZv/p2K+9/+QM/XXx2Aar8GrcQvbQ6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-wgDJ3bvsNqumYSfWz2EF5A-1; Fri, 19 Mar 2021 14:55:39 -0400
X-MC-Unique: wgDJ3bvsNqumYSfWz2EF5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9086981746A;
        Fri, 19 Mar 2021 18:55:37 +0000 (UTC)
Received: from krava (unknown [10.40.195.94])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0A9A4610F3;
        Fri, 19 Mar 2021 18:55:35 +0000 (UTC)
Date:   Fri, 19 Mar 2021 19:55:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, acme@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH v2 1/3] perf-stat: introduce bperf, share hardware PMCs
 with BPF
Message-ID: <YFTzp9CA2/il8p77@krava>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <20210316211837.910506-2-songliubraving@fb.com>
 <YFPC4UbLWzTuzyER@krava>
 <YFTwdWxUvqHDNe1x@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFTwdWxUvqHDNe1x@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 03:41:57PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

>   LD       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf-in.o
>   LINK     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/libbpf.a
>   LINK     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/bpftool
>   GEN-SKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
>   GEN-SKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
>   GEN-SKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
> libbpf: map 'prev_readings': unexpected def kind var.
> Error: failed to open BPF object file: Invalid argument
> libbpf: map 'diff_readings': unexpected def kind var.
> Error: failed to open BPF object file: Invalid argument

I'm getting clean build for the same options,
could you please send the same output also with 'JOBS=1 V=1'


> make[2]: *** [Makefile.perf:1029: /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h] Error 255
> make[2]: *** Waiting for unfinished jobs....
> make[2]: *** [Makefile.perf:1029: /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h] Error 255
> make[1]: *** [Makefile.perf:236: sub-make] Error 2
> make: *** [Makefile:110: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf/tools/perf'
> [acme@quaco perf]$ clang -v
> clang version 11.0.0 (https://github.com/llvm/llvm-project 67420f1b0e9c673ee638f2680fa83f468019004f)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/local/bin
> Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> Selected GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> Candidate multilib: .;@m64
> Candidate multilib: 32;@m32
> Selected multilib: .;@m64
> [acme@quaco perf]$
> 

I have:

[jolsa@dell-r440-01 linux-perf]$ clang --version
clang version 11.0.0 (Fedora 11.0.0-2.fc33)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/bin


jirka

