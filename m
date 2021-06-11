Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53A93A3D13
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhFKH3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:29:00 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41489 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhFKH25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:28:57 -0400
Received: by mail-wr1-f52.google.com with SMTP id o3so4899100wri.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5n7ASjdVQX9++neRCXsv7Z55wQbm+s4kD6dVvYNgYZU=;
        b=RkGhur84xEjQsrcwc17SY0Ez3fwuqcn5f5rlRsDo2lCJhNvFrLOeuP6kE4LZBVcoHJ
         5nPcwz/cy8940sVu5oeagEQfRZ4DqX7vnn1dRk7+J8MZaWKGgPck/C2dGopKuSYUxWZQ
         2kIeB/JLDWIlTLKDsd196FK0pbJsiVkIifD32EzDG/Z+wLswZ81khODnZEVFWqNthTK3
         +3LbBXrt+orTfFFefYdpJl1iMNR3LWEnujy6HsW8QirKjUIF3U8zCeJDFSTsaZIwV9ib
         w7qmxIO7WP+0A1cTzFKMI8Jc22XfhERfpMzW5kv+/SMBtEOGHQnBAnNxsdJW8vC37j/0
         zZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5n7ASjdVQX9++neRCXsv7Z55wQbm+s4kD6dVvYNgYZU=;
        b=St0F/rbzQvMDzHU7GEI3X2+zZ/T9FEVjMDaFXwalToYPX7efBZcf1lbOU/PsR2aR2H
         RooLHzs0vN6n/wBjuGmmiIi2Td3JqZzd3ZgI2Q+3/GpnYuvvC8PFQa/T7xH0j0E/r0V5
         qMQZtBKGxJK4zsGXdnYpG7hM7pTHk4OCa+fC5CcQ1ngF5G+RNaZOHPwPudgE4lnCmWH/
         X4rGR6f4NX4nygs4lXkQnBqy7yOPnNFeg5GUq6C0TBv0bSuh1ORxxlIsCvuz0DNJTcMA
         R+RaRYFHdKgMCfobRgnVViQyMOlyuKSyLmT9k2aPcvb35whJcxYuU3Lt3W4FnGfYAIVo
         +rIA==
X-Gm-Message-State: AOAM530nnyPJcjAZq1H7Hu/UE1okMfLUNr1/+TyUhdYYa4lmKoJcNXx9
        cnRtu4p85I75t9JLtpSTWyFcBg==
X-Google-Smtp-Source: ABdhPJywDjMPIVHmBZnMC7XwmDy67BVO5LvTdapfKfYTMXfIQtvsTZrpK5D1YCs4I7vz0/6bxoXg2A==
X-Received: by 2002:a05:6000:232:: with SMTP id l18mr2382154wrz.88.1623396346083;
        Fri, 11 Jun 2021 00:25:46 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id a15sm7403125wrs.63.2021.06.11.00.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 00:25:45 -0700 (PDT)
Date:   Fri, 11 Jun 2021 07:25:42 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com, rickyiu@google.com,
        wvw@google.com, patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <YMMP9uqcCeDlt95F@google.com>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-2-qperret@google.com>
 <YMJiaO0IN2pN/EYY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMJiaO0IN2pN/EYY@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 Jun 2021 at 21:05:12 (+0200), Peter Zijlstra wrote:
> On Thu, Jun 10, 2021 at 03:13:04PM +0000, Quentin Perret wrote:
> > The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
> > active task to maintain the last uclamp.max and prevent blocked util
> > from suddenly becoming visible.
> > 
> > However, there is an asymmetry in how the flag is set and cleared which
> > can lead to having the flag set whilst there are active tasks on the rq.
> > Specifically, the flag is cleared in the uclamp_rq_inc() path, which is
> > called at enqueue time, but set in uclamp_rq_dec_id() which is called
> > both when dequeueing a task _and_ in the update_uclamp_active() path. As
> > a result, when both uclamp_rq_{dec,ind}_id() are called from
> > update_uclamp_active(), the flag ends up being set but not cleared,
> > hence leaving the runqueue in a broken state.
> > 
> > Fix this by setting the flag in the uclamp_rq_inc_id() path to ensure
> > things remain symmetrical.
> 
> The code you moved is neither in uclamp_rq_inc_id(), although
> uclamp_idle_reset() is called from there

Yep, that is what I was trying to say.

> nor does it _set_ the flag.

Ahem. That I don't have a good excuse for ...
> 
> I'm thinking it's been a long warm day? ;-)

Indeed :-)

Let me have another cup of coffee and try to write this again.

Thanks,
Quentin
