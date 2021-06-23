Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E1F3B1BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhFWN6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhFWN6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:58:18 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E876AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:56:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id d2so3101954ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1f+5SV/sKKdVD+KkZH0IXa6QMqcFSI8JGYCiF1TdD4k=;
        b=dBTP92imt0I9HU+05kls9sQhXxMKLcysBBwH+S4miexo3dqJyu+O+rQynNCgaX0qdm
         eNPI+YUE0oApsiGFtxNHOpXVnRmJS5miXMCAGHXVM8wmxqDMV7gj3eBgohN9RLeCGC9P
         49YJ1XlgShyegR64ROQ7iLwhFZ91jWP5BTcJdyWzYgIznVd05+5H5YHy3hUWHRZV/wmL
         IWGvSS0mzQOYseCSV5uVWAtmZFvzYKVVyQDvG3I0lBJkJFiZWTUpMWXkltpwtLOtsy9c
         jESTDl3aZ8tl/nRmvr5gfs+qDttx04H/Kf+Y1+oMB1rBrNw2gofObjYCgkVyr2zimNVm
         5Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1f+5SV/sKKdVD+KkZH0IXa6QMqcFSI8JGYCiF1TdD4k=;
        b=ad8sbPKRDDzEsOuGHEH1pyOThhOjopDlzFXy9pW0leAkI3ZdVXtn6qxJQUDrjpH4Q2
         oeNSPw673X75aR9KTS+cChxIzyW4PcNOlZCVfg18lki6L6u1gOgVTQzhILovCrYo/2CN
         H4bIbCekGznwFadz7W3YgnlEtqzZqSGRHQeH8ySsTxZe1cZhTmXhMbJPr8uoXcfLzeKG
         MpprdzSFq4KN36ElsP17edELhguNVlzveUsgIlIPgt1MQXC12PJ631+mNQrGaAaLn/Y6
         P95+HM4H3J1za7U1zTV+ZoJRm0fBXO5ORn9fvFJNvotL4WefXCAnpxm8cv66d5WT4Ums
         Qa8Q==
X-Gm-Message-State: AOAM533SR9MRMqLWq4NELo5DbjajMwwstZFXFYTAT5h819yE8t6gvbEt
        pACZXpqd45VRs1aAiTpYvol9GAauZxjqnydmISw/VN9/1j9u3Q==
X-Google-Smtp-Source: ABdhPJxlUoNcCWDmNAtxOnwl+M5yGlxw6Qr0+aRWuR5aZ7bwSqa9mI0ZgpmUj6tJ5fQ0P8MVzLExn4R+QzuICDbg4K4=
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr7799901lji.209.1624456559281;
 Wed, 23 Jun 2021 06:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <2ED1BDF5-BC0C-47CD-8F33-9A46C738F8CF@linux.vnet.ibm.com>
 <CAKfTPtDrHv4OOfPvwOE2DMNoucXQJ=yvvEpTVKrXghSdKEnZcA@mail.gmail.com>
 <20210622143154.GA804@vingu-book> <53968DDE-9E93-4CB4-B5E4-526230B6E154@linux.vnet.ibm.com>
 <20210623071935.GA29143@vingu-book> <CCB4222F-000A-44E8-8D61-F69893704688@linux.vnet.ibm.com>
 <6C676AB3-5D06-471A-8715-60AABEBBE392@linux.vnet.ibm.com> <20210623120835.GB29143@vingu-book>
 <CAFpoUr01xb9ZJF9mb2nmZDpUHXFH3VSbY3AU8-1owV-_7wVTPg@mail.gmail.com>
 <CAKfTPtB++3y4VnbKE_n=bgsqCfqXuF0KUsdB_cFhi9xAnMRubw@mail.gmail.com> <CAFpoUr3bHzrwvumw6R=2JVbKa_wmtT9cMf-mdDHxY0Png-N9Jw@mail.gmail.com>
In-Reply-To: <CAFpoUr3bHzrwvumw6R=2JVbKa_wmtT9cMf-mdDHxY0Png-N9Jw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 23 Jun 2021 15:55:47 +0200
Message-ID: <CAKfTPtAev0VgCmK3AUyTCoVA38YmskpB98q0kTrbEPK6e=1dTA@mail.gmail.com>
Subject: Re: [powerpc][next-20210621] WARNING at kernel/sched/fair.c:3277
 during boot
To:     Odin Ugedal <odin@uged.al>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 at 14:37, Odin Ugedal <odin@uged.al> wrote:
>
> ons. 23. jun. 2021 kl. 14:22 skrev Vincent Guittot <vincent.guittot@linaro.org>:
> >
> > In theory it should not because _sum should be always larger or equal
> > to _avg * divider. Otherwise, it means that we have something wrong
> > somewhere else
>
> Yeah, that might be the case. Still trying to wrap my head around
> this. I might be wrong, but isn't there a possibility
> that avg->period_contrib is increasing in PELTs accumulate_sum,
> without _sum is increasing. This makes the pelt divider increase,
> making the statement "_sum should be always larger or equal to _avg *"
> false? Or am I missing something obvious here?

The pelt value of sched_entity is synced with  cfs and its contrib
before being removed.
Then, we start to remove this load in update_cfs_rq_load_avg() before
calling __update_load_avg_cfs_rq so contrib should not have change and
we should be safe

>
> Still unable to reproduce what Sachin is reporting tho.
>
> Odin
