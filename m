Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223193B33EB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhFXQ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:28:46 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D450BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 09:26:26 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id v5so6951316ilo.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrOCyYBIJY4cdtyBPlA6E/rCcTjWDsRIrK+3PqxcHdc=;
        b=LcHpz0yK06CBT6w7Wu1HQ7P9Vf39YiJzCWJCJ5kOatQ+sJmhGgEPL0AiKXgduYVvj6
         cn9RdRwWut0vT0NdMkvgPG+gFMeetZlV+OseG6HUSHFqG22n05RRUVIRv7iZnbf2WAp3
         gcz+oKeDGFTPRGxz5IETuW37Z1s44EH9oTjevsXq7l46bmFMAjveW24bBDwhjgfgB+S7
         GIf9NY58muChBJ8Pb5b73Hh4s+tvBTZMxo46dHd9SDrX8l72WW2WBO4aI+TgxZ6y1AE5
         /IX38IywG9gMIVF97wEAsnyjkdNkstjZDR+q3KcyupswxpFvjNJ+EVN77kcVs2arIg3F
         9gkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrOCyYBIJY4cdtyBPlA6E/rCcTjWDsRIrK+3PqxcHdc=;
        b=Zi2TaHvdLowUODAnaGNWug1bwpYIYZcylv056FsOnbZb3T1G+hKHwpQGIeBlgVGgh7
         4sEKcNhwr7jqtum/ZSIcuvXjsSmpuMo5EA/1QH2pYbkiEdzkP8jLIjOqHmpgmAkB6PIt
         0MuJ+wWPMj4xW/GUwbhwOR8dYJl24yuqSCMGaaURGWeUQAASs6/eJrHEEM0b26W3FLsj
         qQ1v9AUU5XR3HElip4UYTr5elpOrgmceFTZKKyKy2LZIuUgffi5pL8MkKA3TKmrABJ7r
         oqX5O+iUIBV2rWguN3rBOHpCg5jqC3dP2w36f0dRy5pJhlR34imhu9VNFBv3+u7gur9p
         6vLw==
X-Gm-Message-State: AOAM533rBEy/cT1IVqH8MWtguB8rAk3sMoStg9FN9QRv5r7eGsc5Zb4Y
        Vv/lg/kxRl/Ze0hIi5q2pvYVStOjqmMjxaGaBvcAOQ==
X-Google-Smtp-Source: ABdhPJy56vq0P3AItM7SlxjHkvpLxbOPsxB7g29rX7O/9lL/P+Quz1SXh7l9Og1Q/ea9psKq4Vgd/h47Gwmj3dFy3ug=
X-Received: by 2002:a92:2e08:: with SMTP id v8mr1331748ile.50.1624551986228;
 Thu, 24 Jun 2021 09:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <1623749684-65432-1-git-send-email-liuqi115@huawei.com>
 <1623749684-65432-2-git-send-email-liuqi115@huawei.com> <20210623225111.GA1057775@p14s>
 <0aac4467-3abc-026c-4989-22b87bc80dc7@huawei.com>
In-Reply-To: <0aac4467-3abc-026c-4989-22b87bc80dc7@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 24 Jun 2021 10:26:13 -0600
Message-ID: <CANLsYkyCGO6tVn7WWfw6BPJwsHPT6dbWmXHXAzEh8X-x=2ENGg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] Documentation: tracing: Documentation for
 ultrasoc framework and drivers
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Jonathan Zhou <jonathan.zhouwen@huawei.com>,
        f.fangjian@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +Example usage of perf::
> >> +
> >> +     $# ./perf list pmu
> >> +     cs_etm//                                    [Kernel PMU event]
> >> +    $# ./perf record -e cs_etm/@sink_smb0/ -C 0 --per-thread sleep 2s
> >> +    [ perf record: Woken up 2 times to write data ]
> >> +    [ perf record: Captured and wrote 0.288 MB perf.data ]
> >> +    $# ./perf report
> >
> > After reading all this and without looking at the rest of the patchset it seems
> > to me this work should go under drivers/hwtracing/coresight/.
> >
>
> So how about drivers/hwtracing/coresight/ultrasoc?
>

It's hard to say at this time - I'll advise further once I have
reviewed the other patches.

> > There is a lot of code to review and as such it will take me a fair amount of
> > time to go through it all.  Comments will be scattered over several days (weeks)
> > - I will set you know when I am done.
> >
> > Thanks,
> > Mathieu
>
> Ok, thanks for revewing this patchset
>
> Qi
> >
> >> --
> >> 2.7.4
> >>
> > .
> >
>
