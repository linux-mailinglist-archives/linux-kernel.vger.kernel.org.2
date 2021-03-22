Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8B6344560
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbhCVNRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhCVNLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:11:52 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E4EC061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:11:52 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y1so20928237ljm.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THXO5+mjXh1wGkFTexS2PYltIzJKCCGh8lFumPrqIUY=;
        b=V3NLN9AF7s5KHxwHc8zstJJRA3ykdhSnxEDgxe3WMgNzeRnF423817353hONJNttBt
         IipdJOsfIG8B74RBK7vEBWA8NjXegBGPcFFshSF6RtBDZYXY8g/+BEuUHCmdhBg8PBcu
         GWLDSgNX+lM5Iw6oQ2LtCLigAaCIf0gJc6yqPXCz7jJQxaL5XPQKAsuD2KS1sVkBIyfJ
         0Fw3ynmBI/1BHRLOINoThu+fkeg08RVu5S2IEMDWXlcMPHjahTG21ixlx9q8gJueuA13
         baqsv5uWiL9u0gV3hxc/W4SBGDOmQzYh2Yy4EyJP8vsqpgCyxQSwmn7UeNyODsGK3qw8
         t2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THXO5+mjXh1wGkFTexS2PYltIzJKCCGh8lFumPrqIUY=;
        b=h+OOxDSxmT3n36L006aqYW0lG44GM3UhC4xrgOKhGwVFiVYm1cOlhK3V5/TPQIeUQn
         1NdnpdhRaBXTuJaq2bv+XkFRTWRCOS6LwJJQHD/M7MZbgaVYqqEYc2tasuRFIkLWKkJj
         NWL19OQQPyYJ97fjPeLDfx55ORHB2wPTYmfi/mSThRN8J9g20MW3/ZS60AAnwI7KQ0R+
         PjRJSTDwyM6ZhN9qkViSbHxY0RhAoEx5eZoaO9/UbPqjI/JIMre/hw4hBJSytgvjsdT5
         DZyRFhbbmhn44rRdyhvEuWmyhgezoIrhZ0Pkd0UUDA48vsz0gj/zuEyTC3ccGG3V8U4W
         BEgw==
X-Gm-Message-State: AOAM5312y10StHly1EEeAZ1xNtWKAnZzV0dks6YSRxSYH+2oEXMnC3vt
        HiH2VDYaWoZqA2NbCuqE5LNho8LAaxcPsuMoWge+ztP16jo=
X-Google-Smtp-Source: ABdhPJz16JNIGQBV7CTW00f/Xrkuu51V8tB5htHWVkMZgSlN0DgeAVtgBo8MdX20BkyJVz4NDLMTzFFdflAQpS3lAsE=
X-Received: by 2002:a2e:96c3:: with SMTP id d3mr9982514ljj.284.1616418710743;
 Mon, 22 Mar 2021 06:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210320221432.924-1-song.bao.hua@hisilicon.com>
In-Reply-To: <20210320221432.924-1-song.bao.hua@hisilicon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 22 Mar 2021 14:11:38 +0100
Message-ID: <CAKfTPtA8GibaRWB_=i3ycR8xT2iFkAn337k_cwrAQOshAi=VGA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: remove redundant test_idle_cores for non-smt
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>, yangyicong@huawei.com,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        linuxarm@openeuler.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2021 at 23:21, Barry Song <song.bao.hua@hisilicon.com> wrote:
>
> update_idle_core() is only done for the case of sched_smt_present.
> but test_idle_cores() is done for all machines even those without
> smt.
> this could contribute to up 8%+ hackbench performance loss on a
> machine like kunpeng 920 which has no smt. this patch removes the
> redundant test_idle_cores() for non-smt machines.
>
> we run the below hackbench with different -g parameter from 2 to
> 14, for each different g, we run the command 10 times and get the
> average time:
> $ numactl -N 0 hackbench -p -T -l 20000 -g $1
>
> hackbench will report the time which is needed to complete a certain
> number of messages transmissions between a certain number of tasks,
> for example:
> $ numactl -N 0 hackbench -p -T -l 20000 -g 10
> Running in threaded mode with 10 groups using 40 file descriptors each
> (== 400 tasks)
> Each sender will pass 20000 messages of 100 bytes
>
> The below is the result of hackbench w/ and w/o this patch:
> g=    2      4     6       8      10     12      14
> w/o: 1.8151 3.8499 5.5142 7.2491 9.0340 10.7345 12.0929
> w/ : 1.8428 3.7436 5.4501 6.9522 8.2882  9.9535 11.3367
>                           +4.1%  +8.3%  +7.3%   +6.3%
>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2e2ab1e..de42a32 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6038,9 +6038,11 @@ static inline bool test_idle_cores(int cpu, bool def)
>  {
>         struct sched_domain_shared *sds;
>
> -       sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> -       if (sds)
> -               return READ_ONCE(sds->has_idle_cores);
> +       if (static_branch_likely(&sched_smt_present)) {
> +               sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +               if (sds)
> +                       return READ_ONCE(sds->has_idle_cores);
> +       }
>
>         return def;
>  }
> --
> 1.8.3.1
>
