Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE313B7994
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 22:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhF2U56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbhF2U54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:57:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2EC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:55:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h1so239322plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CLNubV6h8jFoObsVh2bIrnrEx1Q0EoycL8dhVCx5IdE=;
        b=nfne3WlViskrc/HvxIeLhhxR0T8rS3bMCaS83Z55CJS/ptKzI9GT2PW5PvCAZjHfH6
         PVU2zmJ0PzWPlkV4DyEkXtCY5GAuQ3ZrRHnD2QpAsb/M6zi1c0FEFdSl/0U6KQvB9q0b
         Q3oLQe0m9VfHHt2jF3TasN3RasyLKgahaMg2wFWfWuD1pWlq59rqMGhMRw5PnEbU6Mgp
         Z+ZpMusYLDyQpLPpQBW6X/T2Tl5bKETVKlVwLARkR/+0nnHrrDyUn8JQWCNlgEoatgHr
         Qdw6zAxH+js+yvQe4wpBRZmRnRo1q5Ao2/cp15UHwFHzaQunIiHeXRf2GX4L322k1f/2
         c9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=CLNubV6h8jFoObsVh2bIrnrEx1Q0EoycL8dhVCx5IdE=;
        b=GlV0DsCIR1jkT57Y9DPGJ7lEdNbUE2oR2auEhcgz32Abqtv7IYXrLV8oDHtLgddXrp
         3AmPekNk2PhPJ1U8Vu7yVU3dbP7/HtcRDmcNpCeqSAPOTQUslh26Ks4n5hEFJ5UEEZ0G
         i9KDzfnLbPIzs0l6YuUjYsrI6L/hqtAwpomr22pLEKcRklhlJjFQ8xJE3gOmdB8t0nm5
         qupfJ6dcgpfMAXPGmQSb2Jox131WgRNtDp1B9zjPVMD6EPEh1mOAGkgwArtKQKEfiMlO
         zH9yojJ5gv4tH/Qw2RSXNNeNBvbaWuKHJO7QbBuPiTn/jVw9pXz3BlX+I17Tmz9S6j8k
         Ukrg==
X-Gm-Message-State: AOAM5338rC5arX+xNWeCIbzeeCbGaf6syHAx2Y1QClvg54Gna+ba40Gv
        GNo+eCAFupUyNCevVTonz9Lf5yTuaZNWdA==
X-Google-Smtp-Source: ABdhPJwaZdVDnaG/o3SnYATdX1bBJgofJQ7Uhdq0K2DFXTXRdB1By+Y8ATUcjb03x6nAK9fhe3q0NA==
X-Received: by 2002:a17:90b:1c02:: with SMTP id oc2mr804297pjb.36.1625000124109;
        Tue, 29 Jun 2021 13:55:24 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id r21sm4261765pjz.12.2021.06.29.13.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:55:22 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix CFS bandwidth hrtimer expiry type
References: <20210629121452.18429-1-odin@uged.al>
Date:   Tue, 29 Jun 2021 13:55:20 -0700
In-Reply-To: <20210629121452.18429-1-odin@uged.al> (Odin Ugedal's message of
        "Tue, 29 Jun 2021 14:14:52 +0200")
Message-ID: <xm26bl7o9yrr.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Odin Ugedal <odin@uged.al> writes:

> The time remaining until expiry of the refresh_timer can be negative.
> Casting the type to an unsigned 64-bit value will cause integer
> underflow, making the runtime_refresh_within return false instead of
> true. These situations are rare, but they do happen.
>
> This does not cause user-facing issues or errors; other than
> possibly unthrottling cfs_rq's using runtime from the previous period(s),
> making the CFS bandwidth enforcement less strict in those (special)
> situations.

Yeah, extremely rare, not any real sort of problem when it does happen,
but no reason not to fix it and get the slight win in precision.

Reviewed-by: Ben Segall <bsegall@google.com>

>
> Signed-off-by: Odin Ugedal <odin@uged.al>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 23663318fb81..62446c052efb 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5108,7 +5108,7 @@ static const u64 cfs_bandwidth_slack_period = 5 * NSEC_PER_MSEC;
>  static int runtime_refresh_within(struct cfs_bandwidth *cfs_b, u64 min_expire)
>  {
>  	struct hrtimer *refresh_timer = &cfs_b->period_timer;
> -	u64 remaining;
> +	s64 remaining;
>  
>  	/* if the call-back is running a quota refresh is already occurring */
>  	if (hrtimer_callback_running(refresh_timer))
> @@ -5116,7 +5116,7 @@ static int runtime_refresh_within(struct cfs_bandwidth *cfs_b, u64 min_expire)
>  
>  	/* is a quota refresh about to occur? */
>  	remaining = ktime_to_ns(hrtimer_expires_remaining(refresh_timer));
> -	if (remaining < min_expire)
> +	if (remaining < (s64)min_expire)
>  		return 1;
>  
>  	return 0;
