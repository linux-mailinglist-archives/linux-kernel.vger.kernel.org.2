Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8063C1B1D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 23:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhGHVnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 17:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhGHVnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 17:43:07 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBE1C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 14:40:25 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id x6so3572676qvx.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X04tcKXa7hFEehVhGpumTDGOPBdfX4n0IkKTDrQdgMI=;
        b=W1oZZzqpf6gxAFkRB9yGMvnIAM8TSfq+X3VRQUEVVXMXrfR2ZwUNGHs0NA5Vofb94J
         7v5Y+vSGdYpRXRz9xGFt9ANLqHvJkHv9dBgQlHNU/EimvI4nTd3jhdvnrxghP4WGvmuM
         O5eZGSMna5lzQ/fN4xemsrRE+IH2AfSWerxc6NBuJ1nbKa3juenlp347rrYTij3hKIkP
         VGJp6cpQeAvlTRL5vl9nH0utTLIZA8UX8271PJ5YvN7Yz5MHMT+yPkCdxM3X8160mCJV
         KBLRQbUSLSRzuwV8HYmcGmJUXf+2jqHJoVeFVf9aoljCxwSTBrcBjc7r2g2NwnuSIue6
         H+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X04tcKXa7hFEehVhGpumTDGOPBdfX4n0IkKTDrQdgMI=;
        b=i7UbUgsLnxueW3BJ656ZPGEHvPMiDiWJDLNxFSkMmxk+Zm+dKjBp+X8lvGvwn67+w2
         Eqmsje1RGYxcmZ6Mr5oWHyew+vjcGGF9qstWFqrmpXdhKP/SOxrP8QThxVd4ihFlaLm4
         UswiaSxgWs1GWgeOmm6sqX8z/TzB6vIkpT8VIKEba2wzjuPfVlrhDw1PdCCQq7BaGzm7
         dPbwcdhROa1Okmk0dXo8Vv3fW9vkNyLjJ8b9llHEmBV/zqjozSIbZRsRobnOFA19aY1C
         9dJFBL9RnM6Fa7HNvalniEU842GO2VjkrS5Fa+mH9pNci3f0PWJlzUyjRflaTd2/tRTM
         ivUA==
X-Gm-Message-State: AOAM531jK2R9GFvJu5gpawxUfaHQDZY9V/B4GZuzQHw2jNKFOubhLZmw
        41ZahJCy1+LjMhF3EO8PwnlsKQ==
X-Google-Smtp-Source: ABdhPJyCj0Bip0e8fLTg2zNGYdN69r9A0+iv9qeSlSw4AqQRYRpiDcI/avhqQZQnUQiZVSO4BPtW1Q==
X-Received: by 2002:a05:6214:29ef:: with SMTP id jv15mr7195839qvb.1.1625780424291;
        Thu, 08 Jul 2021 14:40:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8649])
        by smtp.gmail.com with ESMTPSA id k6sm1458865qtg.78.2021.07.08.14.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 14:40:23 -0700 (PDT)
Date:   Thu, 8 Jul 2021 17:40:22 -0400
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
Subject: Re: [PATCH v4 1/1] psi: stop relying on timer_pending for poll_work
 rescheduling
Message-ID: <YOdwxh3487PeMHRX@cmpxchg.org>
References: <20210708203648.2399667-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708203648.2399667-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 01:36:48PM -0700, Suren Baghdasaryan wrote:
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
> This patch also ensures correct ordering between clearing poll_scheduled
> flag and obtaining changed_states using memory barrier. Correct ordering
> between updating changed_states and setting poll_scheduled is ensured by
> atomic_xchg operation.
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
