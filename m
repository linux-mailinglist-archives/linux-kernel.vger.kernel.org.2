Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05563AFC66
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 07:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFVFHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 01:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhFVFHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 01:07:16 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829A7C061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 22:05:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n35-20020a05600c3ba3b02901cdecb6bda8so826801wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 22:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+g2cDm90CB3GlXD7F+2HbQDsSyNiPVE27GB4Qds/ug=;
        b=BEAaUNJAnZjXpADNwNtp/OzRi2QuPmhjcAA7gWJNcXYyq0hiAQM/51ioTWBN1IDH+T
         818GVC0M3gvI31oyVpQp2akGuW713pwRLm2gYB+GT+XVAdGyHLaMOQEO2WMJon5MqhRt
         5VVByLrFsy6p5HK5LS02fynzdzMAmza5Oc1A+tx8i2UNCxDhUNbTpxciShU26f4c9VmW
         IV5XzLWuuVdTPEzv5bXeTf9U01VJmsrEkC7Hw4VDbIOAoXa/I9GB7whopbTgrtzmamNh
         js5uP+lvSp7yNB3ti8rOtnCPHuthEtjWIG9Pstt+HoQCQWSwADZ2qZaUzVpEtKkVI207
         tkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+g2cDm90CB3GlXD7F+2HbQDsSyNiPVE27GB4Qds/ug=;
        b=Uwu4lBJ7QPbOw/MHb51KufiR8AsM61tq9iffxNAbU7fqLy+hhI/oA3YIkE31MGISUH
         j5N5Jc29Peem6UwkgKqfr/j3HB2xrhtkZpSAgCXobGTfrRcewKreqQGW0+gJA9kcj7nt
         cvVKDJdZyVs7SI5fy+X9RZuSpfoIDz1EuluHGegLROOJ0ZnZeF9jcrERFRDDCPO5h5jI
         pHcWdMwMO6aZ2ZmO1z2yb5Cft3j69mY+VWXg2IzM8cF6zGLfsnTvmjRnBUqD0RiybGol
         8m0s0Y1pz1SrPfXYyXrkl9aIuxswC4nnLrGuQ73MngzWD/HyqxJBhuaM1i7i5VoJIH1O
         C6hA==
X-Gm-Message-State: AOAM530HFOqeajVRrV/zl7JsblKb6Abcm9+KalXAm15PLwfksQgrUXBU
        w4RlwwEv5/W6sad92Ls8xt45kD2vjWDcl7hgei1OfQ==
X-Google-Smtp-Source: ABdhPJxhpbskY/B3s9xdO3sJObyiIErNXqD53Rx+6IKJQhC37ZkbhG4Qj6yv3Ij0RLRiTjGiYInsCay08uQJo+nu5KM=
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr2275123wmi.58.1624338298916;
 Mon, 21 Jun 2021 22:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <ecd941b3-2fd5-61d8-93a1-76a3a3ee4138@huawei.com>
In-Reply-To: <ecd941b3-2fd5-61d8-93a1-76a3a3ee4138@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 21 Jun 2021 22:04:46 -0700
Message-ID: <CAP-5=fUxQZ+rxLEn6jeRNVMf48BaPNdaUdoMs8LY4P-GROiOnw@mail.gmail.com>
Subject: Re: perf tool: About tests debug level
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 4:26 AM John Garry <john.garry@huawei.com> wrote:
>
> Hi guys,
>
> I noticed that when it was discovered recently that the new icelake JSON
> did not pass "PMU events" test, running the test with -v makes pr_err()
> and pr_debug() come out at the same level, so it's hard to distinguish
> the important logs.
>
> Here is a link:
> https://lore.kernel.org/lkml/YLdq%2FH8CXYgHWzCL@kernel.org/
>
> And here is an extract:
>
> parsing '(cpu_clk_unhalted.thread / cpu_clk_unhalted.ref_tsc) * msr@tsc@
> / 1000000000 / duration_time'
> parsing '( ( 1 * ( fp_arith_inst_retired.scalar_single +
> fp_arith_inst_retired.scalar_double ) + 2 *
> fp_arith_inst_retired.128b_packed_double + 4 * (
> fp_arith_inst_retired.128b_packed_single +
> fp_arith_inst_retired.256b_packed_double ) + 8 * (
> fp_arith_inst_retired.256b_packed_single +
> fp_arith_inst_retired.512b_packed_double ) + 16 *
> fp_arith_inst_retired.512b_packed_single ) / 1000000000 ) / duration_time'
> parsing 'cpu_clk_unhalted.thread / cpu_clk_unhalted.ref_tsc'
> parsing '1 - cpu_clk_unhalted.one_thread_active /
> cpu_clk_unhalted.ref_distributed'
> parsing 'cpu_clk_unhalted.thread:k / cpu_clk_unhalted.thread'
> parsing '( 64 * ( uncore_imc@cas_count_read@ +
> uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time'
> parsing '1000000000 * ( cha@event\=0x36\,umask\=0x21\,config\=0x40433@ /
> cha@event\=0x35\,umask\=0x21\,config\=0x40433@ ) / ( cha_0@event\=0x0@ /
> duration_time )'
> parsing 'cha@event\=0x36\,umask\=0x21\,config\=0x40433@ /
> cha@event\=0x36\,umask\=0x21\,config\=0x40433\,thresh\=1@'
> parsing '( 1000000000 * (
> cha@event\=0x36\,umask\=0x21\,config\=0x40433@_pmm /
> cha@event\=0x35\,umask\=0x21\,config\=0x40433@_pmm ) / cha_0@event\=0x0@
> )' [pr_debug]
> check_parse_fake failed [pr_err]
> test child finished with -1
> ---- end ----
>
> I annotated in [], above
>
> As for another issue, if you consider "Parse and process metrics", debug
> from core code comes out at same level as test code, e.g. with -v, we
> see pr_debug() from test code and core code. Again, this makes it hard
> to distinguish various levels. As an illustration, here I hack the code
> to fail a test:
>
> sudo ./perf test -v 68
> 68: Parse and process metrics                                       :
> --- start ---
> test child forked, pid 9747
> metric expr inst_retired.any / cpu_clk_unhalted.thread for IPC
> found event inst_retired.any verbose=1 pr_debug
> found event inst_retired.any verbose=1 pr_err
> found event cpu_clk_unhalted.thread verbose=1 pr_debug
> found event cpu_clk_unhalted.thread verbose=1 pr_err
> adding {inst_retired.any,cpu_clk_unhalted.thread}:W
> FAILED tests/parse-metric.c:223 IPC failed, wrong ratio
> FAILED tests/parse-metric.c:374 IPC failed
> test child finished with -1
> ---- end ----
> Parse and process metrics: FAILED!
>
> Note that the "FAILED" messages from the test code come from pr_debug().
>
> In a way, I feel that pr_debug()/err from the test is more important
> than pr_debug() from the core code (when running a test).
>
> Any opinion on this or how to improve (if anyone agrees with me)? Or am
> I missing something? Or is it not so important?

Hi John,

I think the issue is that in the parsing you don't know it's broken
until something goes wrong. Putting everything on pr_err would cause
spam in the not broken case. Improving the parsing error handling is a
big task with lex and yacc to some extent getting in the way. Perhaps
a middle way is to have a parameter to the parser that logs more, and
recursively call this in the parser when parsing fails. I guess there
is also a danger of a performance hit.

Thanks,
Ian

> Thanks,
> John
