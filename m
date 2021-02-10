Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95ED3166CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhBJMd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhBJMbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:31:22 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30EFC061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:30:41 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id d85so1391204qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enZFEFjPnVDKy5Tf5uYXOTSQtZWht4M7Wyya0sZvSX0=;
        b=NicfCiKndcuJChQTNN5a3eGvVeyhhtieDO8+PjG8PLLhhvnMQqgqryax9VoN9lsaWJ
         XTS+F+VCOy1xBGyJApqwoxHuoA1GIfuZf1axUoi9h2+H6FLvJdZi2hXid7qW9DGgeKe+
         0HRTL9E7CNAxrbaK30fHQ9D+cZpUISAxWyNjMZ41JcPmph5KX/AlA2Gk1M8uN2u2sEt2
         W+/C6wAIeMZBFSNMdGQkW+ZB282FOnKAx0/QaTumad26QAcF9h+ycOCe8A6aJ/9U0+n3
         5k0GdCLZiosGohx9I5NPjv6XqlsKI90sarjeYGx1727fKyOoOuG7qZFKOOKx/5liTX8a
         JRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enZFEFjPnVDKy5Tf5uYXOTSQtZWht4M7Wyya0sZvSX0=;
        b=fE5DkdZZtmk1pCE82nXRwhKrs6rTP07ddyQPJEu4JOV9BBqnhyag/hzZIYUPjUNudN
         SATsg5Tfu4Fi6DY/ljA2Nd1N6UQRnIrnOGyayhy2D5IOrmScZDWteW8bFj+xdoc2ldNH
         +Qi2sulD4aeLXibHkwRl7iFpKhSCJh76fsX9Ig3qdcMsvrC9u/1AanSPlqpaQphyr2gJ
         dmjpHYcGTdIxN20weZzttw2iBWTBrIwGAuaKwzQOEnoUTcUJ2mMbmaOinGxrdedjE8CI
         5dBGLiLveR+tPzJecYXcS7Gm1ho32IPmsDakcPku6pJeAzQ10j8hlHV/K5Q2AqL7X8yT
         I7Hw==
X-Gm-Message-State: AOAM533JUI4fzermKiR8TC2h5vMJAaQYp5jtTRC8QkE71mNjUhtHgmoZ
        3hvj7oyxsNZiYXe3tXL1OuJPgUFUxQBWbuD7tM70LTso9EAqQA==
X-Google-Smtp-Source: ABdhPJzyjqBukjZvtAk65BtB9PrDvKg5QPFDBrgXHPnXOnzpLkOrdmOIMa7BccC49bGgo1NJ/An44gWSgfYSejpAfxA=
X-Received: by 2002:ae9:e915:: with SMTP id x21mr2958560qkf.311.1612960241153;
 Wed, 10 Feb 2021 04:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20201217170009.GA29186@192.168.3.9> <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
 <CAA70yB5evFpMSy-D9txv91NNHTguXsSVstAFQ3sYTTkDMy6F=A@mail.gmail.com>
 <20210127111346.GB59838@balbir-desktop> <CAA70yB6P4_JsZnCrBkYg=7eyT5KW0XucUY+Y7T8YYMnXj6iVXA@mail.gmail.com>
 <20210204102020.GA286763@balbir-desktop> <CAA70yB4P2jhOSH=MSc+2NNSmaH8ckF4M0v_vGwE7c9qShMGKew@mail.gmail.com>
 <20210205000848.GB286763@balbir-desktop> <CAA70yB7VwbuzuU0=SH+mhSkYBiC28G2NCe9vpqfHv27gyxafCw@mail.gmail.com>
 <20210208055531.GD286763@balbir-desktop>
In-Reply-To: <20210208055531.GD286763@balbir-desktop>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 10 Feb 2021 20:30:30 +0800
Message-ID: <CAA70yB74AH6J0iuhd5s4ONDVh71fEuh3Kr625H_CypyMP0Te+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid status
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     sblbir@amazon.com, davem@davemloft.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 1:55 PM Balbir Singh <bsingharora@gmail.com> wrote:
>
> On Fri, Feb 05, 2021 at 10:43:02AM +0800, Weiping Zhang wrote:
> > On Fri, Feb 5, 2021 at 8:08 AM Balbir Singh <bsingharora@gmail.com> wrote:
> > >
> > > On Thu, Feb 04, 2021 at 10:37:20PM +0800, Weiping Zhang wrote:
> > > > On Thu, Feb 4, 2021 at 6:20 PM Balbir Singh <bsingharora@gmail.com> wrote:
> > > > >
> > > > > On Sun, Jan 31, 2021 at 05:16:47PM +0800, Weiping Zhang wrote:
> > > > > > On Wed, Jan 27, 2021 at 7:13 PM Balbir Singh <bsingharora@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Jan 22, 2021 at 10:07:50PM +0800, Weiping Zhang wrote:
> > > > > > > > Hello Balbir Singh,
> > > > > > > >
> > > > > > > > Could you help review this patch, thanks
> > > > > > > >
> > > > > > > > On Mon, Dec 28, 2020 at 10:10 PM Weiping Zhang <zwp10758@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi David,
> > > > > > > > >
> > > > > > > > > Could you help review this patch ?
> > > > > > > > >
> > > > > > > > > thanks
> > > > > > > > >
> > > > > > > > > On Fri, Dec 18, 2020 at 1:24 AM Weiping Zhang
> > > > > > > > > <zhangweiping@didiglobal.com> wrote:
> > > > > > > > > >
> > > > > > > > > > If a program needs monitor lots of process's status, it needs two
> > > > > > > > > > syscalls for every process. The first one is telling kernel which
> > > > > > > > > > pid/tgid should be monitored by send a command(write socket) to kernel.
> > > > > > > > > > The second one is read the statistics by read socket. This patch add
> > > > > > > > > > a new interface /proc/taskstats to reduce two syscalls to one ioctl.
> > > > > > > > > > The user just set the target pid/tgid to the struct taskstats.ac_pid,
> > > > > > > > > > then kernel will collect statistics for that pid/tgid.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > > > > > >
> > > > > > > Could you elaborate on the overhead your seeing for the syscalls? I am not
> > > > > > > in favour of adding new IOCTL's.
> > > > > > >
> > > > > > > Balbir Singh.
> > > > > >
> > > > > > Hello Balbir Singh,
> > > > > >
> > > > > > Sorry for late reply,
> > > > > >
> > > > > > I do a performance test between netlink mode and ioctl mode,
> > > > > > monitor 1000 and 10000 sleep processes,
> > > > > > the netlink mode cost more time than ioctl mode, that is to say
> > > > > > ioctl mode can save some cpu resource and has a quickly reponse
> > > > > > especially when monitor lot of process.
> > > > > >
> > > > > > proccess-count    netlink         ioctl
> > > > > > ---------------------------------------------
> > > > > > 1000              0.004446851     0.001553733
> > > > > > 10000             0.047024986     0.023290664
> > > > > >
> > > > > > you can get the test demo code from the following link
> > > > > > https://github.com/dublio/tools/tree/master/c/taskstat
> > > > > >
> > > > >
> > > > > Let me try it out, I am opposed to adding the new IOCTL interface
> > > > > you propose. How frequently do you monitor this data and how much
> > > > > time in spent in making decision on the data? I presume the data
> > > > > mentioned is the cost per call in seconds?
> > > > >
> > > > This program just read every process's taskstats from kernel and do not
> > > > any extra data calculation, that is to say it just test the time spend on
> > > > these syscalls. It read data every 1 second, the output is delta time spend to
> > > > read all 1000 or 10000 processes's taskstat.
> > > >
> > > > t1 = clock_gettime();
> > > > for_each_pid /* 1000 or 10000 */
> > > >         read_pid_taskstat
> > > > t2 = clock_gettime();
> > > >
> > > > delta = t2 - t1.
> > > >
> > > > > > proccess-count    netlink         ioctl
> > > > > > ---------------------------------------------
> > > > > > 1000              0.004446851     0.001553733
> > > > > > 10000             0.047024986     0.023290664
> > > >
> > > > Since netlink mode needs two syscall and ioctl mode needs one syscall
> > > > the test result shows  netlink cost double time compare to ioctl.
> > > > So I want to add this interface to reduce the time cost by syscall.
> > > >
> > > > You can get the test script from:
> > > > https://github.com/dublio/tools/tree/master/c/taskstat#test-the-performance-between-netlink-and-ioctl-mode
> > > >
> > > > Thanks
> > > >
> > >
> > > Have you looked at the listener interface in taskstats, where one
> > > can register to listen on a cpumask against all exiting processes?
> > >
> > > That provides a register once and listen and filter interface (based
> > > on pids/tgids returned) and lets the task be done on exit as opposed
> > > to polling for data.
> > >
> > That is a good feature to collect data async mode, now I want to collect
> > those long-time running process's data in a fixed frequency, like iotop.
> > So I try to reduce the overhead cost by these syscalls when I polling
> > a lot of long-time running processes.
> >
> > Thanks a ton
>
> Still not convinced about it, I played around with it. The reason we did not
> use ioctl in the first place is to get the benefits of TLA with netlink, which
For monitoring long-time-running process the ioctl can meet our requirement,
it is more simple than netlink when we get the real user data(struct taskstats).
The netlink mode needs construct/parse extra strcutures like struct msgtemplate,
struct nlmsghdr, struct genlmsghdr. The ioctl mode only has one
structure (struct taskstats).
For complicated user case the netlink mode is more suitable, for this
simple user case
the ioctl mode is more suitable. From the test results we can see that
ioctl can save CPU
resource, it's useful to build a light-weight monitor tools.
> ioctl's miss. IMHO, the overhead is not very significant even for
> 10,000 processes in your experiment. I am open to considering enhancing the
> interface to do a set of pid's.
It's a good approach to collect data in batch mode, I think we can support it in
both netlink and ioctl mode.

Add ioctl can give user mode choice and make user code more simple, it seems no
harm to taskstats framework, I'd like to support it.

Thanks very much
>
> Balbir Singh.
