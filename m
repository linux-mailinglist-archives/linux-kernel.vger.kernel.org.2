Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59774072AA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhIJUpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhIJUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:45:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112D7C061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:43:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id n34so2918500pfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lKqAYpYNlQ9hkuyrKjXk6bTpMchdOnzhQvx8SF/LD7o=;
        b=DlpN4wySBad/y9SQPx+P71ThJSo7FqyruNXODlhEZ1s3VW+7183RRa/2RPQdKA+x3C
         xHLFetRomChjnZ3c9CXts4FhRjtnNUDGvp7l9/XhuzSR31sm0fhUne3+cv1xX3y+Q4RT
         vnIiVPDc31WJZb8SkH5yokzl7SaZ1uqJS9NKc3tenwZeDy3QiLXYxoaP4efDPlRISMC+
         CYlX2+VJMkBkFXQBbBCTN9lLugiwuTAGkFQCLmpjlnMnC59LKz04aqsuDFkGQEPCI3L5
         9pIEOFG7qghiV+TfkNgunDkPDacmtSqxhqnLpI/X8vvrmedAWnxwvoBdNXFXB/Q9BWpF
         y48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=lKqAYpYNlQ9hkuyrKjXk6bTpMchdOnzhQvx8SF/LD7o=;
        b=dByivAhKz/NdWccCtsmpwsZKOwOXyTkuYkBeTsXgHyC/6uTkdXiHcZMs0BSAkLVuNr
         9xC77wVe2ORJZqaDtGFO0GbODN9gF8bUmhbQ1Blj4wiTz164rqArTXbsVZyizat5Y3tp
         A2htrINlHsT4kG2ye/NPiXuLUIvbflqwYQ7pcKjddDlvbqptFKrTHNQk9IyXcUUilMKB
         bHUyr8Hf2A1pjNd+b0ebqBHtCQsB7GUMW4HGSLQ+ZJXIsnDpbz+GX1eHtg0vHuuYJ9V9
         vRAOFUlUj3QzhdhlM50o1Wl7KB0Cw+NxkGuZphnxkUMeXt8cofdtVwEero1DJkVFSNNi
         UwpQ==
X-Gm-Message-State: AOAM531czp79PdYFKnvGBWlzpQWEqoKZHSnDelfX5W/aUlNsiupEEvnk
        FvIoQRxWg3O1TXr9eoIqEHrc2AeBXrKfbQ==
X-Google-Smtp-Source: ABdhPJwiFdCSpFHUVrxWhGBdkE/BHmxDqiwoStULK3QICSNhV57xCRT2ou2cu/HVzHN00h72WGl6aA==
X-Received: by 2002:a63:555c:: with SMTP id f28mr8943790pgm.340.1631306630358;
        Fri, 10 Sep 2021 13:43:50 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id o10sm5950482pgp.68.2021.09.10.13.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:43:48 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Kailun Qin <kailun.qin@intel.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, changhuaixin@linux.alibaba.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/core: Fix wrong burst unit in cgroup2 cpu.max write
References: <20210910162509.622222-1-kailun.qin@intel.com>
Date:   Fri, 10 Sep 2021 13:43:39 -0700
In-Reply-To: <20210910162509.622222-1-kailun.qin@intel.com> (Kailun Qin's
        message of "Fri, 10 Sep 2021 12:25:09 -0400")
Message-ID: <xm267dfonouc.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kailun Qin <kailun.qin@intel.com> writes:

> In cpu_max_write(), as the eventual tg_set_cfs_bandwidth() operates on
> the burst in nsec which is input from tg_get_cfs_burst() in usec, it
> should be converted into nsec accordingly.
>
> If not, this may cause a write into cgroup2 cpu.max to unexpectedly
> change an already set cpu.max.burst.
>
> This patch addresses the above issue.
>
> Signed-off-by: Kailun Qin <kailun.qin@intel.com>

Oh, huh, cpu_period_quota_parse is confusing and changes the units in
period. (It might make more sense to make all that interaction clearer
somehow, but this is probably fine)

It's probably also better to just use tg->cfs_bandwidth.burst directly
rather than do an unnecessary div+multiply.

For whichever version:

Reviewed-by: Ben Segall <bsegall@google.com>

> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c4462c454ab9..fc9fcc56149f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10711,7 +10711,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
>  {
>  	struct task_group *tg = css_tg(of_css(of));
>  	u64 period = tg_get_cfs_period(tg);
> -	u64 burst = tg_get_cfs_burst(tg);
> +	u64 burst = (u64)tg_get_cfs_burst(tg) * NSEC_PER_USEC;
>  	u64 quota;
>  	int ret;
