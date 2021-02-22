Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CAE321D54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhBVQpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhBVQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:44:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D899C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:43:43 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v21so1067900wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 08:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jPRsaEa5vUBDAV+YM6wLvtVhhlfjRcm7BzNc5iCS4sY=;
        b=vdQYAqjv5wsEdnZ5YQOvOsZ+kRkDiXJ3iRkSNfowvbBQ5gOpWq/DF0b4xWCChan6j3
         Opu/Ira96c/urawggjhjNn7oaatmYByAResk0E9jPRn2caGDbhX5WJgbgCE6B1Okgcb0
         3JYzVO1atSYmRYWoQA7qxN3oMT452+WKy14XXAit5mBj8cd3je3xh7H8DW8PrBimq8CA
         jrpA/aGziU4/htWQ0piUPBLUvQn5+IRjIr5E1Z73bRppDdqXDQAEPCwixA40kR33uScP
         3gS/HFBHbsYD/VsQQl6Xd6UDHWiRTa96I/+uE9qp1duKqzjsy9enIhqWM926EiN79KM/
         keJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jPRsaEa5vUBDAV+YM6wLvtVhhlfjRcm7BzNc5iCS4sY=;
        b=agmnTf2Tv6SHVX1mvvdU06O6MjREkBHiAZrs9QO8KZg1XJwZCRxtO5KtMEJsvgcfrT
         RkUDsVZ31gvaRwNGH0dSqHhFwdAuuHAk2wJZ8N6ajb2WG06OcF9vMrP+7yLuvFgesLVB
         zb11ZY6iFKCucKjpG32lO9iqMtWXnoTttlKrKX0TXgpXn6NKy4faJFZTs1o/DkVs4eIf
         OdNePP3f0WT2sPOa/4uENpuPFRzNJCHFf87VQBN2gSFEkAIA300pNtAiVFS/h6tK8b6L
         UYEvM0UomPsdGSd0KnpbCTNzEUspzN2TbeSRahh+o8FzUZPizVq9cAKT6cqvTXaDR7xZ
         f7ew==
X-Gm-Message-State: AOAM530iLhWgXDVIoX5GH83gdHxbQSaCN5DMa9P7hgQrnuJljjg6aFHn
        nWQdkuw9m9KgvW6zwRhp47m++A==
X-Google-Smtp-Source: ABdhPJz6K9/nIAcyv4qk+mgY28pDR9Op91W6n374fqlCrLutVuuGVz0j9V0Jn88uL/3DkEvgPOuTvg==
X-Received: by 2002:a1c:f702:: with SMTP id v2mr20446477wmh.131.1614012221835;
        Mon, 22 Feb 2021 08:43:41 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id m3sm25918046wmb.19.2021.02.22.08.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:43:41 -0800 (PST)
Date:   Mon, 22 Feb 2021 16:43:39 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: Fix task utilization accountability in
 cpu_util_next()
Message-ID: <YDPfO1ixfb+8PNm0@google.com>
References: <20210222095401.37158-1-vincent.donnefort@arm.com>
 <YDODN1rnTqfTQOug@google.com>
 <20210222113602.GA286874@e120877-lin.cambridge.arm.com>
 <YDOiKH/XQDUKcrPU@google.com>
 <20210222150151.GA124800@e124901.cambridge.arm.com>
 <YDPUwKKYgZfzzCJm@google.com>
 <YDPajlnvgkonocpp@google.com>
 <20210222163947.GB225035@e124901.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222163947.GB225035@e124901.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 Feb 2021 at 16:39:47 (+0000), Vincent Donnefort wrote:
> On Mon, Feb 22, 2021 at 04:23:42PM +0000, Quentin Perret wrote:
> > On Monday 22 Feb 2021 at 15:58:56 (+0000), Quentin Perret wrote:
> > > But in any case, if we're going to address this, I'm still not sure this
> > > patch will be what we want. As per my first comment we need to keep the
> > > frequency estimation right.
> > 
> > Totally untested, but I think in principle you would like something like
> > the snippet below. Would that work?
> 
> You preempted my previous email :)
> 
> Yeah, that looks like what we want, I'll give a try.

Cool, thanks.

And ofc no strong opinion about the implementation details, this can
most certainly be optimized in some way so have fun :)

Cheers,
Quentin
