Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5643A24A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 08:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFJGp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 02:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFJGp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:45:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D52C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 23:43:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k7so3046350pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 23:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUPABG3O3CDDu1dQnUzHVQ+UKKBGPvf/5NlGon0kreI=;
        b=MLzV/387AlSC2uS+7or1pUo9owMnkGdTKAI/nKO++4Q6BS+30HOwLJsJi2IxkeFfqi
         w23uyYrwS5QCmvEm9MNjJCKNaDoNORT7Tz42fCTwRWr01yw3aqyJna2BidJpJcYiXv/0
         Li8rHcdpM4h66iuMfHmpgo3PT8kTl8Oppqqu+SmLzWG2hZ7PzUiPbg5R1iFomZtTeOSm
         1ClQNO03jsG9AWmXitVJnW0Ii9xZuXyGe5cfaBrp/qKfow+UvNwoV1F+gZRGvy9dzvwV
         +g69QVJsjwu2Kq3zUdFWZFL/s6Ux8ltb5N25fczaSQD2HqmoKA4eW/M02zJm2K8sT3e6
         +x0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUPABG3O3CDDu1dQnUzHVQ+UKKBGPvf/5NlGon0kreI=;
        b=Gjnd0uAcKxQvRVnyNytXbeiXGVhZfBkJzKuouwpU9pPQIa9vsdYxDIIK5BP+BxwsQs
         6FnGYAGvOJuDdjeJZ9zxOhG+yn0SlH2Eqr2G95FRf+A6B3+Wubt/rKrbjDlLmEu6eP5P
         EmmPW3f9qS+erteiHyDNBgr74+yz/P5Lhxr6rXy7CjZseXCsjFkbxOUjsg//7uSQys/V
         DFzvxJTnvygacsrrE3L4LpMd0FJBVhj4u1ebnEqeB/+qxUNZpXRkM16rbRhro6NgWQil
         FHtzd1j/W71FQ4YIHEQL7mdw4rD4rBAZHox58KXYFqxwlqR5TnFaE7HHWKW8a1yOg1Yf
         LmAw==
X-Gm-Message-State: AOAM532VEISm9HswXcDFEWroKJcYbtDQWuDZzEG6DSPozGV8M+7JNFmi
        FAcQ+DxmgzlmYHNc4sPKDrrbQKsyz3migl6rK/5+qQ==
X-Google-Smtp-Source: ABdhPJzE1OTsOe1Tmv1luM+6FViDqEQT6z+Eg005Ae+ht3Zm7BUL874r5HEauLN7n3KjkzIOOj+R6LKyPskfp+cjn60=
X-Received: by 2002:a17:90a:fd15:: with SMTP id cv21mr1817207pjb.46.1623307410554;
 Wed, 09 Jun 2021 23:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210528161552.654907-1-leo.yan@linaro.org>
In-Reply-To: <20210528161552.654907-1-leo.yan@linaro.org>
From:   Denis Nikitin <denik@google.com>
Date:   Wed, 9 Jun 2021 23:43:15 -0700
Message-ID: <CAOYpmdEvkSZaei-_SWrUC4YJ7rOUOoOaxM7+qc6dw=P+b_ivgA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] coresight: Fix for snapshot mode
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Fri, May 28, 2021 at 9:16 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> This patch series is to correct the pointer usages for the snapshot
> mode.
>
> Patch 01 allows the AUX trace in the free run mode and only syncs the
> AUX ring buffer when taking snapshot.
>
> Patch 02 is to polish code, it removes the redundant header maintained
> in tmc-etr driver and directly uses pointer perf_output_handle::head.
>
> Patch 03 removes the callback cs_etm_find_snapshot() which wrongly
> calculates the buffer headers; we can simply use the perf's common
> function __auxtrace_mmap__read() for headers calculation.
>
> This patch can be cleanly applied on the mainline kernel with:
>
>   commit 97e5bf604b7a ("Merge branch 'for-5.13-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu")
>
> And it has been tested on Arm64 Juno board.

I have verified the patches on Chrome OS Trogdor device.
They fixed the problem discussed in
https://lists.linaro.org/pipermail/coresight/2021-May/006411.html.

Tested-by: Denis Nikitin <denik@chromium.org>

Thanks,
Denis

>
>
> Leo Yan (3):
>   coresight: etm-perf: Correct buffer syncing for snapshot
>   coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
>   perf cs-etm: Remove callback cs_etm_find_snapshot()
>
>  .../hwtracing/coresight/coresight-etm-perf.c  |  30 +++-
>  .../hwtracing/coresight/coresight-etm-perf.h  |   2 +
>  .../hwtracing/coresight/coresight-tmc-etr.c   |  10 +-
>  tools/perf/arch/arm/util/cs-etm.c             | 133 ------------------
>  4 files changed, 32 insertions(+), 143 deletions(-)
>
> --
> 2.25.1
>
