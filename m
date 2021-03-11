Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3291D336D00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhCKHWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhCKHWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:22:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD51C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 23:22:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso8897407pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 23:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MNNXBjyFBBg+ZOfSSdEcuVG7CkN6sHcDa7incDvsMj4=;
        b=inVEDgwGBQio+eYnQwGOqgiOqLZoTLz4zOJCGFyjXY495PngbnvjoG5nvIXKkBZu5U
         ZM3EEFoO2Wm1/SKDjIpEO3+fu0jqkTrmR7uScfS3em12PrLAxgEo9JpO5ygJhByGGBK1
         inv7JU2UK+XHhkLzLGiecN7nB4oGkKd+ym7U5I3FMk2jeT3tc3+YXqazPfUfFs6Qduzu
         IO/2bo+7+Yhf45fGyKH37deQFwIJfLfWDPrcVvsVpfAcwSQx1FgCVzE3VAp90QTkMqWj
         /AUF2A3CLVqKhMFy6tvOthjtWj7zM5ufKpzlmBErsztKzb7DEHWkFNFFm89r2qxEb8P4
         r+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MNNXBjyFBBg+ZOfSSdEcuVG7CkN6sHcDa7incDvsMj4=;
        b=CRMyeNa91XvyR9JD6RQP3WlCtIgubVAN9iK3EyflPx9TTupZwA76sphHfF5auq3v6d
         3vAMx7efA1tNg7ELGMcucjmCYgcUBIpaLXb9zhqs7WiGYsEyC6RCvnWycqPGwRWAq3Qf
         +gKZnC6E9NSnBreKDrmPJJVw0B61Mu3JMJrBx+9geIWGCnn4rdr/dqKPWTlZdG/tUu37
         UcWIje0CP7ncAbcDh2gIlPxRUnj+6k4KPdXNnS2/pYDgEIvPthzzfGkIPQKQnqc/92eR
         8tq8TfmhUG4KeyroxH/MWdSb7bTliHrNON5yyv2SZupHtTOW/jyErjqwP+Vh4RaOqCrS
         jh4w==
X-Gm-Message-State: AOAM533bdStre01gOkJ5q3WRQsI7b8CVxEWojpoq1Mf63Y3M6o5JFF/H
        ElKeYRlti4bT4zPrnpmj+W9JZftMoJmXOg==
X-Google-Smtp-Source: ABdhPJyUmk5L9/MKNyiCY8rn2invnJXnWqFXJPq+frVezy84HP9fOnE+eF3+tuNv8H+q3Ei+qXw8cw==
X-Received: by 2002:a17:902:8f8c:b029:e3:7e6c:36fa with SMTP id z12-20020a1709028f8cb02900e37e6c36famr6934282plo.77.1615447337704;
        Wed, 10 Mar 2021 23:22:17 -0800 (PST)
Received: from google.com ([2620:15c:f:10:c4e3:28f1:33df:26ba])
        by smtp.gmail.com with ESMTPSA id y8sm1269919pjb.11.2021.03.10.23.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 23:22:16 -0800 (PST)
Date:   Wed, 10 Mar 2021 23:22:09 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Ben Gardon <bgardon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Subject: Re: [PATCH] mm/oom_kill: Ensure MMU notifier range_end() is paired
 with range_start()
Message-ID: <YEnFIZde1t+TF4y6@google.com>
References: <20210310213117.1444147-1-seanjc@google.com>
 <20210311002807.GQ444867@ziepe.ca>
 <YElwQU9mPUNwPg7q@google.com>
 <20210311015013.GS444867@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311015013.GS444867@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021, Jason Gunthorpe wrote:
> On Wed, Mar 10, 2021 at 05:20:01PM -0800, Sean Christopherson wrote:
> 
> > > Which I believe is fatal to kvm? These notifiers certainly do not only
> > > happen at process exit.
> > 
> > My point about the process dying is that the existing bug that causes
> > mmu_notifier_count to become imbalanced is benign only because the process is
> > being killed, and thus KVM will stop running its vCPUs.
> 
> Are you saying we only call non-blocking invalidate during a process
> exit event?? 

Yes?  __oom_reap_task_mm() is the only user of _nonblock(), if that's what you're
asking.

> > > So, both of the remaining _end users become corrupted with this patch!
> > 
> > I don't follow.  mn_hlist_invalidate_range_start() iterates over all
> > notifiers, even if a notifier earlier in the chain failed.  How will
> > KVM become imbalanced?
> 
> Er, ok, that got left in a weird way. There is another "bug" where end
> is not supposed to be called if the start failed.

Ha, the best kind of feature.  :-)

> > The existing _end users never fail their _start.  If KVM started failing its
> > start, then yes, it could get corrupted.  
> 
> Well, maybe that is the way out of this now. If we don't permit a
> start to fail if there is an end then we have no problem to unwind it
> as we can continue to call everything. This can't be backported too
> far though, the itree notifier conversions are what made the WARN_ON
> safe today.
> 
> Something very approximately like this is closer to my preference:

Makes sense.  I don't have a strong preference, I'll give this a spin tomorrow.

> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 61ee40ed804ee5..6d5cd20f81dadc 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -501,10 +501,25 @@ static int mn_hlist_invalidate_range_start(
>  						"");
>  				WARN_ON(mmu_notifier_range_blockable(range) ||
>  					_ret != -EAGAIN);
> +				/*
> +				 * We call all the notifiers on any EAGAIN,
> +				 * there is no way for a notifier to know if
> +				 * its start method failed, thus a start that
> +				 * does EAGAIN can't also do end.
> +				 */
> +				WARN_ON(ops->invalidate_range_end);
>  				ret = _ret;
>  			}
>  		}
>  	}
> +
> +	if (ret) {
> +		/* Must be non-blocking to get here*/
> +		hlist_for_each_entry_rcu (subscription, &subscriptions->list,
> +					  hlist, srcu_read_lock_held(&srcu))
> +			subscription->ops->invalidate_range_end(subscription,
> +								range);
> +	}
>  	srcu_read_unlock(&srcu, id);
>  
>  	return ret;
