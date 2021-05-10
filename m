Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE86F379939
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhEJVgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 17:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhEJVgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 17:36:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9253C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 14:35:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n2so18121697wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hZ/+U6WM/oBhT9ejagi+2/Cu4FUVwBwnUAjh35AzmU=;
        b=c+4XfWHa01qoxqxzh+khnIIAmXl+BFrsmtRbiN5wDAxlckwnrILOnc+gmdmUd0VU2u
         dsagWuA/cxohATcTDqDheiKMgmpBKsy11Ghpsfd19kYxuDjEK/6+C8oBPL5ZBaP769sJ
         POSd0VVj9LUtXnG+khBEEmFpcx/g2mTJf3fVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hZ/+U6WM/oBhT9ejagi+2/Cu4FUVwBwnUAjh35AzmU=;
        b=JOFWGgTGgGVeCzeNlOEPTB80/dqUWQQZ7eH6bRv2Xlc4ScY7TUT/Rw5uWDvjaCTqN5
         Pu/kqMCWQlE1JhVQFa93Iz7viR6TdXf02fL8HM8QmQiuq/qABzLsnhTb2Pymn82pNFln
         PBUktodfJmQCtNyC0bDRl+8s8J7PUUbrsadvjhZBrCkTI8mG2Di4cw6yzaYairsSRyRg
         Y4HJX3GIMFuAlTA5EW5Tz2ptA6fLsRJeevfMBrxw+d1NHvQnTvl0u4kYmXpYuRVrXlmj
         djZBv4R2BBgdO/dIzkZFjkSJGhPh+9S/SJ0lBYOoSm8KUpcwbp3x2anwT0LmorTgEbEn
         ZSpw==
X-Gm-Message-State: AOAM531fsRwZoJLm7PBkiQO5KAQyznsM96T+8gr0Iu7x1WDNwdRNR6QU
        3SE9OjjYfTOzeCIU7cPnEbILCG04vmSfNS6+bkm06A==
X-Google-Smtp-Source: ABdhPJxoN8xyxBOpcL2/QUwyrNQuDJWKT1MEyVeekKmH+8ZQm9PvvqXsvVoemOpCGUEmqDrWsBhAaZThKOFcFJCqI50=
X-Received: by 2002:a5d:498c:: with SMTP id r12mr33397485wrq.31.1620682499375;
 Mon, 10 May 2021 14:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210508205020.617984-1-jolsa@kernel.org>
In-Reply-To: <20210508205020.617984-1-jolsa@kernel.org>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 10 May 2021 16:34:48 -0500
Message-ID: <CAFxkdArafHXFtw-MQzJ+bpFUqne7u3++amqL0h-pdBj4_UK0dA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fix dynamic libbpf link
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Justin M . Forbes" <jforbes@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 3:50 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Justin reported broken build with LIBBPF_DYNAMIC=1.
>
> When linking libbpf dynamically we need to use perf's
> hashmap object, because it's not exported in libbpf.so
> (only in libbpf.a).
>
> Following build is now passing:
>
>   $ make LIBBPF_DYNAMIC=1
>     BUILD:   Doing 'make -j8' parallel build
>     ...
>   $ ldd perf | grep libbpf
>         libbpf.so.0 => /lib64/libbpf.so.0 (0x00007fa7630db000)
>
> Fixes: eee19501926d ("perf tools: Grab a copy of libbpf's hashmap")
> Cc: Ian Rogers <irogers@google.com>
> Reported-by: Justin M. Forbes <jforbes@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

This patch fixes it for me.

Tested-by: Justin M. Forbes <jforbes@redhat.com>

>  tools/perf/Makefile.config | 1 +
>  tools/perf/util/Build      | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7b195e16040e..dacd16874d3d 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -546,6 +546,7 @@ ifndef NO_LIBELF
>        ifdef LIBBPF_DYNAMIC
>          ifeq ($(feature-libbpf), 1)
>            EXTLIBS += -lbpf
> +          $(call detected,CONFIG_LIBBPF_DYNAMIC)
>          else
>            dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
>          endif
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index e27a551acd3a..95e15d1035ab 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -145,7 +145,14 @@ perf-$(CONFIG_LIBELF) += symbol-elf.o
>  perf-$(CONFIG_LIBELF) += probe-file.o
>  perf-$(CONFIG_LIBELF) += probe-event.o
>
> +ifdef CONFIG_LIBBPF_DYNAMIC
> +  hashmap := 1
> +endif
>  ifndef CONFIG_LIBBPF
> +  hashmap := 1
> +endif
> +
> +ifdef hashmap
>  perf-y += hashmap.o
>  endif
>
> --
> 2.31.1
>
