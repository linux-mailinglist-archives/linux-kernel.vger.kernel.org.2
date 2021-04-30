Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF9C36F711
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhD3I0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhD3I0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:26:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8239C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:25:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d4so1147457wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fwsAIi/If273EsXT5ZuVqdKChgrly5h2K/eYVUgxNUw=;
        b=E2c0n7s7oitH0D8Ah/Z9gdAqOZT5sTY5j8ZANpTVQMovagfz1IGTS6a+Mk2yAQONft
         EiJci43FSglqefb1deZgQ77Fup1OScgoqfsQWP1SzQ2ajakMcDM9vpcnsbQFfCHuFHDQ
         1cjDADw6ogFz+xMq/Iary7PBGYKkXU4UBqIuHkVl3WNSpq0nUNHadSrWM9KfgjiD9E/m
         yBem9MlYIpjAds7zBRTO/beGkl2mXb0CE2HlZw+CkqoYzCs4v4Tos0s76rruvn87DppA
         eeHM+CVIz27/dR8t3jXsVXtxoGYHTPr7JscncKom3npeTBYs4BgqfvaQVmKwrqy88pRR
         xfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fwsAIi/If273EsXT5ZuVqdKChgrly5h2K/eYVUgxNUw=;
        b=eaT1EFyYPPZnnHQJAiUaXJ2ZktnLYdz7HtsiiVoPjYFNMpRqZh0ZID2XUeSngeavwD
         /hv/gQjVigGx0/1PSfhMYytFSsxTQM0br2BRzIDVUj4T+c0olbFIEy0ZUcX/GH+cGoYi
         ThaK65nYd+XfLqVJKXol7e1DT/snsK2Cn55Si/i4OTZSwN0F1uRQgUapab6pPXkg1xqD
         Dr6yeByoZSwWdIEBDZXFt9mKllftjdtyC4JEnBxh2JbXRmsZNqeQSGJ6mAgYbjNqOdKb
         YRS7tKYP+mCEGQD35HTgde4Y28WAHnhnlpswrd2jQB5TbPe3zvcuDARa17Lxoj+fHrEc
         hQvg==
X-Gm-Message-State: AOAM531S07rckDgV2ZbCZsqYcE2mEI9NijZlP+ws9a+x3d20R2EYxu7i
        aS7CirRjkE3G/l6pSYNb512i4Q==
X-Google-Smtp-Source: ABdhPJwKHdRlkFufn/Mu6LMApPOP55Uaraw0NAqqTP3u5bF/Kvqf/VTt+Qa8th+/Dont7liuKjsYRg==
X-Received: by 2002:a5d:64e6:: with SMTP id g6mr5224175wri.216.1619771157376;
        Fri, 30 Apr 2021 01:25:57 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id z2sm1491345wrg.6.2021.04.30.01.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 01:25:56 -0700 (PDT)
Date:   Fri, 30 Apr 2021 08:25:54 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH v2] sched: Fix out-of-bound access in uclamp
Message-ID: <YIu/EjZ8QsEl9sum@google.com>
References: <20210429152656.4118460-1-qperret@google.com>
 <CAKfTPtAfgVnMYkY_M+SDmNQDb_EsxSctQw-fkt2WJhczZakOjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAfgVnMYkY_M+SDmNQDb_EsxSctQw-fkt2WJhczZakOjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 Apr 2021 at 09:45:32 (+0200), Vincent Guittot wrote:
> On Thu, 29 Apr 2021 at 17:27, Quentin Perret <qperret@google.com> wrote:
> >
> > Util-clamp places tasks in different buckets based on their clamp values
> > for performance reasons. However, the size of buckets is currently
> > computed using a rounding division, which can lead to an off-by-one
> > error in some configurations.
> >
> > For instance, with 20 buckets, the bucket size will be 1024/20=51. A
> > task with a clamp of 1024 will be mapped to bucket id 1024/51=20. Sadly,
> > correct indexes are in range [0,19], hence leading to an out of bound
> > memory access.
> >
> > Fix the math to compute the bucket size.
> >
> > Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
> > Suggested-by: Qais Yousef <qais.yousef@arm.com>
> > Signed-off-by: Quentin Perret <qperret@google.com>
> >
> > ---
> >
> > Changes in v2:
> >  - replaced the DIV_ROUND_UP(a,b) with a/b+1 (Dietmar)
> 
> Doesn't this create unfairness between buckets ?
> 
> If we take your example above of 20 buckets, delta is now 52. Then we
> expect the last bucket to get the range [972-1024] but values lower
> than 988 will go in the idx 18.

Well, that's just the limitation of integer arithmetics isn't it?

> And the more bucket you will have, the
> worse it will be

Sure, but 20 is a hard limit, and if we ever need more than that then
maybe we should think about getting rid of the buckets altogether.

> Your problem comes from the fact that we use 1025 values instead of
> 1024.

I don't understand what you mean here. Right now we'll assign bucket id
20 for any clamp in the range [1020-1024], so I don't think we can
special case 1024.

> Wouldn't it be easier to have a special condition for
> SCHED_CAPACITY_SCALE value

As per the above, I don't see how that'll work.

Thanks,
Quentin
