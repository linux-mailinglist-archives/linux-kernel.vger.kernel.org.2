Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBF3360E13
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhDOPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbhDOPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:00:22 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A49C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:59:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so433245wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wEmeE+nRU2i2HuTEhl2l+nDu4F3N+EEwdYCFM019aAY=;
        b=A45SPYWVLdT7S1dswSXWtbcLIKQs4WiHE/Ut3PZ0xIiaRcL3umDmo8P9ZrwTDFF7V6
         YDKC6g0b1KhlecjvXgtySFWKVq2QdkQo3ARkALOHZ6iR40y5YaYTHl62khsxLAXngB7c
         uYneF1Yx836FyhliuVUFQPVgyur9q5JMyd3+Hp3PM8OmyHRFEVJa5x1Y9DGVkVOzcoA1
         mAHyIuuYFbu3alcwhnvS5wzJetRQ+vkZSlD+Os/ylplcUuJBtBoQ3zLOLpbgrpaC0zxX
         zd3u5giUf0USAYnGu5e+saklLbDrHTbUg8euRGtwECxLoaZPeSy2JNm4I5kGH7WDqmWp
         i8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wEmeE+nRU2i2HuTEhl2l+nDu4F3N+EEwdYCFM019aAY=;
        b=pG9vcaZR6uVWYuBySp4Jli3o8AAQhRO076/fNhFpWorvs6JO04wOlNSAl//hSZbwS2
         T6FjkpnbDFfH4YcbiYYpAA2ALWqQzbEM0FgO9v1+3fYhc/k40PlOmNkeQOSQ5T9AfzzA
         sQFjbnYlabHKEgaxVjviolClnbiPWOGyU25s9fX4DLBfFi7g+53t18d7DYGXHixQSSW6
         RX5WCbjwg5ucPi+X3+CxilA8yoRACo3dRtSxgAn18fOQPXZk6hCcbK+naIsUqhEph04Z
         G715DKKvKLF1TN3aSGkAyr6+lJ3TqR3pV7GuGoSIgVrHl3ZZ6BvWKYDLmEeX4DvNNVMH
         SxXw==
X-Gm-Message-State: AOAM533+bziXh4PtGJCgav5i1Ey8C+wf8wGHSJvLUCvPyerBrhOJ3iv9
        JNfQRShaLBu7DWHxZtQ7++rXVmBXdIDA9Q==
X-Google-Smtp-Source: ABdhPJxqlVPWGCKsf2QzXPRd1bPNJjdG3jhIFGVI5LZlI6SFJOqN137fv0fwdNdQbhLlYHVVqC+ipA==
X-Received: by 2002:a05:600c:3544:: with SMTP id i4mr3497996wmq.38.1618498797586;
        Thu, 15 Apr 2021 07:59:57 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id 3sm3820681wma.45.2021.04.15.07.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 07:59:57 -0700 (PDT)
Date:   Thu, 15 Apr 2021 14:59:54 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] PM / EM: Inefficient OPPs detection
Message-ID: <YHhU6pb8E5W2eeCX@google.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
 <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
 <YHg8s4VTQdiBNOpr@google.com>
 <20210415143453.GB391924@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415143453.GB391924@e120877-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 Apr 2021 at 15:34:53 (+0100), Vincent Donnefort wrote:
> On Thu, Apr 15, 2021 at 01:16:35PM +0000, Quentin Perret wrote:
> > On Thursday 08 Apr 2021 at 18:10:29 (+0100), Vincent Donnefort wrote:
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -10,6 +10,7 @@
> > >  
> > >  #include "sched.h"
> > >  
> > > +#include <linux/energy_model.h>
> > >  #include <linux/sched/cpufreq.h>
> > >  #include <trace/events/power.h>
> > >  
> > > @@ -164,6 +165,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> > >  
> > >  	freq = map_util_freq(util, freq, max);
> > >  
> > > +	/* Avoid inefficient performance states */
> > > +	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
> > 
> > I remember this was discussed when Douglas sent his patches some time
> > ago, but I still find it sad we index the EM table here but still
> > re-index the cpufreq frequency table later :/
> > 
> > Yes in your case this lookup is very inexpensive, but still. EAS relies
> > on the EM's table matching cpufreq's accurately, so this second lookup
> > still feels rather unnecessary ...
> 
> To get only a single lookup, we would need to bring the inefficiency knowledge
> directly to the cpufreq framework. But it has its own limitations: 
> 
>   The cpufreq driver can have its own resolve_freq() callback, which means that
>   not all the drivers would benefit from that feature.
> 
>   The cpufreq_table can be ordered and accessed in several ways which brings
>   many combinations that would need to be supported, ending-up with something
>   much more intrusive. (We can though decide to limit the feature to the low to
>   high access that schedutil needs).
> 
> As the EM needs schedutil to exist anyway, it seemed to be the right place for
> this code. It allows any cpufreq driver to benefit from the feature, simplify a
> potential extension for a usage by devfreq devices and as a bonus it speeds-up
> energy computing, allowing a more complex Energy Model.

I was thinking of something a bit simpler. cpufreq_driver_resolve_freq
appears to be used only from schedutil (why is it even then?), so we
could just pull it into cpufreq_schedutil.c and just plain skip the call
to cpufreq_frequency_table_target if the target freq has been indexed in
the EM table -- it should already be matching a real OPP.

Thoughts?
Quentin
