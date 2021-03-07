Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51388330011
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 11:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCGKR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 05:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhCGKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 05:17:25 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D52C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 02:17:24 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h9so5417056qtq.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 02:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sel+nftChg+kM2jOw+J/2yqQU62BUDNfivprLpMSJls=;
        b=FAhX+sQbjHABMbcX6gpL2k+ng7W29Y88mQWS372n6hJX1vxLp9pAO4xmAEZS3cHFGj
         xzNXQZi4sx5l9Qo/m/yp1z1OEnFkaX5BRHI9GdDyp2x+E8niA20mqEM8vGYfAFAWZPO2
         YudpoxEBPTfYOsoaT009RQ7gDElL1rn9RwrSqtZg3DNFh5Xrey/UKgwE5xjc8HM1ztxT
         Vc6htAlCeyyIEMYawsOSPvuAUv3XxJ6pS6sk/jRDBODyW92YSF/az9BIzcPb0a/XaFpK
         tLl1xdcwZLfM1tH/y5d3NwVeWv7IB4H3r05KfPqXuZ+PfBaBLJkB3m1wMAMuE6d+HDDb
         vCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sel+nftChg+kM2jOw+J/2yqQU62BUDNfivprLpMSJls=;
        b=R6zDuQ1su0E1kY6RphiFbrO5dO6MwZ7uHreRH3azx54co46eFvEZ76CP2Z3X2lMsXX
         naYLhIfoSIinvlQEB05e3cqALwNr9+tkPtUgmJpQn1yZ8456y2X6GUcn+YqQhwq0pzOW
         h7pa+IIabL6Qu8kqsuxjmOPHw2mhY5VWXFvEMZeUXVA2DJbds004ab4FI8gkKym6eJnA
         OsJ2QDCLDhVkMQdOMq3kR5o7StsQhmD8HY7GcmQlr/qLloOQUeX+F8XGyKTguZtzlzhQ
         mn+i2y9WV+j3soJuRaCXdz7iOSaxKQXX1KSTXOKlFQly0UP5dFk3c+g3NSrgZjYiyqrp
         wXJQ==
X-Gm-Message-State: AOAM531sZcv/mFVGID4c3mQLHoXWwRpleKPyjoBPAK9wonz8s2EPCStn
        PSDBgIulRSxsDMOB8Gzip4HStrhPfV2aSO7OWOW9Hg==
X-Google-Smtp-Source: ABdhPJxOAewlD2EEa+mNKwK55t8pGtlP+wGovdRdBp6omY1xkkU+OHlzZuFMjYHVa1nKmAiO7ju6slw1dsECI2RNZwo=
X-Received: by 2002:ac8:5847:: with SMTP id h7mr14323827qth.43.1615112243553;
 Sun, 07 Mar 2021 02:17:23 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsP63mN+G1xE7UBfVRuDRcJiRRC7EXU2y25f9rXkoU-0LQ@mail.gmail.com>
 <CACVXFVOy8928GNowCQRGQKQxuLtHn0V+pYk1kzeOyc0pyDvkjQ@mail.gmail.com>
 <20210305090022.1863-1-hdanton@sina.com> <CACVXFVPp_byzrYVwyo05u0v3zoPP42FKZhfWMb6GMBno1rCZRw@mail.gmail.com>
 <E28250BB-FBFF-4F02-B7A2-9530340E481E@linaro.org> <YEIBYLnAqdueErun@T590>
 <20210307021524.13260-1-hdanton@sina.com> <CACT4Y+aLnam+7FGx9MiMRRbgFE6v+Vg6Hu0hkx+P=h+DL8Mayg@mail.gmail.com>
 <20210307100900.13768-1-hdanton@sina.com>
In-Reply-To: <20210307100900.13768-1-hdanton@sina.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 7 Mar 2021 11:17:12 +0100
Message-ID: <CACT4Y+aT0BySK8RVv5tC1pQDPg-7Z_DRToNH7vE7_5pQkqcs1g@mail.gmail.com>
Subject: Re: [bugreport 5.9-rc8] general protection fault in __bfq_deactivate_entity
To:     Hillf Danton <hdanton@sina.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Palash Oswal <oswalpalash@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 7, 2021 at 11:09 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Sun, 7 Mar 2021 08:46:19 +0100  Dmitry Vyukov wrote:
> > On Sun, Mar 7, 2021 at 3:15 AM Hillf Danton <hdanton@sina.com> wrote:
> > >
> > > Dmitry can you shed some light on the tricks to config kasan to print
> > > Call Trace as the reports with the leading [syzbot] on the subject line do?
> >
> > +kasan-dev
> >
> > Hi Hillf,
> >
> > KASAN prints stack traces always unconditionally. There is nothing you
> > need to do at all.
>
> Got it, thanks.
>
> > Do you have any reports w/o stack traces?
>
> No, but I saw different formats in Call Trace prints.
>
> Below from [1] is the instance without file name and line number printed,
> while both info help spot the cause of the reported issue.


KASAN always prints stack traces w/o file:line info, like any other
kernel bug detection facility. Kernel itself never symbolizes reports.
In case of syzkaller, syzkaller will symbolize reports and add
file:line info. The main config it requires is CONFIG_DEBUG_INFO.

You may see syzkaller kernel configuration guide here:
https://github.com/google/syzkaller/blob/master/docs/linux/kernel_configs.md

Or fragments that are actually used to generate syzbot configs in this
dir (the guide above may be out-of-date):
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/base.yml
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/debug.yml
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/bits/kasan.yml

Or a complete syzbot config here:
https://github.com/google/syzkaller/blob/master/dashboard/config/linux/upstream-apparmor-kasan.config


> >>>>>>>>>>>>>>>>>>>>>>>>>
>
> I was running syzkaller and I found the following issue :
>
> Head Commit : b1313fe517ca3703119dcc99ef3bbf75ab42bcfb ( v5.10.4 )
> Git Tree : stable
> Console Output :
> [  242.769080] INFO: task repro:2639 blocked for more than 120 seconds.
> [  242.769096]       Not tainted 5.10.4 #8
> [  242.769103] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  242.769112] task:repro           state:D stack:    0 pid: 2639
> ppid:  2638 flags:0x00000004
> [  242.769126] Call Trace:
> [  242.769148]  __schedule+0x28d/0x7e0
> [  242.769162]  ? __percpu_counter_sum+0x75/0x90
> [  242.769175]  schedule+0x4f/0xc0
> [  242.769187]  __io_uring_task_cancel+0xad/0xf0
> [  242.769198]  ? wait_woken+0x80/0x80
> [  242.769210]  bprm_execve+0x67/0x8a0
> [  242.769223]  do_execveat_common+0x1d2/0x220
> [  242.769235]  __x64_sys_execveat+0x5d/0x70
> [  242.769249]  do_syscall_64+0x38/0x90
> [  242.769260]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> [1] https://lore.kernel.org/lkml/CAGyP=7cFM6BJE7X2PN9YUptQgt5uQYwM4aVmOiVayQPJg1pqaA@mail.gmail.com/
