Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAF35301F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhDBUJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhDBUIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:08:55 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF401C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 13:08:53 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id h136so1322471vka.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBFiphv0iynhsmG5QBbrvBXWAHMSUgpS8oxKeXcIk4M=;
        b=DyBPssubbxErBoPOq0fJNAK510u1T6sDaXNjdScMSC4hdsfrLwCYCE7W6/e4Zp69HO
         9uaEgLi5XI/TvfpO0EcuWpS9mM7N6k9eRW0cLcSNfce1RbH0iEfi/5O2DMWN21gPAZOj
         nfJBZuLqrkC8SUhasfiWypCLPc8Fa0YEdN85MqP9NyF4rnsL+q+fqCL0ywQ1p+/zsHM+
         cbXiM0TTyJKuAaHx/VFd+ApBDy4aF8CMLqx3zXlZkrwnZNs5/EkkJ2G6p0MULBNj/tV7
         Cxwjx9xgD4HtL+CN8cx5og7sGxOTDzD+epaYP/vIIMJR+pXd5Rs/ojrAGPlmJFh8Jj7e
         KqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBFiphv0iynhsmG5QBbrvBXWAHMSUgpS8oxKeXcIk4M=;
        b=bReB//Kh8a0u7ri7swZKySy2EfYsV1BFhfDWjIhDAeuG4QBmFbWI/0SyA/FRhru/Ug
         3atAUE9twKHM71+MQ4o81vroarYajhUso7MUShYbFUnSxAlyBL2arnrvQ+hj6IGyAtpa
         NAmz4x1J0JivUMJ027zzpkEpsh38AUv325LEwSfAeAtwreSnRJ1IvAMhVuralQgRynj1
         Yr3ZxzNcbYNsyYJ9QvLv4GxQXCrmHKSJLKnz1Xao9+sm8QsDcwnalz324InGOes1motC
         ydG1yLdx9bVamsOf7uY8LcU2PkXNMkIIwyqPfxpPZaZRDTg7y2CnOoTJYohiIgJyW39y
         c96g==
X-Gm-Message-State: AOAM5316qemM38rR+lnGJUrFI/LHusSkGNLeO4P/7/tc1d7VuN4CSljB
        LSFgaEkKk6zXMDGx4aLxXEkjNcJtgpa4L/Zu7XQ=
X-Google-Smtp-Source: ABdhPJyHxEUGE3dMiGIj93PvLiCC1o7fw/dlZeYfFtFeF4N46laW1ppvJ5d5JAIA+cPUSLBbvM6H227LYDwx9EwYh98=
X-Received: by 2002:ac5:c84f:: with SMTP id g15mr10188260vkm.15.1617394132999;
 Fri, 02 Apr 2021 13:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <1610158662-3926-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1610158662-3926-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 3 Apr 2021 01:38:41 +0530
Message-ID: <CAFqt6zb405L9AhrzdMd3CTRCFN9J9kEVE5vudeF_R4OfVjLygQ@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Mark perf_pmu_snapshot_aux() as static
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 7:47 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Kernel test robot throws below warning ->
>
>  kernel/events/core.c:6535:6: warning: no previous prototype for
> 'perf_pmu_snapshot_aux' [-Wmissing-prototypes]
>     6535 | long perf_pmu_snapshot_aux(struct perf_buffer *rb,
>          |      ^~~~~~~~~~~~~~~~~~~~~
> Marking perf_pmu_snapshot_aux() as static as it is not used outside
> this file.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?

> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 55d1879..a4ba6fd 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6532,7 +6532,7 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
>         return data->aux_size;
>  }
>
> -long perf_pmu_snapshot_aux(struct perf_buffer *rb,
> +static long perf_pmu_snapshot_aux(struct perf_buffer *rb,
>                            struct perf_event *event,
>                            struct perf_output_handle *handle,
>                            unsigned long size)
> --
> 1.9.1
>
