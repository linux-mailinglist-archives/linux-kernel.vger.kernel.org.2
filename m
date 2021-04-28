Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8919B36D813
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 15:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239768AbhD1NLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 09:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbhD1NLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 09:11:41 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E21C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 06:10:55 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id d1so19102060qvy.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCqiPinRq7KbHRxw2+1CXLudhDzt8HuMBSPIFpRiJPQ=;
        b=op0etC5f3iUvcNGm81crqMGzOmX3gWMXzJ1+rzIG/28W0YXHGVhDZikIUWNtLjtHcV
         N5bDI277rR4vU5GWFEoGG5TddC76vb5yoAhS5AjLe50YPBa0VSTIQCNkGP7lP70EA5Hv
         pum91yU819opegmcarW/Xkhb4kPpl34BF/gLEQUBRP5IrfDqM9nVUFrqoTYhr1qo3fZA
         Rtcw/hUDlSIljTYbcOcRo4awy0mbjxf1q+vVlTg0XEyAzEHgw7n8bmNv03Ll42cMok3m
         3CfnuCqpwzKRuyhuSLqHXPqQ3rg4wTERINUrqlNHeaT3RTloj79T+iEBFkNO+IHU/OAq
         vGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCqiPinRq7KbHRxw2+1CXLudhDzt8HuMBSPIFpRiJPQ=;
        b=a+tjlx0OLBcSdBcwO/iJ3hIlfLGQ6dqCBRTAQKk+4+5b7D3mX8otBVAgn0nD9HejpJ
         1Kv8wuDa9ZS939qMdFtwmm60uYwAmabHNMSYx+TOR+sPcryo/ILy4L+CQGO/0GvslC3G
         AuvZt6Wi8TRTvweIAPkLAkdaT78Ov0hmikX0llsyw0LX7VykrM0XGD5vdckyKo4wTXvj
         32QQF9B9H7h5h4QkJe4YvmkBODrurfrQs4NvsryihY6LqyXl0mCaes6Qo36hxNWvVFUi
         hqdE6WDxXO2z4lLIAVcGeO6xIKd1lEnVXm8TR2zuqpZ9vA9BsgUhyDZ0yn3Udpb+mD5P
         BDzQ==
X-Gm-Message-State: AOAM53351ydJ5lzbz5lUY59e7wyB+VAhvS2YEhMs5b4exw14ffd7ApG/
        rXvKEEhtZ68sWxS7MwdyyVX9ymbA+orz6Z0QVCVJFA==
X-Google-Smtp-Source: ABdhPJyVeqmrfxrJsE7YtnrS1x7yB+kJEsn0IMfmyFpC//oxcg5qEIlR8URP75kggnbwdsc51WSnkyAR7mbZAl+hl7I=
X-Received: by 2002:a05:6214:1321:: with SMTP id c1mr8670090qvv.9.1619615455110;
 Wed, 28 Apr 2021 06:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210425080902.11854-1-odin@uged.al> <20210425080902.11854-2-odin@uged.al>
 <20210427142611.GA22056@vingu-book>
In-Reply-To: <20210427142611.GA22056@vingu-book>
From:   Odin Ugedal <odin@ugedal.com>
Date:   Wed, 28 Apr 2021 15:10:22 +0200
Message-ID: <CAFpoUr1KOvLSUoUac8MMTD+TREDWmDpeku950U=_p-oBDE4Avw@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: Fix unfairness caused by missing load decay
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Would be good to mention that the problem happens only if the new cfs_rq has
> been removed from the leaf_cfs_rq_list because its PELT metrics were already
> null. In such case __update_blocked_fair() never updates the blocked load of
> the new cfs_rq and never propagate the removed load in the hierarchy.

Well, it does technically occur when PELT metrics were null and therefore
removed from this leaf_cfs_rq_list, that is correct. We do however not add
newly created cfs_rq's to leaf_cfs_rq_list, so that is also a reason for it
to occur. Most users of cgroups are probably creating a new cgroup and then
attaching a process to it, so I think that will be the _biggest_ issue.

> The fix tag should be :
> Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
>
> This patch re-introduced the del of idle cfs_rq from leaf_cfs_rq_list in order to
> skip useless update of blocked load.

Thanks for pointing me at that patch! A quick look makes me think that that
commit caused the issue to occur _more often_, but was not the one that
introduced it. I should probably investigate a bit more tho., since I didn't
dig that deep in it. It is not a clean revert for that patch on v5.12,
but I did apply the diff below to test. It is essentially what the patch
039ae8bcf7a5 does, as far as I see. There might however been more commits
beteen those, so I might take a look further behind to see.

Doing this does make the problem less severe, resulting in ~90/10 load on the
example that without the diff results in ~99/1. So with this diff/reverting
039ae8bcf7a5, there is still an issue.

Should I keep two "Fixes", or should I just take one of them?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..5fac4fbf6f84 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7941,8 +7941,8 @@ static bool __update_blocked_fair(struct rq *rq,
bool *done)
                 * There can be a lot of idle CPU cgroups.  Don't let fully
                 * decayed cfs_rqs linger on the list.
                 */
-               if (cfs_rq_is_decayed(cfs_rq))
-                       list_del_leaf_cfs_rq(cfs_rq);
+               // if (cfs_rq_is_decayed(cfs_rq))
+               //      list_del_leaf_cfs_rq(cfs_rq);

                /* Don't need periodic decay once load/util_avg are null */
                if (cfs_rq_has_blocked(cfs_rq))

> propagate_entity_cfs_rq() already goes across the tg tree to
> propagate the attach/detach.
>
> would be better to call list_add_leaf_cfs_rq(cfs_rq)  inside this function
> instead of looping twice the tg tree. Something like:
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 33b1ee31ae0f..18441ce7316c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11026,10 +11026,10 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>         for_each_sched_entity(se) {
>                 cfs_rq = cfs_rq_of(se);
>
> -               if (cfs_rq_throttled(cfs_rq))
> -                       break;
> +               if (!cfs_rq_throttled(cfs_rq))
> +                       update_load_avg(cfs_rq, se, UPDATE_TG);
>
> -               update_load_avg(cfs_rq, se, UPDATE_TG);
> +               list_add_leaf_cfs_rq(cfs_rq);
>         }
>  }
>  #else


Thanks for that feedback!

I did think about that, but was not sure what would be the best one.
If it is "safe" to always run list_add_leaf_cfs_rq there (since it is used in
more places than just on cgroup change and move to fair class), I do agree
that that is a better solution. Will test that, and post a new patch
if it works as expected.

Also, the current code will exit from the loop in case a cfs_rq is throttled,
while your suggestion will keep looping. For list_add_leaf_cfs_rq that is fine
(and required), but should we keep running update_load_avg? I do think it is ok,
and the likelihood of a cfs_rq being throttled is not that high after all, so
I guess it doesn't really matter.

Thanks
Odin
