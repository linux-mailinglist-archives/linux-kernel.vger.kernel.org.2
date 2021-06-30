Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D23B8A4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 00:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhF3WGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 18:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhF3WGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 18:06:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6959DC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:04:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g24so2767648pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1xj3mjgl+Arki73EKAV3PgrCtaGzeKnSIXIchlBxI7Q=;
        b=ZFbyjeWHwvRHjkoWH0VLZRj64VuV8dW50SYuFmOa8Qf0sCuKNptjXInz4yTTYxYvY6
         0h+molYKLDQv+Y5fbYAImma6LRY5JjOW2+wn5LdYM4hKBGiW4Bxluh8gELH0CaPrkliV
         0H+1OG7nuAPOUV56lP4jPUrHsmFQoYqdnoA2a8t8ZEPChGwzz0UoWrbDgc+SQ3diZCL/
         6UdItCFGiKSXjoiO7xzMpQcYlE1uYQfVDOz8r3QAieMCveeGdoTm/6j60uXFWo20HvL8
         qkmBuKjFzyJacM7aOTntm3tfT7sdjJqvg2JowrAq3MkgURnMneU6rQrT44Cjrzn1xrn9
         SZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1xj3mjgl+Arki73EKAV3PgrCtaGzeKnSIXIchlBxI7Q=;
        b=CQyRA8FoXCA0GQnAMte0oUWeremXW5ZFAu+xDqGpDTyg4zxVgJWiwWC2xf2mnPCKDn
         b3qc8FpePlJRvtKffk34DiivfJyMdvmORojFjZhbsq/UVlgEHaQfCGy89avyZFXUUDCm
         aBCYt4vkD5XhWx/undyCCZ0MVwW8DBENayn/WP5t+HKBuGSwn+8jdHusJYVnq64091FY
         XosmraMZax59UCWrdtoRHwmnDy0k9JkE+AuRegaPBsrtuFpmwgToSeegoECdOO7EDK7P
         NqdgDymqndO9z4k2zLpohSGr4Xk9GpWMoLzYd5tF9VKiIDac4sotifXjCd9869M2BnJH
         ORxA==
X-Gm-Message-State: AOAM531Jnv973HXLc7G4zPz+MQRY8xOkjRfltYEyrBauy1ZzKuvMmd93
        jJSI9bD2uGL45AUW1kaW3mUwpQ==
X-Google-Smtp-Source: ABdhPJxz1ZMyumEp4ut6puBSe5M6KJD1Ou9m6zO5s120HNE35/ac+ogH5z1hWCJkO91lDKpKS2b7BQ==
X-Received: by 2002:a17:90a:db4e:: with SMTP id u14mr6487559pjx.120.1625090648854;
        Wed, 30 Jun 2021 15:04:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:14ba])
        by smtp.gmail.com with ESMTPSA id x4sm13788221pgr.40.2021.06.30.15.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 15:04:08 -0700 (PDT)
Date:   Wed, 30 Jun 2021 18:04:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, matthias.bgg@gmail.com, minchan@google.com,
        timmurray@google.com, yt.chang@mediatek.com, wenju.xu@mediatek.com,
        jonathan.jmchen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com,
        SH Chen <show-hong.chen@mediatek.com>
Subject: Re: [PATCH v2 1/1] psi: stop relying on timer_pending for poll_work
 rescheduling
Message-ID: <YNzqVh9fnpYVeP6j@cmpxchg.org>
References: <20210630205151.137001-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630205151.137001-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 01:51:51PM -0700, Suren Baghdasaryan wrote:
> Psi polling mechanism is trying to minimize the number of wakeups to
> run psi_poll_work and is currently relying on timer_pending() to detect
> when this work is already scheduled. This provides a window of opportunity
> for psi_group_change to schedule an immediate psi_poll_work after
> poll_timer_fn got called but before psi_poll_work could reschedule itself.
> Below is the depiction of this entire window:
> 
> poll_timer_fn
>   wake_up_interruptible(&group->poll_wait);
> 
> psi_poll_worker
>   wait_event_interruptible(group->poll_wait, ...)
>   psi_poll_work
>     psi_schedule_poll_work
>       if (timer_pending(&group->poll_timer)) return;
>       ...
>       mod_timer(&group->poll_timer, jiffies + delay);
> 
> Prior to 461daba06bdc we used to rely on poll_scheduled atomic which was
> reset and set back inside psi_poll_work and therefore this race window
> was much smaller.
> The larger window causes increased number of wakeups and our partners
> report visible power regression of ~10mA after applying 461daba06bdc.
> Bring back the poll_scheduled atomic and make this race window even
> narrower by resetting poll_scheduled only when we reach polling expiration
> time. This does not completely eliminate the possibility of extra wakeups
> caused by a race with psi_group_change however it will limit it to the
> worst case scenario of one extra wakeup per every tracking window (0.5s
> in the worst case).
> By tracing the number of immediate rescheduling attempts performed by
> psi_group_change and the number of these attempts being blocked due to
> psi monitor being already active, we can assess the effects of this change:
> 
> Before the patch:
>                                            Run#1    Run#2      Run#3
> Immediate reschedules attempted:           684365   1385156    1261240
> Immediate reschedules blocked:             682846   1381654    1258682
> Immediate reschedules (delta):             1519     3502       2558
> Immediate reschedules (% of attempted):    0.22%    0.25%      0.20%
> 
> After the patch:
>                                            Run#1    Run#2      Run#3
> Immediate reschedules attempted:           882244   770298    426218
> Immediate reschedules blocked:             881996   769796    426074
> Immediate reschedules (delta):             248      502       144
> Immediate reschedules (% of attempted):    0.03%    0.07%     0.03%
> 
> The number of non-blocked immediate reschedules dropped from 0.22-0.25%
> to 0.03-0.07%. The drop is attributed to the decrease in the race window
> size and the fact that we allow this race only when psi monitors reach
> polling window expiration time.
> 
> Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger scheduling mechanism")
> Reported-by: Kathleen Chang <yt.chang@mediatek.com>
> Reported-by: Wenju Xu <wenju.xu@mediatek.com>
> Reported-by: Jonathan Chen <jonathan.jmchen@mediatek.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Tested-by: SH Chen <show-hong.chen@mediatek.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
