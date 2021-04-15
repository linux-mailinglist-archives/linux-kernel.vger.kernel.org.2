Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890D6360A56
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhDONRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhDONRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:17:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:16:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g9so7255905wrx.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NKejnveXNi5sKQ3Fqa03VCfcV7AALd2c36ccz7nhPZY=;
        b=ba6yy8JJ2NkhGLg2FXH94QCAJwG/HzFyRsAvCFc2WH8bdvAq4Ou7Dj/t+mLuWyHUP5
         p83FLHxXC1vkKLcHKmmsqWEy6wjWbGdUzumINwnJMu0myqEoR+EgZRR4E9cQfcLPb1mk
         qd0kQTif5m9NPRTVER/al96QKXCRNfrOvsDRsZHaE+2H5wEhHkJ6x6nl7LElU/7zjcVx
         Wk7mNtuZpqoCeVVW3cdE2W3PLIo2j6x7pl2AuPY2CTi6aS/mAk7etwqaf7tRPpSG/BH1
         JvtenQM2vmZxjSKSXFV2DYyJJ1Y+/1PcU2VtHdb7chZekR3sjVWsBb9mJKwhQisi0hDh
         Q1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NKejnveXNi5sKQ3Fqa03VCfcV7AALd2c36ccz7nhPZY=;
        b=cGcFdbvKgw4Wv2V7ygqIPvxj3rZIt1oSS2/phhGNdd0Wkx4fV+lR+FGbpv+VCHfdt3
         ddOPwqvcoiHBIenqROO3XJKxejwDAOg14sCIKWCvrBDAg92paJQAldwcxed292NNLSKh
         5ONLmW3utDPHC3I7v9r0+/V6/nmj/wgpPZOlpynBNrSFBmek0MHSctqTvGB0/kiq807I
         gIrtbdbRqmpir7hfGjw4xx0ICDgG48KWI0WIO3Qeh7F0iV0MI5l2+DFtbxE751j0bBgT
         vg2g2TdsFMlEogRjwqtyo49Glp/FHbz8egcMwYkQCq/DHqrIfi8dvqSdzrspUtLg6SjH
         2y/Q==
X-Gm-Message-State: AOAM533PcuOv7cr+YQDW8S4FSYLGIC8/cVC7ZUH9pl5HhYhVEpZ2qXgE
        2heK45cLhQIpezvN5NcRglJlSw==
X-Google-Smtp-Source: ABdhPJxnEOUyAdmWKbK1/Gr1j9sErW51Sk0p5PhFGVckJwsRyUGTQ5aaYvbcIE6YM7zEGp0le51qKw==
X-Received: by 2002:adf:eb4a:: with SMTP id u10mr3587905wrn.409.1618492598330;
        Thu, 15 Apr 2021 06:16:38 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id n9sm3134003wrq.86.2021.04.15.06.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 06:16:38 -0700 (PDT)
Date:   Thu, 15 Apr 2021 13:16:35 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <YHg8s4VTQdiBNOpr@google.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 Apr 2021 at 18:10:29 (+0100), Vincent Donnefort wrote:
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -10,6 +10,7 @@
>  
>  #include "sched.h"
>  
> +#include <linux/energy_model.h>
>  #include <linux/sched/cpufreq.h>
>  #include <trace/events/power.h>
>  
> @@ -164,6 +165,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  
>  	freq = map_util_freq(util, freq, max);
>  
> +	/* Avoid inefficient performance states */
> +	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);

I remember this was discussed when Douglas sent his patches some time
ago, but I still find it sad we index the EM table here but still
re-index the cpufreq frequency table later :/

Yes in your case this lookup is very inexpensive, but still. EAS relies
on the EM's table matching cpufreq's accurately, so this second lookup
still feels rather unnecessary ...

>  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>  		return sg_policy->next_freq;
>  
> -- 
> 2.7.4
> 
