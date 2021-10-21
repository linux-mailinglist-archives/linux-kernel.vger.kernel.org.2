Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1592443620C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhJUMrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhJUMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:47:31 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146D7C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:45:16 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g20so1263300qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pxhy3qc+nLWV5NWxoq4OHeKw3idC+IYA3epA9bvPejk=;
        b=L+v3jRHgl6uBQFFizZfYICZ72rZEDgb/ZWV8LFZ/rtUmA8ZNqFV2vhjWphXjJMN5V8
         8iehxfu/vahXIk/LGnAQDIFfYqSl+JU1eRp3oUv+g0xiu6QsRQsgwVGghhgTQaIKc4+C
         JvgCYqkv/2MwB8CoCojZt8bcPuS7G61HsyAByItQzZmsy5kzuOzfiHB770dNi9rDSb/v
         t3FrEf08/DWwIMi0Zqw+eg91fyUngwrkuejt4d8qshN+gGHHlFNf33vdR60XQoyMfvUN
         npPPRUDGZRjKEqkq77VjYnNkKSz6AM9BD9P94EiEkT/UKkdzTZLJLs9etAU60YMagkID
         iSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pxhy3qc+nLWV5NWxoq4OHeKw3idC+IYA3epA9bvPejk=;
        b=N0Cv2roo0dYJUGW6dC/dAPsfjuo9PUWEDnMNb73shWv/iccLCeNsF62vJhQiKQcojt
         qT588b05iEdqGkVSXQHrgH5hbaN4NemQ2t7w5xTyR6foExUt0K2X+Gq3DpE4mAA5jNjy
         8b+EW59P1RqAwwc2BmCRy1fa46fnyluaJu5Hbo8dUAxywXDDLZgisDTCzjVycvD0Hicf
         dY+gYs8PpNyUnP9y/mNnyg2IqZ1o63c8ANP4DkN9iTW5pjQLx9eAGLM1bil6OR9MmV3l
         2KPwJM3AYSqTMVB0j9v0+SCusi/xbpfN+H/xEYpZtRSvIMwL0YBZafBMETZPaJnpaIuN
         iSuQ==
X-Gm-Message-State: AOAM532sE+IgjFmqOkHoGd+m5tDp9ydZsaVMH3b/tWOoHTo3TKSjOhOB
        5y1UcQpLBDOexO3KKFSJRWbvztfLamECpRK1zwTmew==
X-Google-Smtp-Source: ABdhPJxc5HIDGeKoTqFiVw34gzJ1Cmf9gRhaMzaaJ4P1uyfIselDlKQCosG9umHucSmhzaQo/HFYUjEz7bqDeFSsRec=
X-Received: by 2002:a25:bd50:: with SMTP id p16mr2476950ybm.350.1634820315230;
 Thu, 21 Oct 2021 05:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
 <20211019123537.17146-3-vincent.guittot@linaro.org> <20211021094412.GC3891@suse.de>
In-Reply-To: <20211021094412.GC3891@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 21 Oct 2021 14:45:03 +0200
Message-ID: <CAKfTPtAQ3V6nRbrFfZCM7m+VteVwQi2o3k8Cqf9eGAKRBdwrvA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] sched/fair: Skip update_blocked_averages if we are
 defering load balance
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021 at 11:44, Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Oct 19, 2021 at 02:35:34PM +0200, Vincent Guittot wrote:
> > In newidle_balance(), the scheduler skips load balance to the new idle cpu
> > when the 1st sd of this_rq is:
> >
> >    this_rq->avg_idle < sd->max_newidle_lb_cost
> >
> > Doing a costly call to update_blocked_averages() will not be useful and
> > simply adds overhead when this condition is true.
> >
> > Check the condition early in newidle_balance() to skip
> > update_blocked_averages() when possible.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>
> The Signed-off-by seems to be in the wrong order but otherwise

The right signoff sequence should be:

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

But I skipped the last one which was only a rebase and my signoff was
already there

>
> Acked-by: Mel Gorman <mgorman@suse.de>
>
> --
> Mel Gorman
> SUSE Labs
