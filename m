Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3033A38B2EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhETPWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhETPWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:22:47 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E72C061760
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:21:26 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id y2so23284978ybq.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hro9I3loiFQO7tPWR5EHbQ134jYdNaWCcDWr/ZKxd0=;
        b=qRMDUd1AXQTjN9du4gVoKHaXfUCh7NrxvD55AdymCSHEv6PAmW8pw0vThGNZM5QA6G
         wfSXPSwTc0vOoQRX5T9Ad3TskuHnGD2q4s3uMjagCE8Fxq3k7c+fFHsG/ampRx/l5XZn
         tD/mvhq7dv06+pU1QvJdzYCOGETTghkGD0wA4yYiE61s0V4nVz4SbxwLYub5By2RuyKe
         Akbu6Gb6hJAhX+So6IJStz4n4sz9Y7ct6WiaeE4eZRiUYhCi0XSnYaUT17JfyA1oZVF8
         r/rJjk8x6G1yz7we1MvUS5J1IXpV4ZYtmMb3UZR5aoMMTrXgoEFWo1/zG5RkGc9XHKNg
         oGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hro9I3loiFQO7tPWR5EHbQ134jYdNaWCcDWr/ZKxd0=;
        b=lkWmzzlkYzUtN2ixde4Ct6khjSHxc68nK2t+YklgylOugOgx0A5BZGwVJOKouFbrGC
         i3L5SGamVWXgL5imUb5tj+GnleyT8yjmVSh9VDawhDKlREP9Sqc1ItH2h3YU4V0wIfAc
         nXwR1KpwDtKdPObl7Usz4THyTOeKYSxARm9Ia+HAnK0dX2l6i1bSxBOh5WT1WHvtzPlu
         nE3LjGz3Ke+b1o12cIg+cN8e5f2fxeU8j1QPB7+rrfOlEp1VfhM7NTloDpfALOOa+Yvd
         5NL0Erxd0KhgoiY3OMgXoVwhqpIs+yRqRV7J8Ah9jXD7zskBYfcBhUtrh/PIEwZDVWYA
         dJEA==
X-Gm-Message-State: AOAM532+95Ke1ezaqel2DQs6zKfXRNQJCF/anavP6EQYOzSAgtuxfrQK
        iv6ibDz96jnCPgupXJvI/eOIpRl5vkbZKPKPPREfsA==
X-Google-Smtp-Source: ABdhPJwZ+XcD6fGqo+jL5v2obw/+Ww/uWPdsMnI+El5mBp83pjHELZBh+oWZmXIpIKmcbPg5R87RdIzn9+BdLg79Blo=
X-Received: by 2002:a5b:782:: with SMTP id b2mr7927623ybq.68.1621524085231;
 Thu, 20 May 2021 08:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210520135226.2335704-1-tmricht@linux.ibm.com>
In-Reply-To: <20210520135226.2335704-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 May 2021 08:21:12 -0700
Message-ID: <CAP-5=fV094Ga3T8G5UEBk_s-Y=ZUdVqn-o9386Mqrzg7ZiDTOA@mail.gmail.com>
Subject: Re: [PATCH][Ping] perf test: Test 17 fails with make LIBPFM4=1 on
 s390 z/VM
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        sumanth Korikkar <sumanthk@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>, svens@linux.ibm.com,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 6:52 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
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
>     matching [event-1-0-6]
>     match: [event-1-0-6] matches ['event:base-record']
>     matching [event-1-0-5]
>     match: [event-1-0-5] matches ['event:base-record']
>   matched
>  #
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
> "perf_events generic PMU" data structure which sets exclude_hv per default.
> Using this PMU that test case always fails.
>
> That is the reason why exclude_hv attribute setting varies.
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/attr/test-record-pfm-period | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/tests/attr/test-record-pfm-period b/tools/perf/tests/attr/test-record-pfm-period
> index 368f5b814094..b962d6d11ee2 100644
> --- a/tools/perf/tests/attr/test-record-pfm-period
> +++ b/tools/perf/tests/attr/test-record-pfm-period
> @@ -7,3 +7,4 @@ ret     = 1
>  sample_period=77777
>  sample_type=7
>  freq=0
> +exclude_hv=0|1

Presumably you see the same failure for other attribute checks, such
as test-record-period? Would it make more sense to change base-record
so that exclude_hv=0|1 ?

Thanks,
Ian

> --
> 2.30.2
>
