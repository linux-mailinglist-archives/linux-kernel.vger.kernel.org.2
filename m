Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8CB360ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbhDOPVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbhDOPVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:21:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B26EC061761
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:20:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a4so23714539wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xdNJQK64n+rYcTzZQUdQHuAaJLYEbKsP9vMQ4rSirIY=;
        b=GQCcxeiTgjI803y7fx7JO3lkRYSnDW5B8SBU3IO9CKTgZCH6skbxKHZ3drEEa5hcEs
         +QkYqgOx0W8WKXGg80a2Pic0tUpDaf2QRaHyOZxxRd/jRhDFhGeE+vSvKsHnW8Zc7usT
         iXZWmKJOc2Q/POOjnMs5+99AXc7PY7bXyF3B8no/EwytElfJg330zOR52DxuFwl5cF3/
         eey3qxmVEhEyikZhUJeJyPM3UHjIJV6L8rdWWcdRbLk476NbdT02B0wJbm+LrbriSRwo
         fkOmasVcip8WDBMMVeGYJHtoSi0O3UdEz48goKcFXL+1ENxfW5xhfn2LKk5iLmbkKK5l
         lm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xdNJQK64n+rYcTzZQUdQHuAaJLYEbKsP9vMQ4rSirIY=;
        b=t/CfCjeZwtHFSKiqUbfPPbIUkkoIOqXk1BFKO07eVsDMDpTuDncuvW92HhYeRdg7Pk
         Q5oMWpj8IVbZKAzhHR3hM/ScKh9k01Tc/BIYgtqQmf77tCiIXummDcQcLawnnG/nCrn4
         0mf8sZRVabiFo+/lnnxwjLp/52wjM6AcWVIVgbnTeX/Dm5GiNNZvzHFoVCXyENGJ+iHX
         sFW9FKMy77temIKfQSRqPzrCOLNc229oUgBj4ryjKdlwHe/D+7Bh5nfVYranPxmiDcSB
         Ci5uSHnmNnNgJwNTkRo/vZY5graYw+Sq425AFPi/cgvw2yxBKxwzP55ONgIC+YBcGTNG
         zZWA==
X-Gm-Message-State: AOAM530hMxLbu3qFGmPbvPONy+mpsVqjw7ZHg9TPWybo5GBbTH/4FR1A
        vnlbyAi9vAPquDjBqGAtI2UC2w==
X-Google-Smtp-Source: ABdhPJybj5e8jiHFlJGe+mYwbvkqoiNngk6xw6FNsIeNGsntfv/towgc4yB9bm6Zig2yAJe7KK5nyQ==
X-Received: by 2002:a05:6000:178c:: with SMTP id e12mr4153563wrg.42.1618500015899;
        Thu, 15 Apr 2021 08:20:15 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id o5sm3114164wmc.44.2021.04.15.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:20:15 -0700 (PDT)
Date:   Thu, 15 Apr 2021 15:20:13 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <YHhZrbLcUD6I83m1@google.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg8s4VTQdiBNOpr@google.com>
 <20210415143453.GB391924@e120877-lin.cambridge.arm.com>
 <YHhU6pb8E5W2eeCX@google.com>
 <20210415151446.GC391924@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415151446.GC391924@e120877-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 Apr 2021 at 16:14:46 (+0100), Vincent Donnefort wrote:
> On Thu, Apr 15, 2021 at 02:59:54PM +0000, Quentin Perret wrote:
> > On Thursday 15 Apr 2021 at 15:34:53 (+0100), Vincent Donnefort wrote:
> > > On Thu, Apr 15, 2021 at 01:16:35PM +0000, Quentin Perret wrote:
> > > > On Thursday 08 Apr 2021 at 18:10:29 (+0100), Vincent Donnefort wrote:
> > > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > > @@ -10,6 +10,7 @@
> > > > >  
> > > > >  #include "sched.h"
> > > > >  
> > > > > +#include <linux/energy_model.h>
> > > > >  #include <linux/sched/cpufreq.h>
> > > > >  #include <trace/events/power.h>
> > > > >  
> > > > > @@ -164,6 +165,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> > > > >  
> > > > >  	freq = map_util_freq(util, freq, max);
> > > > >  
> > > > > +	/* Avoid inefficient performance states */
> > > > > +	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
> > > > 
> > > > I remember this was discussed when Douglas sent his patches some time
> > > > ago, but I still find it sad we index the EM table here but still
> > > > re-index the cpufreq frequency table later :/
> > > > 
> > > > Yes in your case this lookup is very inexpensive, but still. EAS relies
> > > > on the EM's table matching cpufreq's accurately, so this second lookup
> > > > still feels rather unnecessary ...
> > > 
> > > To get only a single lookup, we would need to bring the inefficiency knowledge
> > > directly to the cpufreq framework. But it has its own limitations: 
> > > 
> > >   The cpufreq driver can have its own resolve_freq() callback, which means that
> > >   not all the drivers would benefit from that feature.
> > > 
> > >   The cpufreq_table can be ordered and accessed in several ways which brings
> > >   many combinations that would need to be supported, ending-up with something
> > >   much more intrusive. (We can though decide to limit the feature to the low to
> > >   high access that schedutil needs).
> > > 
> > > As the EM needs schedutil to exist anyway, it seemed to be the right place for
> > > this code. It allows any cpufreq driver to benefit from the feature, simplify a
> > > potential extension for a usage by devfreq devices and as a bonus it speeds-up
> > > energy computing, allowing a more complex Energy Model.
> > 
> > I was thinking of something a bit simpler. cpufreq_driver_resolve_freq
> > appears to be used only from schedutil (why is it even then?), so we
> > could just pull it into cpufreq_schedutil.c and just plain skip the call
> > to cpufreq_frequency_table_target if the target freq has been indexed in
> > the EM table -- it should already be matching a real OPP.
> > 
> > Thoughts?
> > Quentin
> 
> Can try that for a V2. That means em_pd_get_efficient_freq() would have to
> know about policy clamping (but I don't think that's an issue)

Indeed, and I think we can even see this as an improvement as EAS will
now see policy clamps as well in compute_energy().

> and probably
> we still have to do the frequency resolution if the driver declared the
> resolve_freq callback?

Yep, looks like this is unavoidable.

Thanks,
Quentin
