Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79415321C03
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhBVP7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhBVP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:59:42 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC69C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:59:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i9so4076419wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=po7ZCyqFMyZIWV0p+8IMI9gFAeID81WPSqIoGNYvua4=;
        b=fitIDR6W4Ci+br3LK2dzGYqKIbRNFwbYQEgmdMCexm1YPkbyoVtvbc1NF4YkJL8nNd
         oGueKlRsp6xf5+mSYK/QvaENI0gvDdX754/WjAazUEaCHNQO8RrKZkgf9k0cyJKobpYv
         5dzvGb9dyLIYuemAALc9ChJLvb+kaz3jjE4EGLVKbhl+2Bpa0Nxj1eFnGRKp+ImvLOAM
         pmh6+9sgWN+hQeDNf0DfKCqUm+7+Vt3dup6dnbZAkzLRfO4hFEAippBZRrJfn9piZCmT
         5Ig/RJiYFquARoeI4oAmCVxbF1RUDlr0IrBtvHzlIpHmkWZ7fJB/BQsLf/0pd0b8VZFq
         RqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=po7ZCyqFMyZIWV0p+8IMI9gFAeID81WPSqIoGNYvua4=;
        b=A028H/ld3qp6OoHPJU+DcUoh6nKDsKoM2zir9byz+b20ok5xMKndiB6+iAgIMOZZ4X
         RHRxiuz2ogguRQvl0YM0RHDIS0MztAkPLvu47lGkT44m9oynxew5etNWhnjrHnLWf7HP
         tLqo91FtMsag4yALUYe/NsYdLtDBnWH0a6I98nVkpfk6E2NEW+xr1rlcsj7o2VyFnalA
         9NxLvvU4cTXioHR/R2lGB/u5gL261dqLx20+KOjhJgZXj3YluM4TTVMfBcxiGPUa1rND
         aGtsDJbthj4GmKKtzkizcoES8/lAVhYBS8u3j5J/7Ru80nFDbfX+llh/Xo3+JrwEbayQ
         1QaA==
X-Gm-Message-State: AOAM5306bCL88dnV39fP3TDRvUplpoYushTtNrT2Cdd7ewBksg1X3aRH
        4wnZyMqhQRWdp+Iw7JLF8DXnRQ==
X-Google-Smtp-Source: ABdhPJyYvaJziWChoNOVN8K56NaGcK8bo0ZZQF6xR4BYaiJD6oQWIEoupJgKmlnuEyj7PSw5xu1YLA==
X-Received: by 2002:a1c:28c1:: with SMTP id o184mr20172452wmo.183.1614009539785;
        Mon, 22 Feb 2021 07:58:59 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id w81sm26221109wmb.3.2021.02.22.07.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:58:59 -0800 (PST)
Date:   Mon, 22 Feb 2021 15:58:56 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: Fix task utilization accountability in
 cpu_util_next()
Message-ID: <YDPUwKKYgZfzzCJm@google.com>
References: <20210222095401.37158-1-vincent.donnefort@arm.com>
 <YDODN1rnTqfTQOug@google.com>
 <20210222113602.GA286874@e120877-lin.cambridge.arm.com>
 <YDOiKH/XQDUKcrPU@google.com>
 <20210222150151.GA124800@e124901.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222150151.GA124800@e124901.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 Feb 2021 at 15:01:51 (+0000), Vincent Donnefort wrote:
> You mean that it could lead to a wrong frequency estimation when doing
> freq = map_util_freq() in em_cpu_energy()?

I'm not too worried about the map_util_freq() part, I'm worried about
the schedutil aggregation. Specifically, when a task is enqueued on a
rq, we sum its util_avg to the rq's util_avg, and the _task_util_est()
to the rq's util_est.enqueue member (as per util_est_enqueue()).

Now, in schedutil, sugov_get_util() calls cpu_util_cfs(), which does the
following:

	static inline unsigned long cpu_util_cfs(struct rq *rq)
	{
		unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);

		if (sched_feat(UTIL_EST)) {
			util = max_t(unsigned long, util,
				     READ_ONCE(rq->cfs.avg.util_est.enqueued));
		}

		return util;
	}

And that value will be the base for frequency selection. cpu_util_next()
tries to mimic this as accurately as possible, by doing the sums
independently, and then computing the max, exactly as we will do when
the task is enqueued and a freq update is generated.

> But in any case, the computed energy, being the product of sum_util with the
> OPP's cost, it is directly affected by this util_avg/util_est difference.

Sure, but we're not going to fix it by messing up the OPP selection part ;-)

> In the case where the task placement doesn't change the OPP, which is often the
> case, we can simplify the comparison and end-up with the following:
> 
>   delta_energy(CPU-3): OPP3 cost * (cpu_util_avg + task_util_avg - cpu_util_avg)
>   delta_energy(CPU-2): OPP2 cost * (cpu_util_est + task_util_est - cpu_util_est)
> 
>   => OPP3 cost * task_util_avg < task_util_est * OPP2 cost
> 
> With the same example I described previously, if you add the scaled OPP cost of
> 0.76 for CPU-3 and 0.65 for CPU-2 (real life OPP scaled costs), we have:
> 
>   2.3 (CPU-3) < 7.15 (CPU-2)
> 
> The task is placed on CPU-3, while it would have been much more efficient to use
> CPU-2.

That should really be a transient state: having a util_avg much larger
than util_est.enqueued is indicative of either a new task or a workload
changing behaviour. And so, chances are all the estimations are wrong
anyways -- it's hard to do good estimations when the present doesn't
look like the recent past.

But in any case, if we're going to address this, I'm still not sure this
patch will be what we want. As per my first comment we need to keep the
frequency estimation right.

> > > When computing the energy
> > > deltas, pd0's is likely to be higher than pd1's, only because the task
> > > contribution is higher for one comparison than the other.
> > 
> > You mean the contribution to sum_util right? I think I see what you mean
> > but I'm still not sure if this really is an issue. This is how util_est
> > works, and the EM stuff is just consistent with that.
> > 
> > The issue you describe can only happen (I think) when a rq's util_avg is
> > larger than its util-est emwa by some margin (that has to do with the
> > ewma-util_avg delta for the task?). But that means the ewma is not to be
> > trusted to begin with, so ...
> 
> cfs_rq->avg.util_est.ewma is not used. cpu_util() will only return the max
> between ue.enqueued and util_avg.

Right, my bad, it was the 'enqueued' member. But the rest of the
argument is still valid I think, but with s/ewma/enqueued :-)

Thanks,
Quentin
