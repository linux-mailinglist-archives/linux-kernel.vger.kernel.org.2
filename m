Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90F633AA94
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCOExU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhCOExF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:53:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA746C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 21:53:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so13674707pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 21:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9jlkZc4l57z4gYpyUQhwFM4YMqSzrWiY9Ig9xmWZ6CM=;
        b=pGoQ3T8HqHZEyJXEatYySB5WORzlCF9PNfWlOpWXhw6jcEuay5IW7JD85GFR+K8SGh
         8Y+u0LeCZhPO55P/eg2HEjPpjd90w3SafcUUWmRdzJAQ/iSwLDjtr1mremDYrsOs/+JD
         uDBhIi4fjJ0fFDGGQ2iQDMD9E1bFLlqY2dF+uBpb0+WB/pYxbXRC58h7ROPWgMiCA0KV
         mIYNHAPr/fRqXP654nOQangoyHSPjm3J1COuc9Tcco80HdjzVhlNLjYz2MtBJUDh+qjD
         AMj6N9kFJte6G+20v07srvUhYdC8OtBYffvUMShBRMh7mhKz3z2mBquM+ER2T3+BXXEz
         /eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9jlkZc4l57z4gYpyUQhwFM4YMqSzrWiY9Ig9xmWZ6CM=;
        b=EE6QpEpq3m+kTawiQN5d80+PGoTfKnOpWzPs5PO+t5EWMoNJn647ThuowD8Bz5FHZ3
         wbSDFWruVML73WnN7u5smXKvNwiN8PfwIHcsDbQ6D+uKMuur4SQHfwuJwAWI3GzDUeHl
         7qpIm9XiDtB0ndVZVhzLgoQEqu8YU2xo0SWJhfUXrt9g/eNwpmTKOd2ICXX51uZovUuE
         ERt6x9hIXlaSBJHrzRWu59vf4queUP37M64EG79O+mf/lEh2tQadCZwAthRg9c6aC2iW
         rfVcU9cHhWyEqO5Hy71bczaI+BobZvi5akeunqIhMsHF2/4tGQy8veh+ny8ytvOq1uTf
         TAfA==
X-Gm-Message-State: AOAM5323/v63H3faBY8CMRcesr01HzcPiy05rbSK0JKVay1xvGlrqWRa
        8K6+gtIjw0KtvwOg9IQkmNEFaA==
X-Google-Smtp-Source: ABdhPJyy7I1OkZgc4AkQUPBPTiQ7mj6++oGWXw9qnwTSeqFRDGqwzlOIcW/m6hQeVd08Xgli2eFfiw==
X-Received: by 2002:a17:90b:1213:: with SMTP id gl19mr10767093pjb.55.1615783985061;
        Sun, 14 Mar 2021 21:53:05 -0700 (PDT)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id ms21sm9350052pjb.5.2021.03.14.21.53.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Mar 2021 21:53:04 -0700 (PDT)
Date:   Mon, 15 Mar 2021 10:23:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Prashanth Prakash <pprakash@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: cppc: simplify default delay_us setting
Message-ID: <20210315045302.hdmu5ca4f7z3y5ki@vireshk-i7>
References: <35ac53f3efdfe58337fb66ad899b548dfa3bbc1b.1615603452.git.tom.saeger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ac53f3efdfe58337fb66ad899b548dfa3bbc1b.1615603452.git.tom.saeger@oracle.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-03-21, 19:50, Tom Saeger wrote:
> Simplify case when setting default in cppc_cpufreq_get_transition_delay_us.
> 
> Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 8a482c434ea6..2f769b1630c5 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -216,26 +216,16 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
>  {
>  	unsigned long implementor = read_cpuid_implementor();
>  	unsigned long part_num = read_cpuid_part_number();
> -	unsigned int delay_us = 0;
>  
>  	switch (implementor) {
>  	case ARM_CPU_IMP_QCOM:
>  		switch (part_num) {
>  		case QCOM_CPU_PART_FALKOR_V1:
>  		case QCOM_CPU_PART_FALKOR:
> -			delay_us = 10000;
> -			break;
> -		default:
> -			delay_us = cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> -			break;
> +			return 10000;
>  		}
> -		break;
> -	default:
> -		delay_us = cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> -		break;
>  	}
> -
> -	return delay_us;
> +	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
>  }

Applied. Thanks.

-- 
viresh
