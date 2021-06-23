Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8623B1F12
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhFWQ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWQ5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:57:39 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53CBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:55:21 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id d2so3853844ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ax+qMkz9tc+3GIw6VBZG84/vn46E053CBBShLS/lu7Y=;
        b=CueGo6nhL0ih/I8+FW2BDzxSi8s4y6185nndbX4VnBGU3Q0H2Dp7iJ49iu+3Go58DR
         yqUuhfV3Ox29PVtvujH9wwUuCShzRU8yiOVxzFinEjKUAJAS0aTMVkDBL/dqryqKGyky
         NpznK3UeD2MPMmPb/Lv+GFPLtebrapqwECa55UF+u7pJn21DUBY2OP+7tjRH3FyOCpuH
         WOA2/vw1hBW/rfog/bzKCiV5ZjXIf28yVBXXXuGxf3/e4kKGxkUCeGguZxtnd+TI0VuF
         +oL0McSqtoJmyHof+hJzkoDTkfVTXv2p9QvJiEJIrRbohBXdMIrZa5ojlZUh2rPjduL7
         qDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ax+qMkz9tc+3GIw6VBZG84/vn46E053CBBShLS/lu7Y=;
        b=bp+MAYbLSIMy36N4MWEnmcYBK9hALrwR9VNUg9AtqaTZpePISqcJ8Avu2IUywJ4qLA
         buNOLO5qEghstdXiu3Jb9bDrAGezSLd2mJyIjvHH9xF1a0eb9YfJE2Vv5BgV/PnfVp5C
         a0QMtiJp63yPGFhV3W6PvFuVb9hLZR67cVUyivwN4INOjMFews0HP96d4lMkMjjyotT/
         63j20EbCw3Ynlr0y1bIbowaEMWc4Ph23paEM0joOIcwxytwKKRwMxh3K+nbZQk0sEaqK
         cp/2L550WIvy+lmqj5M4YV2qsPItWy1+K5H6qMsb1FXafupsZREbQIsvHXQ4rM2nXKJj
         fdiA==
X-Gm-Message-State: AOAM530YtyNSbvkc3pbQG4GtJJjj9VmxmkVrMgUUhZGgW1QcKdLsbqau
        JryYXdVXerizs6/uJO4TxPkj7tkjzy0Y+6kB2jB55Q==
X-Google-Smtp-Source: ABdhPJxoNHsqS0Cspo6atJ2cS4VJgFv31o0Wr8mvnTzi19fZT73UHF2RR+bG/GciFyWIfq1NDhfzJrZct1B7Gxe2TMs=
X-Received: by 2002:a2e:90ca:: with SMTP id o10mr476096ljg.299.1624467318567;
 Wed, 23 Jun 2021 09:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <2ED1BDF5-BC0C-47CD-8F33-9A46C738F8CF@linux.vnet.ibm.com>
 <CAKfTPtDrHv4OOfPvwOE2DMNoucXQJ=yvvEpTVKrXghSdKEnZcA@mail.gmail.com>
 <20210622143154.GA804@vingu-book> <53968DDE-9E93-4CB4-B5E4-526230B6E154@linux.vnet.ibm.com>
 <20210623071935.GA29143@vingu-book> <CCB4222F-000A-44E8-8D61-F69893704688@linux.vnet.ibm.com>
 <6C676AB3-5D06-471A-8715-60AABEBBE392@linux.vnet.ibm.com> <20210623120835.GB29143@vingu-book>
 <5D874F72-B575-4830-91C3-8814A2B371CD@linux.vnet.ibm.com>
In-Reply-To: <5D874F72-B575-4830-91C3-8814A2B371CD@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 23 Jun 2021 18:55:07 +0200
Message-ID: <CAKfTPtBKn27=jryS_sxsVb+0yHDze_PMcLuyFtDkDo0H9Nzqww@mail.gmail.com>
Subject: Re: [powerpc][next-20210621] WARNING at kernel/sched/fair.c:3277
 during boot
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     Odin Ugedal <odin@uged.al>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 at 18:46, Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:
>
>
> > Ok. This becomes even more weird. Could you share your config file and more details about
> > you setup ?
> >
> > Have you applied the patch below ?
> > https://lore.kernel.org/lkml/20210621174330.11258-1-vincent.guittot@linaro.org/
> >
> > Regarding the load_avg warning, I can see possible problem during attach. Could you add
> > the patch below. The load_avg warning seems to happen during boot and sched_entity
> > creation.
> >
>
> Here is a summary of my testing.
>
> I have a POWER box with PowerVM hypervisor. On this box I have a logical partition(LPAR) or guest
> (allocated with 32 cpus 90G memory) running linux-next.
>
> I started with a clean slate.
> Moved to linux-next 5.13.0-rc7-next-20210622 as base code.
> Applied patch #1 from Vincent which contains changes to dequeue_load_avg()
> Applied patch #2 from Vincent which contains changes to enqueue_load_avg()
> Applied patch #3 from Vincent which contains changes to attach_entity_load_avg()
> Applied patch #4 from https://lore.kernel.org/lkml/20210621174330.11258-1-vincent.guittot@linaro.org/
>
> With these changes applied I was still able to recreate the issue. I could see kernel warning
> during boot.
>
> I then applied patch #5 from Odin which contains changes to update_cfs_rq_load_avg()
>
> With all the 5 patches applied I was able to boot the kernel without any warning messages.
> I also ran scheduler related tests from ltp (./runltp -f sched) . All tests including cfs_bandwidth01
> ran successfully. No kernel warnings were observed.

ok so Odin's patch fixes the problem which highlights that we
overestimate _sum or don't sync _avg and _sum correctly

I'm going to look at this further

>
> Have also attached .config in case it is useful. config has CONFIG_HZ_100=y

Thanks, i will have a look

>
> Thanks
> -Sachin
>
