Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E793B9054
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 12:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhGAKJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 06:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhGAKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 06:09:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A99C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 03:07:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id w13so4087345wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 03:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zpmAOCzRySbZCKV9TN6wh7VgVHZsKnoonSB3NRG/zws=;
        b=gnX/S7FElC8N+gTwx1xy7eGLymi9BvTtqU7DXMNvTrpJtTiiSa/gLgqbwsPK+Z/Mkl
         n4rwy4qAkoLyULwJQLtnLKjUPq94EcoQqH8rW3gqc/LSmJPSepOcctPfDAyDjCuNJEzN
         hcdtbDKxNwGjYHNRwDe2o2/VwgXpMhKr7k9f8tjr2e4/q6EBiOl+o3Qqe46/tyLnbNWW
         waJdRF1xXJeRX+UH2sNFkBVTyFpNjm0EULJ3ML5QcTOtuPWY+vla7jhpV1Awj/JFd6l1
         td9GMioabVYAqy8hhI6kdGUHWX+nGTGqE1nnmhTOU1QthPFR52On5KRbICRT3Ml0CRQ7
         KxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zpmAOCzRySbZCKV9TN6wh7VgVHZsKnoonSB3NRG/zws=;
        b=VAnxZqilMIpMxure61hDmAOeVGr7qT7wNo7dinWo81JhQMYY4gt/Rx347Oah9kGT+P
         dBAevCH2N1qLHS8pOFe56YZam26zvNHQlI7tfC3KmCM0UAGU2n1Ot83mLkcrTNmkYl6y
         63dmmOSN2utS2PxMwx9fr3UWR5tOWMgEUFwG8Udjj61FEwiXKujQw1xyDZTmkmMm3aTn
         Qnr4ULddok7N1dDt6vbuuBTCbjmLnjvRD8EBZSaDxrJ+CkIBen/ql2GgFL9pSrrrFQTT
         nt0JQn/oN8H2z1OxgNR5LBL1bRQKuU08oPGTFVm4DK4Fi+2bYqrMFHrlOtR3mgsSjww8
         UgAQ==
X-Gm-Message-State: AOAM5311BGuvJyV8AOvVgp5GArtVJXII2Gn2VLFnXOCzGMwa4nd4hOyt
        P93yFYxzJ8uMrxtc52cKwiwavg==
X-Google-Smtp-Source: ABdhPJx51abgXqqlnEKiVud3LYNplXtT1DFkrx1/2EUk/m0sOsHss4AEU+6ebM3y2evn4rFc1ZutIQ==
X-Received: by 2002:a1c:9d8f:: with SMTP id g137mr9390577wme.13.1625134041718;
        Thu, 01 Jul 2021 03:07:21 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id z3sm5536231wrv.45.2021.07.01.03.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 03:07:21 -0700 (PDT)
Date:   Thu, 1 Jul 2021 10:07:18 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <YN2T1qnalRUKNcXt@google.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-2-qperret@google.com>
 <20210630145848.htb7pnwsl2gao77x@e107158-lin.cambridge.arm.com>
 <YNyRisb3bNhDR0Rh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNyRisb3bNhDR0Rh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 Jun 2021 at 15:45:14 (+0000), Quentin Perret wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b094da4c5fea..c0b999a8062a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -980,7 +980,6 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
>         if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
>                 return;
> 
> -       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
>         WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
>  }
> 
> @@ -1253,6 +1252,10 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> 
>         for_each_clamp_id(clamp_id)
>                 uclamp_rq_inc_id(rq, p, clamp_id);
> +
> +       /* Reset clamp idle holding when there is one RUNNABLE task */
> +       if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> +               rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
>  }
> 
>  static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
> @@ -1300,6 +1303,13 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
>         if (p->uclamp[clamp_id].active) {
>                 uclamp_rq_dec_id(rq, p, clamp_id);
>                 uclamp_rq_inc_id(rq, p, clamp_id);
> +
> +               /*
> +                * Make sure to clear the idle flag if we've transiently reached
> +                * 0 uclamp active tasks on the rq.
> +                */
> +               if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> +                       rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;

Bah, now that I had coffee I realize this has the exact same problem.
Let me look at this again ...

