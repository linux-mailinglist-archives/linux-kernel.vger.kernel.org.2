Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662953102F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 03:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBECn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 21:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhBECny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:43:54 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D04C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 18:43:13 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id w11so2788339qvz.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 18:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpU9HkMmwxE/7DfWqeDXnflXL0U+fnek9VVwo2F+WIM=;
        b=q9JCDETbIZROWf1j4oNFJ0PGXtF7BEOrpZF7oLSV6rjDYwsbwXUNISIMXMKnJwFgul
         znoHyfhqJB42W7U+PW/UuDG7g8ncumsSuJjM4TUmWSZKoXKoOdqZ/rGv4tCeiSC+k4TT
         STPgsXzEx9PRI5XDXywrR7eWT2lfp6aFxAyUEfbekU6N+blCkUeKtjlZ52F9GGwD6lXR
         QLsLM6OxLthG73TSeYizalWFNRLjhZXyEod9HncS93Q7gDQwIEdfF/0QOg8LoljIL7vT
         orHxNhdnrFz/fW9a631KGKhr29LRl9l5joFA2I61Cae94JCfGsngahabaOPDDMfdGnvQ
         fH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpU9HkMmwxE/7DfWqeDXnflXL0U+fnek9VVwo2F+WIM=;
        b=qpVb8A0PpkakSDEhNQTMIBQHyhUlFHXqVfMUbhZcWFGywuS+YWqD3jAje0lSu5dFyC
         RZuuwyEDS8JvwEMqJMQEMNMz/wPMchkJYDG/5/4L0P8w9iIRGHpw1kwDX7APk14xvraz
         3vCP7l27RtbfWXHjnX+1UAMC2hZRHWN+i3J3FLOqec/irGHAfmh+K0WAi1QoOteWKc7M
         uRzYE4IlLFTUYTK7NleWkcwMNIWqYPpa+9gRkyrPQfvwThHfRK0PNLvS/zFrD6gHxFcx
         jupL9bsAmQKfaCjFOiG35Xo7+htUmEIHcajm2eTHrgj2Olso858aNAcn0No3eYc7szG5
         MtDw==
X-Gm-Message-State: AOAM5337F0h03SSZxi5Exv7K+5wtKtg2L+sA2hVa+oNBQreNgvudkTHN
        I0P41180Q+uusGq2FnVSQYPNZMXgLBr6olz150Y=
X-Google-Smtp-Source: ABdhPJyf99Japo2fl7sT+AlafGPuM07xSYT4DB9IhmE+1MgWbIrYhdRG2ivB1GdqSWFVLvYd6VWM6wBQGdZoF3aZEQs=
X-Received: by 2002:a05:6214:906:: with SMTP id dj6mr2541755qvb.28.1612492992907;
 Thu, 04 Feb 2021 18:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20201217170009.GA29186@192.168.3.9> <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
 <CAA70yB5evFpMSy-D9txv91NNHTguXsSVstAFQ3sYTTkDMy6F=A@mail.gmail.com>
 <20210127111346.GB59838@balbir-desktop> <CAA70yB6P4_JsZnCrBkYg=7eyT5KW0XucUY+Y7T8YYMnXj6iVXA@mail.gmail.com>
 <20210204102020.GA286763@balbir-desktop> <CAA70yB4P2jhOSH=MSc+2NNSmaH8ckF4M0v_vGwE7c9qShMGKew@mail.gmail.com>
 <20210205000848.GB286763@balbir-desktop>
In-Reply-To: <20210205000848.GB286763@balbir-desktop>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Fri, 5 Feb 2021 10:43:02 +0800
Message-ID: <CAA70yB7VwbuzuU0=SH+mhSkYBiC28G2NCe9vpqfHv27gyxafCw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid status
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     sblbir@amazon.com, davem@davemloft.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 8:08 AM Balbir Singh <bsingharora@gmail.com> wrote:
>
> On Thu, Feb 04, 2021 at 10:37:20PM +0800, Weiping Zhang wrote:
> > On Thu, Feb 4, 2021 at 6:20 PM Balbir Singh <bsingharora@gmail.com> wrote:
> > >
> > > On Sun, Jan 31, 2021 at 05:16:47PM +0800, Weiping Zhang wrote:
> > > > On Wed, Jan 27, 2021 at 7:13 PM Balbir Singh <bsingharora@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jan 22, 2021 at 10:07:50PM +0800, Weiping Zhang wrote:
> > > > > > Hello Balbir Singh,
> > > > > >
> > > > > > Could you help review this patch, thanks
> > > > > >
> > > > > > On Mon, Dec 28, 2020 at 10:10 PM Weiping Zhang <zwp10758@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi David,
> > > > > > >
> > > > > > > Could you help review this patch ?
> > > > > > >
> > > > > > > thanks
> > > > > > >
> > > > > > > On Fri, Dec 18, 2020 at 1:24 AM Weiping Zhang
> > > > > > > <zhangweiping@didiglobal.com> wrote:
> > > > > > > >
> > > > > > > > If a program needs monitor lots of process's status, it needs two
> > > > > > > > syscalls for every process. The first one is telling kernel which
> > > > > > > > pid/tgid should be monitored by send a command(write socket) to kernel.
> > > > > > > > The second one is read the statistics by read socket. This patch add
> > > > > > > > a new interface /proc/taskstats to reduce two syscalls to one ioctl.
> > > > > > > > The user just set the target pid/tgid to the struct taskstats.ac_pid,
> > > > > > > > then kernel will collect statistics for that pid/tgid.
> > > > > > > >
> > > > > > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > > > >
> > > > > Could you elaborate on the overhead your seeing for the syscalls? I am not
> > > > > in favour of adding new IOCTL's.
> > > > >
> > > > > Balbir Singh.
> > > >
> > > > Hello Balbir Singh,
> > > >
> > > > Sorry for late reply,
> > > >
> > > > I do a performance test between netlink mode and ioctl mode,
> > > > monitor 1000 and 10000 sleep processes,
> > > > the netlink mode cost more time than ioctl mode, that is to say
> > > > ioctl mode can save some cpu resource and has a quickly reponse
> > > > especially when monitor lot of process.
> > > >
> > > > proccess-count    netlink         ioctl
> > > > ---------------------------------------------
> > > > 1000              0.004446851     0.001553733
> > > > 10000             0.047024986     0.023290664
> > > >
> > > > you can get the test demo code from the following link
> > > > https://github.com/dublio/tools/tree/master/c/taskstat
> > > >
> > >
> > > Let me try it out, I am opposed to adding the new IOCTL interface
> > > you propose. How frequently do you monitor this data and how much
> > > time in spent in making decision on the data? I presume the data
> > > mentioned is the cost per call in seconds?
> > >
> > This program just read every process's taskstats from kernel and do not
> > any extra data calculation, that is to say it just test the time spend on
> > these syscalls. It read data every 1 second, the output is delta time spend to
> > read all 1000 or 10000 processes's taskstat.
> >
> > t1 = clock_gettime();
> > for_each_pid /* 1000 or 10000 */
> >         read_pid_taskstat
> > t2 = clock_gettime();
> >
> > delta = t2 - t1.
> >
> > > > proccess-count    netlink         ioctl
> > > > ---------------------------------------------
> > > > 1000              0.004446851     0.001553733
> > > > 10000             0.047024986     0.023290664
> >
> > Since netlink mode needs two syscall and ioctl mode needs one syscall
> > the test result shows  netlink cost double time compare to ioctl.
> > So I want to add this interface to reduce the time cost by syscall.
> >
> > You can get the test script from:
> > https://github.com/dublio/tools/tree/master/c/taskstat#test-the-performance-between-netlink-and-ioctl-mode
> >
> > Thanks
> >
>
> Have you looked at the listener interface in taskstats, where one
> can register to listen on a cpumask against all exiting processes?
>
> That provides a register once and listen and filter interface (based
> on pids/tgids returned) and lets the task be done on exit as opposed
> to polling for data.
>
That is a good feature to collect data async mode, now I want to collect
those long-time running process's data in a fixed frequency, like iotop.
So I try to reduce the overhead cost by these syscalls when I polling
a lot of long-time running processes.

Thanks a ton

> Balbir Singh.
