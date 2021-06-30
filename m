Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABCD3B8673
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 17:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhF3Prt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbhF3Prs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:47:48 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBFEC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 08:45:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o35-20020a05600c5123b02901e6a7a3266cso1960290wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ENtviZFf6UB6WhzhBRX4oayXJFsy08o+zUtpcML1eY=;
        b=sDizoLBzqEtNrNupqrMoJqqdNSqgHESxaRCdnE5PdDJqat6n9Gu8dQHPR1n+Ow5+wX
         nLS/USgKRlgOWl/AuWbSwt9NMyL0HKDduu66WsBdYyjEn6YdxtmXLQH8YQM5ygK6hZxa
         rm8WVh4euy8DL5bA/+PvVzBEuxxlyNyd3jBuPOHRjecZ/aVraaI1CxTTQoh1tUb+1x3v
         /CiX6VH4SALj3i2GZpCwrTFaFUhHTyznY1W1JX3VaqdQK6NBYDiLpTs5huyiKk/Gb/DD
         mEc/ItQPKD76RQT22Kj790w8GaBnEqrapaJuzSwwM4Knur0K7iVlQYcYOxiCQ7jz1gnj
         96HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ENtviZFf6UB6WhzhBRX4oayXJFsy08o+zUtpcML1eY=;
        b=Ar0rk6JTD/FUKNGV31VWd3C7Z1MmUqFTjBO/L1sOEhFmpGEXB9mBPqq/015M/aG72c
         KU9jdSagKqCAGWbKbpjukh+yVQEolJeFValRed+J5wL3NqbnO032NoVXL8bh+9cbY9mS
         UN4WXOLV5fVPw7pZUzFvcuV+R3eHB876FPqdMFHGe9kVrMpupwR5Tpwot5N+/I0UrtLu
         qgYGS3+tKHBY7ZO7dy7fbItVkVfa8Gmq65dx6IrTcN/M80YZKVykn5P9vMO0CM3O3gNC
         MHf9YBM0f8n7O5gzvFODrvzZeu7aMotTYRe8be/UacefCqfT0OnEJEPf0sqYUyWOnO15
         aQzQ==
X-Gm-Message-State: AOAM532qjCXQGNYFJD7BN/sIUdrUaF5p+e1i9vA3LGkOaF5pxUWclgkp
        IDfG7HjfouXO/HcVhRm3spvto9yRQe0X8Kf8
X-Google-Smtp-Source: ABdhPJxXSM+xte/i3dUh9QxdLooYbrIzNQ+oCdy2XkFAgcFBEgMTKPiVFbPqBP3+ifpAs2Erpt0leA==
X-Received: by 2002:a1c:771a:: with SMTP id t26mr5505758wmi.36.1625067917656;
        Wed, 30 Jun 2021 08:45:17 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id w22sm6769228wmc.4.2021.06.30.08.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 08:45:17 -0700 (PDT)
Date:   Wed, 30 Jun 2021 15:45:14 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <YNyRisb3bNhDR0Rh@google.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-2-qperret@google.com>
 <20210630145848.htb7pnwsl2gao77x@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630145848.htb7pnwsl2gao77x@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Wednesday 30 Jun 2021 at 15:58:48 (+0100), Qais Yousef wrote:
> I just realized this needs
> 
> 	if (clamp_id == UCLAMP_MAX)
> 		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> 
> The code is only set for UCLAMP_MAX, so should be cleared for UCLAMP_MAX too.
> 
> Though there's ugly overload here:
> 
> 	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
> 		return;
> 
> This check would fail prematurely if UCLAMP_MAX was reset before UCLAMP_MIN.
> The code before your change would reset both then do the clear. But now when we
> do it from here, we need to be more careful about that.

Right, although this should all work fine as-is, I agree that relying on
the calling order is a bit dodgy and might cause issues in the long run.

What do you think of this instead?

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b094da4c5fea..c0b999a8062a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -980,7 +980,6 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
        if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
                return;

-       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
        WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
 }

@@ -1253,6 +1252,10 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)

        for_each_clamp_id(clamp_id)
                uclamp_rq_inc_id(rq, p, clamp_id);
+
+       /* Reset clamp idle holding when there is one RUNNABLE task */
+       if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+               rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
 }

 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
@@ -1300,6 +1303,13 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
        if (p->uclamp[clamp_id].active) {
                uclamp_rq_dec_id(rq, p, clamp_id);
                uclamp_rq_inc_id(rq, p, clamp_id);
+
+               /*
+                * Make sure to clear the idle flag if we've transiently reached
+                * 0 uclamp active tasks on the rq.
+                */
+               if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+                       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
        }

        task_rq_unlock(rq, p, &rf);
