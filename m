Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B083390EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhEZDt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhEZDtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:49:25 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CE3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:47:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r1so9587949pgk.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ea/o3iNGjziq8XLCHU1LuVy5yxgZ5rFIHpuk1hyA/9g=;
        b=pW5ceqOfiEM/3E6y8uAO2jZnTHk/gwIN9M3DNqVe49b4Yp98p7Xc/VcrCwdyJB1LkI
         pv6SA3PwvtzYC28wGyA5bZuHaXz6NOGUatxr+2snDme9me7yEssrTQ/VNxjKlkqEle+y
         +QXJMMp1OV0W0QnI4/jLGiWs7t2YicpmE7RgeRGfE9EV9SNZmVcQYINo+qsW4eIGB1WX
         cbRqNT9hNrgAkLRv+hLVml6AT8N18pkxjrUzncmjUkxVEAIApcHcGc/F+IG7cqrqaXOM
         0Tk4OyRxep47tOSuHJMvLGcEC4dyXTi3+uKSYxlyoAxBl9Ank/KYcrZBBLXVM9n9Db6x
         pE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ea/o3iNGjziq8XLCHU1LuVy5yxgZ5rFIHpuk1hyA/9g=;
        b=WAI9ODNLTf5gAHOPM/0wx8s4wWp5ay2mjr8G8VYVx8Xz+jsJD/IyUcd/+YssDJlo9M
         pxmYWRqhzL/K08XsAqhuNebo/BE/d286IOAkY1qWS9i7jvCZYxHGUFu4Xa2s/T3AbIP3
         6sR0U4VDFenE/S8oR3gSS3aIehcFJLIq8fl/g72Z0QHnBoi7hgwv+gxHyTfHBX/EhQgi
         8LhqnZKgHmwrZCfiUpx+0VV17q1Tb6Vhsv1mNw9fQyPyG1gXId0CnR3cJ+vhI2ytVg+n
         ryPVPaymmjz/hbVqvKKeh7dk3st5Jo7xSXFUoeDfSARygttRQvZwxbs0Xxc7ByWJ5zfM
         J2sw==
X-Gm-Message-State: AOAM532Qn7+gaqQf02nwDK4vjAKZizY1xpohTezc05ytkczrdDy7rHev
        kICnizV0Xi7Jzpm83MoSGwyliw==
X-Google-Smtp-Source: ABdhPJyZmVQbpV10D6drykzd27F0aT5i/KTyV5Nbi1oQNp8zmUY4ni+HmEFLpeH0b2uzO4ATgn6vMw==
X-Received: by 2002:a63:36ce:: with SMTP id d197mr18399152pga.151.1622000873435;
        Tue, 25 May 2021 20:47:53 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id s23sm3083965pjg.15.2021.05.25.20.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 20:47:53 -0700 (PDT)
Date:   Wed, 26 May 2021 09:17:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 0/3] EM / PM: Inefficient OPPs
Message-ID: <20210526034751.5fl4kekq73gqy2wq@vireshk-i7>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-21, 17:54, Vincent Donnefort wrote:
> We (Power team in Arm) are working with an experimental kernel for the
> Google's Pixel4 to evaluate and improve the current mainline performance
> and energy consumption on a real life device with Android.
> 
> The SD855 SoC found in this phone has several OPPs that are inefficient.
> I.e. despite a lower frequency, they have a greater cost. (That cost being 
> fmax * OPP power / OPP freq). This issue is twofold. First of course,
> running a specific workload at an inefficient OPP is counterproductive
> since it wastes wasting energy. But also, inefficient OPPs make a
> performance domain less appealing for task placement than it really is.
> 
> We evaluated the change presented here by running 30 iterations of Android 
> PCMark "Work 2.0 Performance". While we did not see any statistically
> significant performance impact, this change allowed to drastically improve 
> the idle time residency.   
>  
> 
>                            |   Running   |  WFI [1]  |    Idle   |
>    ------------------------+-------------+-----------+-----------+
>    Little cluster (4 CPUs) |    -0.35%   |   +0.35%  |   +0.79%  |
>    ------------------------+-------------+-----------+-----------+
>    Medium cluster (3 CPUs) |    -6.3%    |    -18%   |    +12%   |
>    ------------------------+-------------+-----------+-----------+
>    Big cluster    (1 CPU)  |    -6.4%    |    -6.5%  |    +2.8%  |
>    ------------------------+-------------+-----------+-----------+
> 
> On the SD855, the inefficient OPPs are found on the little cluster. By
> removing them from the Energy Model, we make the most efficient CPUs more
> appealing for task placement, helping to reduce the running time for the
> medium and big CPUs. Increasing idle time is crucial for this platform due 
> to the substantial energy cost differences among the clusters. Also,
> despite not appearing in the statistics (the idle driver used here doesn't 
> report it), we can speculate that we also improve the cluster idle time.

First of all, sorry about not replying earlier. I have seen this earlier and was
shying away to receive some feedback from Rafael/Peter instead :(

I think the problem you mention is genuine, I have realized it in the past,
discussed with Vincent Guittot (cc'd) but never was able to get to a proper
solution as the EM model wasn't there then.

I have seen your approach (from top level) and I feel maybe we can improve upon
the whole idea a bit, lemme know what you think. The problem I see with this
approach is the unnecessary updates to schedutil that this series makes, which
IMHO is the wrong thing to do. Schedutil isn't the only governor and such
changes will end up making the performance delta between ondemand and schedutil
even more (difference based on their core design philosophy is fine, but these
are improvements which each of them should enjoy). And if another governor wants
these smart decisions to be added there, then it is trouble again.

Since the whole thing depends on EM and OPPs, I think we can actually do this.

When the cpufreq driver registers with the EM core, lets find all the
Inefficient OPPs and disable them once and for all. Of course, this must be done
on voluntarily basis, a flag from the drivers will do. With this, we won't be
required to update any thing at any of the governors end.

Will that work ?

-- 
viresh
