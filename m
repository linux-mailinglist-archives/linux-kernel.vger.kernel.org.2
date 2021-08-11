Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFCB3E9265
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhHKNSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhHKNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:18:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F84C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:17:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so1971572wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2xXMH953pZKCgCZ25e4o88jpheK19gphzrEklU0JwmQ=;
        b=N4jsEQMm8u5Z3lUmz5YhckOJN30t7GmxaBr/GyBrLlCIypYSx4DQdSeWJ3lYSvvYBN
         fj7stKjnQStjvf+Yr3j+QuN6RIRSGi284w9wZFzo1CUEt0VAY71Y9r4T+xdecrqCwSXi
         Xf/8F05FY0CXoaKedUtvqCKv4UVZHXCJZHuHpn+wynWUnWaeX+4dZNlVsuzMIQ/ly7W6
         PufK/ExoII8fGmC4rVj9r1TRSMuyfzGzjVzSUSXVBin5n3ciHmb45XOQDoYpoZkeGxnn
         1+ptpUmArPo/T8A2nEow1cRfU7t8SVlU93GNLR1XebZ8LsGyvxOiiiUk61doZafLRtPw
         Jf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2xXMH953pZKCgCZ25e4o88jpheK19gphzrEklU0JwmQ=;
        b=kteLfTnuk2zK5s+TtPTC9Vtkzmri1jq5B1FvnXHAqNhytYnumF/mBGsIbUyqlvDU2k
         f8hp7Numycb1AaqsoySdAMKrViQIVApKSXGeS9NxhHpSXmYjiZEgHVuiGpMvvp0/hgVF
         q7YjJYXpn/DBIFkGyZvYjhEhEgr7zYAhCy+gTWhxkid6fIHi0TXJOKBOcoNwMIxDzHB0
         KSovONqSzWFetLO9Lvt2Xfscx+l9knpOQ5gCrX8oIoyv5xeC7pGXHZjnwyzV1K9jD0IV
         hll0aZD9dlqo7qT8o+O7LzS7i/lVq7XvL/stWR3oKkFFD6EVR4SgWAEDWvIPi/uzGvwT
         b+aA==
X-Gm-Message-State: AOAM532oWj7XqT8+4RnVhgXjOjgSNcJ901D5z2QHKyvHn5uqtvrFJyAL
        qD0VV1xg4gby+dinVLUrUN+CVQ==
X-Google-Smtp-Source: ABdhPJwIUxJpPNGUgdCSYFBLbtc9j6za/dLf5bCk68g89565QOV9b0vnjKefGnpYPFSTCxW9pYRBcA==
X-Received: by 2002:a7b:c102:: with SMTP id w2mr10068103wmi.133.1628687865175;
        Wed, 11 Aug 2021 06:17:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:43fd:e634:73d9:e10e])
        by smtp.gmail.com with ESMTPSA id t15sm25828059wrw.48.2021.08.11.06.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 06:17:44 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:17:39 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 9/9] cpufreq: scmi: Use .register_em() callback
Message-ID: <YRPN8zjp1wqkHg6t@google.com>
References: <cover.1628682874.git.viresh.kumar@linaro.org>
 <6094d891b4cb0cba3357e2894c8a4431c4c65e67.1628682874.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6094d891b4cb0cba3357e2894c8a4431c4c65e67.1628682874.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 Aug 2021 at 17:28:47 (+0530), Viresh Kumar wrote:
> Set the newly added .register_em() callback to register with the EM
> after the cpufreq policy is properly initialized.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 55 ++++++++++++++++++++--------------
>  1 file changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 75f818d04b48..b916c9e22921 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -22,7 +22,9 @@
>  
>  struct scmi_data {
>  	int domain_id;
> +	int nr_opp;
>  	struct device *cpu_dev;
> +	cpumask_var_t opp_shared_cpus;

Can we use policy->related_cpus and friends directly in the callback
instead? That should simplify the patch a bit.

Also, we can probably afford calling dev_pm_opp_get_opp_count() from the
em_register callback as it is not a hot path, which would avoid wasting
some 'resident' memory here that is only used during init.

Thanks,
Quentin
