Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E76E393CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 07:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhE1FLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 01:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhE1FLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 01:11:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5882DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 22:09:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e15so1088164plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 22:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZopcSkX2Q3KN5uKuj5D0fi40cQECPF2z0euTxDiILU=;
        b=SfxTGuAjzEBDyY66hS65kd2J9YsRydRNyh5jKrWVqvHuhGvc6uI7bZBfcaAJX6gtdv
         jZVYWv67anr00Jv8EDbUOuB3bY9sAf8phNTqa3oUvMcY2eVTO4yc+n2peRhvxtYJCeKO
         9IB0DYT0GKp+HE6opyMtHEnuSC7z/SoI9thDRyiexlBkYQPNIxiDpRWILRtBtZ7tNVgn
         d3Ra/M7tX02h+3+mTCdOKamfpuLSRRd2TBmT/BGga6Z2+EDGZb1sMbtA4Y6ngo20Gg76
         tBXI45p2RMmhl5VGF/xyKUoxnypyubole6xHK/Sw+vOEKGyyhegAOJtQ5FUTOSWrgt8Q
         O1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZopcSkX2Q3KN5uKuj5D0fi40cQECPF2z0euTxDiILU=;
        b=BHp6mSz1YDPXXwGNRichS18Xpfv6qNhw50bo6DSMjMq2X+dltaWh0O9oN3gmGzpsy1
         IMPM4LzrfOmwSPgtUoL2eafn3hbXJCiCUG7nn5NgMfjrSoTw6AUCy7CLbIcE2IpBMfVn
         gyboPn+S105LmZrIBOkGko+mKtPzaDijh9kyuh/Eq0mrU/u8B2kcWpv+cWpJLh2lBW6R
         zBZ1F+TdSX4H0BoMI7490gX4iAW9wN3CToHmKKbVXBbtxk5ZeM9nVEq5NlS64OcMSkzg
         gPDAk4XunoPvuMQMO7nt5/EBVnUolKW+A0mHn0EozYfoqAn5JNszeXKghMa0OCfnaeyh
         FQgQ==
X-Gm-Message-State: AOAM530T0mOmqEShoYPZIFI5E71Ael/6UDLj9+ezvXf3IfQl0aAWmaaF
        hQGlmRT4OFrFJODsa9H0Hc66Anbg88jjaw==
X-Google-Smtp-Source: ABdhPJxDNLPlvoZGNfzjZBi4Hg4Je83MrpPodZTYhZ3VQE3ivEWoN5q2BPv4lh/PVQTI/NnG9mSeZg==
X-Received: by 2002:a17:902:bf46:b029:ee:b949:bd0 with SMTP id u6-20020a170902bf46b02900eeb9490bd0mr6450274pls.14.1622178577194;
        Thu, 27 May 2021 22:09:37 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id 10sm3382180pgl.39.2021.05.27.22.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 22:09:36 -0700 (PDT)
Date:   Fri, 28 May 2021 10:39:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
Message-ID: <20210528050934.muji5bv7ed4k4t6j@vireshk-i7>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
 <YKy516IKPfsZj3cY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKy516IKPfsZj3cY@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-05-21, 10:48, Peter Zijlstra wrote:
> On Fri, May 21, 2021 at 05:54:24PM +0100, Vincent Donnefort wrote:
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 4f09afd..5a91a2b 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -10,6 +10,7 @@
> >  
> >  #include "sched.h"
> >  
> > +#include <linux/energy_model.h>
> >  #include <linux/sched/cpufreq.h>
> >  #include <trace/events/power.h>
> >  
> > @@ -153,6 +154,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >  
> >  	freq = map_util_freq(util, freq, max);
> >  
> > +	/* Avoid inefficient performance states */
> > +	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
> > +
> >  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> >  		return sg_policy->next_freq;
> >  
> 
> This seems somewhat unfortunate, it adds a loop over the OPPs only to
> then call into cpufreq to do the exact same thing again :/

And that's why I feel it needs to be done at a single place, either disable the
OPP (which seems like a bad option based on what Lukasz and Vincent said
earlier), or make changes in the cpufreq core itself to search for the best
frequency (like adding another API to mark some frequencies as inefficient, and
take that into account while selecting next freq).

There is a potential of ending up selecting the wrong frequency here because
there are too many decision making bodies here and so corner cases.

-- 
viresh
