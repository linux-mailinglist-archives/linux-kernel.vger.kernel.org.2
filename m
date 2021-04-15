Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B5E360E80
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhDOPQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbhDOPF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:05:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E952C061761
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:05:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r7so11639107wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wcc69JXO5Q47MiJVQ+7BFoE+NhPi4SuSbHkg+Zlz7ew=;
        b=ZCKe97NR4zQ8B062PdvBP2d0ue9p1J5r/RymmmfuWpy5WFtWxPPQO2PfgIKpeWkzQd
         pMchr6l0UexeqrS3scINxX634LfCX8EyNKPl46jiNyyYdYmTVMT595myK4a9a1ukgnCV
         3iNKnUaZfFCL+/RPfdIVLOcX8i7hu9h+rPRvXHmI7O4ySgXQKWT+/FeGPsxGicLIpILJ
         KAW/WGVBGbC/vxCskmmYBufWoAzmWC7XfhPt/TGqB68XJ8rKLOtfk+PrhaVWXV1cIQD8
         uL1JMKpHyzydh+oiG/W9WiuHvEyyyYk5SVmEZ87sp9VhWyQE2ZqJauXziMn64WPWiwPu
         yc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wcc69JXO5Q47MiJVQ+7BFoE+NhPi4SuSbHkg+Zlz7ew=;
        b=BmLSmSL0OqrvzK+nCII8V4Lnm2L3Z+US6hz+wqwZyS6sHDA36m3PVqJR0XOuKklocQ
         gI7F9uS1Zv8H2Kw5JdH9EhA7INTjvT+gmqeDjG8lXRne1eUf0zKP+1ob8UJUxjgdAn8w
         zqxHzg77TjyjdfRAnfTnEFmSVJKW8KiqF2n6x/Yl3VFWJoc5XsPXzeLzzJc5n1PRtoBc
         pzK3j4HMj9PoFycCYviOelOAtKk47AKuGOOcwF4WDd4LPdzMScTh24HkfFGnENWYgCqE
         5KX03HHrArHR9np1wvv4ov9OszrMeycJUfaVBmMXlqwZulF7lRtS4VU0qfVlNuuyaELg
         Ekyg==
X-Gm-Message-State: AOAM533aAUsxSBDJ3KYwv9m4nAxAV3sCnAzyWB53s1QqGmgC6XrqgUhH
        HBDCHqXn1CIVuAwKv3/Dhj0qNw==
X-Google-Smtp-Source: ABdhPJytMQejVWQNB6tMfL2ymW1WpchApEjfI1ds6I8w+KwVkNbWk8ZC2kaiNBvIFpmKw0epPwQI6g==
X-Received: by 2002:a5d:66cd:: with SMTP id k13mr4091160wrw.387.1618499129237;
        Thu, 15 Apr 2021 08:05:29 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id t19sm3239875wmq.14.2021.04.15.08.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:05:28 -0700 (PDT)
Date:   Thu, 15 Apr 2021 15:05:26 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <YHhWNo7a/MsnT3em@google.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg8s4VTQdiBNOpr@google.com>
 <20210415143453.GB391924@e120877-lin.cambridge.arm.com>
 <YHhU6pb8E5W2eeCX@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHhU6pb8E5W2eeCX@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 Apr 2021 at 14:59:54 (+0000), Quentin Perret wrote:
> On Thursday 15 Apr 2021 at 15:34:53 (+0100), Vincent Donnefort wrote:
> > On Thu, Apr 15, 2021 at 01:16:35PM +0000, Quentin Perret wrote:
> > > On Thursday 08 Apr 2021 at 18:10:29 (+0100), Vincent Donnefort wrote:
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -10,6 +10,7 @@
> > > >  
> > > >  #include "sched.h"
> > > >  
> > > > +#include <linux/energy_model.h>
> > > >  #include <linux/sched/cpufreq.h>
> > > >  #include <trace/events/power.h>
> > > >  
> > > > @@ -164,6 +165,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> > > >  
> > > >  	freq = map_util_freq(util, freq, max);
> > > >  
> > > > +	/* Avoid inefficient performance states */
> > > > +	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
> > > 
> > > I remember this was discussed when Douglas sent his patches some time
> > > ago, but I still find it sad we index the EM table here but still
> > > re-index the cpufreq frequency table later :/
> > > 
> > > Yes in your case this lookup is very inexpensive, but still. EAS relies
> > > on the EM's table matching cpufreq's accurately, so this second lookup
> > > still feels rather unnecessary ...
> > 
> > To get only a single lookup, we would need to bring the inefficiency knowledge
> > directly to the cpufreq framework. But it has its own limitations: 
> > 
> >   The cpufreq driver can have its own resolve_freq() callback, which means that
> >   not all the drivers would benefit from that feature.
> > 
> >   The cpufreq_table can be ordered and accessed in several ways which brings
> >   many combinations that would need to be supported, ending-up with something
> >   much more intrusive. (We can though decide to limit the feature to the low to
> >   high access that schedutil needs).
> > 
> > As the EM needs schedutil to exist anyway, it seemed to be the right place for
> > this code. It allows any cpufreq driver to benefit from the feature, simplify a
> > potential extension for a usage by devfreq devices and as a bonus it speeds-up
> > energy computing, allowing a more complex Energy Model.
> 
> I was thinking of something a bit simpler. cpufreq_driver_resolve_freq
> appears to be used only from schedutil (why is it even then?), so we

why is it even *exported* then ...

> could just pull it into cpufreq_schedutil.c and just plain skip the call
> to cpufreq_frequency_table_target if the target freq has been indexed in
> the EM table -- it should already be matching a real OPP.
> 
> Thoughts?
> Quentin
