Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC05394712
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhE1SfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhE1SfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:35:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D693C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:33:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n2so4262878wrm.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXu/cY1gGv2Wn1ajEnYj9SqMQ0t/TGuBi8LefYvM9Os=;
        b=TFy/0qHR56Mqoi4QCYcIUqRrFcC4OfaZIl8pJnIaQ1D9n86aOiHpWvVa9tlcY5DQo4
         OyGAd/aL9E+w8rc6+xUlr2zej0kzx7Ih3/DQKBZ2BAf6VsMjIluRkrCpPPoCMJJy4HZE
         rBRlPNzyyHWLPDMEsHiYLNJm4OmW4+wUbtfRC6DGRBuw/FDJAaC+QL77kHI9QnH7TCBZ
         zXTHoT9Kg1QHjRvQMc/SHsb6HW1JhyYA+0c7tAUWmvdFDqG9aatruxmhKvauyCRG+ljc
         wBd9yWR+Xn5tv5Mv/XSD+qZtaEi/oN2MafMWBFBA8bh9Atb8e6pvtAy6Vte6/oobQp37
         i9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXu/cY1gGv2Wn1ajEnYj9SqMQ0t/TGuBi8LefYvM9Os=;
        b=lLQlVaecl/PwmPDeNehYKMiVGBrUf2Peuy0iyhulBxYFfXUuEW3gJbI0VSHDwN/tV8
         W3vktRbHy1+6saIJu1ewL2LysiNSpuPiI9CE7Z0KIoUDsST2VF7Uhxo8JeQ10nlDLzpX
         flTWQKJggRBYSPck0wUUYrUsVXYSpj5lDtJydzWDvNK73MQozjhmQf67lCTvIv/BnvE4
         beYytcyMxTkTuSLDRTjx126FUfOwwnMP6BGdnHmlysT43OYSmZoGSHwnScPGDoeiKYqF
         VdUK5XuO74ewF+D1QxwOB1mEUVcMApN3uLAVMp6bAbmrduSfCwTfj+3m34sZV3w/ev8P
         bxEw==
X-Gm-Message-State: AOAM530WkG+TGsA6mdxx5CawBY+pW8Cbu6e9EBW7h2L/RPIZr1v681qP
        RVfPEaSUC7clEaUU2DuUrBgUjPcXR4W1J1RBMKOUew==
X-Google-Smtp-Source: ABdhPJycLMNeDS6cKxpYu+G9ucBc5+PBrKMdT8a1Q/Hf2nzK6IL3Ya5BLn7h8BuDOviUGjmQkCK3lxhH0U8FYvnffiY=
X-Received: by 2002:a05:6000:1b8f:: with SMTP id r15mr9837463wru.119.1622226816011;
 Fri, 28 May 2021 11:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210528091050.245838-1-tmricht@linux.ibm.com>
In-Reply-To: <20210528091050.245838-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 May 2021 11:33:23 -0700
Message-ID: <CAP-5=fVv--BXLcSpfenfOG=sEPNGqWhBisNmpUkEO29d_Q7uTw@mail.gmail.com>
Subject: Re: [PATCH V2][Ping] perf test: Test 17 fails with make LIBPFM4=1 on
 s390 z/VM
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        svens@linux.ibm.com, Vasily Gorbik <gor@linux.ibm.com>,
        sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 2:11 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>
> Version 2:
>    As suggested by Ian Rogers make perf_event_attribute member
>    exclude_hv more robust and accept value 0 or 1 to handle more
>    test cases which might fail on s390 virtual machine z/VM.
>
> This test case fails on s390 virtual machine z/VM which has no PMU support
> when the perf tool is built with LIBPFM4=1.
>
> Using make LIBPFM4=1 builds the perf tool with support for libpfm
> event notation. The command line flag --pfm-events is valid:
>  # ./perf record --pfm-events cycles -- true
>  [ perf record: Woken up 1 times to write data ]
>  [ perf record: Captured and wrote 0.001 MB perf.data (2 samples) ]
>  #
>
> However the command 'perf test -Fv 17' fails on s390 z/VM virtual machine
> with LIBPFM4=1:
>   # perf test -Fv 17
>   17: Setup struct perf_event_attr                                    :
>   --- start ---
>   .....
>   running './tests/attr/test-record-group2'
>   unsupp  './tests/attr/test-record-group2'
>   running './tests/attr/test-record-pfm-period'
>   expected exclude_hv=0, got 1
>  FAILED './tests/attr/test-record-pfm-period' - match failure
>  ---- end ----
>  Setup struct perf_event_attr: FAILED!
>
> When --pfm-event system is not supported, the test returns unsupported
> and continues. Here is an example using a virtual machine on x86 and
> Fedora 34:
>  [root@f33 perf]# perf test -Fv 17
>  17: Setup struct perf_event_attr                                    :
>  --- start ---
>  .....
>  running './tests/attr/test-record-group2'
>  unsupp  './tests/attr/test-record-group2'
>  running './tests/attr/test-record-pfm-period'
>  unsupp  './tests/attr/test-record-pfm-period'
>  ....
>
> The issue is file ./tests/attr/test-record-pfm-period
> which requires perf event attribute member exclude_hv to be zero.
> This is not the case on s390 where the value of exclude_hv is one when
> executing on a z/VM virtual machine without PMU hardware support.
>
> Fix this by allowing value exlucde_hv to be zero or one.
>
> Output before:
>  # /usr/bin/python ./tests/attr.py -d ./tests/attr/ -t \
>         test-record-pfm-period -p ./perf  -vvv 2>&1| fgrep match
>     matching [event:base-record]
>     match: [event:base-record] matches []
>  FAILED './tests/attr//test-record-pfm-period' - match failure
>  #
>
> Output after:
>  # /usr/bin/python ./tests/attr.py -d ./tests/attr/ -t \
>         test-record-pfm-period -p ./perf  -vvv 2>&1| fgrep match
>     matching [event:base-record]
>     match: [event:base-record] matches ['event-1-0-6', 'event-1-0-5']
>   matched
>
> Background:
> Using libpfm library ends up in this function call sequence
>
> pfm_get_perf_event_encoding()
> +-- pfm_get_os_event_encoding()
>     +-- pfmlib_perf_event_encode()
>
> is called when no hardware specific PMU unit can be detected
> as in the s390 z/VM virtual machine case. This uses the
> "perf_events generic PMU" data structure which sets exclude_hv
> to 1 per default.  Using this PMU that test case always fails.
>
> That is the reason why exclude_hv attribute setting varies.
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Ian Rogers <irogers@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Tested on x86 with and without hypervisor and test still passes. This
would be expected as the change is making a flag more permissive. As
we don't care about this flag in existing tests I believe there's no
impact to this change other than fixing the tests on s390.

Thanks,
Ian

> ---
>  tools/perf/tests/attr/base-record | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
> index 4a7b8deef3fd..8c10955eff93 100644
> --- a/tools/perf/tests/attr/base-record
> +++ b/tools/perf/tests/attr/base-record
> @@ -16,7 +16,7 @@ pinned=0
>  exclusive=0
>  exclude_user=0
>  exclude_kernel=0|1
> -exclude_hv=0
> +exclude_hv=0|1
>  exclude_idle=0
>  mmap=1
>  comm=1
> --
> 2.31.1
>
