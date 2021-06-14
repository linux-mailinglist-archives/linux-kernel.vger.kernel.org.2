Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52B83A5FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhFNKPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 06:15:23 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:55944 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhFNKPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:15:20 -0400
Received: by mail-pj1-f44.google.com with SMTP id k7so9414184pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ND5eYThFOS6UrKO1IOLZFgJ1DOYkhWc72TR5fFFEeI8=;
        b=ykuAnxiv/xr5+aP9R+T/F3VMX7KnrYgvC8HpsbV/ZJPcQWyYPA4Iuln+pr4qxZuqnd
         sgWKcpVzJRlHG6psrUaBEsmNkL+HpTQG5O/BjFIvAb+iDA8x4fmzv+wcUYYD1NUu5jzE
         x812ckGrNGrdjVWOrJ6gSA/68RILYko/ZXq06UmyjnhJL4Z5Ov2Ujlx96sdLLPltOG/C
         8AFvLCta3Q1MYSNOsrVEsWCYRJ6tNbjLut9B9Xw1xr6zaV8JODWYbhoAmv816AunRfy3
         O4zdlsUusFrwKIDg35IxznRQLgcAPa/8IVHn74QvAoqBBRQ0McXFZeGinRg6XbnnIFAN
         tU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ND5eYThFOS6UrKO1IOLZFgJ1DOYkhWc72TR5fFFEeI8=;
        b=D4w8yt9TV7iQqY3iFw5m4K7vTfmNdrfeXT4DcoQl+VcE2bzyuKf3T+HSJCFXln3RMe
         xUzSUEBkvfciS/uhrwAiYZwDw+dfXU+XA4v9+oiAv/ksaHH7XFzar/30f7Hsvv07moa7
         9bwoR5anbovXZC5dOcnCJ4MsfcXgjSY2zG3UkG9vXx61q8z57Mg/II5VAFDg5Fidl/ER
         5OpST7FH9So6whotnI1P4uMopVPX63H7IwTXktB/YNn3f57kO0kdaCxJpARE6tJcIEb5
         k1I6trgXCTxLntf7UjzmissZss2/u/7qpxvywVSrtThTsPvXVXQZvQwJPLN8rRSQL8+X
         7+gw==
X-Gm-Message-State: AOAM533mQ+4iLCDD6EqkhpLAHWJ1b0yukfXnzjBRKohQOJInY5N/a3QF
        9fGRCs1I0AM9zWFREOX1lFiz/Q==
X-Google-Smtp-Source: ABdhPJzuMagoQd87+77ml6IYAM5yV8nrziwQ2GIYoI6xXqj1UlE3g5TXNIzO2IKzAk+5N3EgETFrSQ==
X-Received: by 2002:a17:90b:a0e:: with SMTP id gg14mr17920055pjb.191.1623665535569;
        Mon, 14 Jun 2021 03:12:15 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id c196sm6216351pga.13.2021.06.14.03.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:12:14 -0700 (PDT)
Date:   Mon, 14 Jun 2021 15:42:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        dietmar.eggemann@arm.com, vincent.donnefort@arm.com,
        Beata.Michalska@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
        bristot@redhat.com, thara.gopinath@linaro.org,
        amit.kachhap@gmail.com, amitk@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org
Subject: Re: [PATCH v3 1/3] thermal: cpufreq_cooling: Update also offline
 CPUs per-cpu thermal_pressure
Message-ID: <20210614101213.enhmoyupag5d556r@vireshk-i7>
References: <20210610150324.22919-1-lukasz.luba@arm.com>
 <20210610150324.22919-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610150324.22919-2-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-06-21, 16:03, Lukasz Luba wrote:
> The thermal pressure signal gives information to the scheduler about
> reduced CPU capacity due to thermal. It is based on a value stored in a
> per-cpu 'thermal_pressure' variable. The online CPUs will get the new
> value there, while the offline won't. Unfortunately, when the CPU is back
> online, the value read from per-cpu variable might be wrong (stale data).
> This might affect the scheduler decisions, since it sees the CPU capacity
> differently than what is actually available.
> 
> Fix it by making sure that all online+offline CPUs would get the proper
> value in their per-cpu variable when thermal framework sets capping.
> 
> Fixes: f12e4f66ab6a3 ("thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping")
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index eeb4e4b76c0b..43b1ae8a7789 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -478,7 +478,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
>  	if (ret >= 0) {
>  		cpufreq_cdev->cpufreq_state = state;
> -		cpus = cpufreq_cdev->policy->cpus;
> +		cpus = cpufreq_cdev->policy->related_cpus;
>  		max_capacity = arch_scale_cpu_capacity(cpumask_first(cpus));
>  		capacity = frequency * max_capacity;
>  		capacity /= cpufreq_cdev->policy->cpuinfo.max_freq;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
