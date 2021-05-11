Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8787337A15A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhEKIH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhEKIHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:07:22 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E857CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 01:06:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i190so15443224pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owL/4Levsbr9ZSdMY4wPEiIgPr6GonMYfwkwZ8+sBwc=;
        b=WdsVMzw5hMV3bpevyN4y/+8vNyWJPzr8NHJEo7BFpTmqs+8FT6YlbQUBVryuJ4fWul
         v2u0iA/uN6aXvyuG6a9l92kUtS0KQvwWtUntXwFiTreAedIkwLDK44GOvT4gTqTxH8mh
         9otyMAuHnoEskR24vEZHE5yQnVl5LgxzU0wkreU5hq2Xn7BFc+Z0kBn000Ila/bdjk9o
         2VZmIBcHb2ZgkeK2gBk+V2/O+EqIk0y4Sn8U4TLAPEYUWGDNVIJkQR6dAZrFUZFOlirD
         iTKg9UJ8CXzNuCRMmoN5yb10JdCRrs7zS3zivhAraGN2F3j00nIlYihaqs4+aq7SKb+Q
         cBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owL/4Levsbr9ZSdMY4wPEiIgPr6GonMYfwkwZ8+sBwc=;
        b=gDvNuJwuZv/OyB4lDoW6623xkMXLShNOs+bB6imImkZAogzj922tZs+KoflR3Fo0si
         gpVYCE+zmwZ7vGyIwJO0lt8mTK6Ba/yeQ9iTpukS2LGQ6s18ti90WQB6fhkB3zAVucAc
         2IP8n8EqTgGgcQNVUQQiEgl/57ExfN2yF1m+vLozYMWJtO/QRE7GJ/KEWggNHOtM4XcS
         bqhd5USn2YR6h1vcpHm4aIGo+maLyUznm9neam4R0W/1LCKmK1AF7L8xw6nPWM33UoBa
         /SQ2JoitohMV7sCvpS50S/JTPAZrXoMu/g4dWF+afl+Nxn3JHMhOFChf82HOBAbZIdsA
         x9xA==
X-Gm-Message-State: AOAM530WICBONC5grztst+jvzEvnG8s8Rs0cnjP4k8qkI/L4i7h0WKth
        m9s4740fYRTtd8JQIlf6FmH703KoxOKbHbNg5TUCgg==
X-Google-Smtp-Source: ABdhPJy/IpuNzfVlzHBbQnYHtWtbClkdPrzK/5eTeFhvGdUmoXvn7GLPxtZ2SwEo8SN6ofJVFb6GhcZ1I1MrmHivm9g=
X-Received: by 2002:a63:e918:: with SMTP id i24mr29602351pgh.118.1620720375143;
 Tue, 11 May 2021 01:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210507095814.17933-1-james.clark@arm.com> <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
 <20210510053904.GB4835@leoy-ThinkPad-X240s>
In-Reply-To: <20210510053904.GB4835@leoy-ThinkPad-X240s>
From:   Denis Nikitin <denik@google.com>
Date:   Tue, 11 May 2021 01:06:03 -0700
Message-ID: <CAOYpmdFYs8=FzpiA-mMNZ=L8B9GRXLfQuEnMeDsvWeeKg2PWtA@mail.gmail.com>
Subject: Re: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Branislav Rankov <branislav.rankov@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        anshuman.khandual@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,



> Just remind, as Mike has mentioned that if the timestamp is zero, it
> means the hardware setting for timestamp is not enabled properly.  So
> for system wide or per CPU mode tracing, it's better to double check
> what's the reason the timestamp is not enabled properly.

The bug is confirmed by HW verification.

>
> IIUC, this patch breaks the existed rational in the code.  Let's think
> about there have 4 CPUs, every CPU has its own AUX trace buffer, and
> when decode the trace data, it will use 4 queues to track the packets
> and every queue has its timestamp.
>
>   CPU0: cs_etm_queue -> ... -> packet_queue->timestamp
>   CPU1: cs_etm_queue -> ... -> packet_queue->timestamp
>   CPU2: cs_etm_queue -> ... -> packet_queue->timestamp
>   CPU3: cs_etm_queue -> ... -> packet_queue->timestamp
>
> The issue is if all CPUs' timestamp are zero, it's impossible to find
> a way to synthesize samples in the right time order.

Is it really impossible or it just can lead to incorrect decoding?
I verified the profiles generated with zero timestamps and this patch
on Trogdor (8 CPU cores) and I don't see any significant difference
in the quality of the AutoFDO profiles.

If mixed packets don't cause errors in reconstructing the branches
but instead mess up with their timeline then it probably won't matter
for AutoFDO which just collects statistics of the branches.
What do you think?

>
> [...]
>
> Thanks,
> Leo

Thanks,
Denis
