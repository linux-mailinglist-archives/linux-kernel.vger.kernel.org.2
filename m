Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FEF352F0E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 20:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhDBSRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 14:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbhDBSRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:17:49 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53DFC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 11:17:47 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id x16so6153634iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccSWi23ioLarklHBwKpDmvtB7DFqOqi/sX0Oeizonp0=;
        b=XmdhjhrukGOaqMeDQ7vefBMkZG0SpnAqECA1nEiU4stSwWdD3bGqPgGonZZP9di1bC
         DXLSoc6O9uU06VC7LO4KcT/KynhsbnH7qwdyL7tGieL3GJArfG0jpRoblw1iXm+3r9NP
         KI5suCFU6ihF23FYR2HhpUQSIdaaeRdLy+oI+AgA3UqPDQHOTmq2/9y23T2jW5fsmZld
         JTYph/lNqyUAClmaTC5EQeExcOq79G+5Anasr+7lmNNM+Xl+hwWqQYSjs1oL1FTBtwf4
         sR8nEY0XW/mMC/xIBZ18rZd+3fOAyIXhRY5cvRghZsHE278TGRffpZVRq0gHVwtNWvLU
         UaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccSWi23ioLarklHBwKpDmvtB7DFqOqi/sX0Oeizonp0=;
        b=YbkRbynIfxvVvzHhLlQ9yfWAl+HnHQoXrlEhVqBgERKJ/plq2bcuqXcy+foW1wQU2Y
         fQvJHeTapp+FrrD8cXlc6iILF8pr6kvei1pqqHTn6s+g/Uwp1RgcTKPwEmMY6OkojxMx
         pQwakx6STbEpTjUOCwklGIvwz76P+svx8mRKS8ttWzYwE5pi+Ofbqx6Tzc5t2zNfIwui
         FIRj3rwWR5tJ3cVW9C1zENqjnIzEXgCoQJI6+mYQTzJCGM5gf9IEHUy1FqomS+MhWX2+
         GmQ3yxftURd17uy19b2fyAv9z7VQfqe13o0KiYaffOg54Pd2AC/gOb3wveBX/uMKaOlV
         OlQg==
X-Gm-Message-State: AOAM533uUROZw+QlBIuZI/aDwR8Ptu5c9DritJJFwypWSBWwYUGmvbKu
        7wmwOQfCZYgi2CB4vDk34STsoFLq9G9Ns9RBPVtTd5wgCeE=
X-Google-Smtp-Source: ABdhPJxAH8vNy4Vood2FbsrbqH29MujqOf22SqtN2QCg+MTbrklHoTMZTnm1Z5oCkNE0tAeNEhc3Xv5GEHwZSe1WM7c=
X-Received: by 2002:a05:6638:2591:: with SMTP id s17mr13637097jat.87.1617387467177;
 Fri, 02 Apr 2021 11:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com> <e022da6b-4bc1-759e-ab81-dd3270a9ddde@linux.alibaba.com>
In-Reply-To: <e022da6b-4bc1-759e-ab81-dd3270a9ddde@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 2 Apr 2021 11:17:36 -0700
Message-ID: <CAKgT0Ufy8zEPn86JNFja+2rZ-xkfrVs4yD4Zov9NX1E+bbNz2A@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm/page_reporting: Some knobs and fixes
To:     xlpang@linux.alibaba.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 9:09 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>
> On 3/26/21 5:44 PM, Xunlei Pang wrote:
> > Add the following knobs in PATCH 1~3:
> >  /sys/kernel/mm/page_reporting/reported_kbytes
> >  /sys/kernel/mm/page_reporting/refault_kbytes
> >  /sys/kernel/mm/page_reporting/reporting_factor
> >
> > Fix unexpected user OOM in PATCH 4.
> >
> > Xunlei Pang (4):
> >   mm/page_reporting: Introduce free page reported counters
> >   mm/page_reporting: Introduce free page reporting factor
> >   mm/page_reporting: Introduce "page_reporting_factor=" boot parameter
> >   mm/page_reporting: Fix possible user allocation failure
> >
> >  Documentation/admin-guide/kernel-parameters.txt |   3 +
> >  include/linux/mmzone.h                          |   3 +
> >  mm/page_alloc.c                                 |   6 +-
> >  mm/page_reporting.c                             | 268 ++++++++++++++++++++++--
> >  4 files changed, 260 insertions(+), 20 deletions(-)
> >
>
> Hi guys,
>
> Looks "Alexander Duyck <alexander.h.duyck@linux.intel.com>" was not
> available, so Cced more, any comment?
>
> Thanks!

Yes, my Intel account has been offline since October. If you need to
reach me, my gmail is the best way to go.

As far as the patch series itself I am not exactly thrilled with it.
There seems to be a number of spots where things are being changed
such that the CPU overhead will be much more significant.

The cover page should actually say what the patch set is attempting to
accomplish. In the patch descriptions you have told us what you are
doing, but the why isn't completely clear. For example I am not sure
if the issue addressed in patch 4 was present before patches 1-3 were
introduced.
