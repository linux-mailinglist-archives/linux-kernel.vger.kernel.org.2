Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72943CCAFE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 23:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhGRVlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 17:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229585AbhGRVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 17:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626644333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nz9cNBx4UtlZfvFfqSm6do/zQBCo2j4uVMGUW1R679g=;
        b=LB+5Va6qzIG5/wl8ntKRLnbm8B+p5o8VrdbBKxZncbcUjlIak/4eOMA59ncOd06dlv+VJZ
        VGtKdrjeJEWF7/UYQWgCiCXUCLt04/Hv6eiYm33RO6DNDSrBVYsEcPYXRoZae/oqRFyzcO
        yAET371fJHTsczbj9O3Hgg1CVCiJP9c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-W_opu45VMOaAMmnWpCZhQg-1; Sun, 18 Jul 2021 17:38:52 -0400
X-MC-Unique: W_opu45VMOaAMmnWpCZhQg-1
Received: by mail-ed1-f71.google.com with SMTP id j25-20020aa7ca590000b029039c88110440so8137500edt.15
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 14:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nz9cNBx4UtlZfvFfqSm6do/zQBCo2j4uVMGUW1R679g=;
        b=PmLQB/3OzyIB/SpZCh08YEZB5v1fKAjXy14dWsM16K0tU4y76QOEOI9fI8W+1SGbbj
         Rgxvn3S8vnDW0q5vkOdtjwObYGPuoDiKpyE8ts6fAvZRhsJ3RKKVWyCuu3FCxQgwhHHS
         TuHlRjYDs9XPHZ3PmFMFhO9uHIrRc1M5Eflvt7TpcBy0hh1HRgMWBS+gpxeQRMHxoec2
         w6YlAAgyjLDFgnFPncbbtxixFu4DS4+8/1zXCIfDg1F8SwcqluO/6t2WT4k5dD4LXrtJ
         8HSnJxkHJcN5vhCEALYwwawGHnFuCgBFowvgtWPsFMBpepufXh3pko6XuobzjFju3n3t
         3VSQ==
X-Gm-Message-State: AOAM5318CyoTIuUUNTiTsh5bYakbbG3LhRzosH8dCPqfxvr5OrqTK8YZ
        9b5FoGVxLko3pQOn/fdUbONgboa9bZLBlacfCxwQacolno99yypWy3oIXreGZ0BPXey67aB7d1A
        8Zx7ZVxPnRJtUjp86f6kN69U6
X-Received: by 2002:a17:906:2413:: with SMTP id z19mr23597278eja.215.1626644331160;
        Sun, 18 Jul 2021 14:38:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7zkhkkZRZXNpDYwwvWeWx3H7pm74wCBeAjh7MXrzXScdlOgPnEzHp511dcNNPZjAuVf4QWA==
X-Received: by 2002:a17:906:2413:: with SMTP id z19mr23597265eja.215.1626644330952;
        Sun, 18 Jul 2021 14:38:50 -0700 (PDT)
Received: from krava ([83.240.60.59])
        by smtp.gmail.com with ESMTPSA id j22sm5133213eje.123.2021.07.18.14.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:38:50 -0700 (PDT)
Date:   Sun, 18 Jul 2021 23:38:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 5/5] perf tools: Add pipe_test.sh to verify pipe
 operations
Message-ID: <YPSfaEIKydevKLpi@krava>
References: <20210714003442.1111502-1-namhyung@kernel.org>
 <20210714003442.1111502-6-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714003442.1111502-6-namhyung@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 05:34:42PM -0700, Namhyung Kim wrote:

SNIP

> diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
> new file mode 100755
> index 000000000000..b6a89c6896c3
> --- /dev/null
> +++ b/tools/perf/tests/shell/pipe_test.sh
> @@ -0,0 +1,69 @@
> +#!/bin/sh
> +# perf pipe recording and injection test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# skip if there's no compiler
> +if ! [ -x "$(command -v cc)" ]; then
> +	echo "failed: no compiler, install gcc"
> +	exit 2
> +fi
> +
> +file=$(mktemp /tmp/test.file.XXXXXX)
> +data=$(mktemp /tmp/perf.data.XXXXXX)
> +
> +cat <<EOF | cc -o ${file} -x c -
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +volatile int done;
> +
> +void sigalrm(int sig) {
> +	done = 1;
> +}
> +
> +__attribute__((noinline)) void noploop(void) {
> +	while (!done)
> +		continue;
> +}
> +
> +int main(int argc, char *argv[]) {
> +	int sec = 1;
> +
> +	if (argc > 1)
> +		sec = atoi(argv[1]);
> +
> +	signal(SIGALRM, sigalrm);
> +	alarm(sec);
> +
> +	noploop();
> +	return 0;
> +}
> +EOF
> +
> +
> +if ! perf record -e cycles:u -o - ${file} | perf report -i - --task | grep test.file; then

hi,
cycles:u will fail in virtual machine, could you use
cpu-clock instead or skip the test?

jirka

> +	echo "cannot find the test file in the perf report"
> +	exit 1
> +fi
> +
> +if ! perf record -e cycles:u -o - ${file} | perf inject -b | perf report -i - | grep noploop; then
> +	echo "cannot find noploop function in pipe #1"
> +	exit 1
> +fi
> +
> +perf record -e cycles:u -o - ${file} | perf inject -b -o ${data}
> +if ! perf report -i ${data} | grep noploop; then
> +	echo "cannot find noploop function in pipe #2"
> +	exit 1
> +fi
> +
> +perf record -e cycles:u -o ${data} ${file}
> +if ! perf inject -b -i ${data} | perf report -i - | grep noploop; then
> +	echo "cannot find noploop function in pipe #3"
> +	exit 1
> +fi
> +
> +
> +rm -f ${file} ${data} ${data}.old
> +exit 0
> -- 
> 2.32.0.93.g670b81a890-goog
> 

