Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED853416C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 08:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhCSHh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 03:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhCSHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:37:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA90C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 00:37:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h20so2559784plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 00:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wm6pEQmFURnXOmWTGuqipEn0M3H9/q16ESStcHsZys4=;
        b=Mg500hpsvG0+OCz9a1OBIFE4cVrJa6W2GarK6ZCo0vdzwX8kiNiiRDlUveE3fK+uVc
         BjAkNw723XTvlkxEM3HMw0HVvrWrawdjCYkaMf2yhXYdKsvvsTMbWloBzOTn3FSGLjzv
         P2RPEBqJiw06dHCC4fLO3PLHwq72kk3xRw1IU4GZ5nghSXKM0tJASb/WclAI9MC7rkQG
         dA6qj3saMXFNCVA8OoguhLTx7ttvENXqYDMC0/RzUyXywAViKvXa4XoWpOw9i6Ac/aCF
         RYVGrM751baXS9YoMDFB/nzZln3jHV633iDPSAX2WOV3OfjG0TxARqZ0QD/ZcDnXgdAc
         +ezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wm6pEQmFURnXOmWTGuqipEn0M3H9/q16ESStcHsZys4=;
        b=UMukgvbyD7iP8ubRjgkNKEAb6GrO/HcIP2EFDM6n/VDaKLCMWQUfNGZcCjoDmM0IIU
         HYif2LJ5cYA7utcS6w3grncr+tmo/r4UUvNHWDiEVIeTGHAJkZpVAMele9gF4GHfiR8v
         DIAy9yQH0DoBZTdvgsdpta44oP18RfJrxX5C0C+fOfeazC0bnDqQgQJs4oMhHp8I9rGj
         uplAm2vk1dSyauJLcjNiWzCF7FDsOELYIk+AD0Vs9BsCVIBoLr3L6yTdVRulV9W/Eica
         cLBkbGfpQRziEappHr9jiRvXM7qSskwk8q4a4K0Z6U8StAfKT83PsNzpqNiI4cqg1RF4
         ex1A==
X-Gm-Message-State: AOAM5328VmV6jXRcbIFA/rvdc3C6OQMtk+pYjnUpvDmjXQ1HRIac2VpU
        NW6/KaHzUbeivpW1ANNYLq2s+A==
X-Google-Smtp-Source: ABdhPJy1ULKwk9a7WSlNQ8Yub20HN0cQLokrcjmRmP+oTiYqom1xBERCtcVSKIOQbbbTvmSDhMQcag==
X-Received: by 2002:a17:90a:67cf:: with SMTP id g15mr8401361pjm.208.1616139474219;
        Fri, 19 Mar 2021 00:37:54 -0700 (PDT)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id q14sm4616364pff.94.2021.03.19.00.37.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 00:37:53 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:07:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, mingo@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH] sched: Optimize cpufreq_update_util
Message-ID: <20210319073751.qz2ytpxl2ikrt2b7@vireshk-i7>
References: <20210318212826.GW4746@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318212826.GW4746@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-03-21, 22:28, Peter Zijlstra wrote:
> Also, is there a lock order comment in cpufreq somewhere?

I don't think so.

> I tried
> following it, but eventually gave up and figured 'asking' lockdep was
> far simpler.

This will get called from CPU's online/offline path at worst, nothing more.
 
> +static void cpufreq_update_optimize(void)
> +{
> +	struct update_util_data *data;
> +	cpu_util_update_f func = NULL, dfunc;
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		data = per_cpu(cpufreq_update_util_data, cpu);
> +		dfunc = data ? READ_ONCE(data->func) : NULL;
> +
> +		if (dfunc) {
> +			if (!func)
> +				func = dfunc;
> +			else if (func != dfunc)
> +				return;
> +		} else if (func)
> +			return;
> +	}

So there is nothing cpufreq specific IIRC that can help make this better, this
is basically per policy.

For example, on an ARM platform we have two cpufreq policies with one policy
covering 4 CPUs, while the other one covering only 1 (maybe because we didn't
add those CPUs in DT or something else), then also we will end up separate
routines.

Or if we take all CPUs of a policy offline and then bring them up one by one, I
think for the first CPU online event in that policy we will end up using the
sugov_update_single_freq() variant for some time, until the time more CPUs come
up.

So traversing the way you did this is probably something that will work properly
in all corner cases.

-- 
viresh
