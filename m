Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6586C3214B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 12:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBVLFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 06:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhBVLF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 06:05:29 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C036C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 03:04:49 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id t11so9996735pgu.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 03:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+rcTBMZKhMdES3Cywg/Y8Lt4YKUTAgAp6AlCWuyPtcQ=;
        b=VGTg6aQRkSvcbll2r22P+d3EZH6WF1awpGJZs+/XhKQkdxoGqORsC4fbhqacMlTxQz
         SK6H/6X4MMJntSvc/0Fzf/3t3GSUdJCv0uoRVMleTN7h5+9Wfcel+1pllVIl5O/TChVs
         hRkFuByTu6G4/DFRRonn6pP9uaXrEx38ucAG7Vlz7Ne3ql2TWsADUW0hOyIf+jX6JWT+
         uj/Jf9rsYgr6v0Z9jFCsqDVw19FOe7xWgcWJQwQ24MTJhPVwO83lJ0vDXSuErNngEj8y
         ot5WMXv6lUR/xCEy8ymb3VpJWoKa/A26gK+P0z3SkUzmpcyWrQeTaJsluUBKjbnd2tUR
         RyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+rcTBMZKhMdES3Cywg/Y8Lt4YKUTAgAp6AlCWuyPtcQ=;
        b=ATBQlfGBDMlzZ060EoItjowTheUDXrHyM9SQ+xLIPfViytLKyrcLFRBG1xSEAglmUd
         MDt3mnKMbvJZfc4sil6sC11ihzwYcYqr3QMH+Og2DfvJFlaHr2zn9mo4ZMFgSWTKOLsd
         rV8nT3EkJ7G0oz5D/pXUENOm2S5nr2jaFXXqBjAEWkl+XrFDevixk+aBWWuvUTWhCAE0
         qZosx3L3Bp4kESELAr87Pvfgt6XoVdclJU8F/JWSfY6ijBYIIBPA8eeAT54Kure95ixL
         K6S2fwYuH0nO5eGrmVzJwHYF9RnqKx0+r3yKPqO9CwBnrqPloCbYOzl/v5takTZ9Oa4h
         Dgvg==
X-Gm-Message-State: AOAM532KXs464z8Aacgk0t6hPZEmMMUYpZvlhFBi5kwClfQDOVasxIY5
        ZjXERWwY/zjwy/5PSs3DjpimXg==
X-Google-Smtp-Source: ABdhPJygKT+iXaHBzplZf5PU+PiqXdLVpAhUD2i3pk6WLSAdWbGYk1+8vS3jnjkwVdEjU0AC0N4XKQ==
X-Received: by 2002:aa7:8d8e:0:b029:1d1:f9c9:cff6 with SMTP id i14-20020aa78d8e0000b02901d1f9c9cff6mr21924773pfr.31.1613991888990;
        Mon, 22 Feb 2021 03:04:48 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id q2sm7707116pfl.158.2021.02.22.03.04.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 03:04:48 -0800 (PST)
Date:   Mon, 22 Feb 2021 16:34:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 2/2] cpufreq: cppc: Add support for frequency
 invariance
Message-ID: <20210222110446.boq5at3nmu6k4udt@vireshk-i7>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <59f48538545d080cb1c7b201d2d779ab513d2c0c.1611829953.git.viresh.kumar@linaro.org>
 <20210218163538.GA3105@arm.com>
 <20210222110023.GB4499@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222110023.GB4499@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-21, 11:00, Ionela Voinescu wrote:
> Hey,
> 
> Some test results:

Nice, I haven't responded earlier as Vincent was also testing the
stuff out later last week and was planning to do it more this week.

> On Thursday 18 Feb 2021 at 16:35:38 (+0000), Ionela Voinescu wrote:
> [..]
> > > +static void __init cppc_freq_invariance_init(void)
> > > +{
> [..]
> > > +
> > > +		ret = cppc_get_perf_ctrs(i, &fb_ctrs);
> > > +		if (!ret)
> > > +			per_cpu(cppc_fi->prev_perf_fb_ctrs, i) = fb_ctrs;
> > 
> 
> After fixing this one:
> 			cppc_fi->prev_perf_fb_ctrs = fb_ctrs;

Yeah, I already fixed it and made several changes based on your
feedback.

> I got the following:
> 
> Platform:
> 
>  - Juno R2 (CPUs [0-3] are littles, CPUs [4-5] are bigs)
>     + PMU counters, used by CPPC through FFH
>     + userspace/schedutil
> 
> 
>   - Verifying that with userspace governor we see a correct change in
>     scale factor:
> 
> 	root@buildroot:~# dmesg | grep FIE
> 	[    6.436770] AMU: CPUs[0-3]: AMU counters WON'T be used for FIE.
> 	[    6.436962] AMU: CPUs[4-5]: AMU counters WON'T be used for FIE.
> 	[    6.451510] CPPC:CPUs[0-5]: CPPC counters will be used for FIE.
> 
> 	root@buildroot:~# echo 600000 > policy4/scaling_setspeed
> 	[  353.939495] CPU4: Invariance(cppc) scale: 512.
> 	[  353.939497] CPU5: Invariance(cppc) scale: 512.
> 
> 	root@buildroot:~# echo 1200000 > policy4/scaling_setspeed
> 	[  372.683511] CPU5: Invariance(cppc) scale: 1024.
> 	[  372.683518] CPU4: Invariance(cppc) scale: 1024.
> 
> 	root@buildroot:~# echo 450000 > policy0/scaling_setspeed
> 	[  641.495513] CPU2: Invariance(cppc) scale: 485.
> 	[  641.495514] CPU1: Invariance(cppc) scale: 485.
> 	[  641.495517] CPU0: Invariance(cppc) scale: 485.
> 	[  641.495542] CPU3: Invariance(cppc) scale: 485.
> 
> 	root@buildroot:~# echo 950000 > policy0/scaling_setspeed
> 	[  852.015514] CPU2: Invariance(cppc) scale: 1024.
> 	[  852.015514] CPU1: Invariance(cppc) scale: 1024.
> 	[  852.015517] CPU0: Invariance(cppc) scale: 1024.
> 	[  852.015541] CPU3: Invariance(cppc) scale: 1024.

Great.

>  - I ran some benchmarks as well (perf, hackbench, dhrystone) on the same
>    platform, using the userspace governor at fixed frequency, to evaluate
>    the impact of the work we do or don't do on the tick.
> 
>    ./perf bench sched pipe
>    (10 iterations, higher is better, ops/s, comparisons with
>    cpufreq-based FIE)
> 
>    cpufreq-based FIE    AMU-based FIE    CPPC-based FIE
>    ----------------------------------------------------
>    39498.8		40984.7		 38893.4
>    std: 3.766%		std: 4.461%	 std: 0.575%
>    			diff: 3.625%	 diff: -1.556%
> 
>    ./hackbench -l 1000
>    (10 iterations, lower is better, seconds, comparison with
>    cpufreq-based FIE)
> 
>    cpufreq-based FIE    AMU-based FIE    CPPC-based FIE
>    ----------------------------------------------------
>    6.4207		6.3386		 6.7841
>    std: 7.298%		std: 2.252%	 std: 2.460%
>    			diff: -1.295%	 diff: 5.356%
> 
>    This shows a small regression for the CPPC-based FIE, but within the
>    standard deviation.
> 
>    I ran some dhrystone benchmarks (./dhrystone -t 2/34/5/6/ -l 5000) as
>    well with schedutil governor to understand if an increase in accuracy
>    with the AMU/CPPC counters makes a difference. Given the
>    characteristics of the platform it's no surprise that the results
>    were very similar between the three cases, so I won't bore you with
>    the numbers.

Nice, I have much more confidence on this stuff now :)

Thanks a lot Ionela, I will resend the series again today then.

-- 
viresh
