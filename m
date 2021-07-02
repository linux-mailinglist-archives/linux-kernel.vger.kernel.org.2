Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62E83BA01B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 13:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhGBL4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 07:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhGBL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 07:56:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EB6C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 04:54:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m18so12160684wrv.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 04:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RGPOT3H366fZx93hQt2SsGx1mCHCfBRViHjDfs+Lm/s=;
        b=IFx2OyMWmRP93kRo/ttT3AMMJCHeEHLe1s60J1bHaH0xTPsKVpyFI/qonn20zNulTy
         xI4BEJX+H+zgOlAZ7m8sFQz39yDRAJ6XXWqEV8/IE+PGobZsvLanFQAjEgv5+r9mFXjD
         bWYhSB6mzKjMz2A7qY8nxNEwtBof9j6lcEoexr8/9CzJ9+8n82BtMLlx86kqYACcpea7
         8NisP2ATv+6MIfVT3M5t3+shfWjG8SWtGDsWBmwTiNi7J0A3OVPi/UUUFZvY//sviSIR
         10HdTc1kxs/RUG58bOTmDTwHZL29v0ElvIBcfpsNDu2MVIkzoWJ6ScgqUrBhuqUtF8BE
         vOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RGPOT3H366fZx93hQt2SsGx1mCHCfBRViHjDfs+Lm/s=;
        b=k/mBxQ93yYM7qhB78ORfu5U3EmTHehXEs5xabcNfvdsZc5gSZoSDGxr377GddvUzC/
         kfJyoZxjVgmblxLHbEYqPuriqL9qGtAESMepcxhL4tpgrZ5X0bXAxp1OqoeYyNj2rbyc
         TSN/4CnUXmpoQNxout/SHjsbUWX9vjQ40Uf2IlCegYFeDPdqkGIfe4VtyVXN0HX/X3Hk
         q3nYNKkbGdXnLFVzHRr0YyBRqhD6Q2uqKZqtfqjVky8B9/hL0kd50s0UNzEY/ogJbkU+
         0jxveNAvXdJDy15eVXk+sxvUIfixcDhGQh3gDqxXTFyivD+8zmH2gANrZz5DWMw7UbX8
         u3HQ==
X-Gm-Message-State: AOAM533adbumUzj9xDUhIS7vTrEICk1f8G0EQ3lpQiXZyOS2lOS+XBfW
        HUzTFWX0kV3yTcFPrhQcwIf8YhYaJ9Jyzi8m
X-Google-Smtp-Source: ABdhPJzJtmTUEpNbSDW9Zy99I0eSvsfk1R2CZ01O5lxLIpq4ua2VISCv38Y2yxnjxH4+Ds6T4YRUGA==
X-Received: by 2002:a05:6000:1a43:: with SMTP id t3mr5526930wry.112.1625226850690;
        Fri, 02 Jul 2021 04:54:10 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id q5sm2864365wrx.57.2021.07.02.04.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 04:54:10 -0700 (PDT)
Date:   Fri, 2 Jul 2021 11:54:07 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <YN7+X+5NviroSqZY@google.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-2-qperret@google.com>
 <20210630145848.htb7pnwsl2gao77x@e107158-lin.cambridge.arm.com>
 <YNyRisb3bNhDR0Rh@google.com>
 <YN2T1qnalRUKNcXt@google.com>
 <20210701110803.2lka3eaoukbb6b4p@e107158-lin.cambridge.arm.com>
 <YN24bLOthLd6RIpF@google.com>
 <20210701145750.7mqat4ehja7ikbtc@e107158-lin.cambridge.arm.com>
 <YN3dUhsAHL2M4JbR@google.com>
 <20210701175932.66hiwvuia4drs4yl@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701175932.66hiwvuia4drs4yl@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 Jul 2021 at 18:59:32 (+0100), Qais Yousef wrote:
> On 07/01/21 15:20, Quentin Perret wrote:
> > > > Right or maybe we can just check that uclamp_id == UCLAMP_MAX here and
> > > > we should be good to go? That is, what about the below?
> > > 
> > > Wouldn't it be better to do this from uclamp_idle_reset() then?
> > 
> > That should work too, but clearing the flag outside of
> > uclamp_rq_inc_id() feels a little bit more robust to ordering
> > issues.
> > 
> > Specifically, uclamp_rq_inc() has the following pattern:
> > 
> > 	for_each_clamp_id(clamp_id)
> > 		uclamp_rq_inc_id(rq, p , clamp_id);
> > 
> > 	if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> > 		rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;
> > 
> > So, if we change this to clear the flag from
> > uclamp_rq_inc_id()->uclamp_idle_reset() then we'll have issues if
> > (for example) for_each_clamp_id()'s order changes in the future.
> > IOW, it feels cleaner to not create side effects in uclamp_rq_inc_id()
> > that impact the idle flag given that its very own behaviour depends on
> > the flag.
> > 
> > WDYT?
> 
> Do the clearing from outside the loop then to keep the pattern consistent?

Right, but I actually preferred doing it from here as we're under
task_rq_lock(), which means well behaved readers won't observe the flag
being transiently set. I could also refactor the locking, but oh well ...

> Anyway, I think there's no clear objective advantage. So I'll trust your
> judgement and promise not to complain with your final choice ;-)

:) Alrighty, I'll cook something.

Thanks!
Quentin
