Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFAD38832E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbhERXcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbhERXcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:32:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8402C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:30:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i17so11958981wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 16:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dB5AZpFDnjZnCDVY6EBk4qG0EF9TZ3zY3Xl36EaiD58=;
        b=HCWyWnipiDG/MI4w05WoFcFXiK7TIRM2s5AZySf50hADftHFa0C/YxNZaWNiaOAA1J
         JVhoVrPYXBcsFY7WdYrvk2OAPdAVH1xLCL+tGJUapuvoZU7VndDnN5Yk2rCQeIyT2juE
         rCCwG7rhS80YJPTck2ZqjiAIombL9CbzlCeLfUjfkRRm19seREKYo81nFyZUxw1JQfnI
         Z8Fk2Ne6BGjA8d77z77jJDuFce9/aZ1yg0FlfV2NIGOapd9TOc14KCwDpEMbXEhMIspl
         gnuXsUalIS0pusuucuNUwOrlumA8xSAolX64pSAY0SSjTIhBQkBK8ZR+D0HEm2KC+Q82
         PG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dB5AZpFDnjZnCDVY6EBk4qG0EF9TZ3zY3Xl36EaiD58=;
        b=b5M15peI8GtZ/KpSFUofB3EdKjbVCUh2kSloVVJg6HraB/uWPt2g0v44TqJgpJlKCT
         zNxxuKt1Tz12Qd3Cut0jT89HQFwBKwHy36ymKWnZl4A8g9SY9Ttq20nrH5S/ZzxLr4fP
         zO9mgeExlhYhJMszdec434g9sBQSQTzzRIsADzFaAoAuLxIqXq3ZxBpK3HDZ0mU38zYm
         IkylQXKPCSNPhlDQrRpr/4Mx4oqSu07iresVul+0zrQynaa/PxSsUIJECCEWZj9mngUr
         1E4AWdktIhbx/5YAVS/3nM0n/bc0GS0IXdHkLUJzjSBf88aFhKiOAI6Lh9WHZDW54MIf
         0B0Q==
X-Gm-Message-State: AOAM532zSRvyJnfRmk0X3k3WDkH976LLF96R44bKF/nSIzBiPC5ushB5
        dSbWK9I82EM+w0r3gDMTbtOAz2pSPymRuK2ipLcBzw==
X-Google-Smtp-Source: ABdhPJx6bJ2EFj7N+dPui1zEDY+zKdFTuhhzcDCr/EqObzNnsBgSk40eMo3yUSBij1/nip8g/rwlREGGjnWHfePpOuo=
X-Received: by 2002:adf:f54b:: with SMTP id j11mr5158668wrp.376.1621380647471;
 Tue, 18 May 2021 16:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210517140931.2559364-1-tmricht@linux.ibm.com>
In-Reply-To: <20210517140931.2559364-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 18 May 2021 16:30:35 -0700
Message-ID: <CAP-5=fV-2J1rxHAaGv_GwFzY-mAKKogEvQf1A87PUvZxT7wzUQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Test libpfm4 support (63) reports error
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>, svens@linux.ibm.com,
        Vasily Gorbik <gor@linux.ibm.com>, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 7:12 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>
> Compiling perf with make LIBPFM4=1 includes libpfm support and
> enables test case 63 'Test libpfm4 support'. This test reports an error
> on all platforms for subtest 63.2 'test groups of --pfm-events'.
> The reported error message is 'nested event groups not supported'

The parsing test checks broken and working strings and so errors are
always going to be reported, but agreed this error is wrong.

>  # ./perf test -F 63
>  63: Test libpfm4 support                                            :
>  63.1: test of individual --pfm-events                               :
>  Error:
>  failed to parse event stereolab : event not found
>  Error:
>  failed to parse event stereolab,instructions : event not found
>  Error:
>  failed to parse event instructions,stereolab : event not found
>   Ok
>  63.2: test groups of --pfm-events                                   :
>  Error:
>  nested event groups not supported    <------ Error message here
>  Error:
>  failed to parse event {stereolab} : event not found
>  Error:
>  failed to parse event {instructions,cycles},{instructions,stereolab} :\
>          event not found
>  Ok
>  #
>
> This patch addresses the error message 'nested event groups not supported'.
> The root cause is function parse_libpfm_events_option() which parses the
> event string '{},{instructions}' and can not handle a leading empty
> group notation '{},...'.
>
> The code detects the first (empty) group indicator '{' but does not
> terminate group processing on the following group closing character '}'.
> So when the second group indicator '{' is detected, the code assumes
> a nested group and returns an error.
>
> With the error message fixed, also change the expected event number to
> one for the test case to succeed.
>
> While at it also fix a memory leak. In good case the function does not
> free the duplicated string given as first parameter.
>
> Output after:
>  # ./perf test -F 63
>  63: Test libpfm4 support                                            :
>  63.1: test of individual --pfm-events                               :
>  Error:
>  failed to parse event stereolab : event not found
>  Error:
>  failed to parse event stereolab,instructions : event not found
>  Error:
>  failed to parse event instructions,stereolab : event not found
>   Ok
>  63.2: test groups of --pfm-events                                   :
>  Error:
>  failed to parse event {stereolab} : event not found
>  Error:
>  failed to parse event {instructions,cycles},{instructions,stereolab} : \
>          event not found
>   Ok
>  #
> Error message 'nested event groups not supported' is gone.

Acked-By: Ian Rogers <irogers@google.com>

I wonder if we should add some coverage for the error cases to the pfm
test with something like the following.

Thanks,
Ian

--- a/tools/perf/tests/pfm.c
+++ b/tools/perf/tests/pfm.c
@@ -155,6 +155,16 @@ static int test__pfm_group(void)
                        .nr_events = 3,
                        .nr_groups = 1,
                },
+               {
+                       .events = "instructions}",
+                       .nr_events = 1,
+                       .nr_groups = 0,
+               },
+               {
+                       .events = "{{instructions}}",
+                       .nr_events = 0,
+                       .nr_groups = 0,
+               },
        };

        for (i = 0; i < ARRAY_SIZE(table); i++) {

> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  tools/perf/tests/pfm.c |  4 ++--
>  tools/perf/util/pfm.c  | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
> index 76a53126efdf..d4b0ef74defc 100644
> --- a/tools/perf/tests/pfm.c
> +++ b/tools/perf/tests/pfm.c
> @@ -131,8 +131,8 @@ static int test__pfm_group(void)
>                 },
>                 {
>                         .events = "{},{instructions}",
> -                       .nr_events = 0,
> -                       .nr_groups = 0,
> +                       .nr_events = 1,
> +                       .nr_groups = 1,
>                 },
>                 {
>                         .events = "{instructions},{instructions}",
> diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> index d735acb6c29c..6eef6dfeaa57 100644
> --- a/tools/perf/util/pfm.c
> +++ b/tools/perf/util/pfm.c
> @@ -62,8 +62,16 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
>                 }
>
>                 /* no event */
> -               if (*q == '\0')
> +               if (*q == '\0') {
> +                       if (*sep == '}') {
> +                               if (grp_evt < 0) {
> +                                       ui__error("cannot close a non-existing event group\n");
> +                                       goto error;
> +                               }
> +                               grp_evt--;
> +                       }
>                         continue;
> +               }
>
>                 memset(&attr, 0, sizeof(attr));
>                 event_attr_init(&attr);
> @@ -107,6 +115,7 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
>                         grp_evt = -1;
>                 }
>         }
> +       free(p_orig);
>         return 0;
>  error:
>         free(p_orig);
> --
> 2.31.1
>
