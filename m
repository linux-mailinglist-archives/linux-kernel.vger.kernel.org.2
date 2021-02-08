Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9FE312A4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 06:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBHF4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 00:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhBHF4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 00:56:17 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2320C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 21:55:36 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 18so6862265pfz.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 21:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0o3h8j9Rb38ZnSlNEEzit2GGaEhxeYWPoauouhC+040=;
        b=ZtOMor8R5VYrkjTy91QCY2yOD3/g4QPGUYqtuxJiMWCRx6ak3a/Tj0afdluDvRfd+N
         jLHzM/KIalSr6/Ntlm5I6uD1YjGRTIUA+qvbckrD8TyJ/Gwi/CcDwjzXQIf3lSl36C87
         w9VFBFJmofcPd/kCvmKsav/Lifz/CwKhdbX67GcTrvCS3m84uXskxgYZ9XC7X1ZzdHSk
         C1XG35m541Jl3/M3ZTOch0jVaVxdT/G50C81YzxepjSd6oATCnm32oa9VfXE0/DVxvkW
         SWjINmvsM8JalcxGcayYNq0SHQHTdo+Xp/vFXqVua2WK/jB+jp3BooC0r9Awp4eiDYok
         pZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0o3h8j9Rb38ZnSlNEEzit2GGaEhxeYWPoauouhC+040=;
        b=qrKit14rEYHBRBQICfhyr6vwYppXL6D4U+P8q7FjJIOD7XZ2QdyYSz3LXqiF7k3N2I
         Sz4pB6PKJrYZHXsgbwdgb5PeNxcolrdelsdvd8c1WG+Bav03K8k4wFUvnO1U2coyWAiW
         2edtCyfBDa0AbLWCUOJEaButIDsYoOj1SMGuBsntInfIsYqpumbZtxUsKHAmBld3lFnF
         ZPUH5L6VUmht/qH4yRLqql7bw3bRbbqJi5bgVqTCryTdFi+rgTcgOCAb/jaNxKD5Sw3D
         UgCObmOSk3gw+deFV4JUbbmI7pxMFEc174e3lnS1hNodmWxpFouIzRn2XsyoolRH9ruS
         qcEA==
X-Gm-Message-State: AOAM533Kgs1lSRiMCjXrnuNiupb8nx/44ZS8jeepOvxVuc5C4gULtuor
        6oGQxF2oiYjVAxoqTogPAlw=
X-Google-Smtp-Source: ABdhPJyeU2lVNM6FJT8pddeuiTKbX+If+78UbRZNHDM7L9ejp9Tusy8YVDzD6hJ9AtxxOXwrs83OWg==
X-Received: by 2002:aa7:90d1:0:b029:1cb:1bf5:614b with SMTP id k17-20020aa790d10000b02901cb1bf5614bmr16162851pfk.34.1612763735908;
        Sun, 07 Feb 2021 21:55:35 -0800 (PST)
Received: from localhost (121-45-171-254.tpgi.com.au. [121.45.171.254])
        by smtp.gmail.com with ESMTPSA id m4sm16686250pgu.4.2021.02.07.21.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 21:55:34 -0800 (PST)
Date:   Mon, 8 Feb 2021 16:55:31 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     sblbir@amazon.com, davem@davemloft.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid
 status
Message-ID: <20210208055531.GD286763@balbir-desktop>
References: <20201217170009.GA29186@192.168.3.9>
 <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
 <CAA70yB5evFpMSy-D9txv91NNHTguXsSVstAFQ3sYTTkDMy6F=A@mail.gmail.com>
 <20210127111346.GB59838@balbir-desktop>
 <CAA70yB6P4_JsZnCrBkYg=7eyT5KW0XucUY+Y7T8YYMnXj6iVXA@mail.gmail.com>
 <20210204102020.GA286763@balbir-desktop>
 <CAA70yB4P2jhOSH=MSc+2NNSmaH8ckF4M0v_vGwE7c9qShMGKew@mail.gmail.com>
 <20210205000848.GB286763@balbir-desktop>
 <CAA70yB7VwbuzuU0=SH+mhSkYBiC28G2NCe9vpqfHv27gyxafCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB7VwbuzuU0=SH+mhSkYBiC28G2NCe9vpqfHv27gyxafCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 10:43:02AM +0800, Weiping Zhang wrote:
> On Fri, Feb 5, 2021 at 8:08 AM Balbir Singh <bsingharora@gmail.com> wrote:
> >
> > On Thu, Feb 04, 2021 at 10:37:20PM +0800, Weiping Zhang wrote:
> > > On Thu, Feb 4, 2021 at 6:20 PM Balbir Singh <bsingharora@gmail.com> wrote:
> > > >
> > > > On Sun, Jan 31, 2021 at 05:16:47PM +0800, Weiping Zhang wrote:
> > > > > On Wed, Jan 27, 2021 at 7:13 PM Balbir Singh <bsingharora@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 22, 2021 at 10:07:50PM +0800, Weiping Zhang wrote:
> > > > > > > Hello Balbir Singh,
> > > > > > >
> > > > > > > Could you help review this patch, thanks
> > > > > > >
> > > > > > > On Mon, Dec 28, 2020 at 10:10 PM Weiping Zhang <zwp10758@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi David,
> > > > > > > >
> > > > > > > > Could you help review this patch ?
> > > > > > > >
> > > > > > > > thanks
> > > > > > > >
> > > > > > > > On Fri, Dec 18, 2020 at 1:24 AM Weiping Zhang
> > > > > > > > <zhangweiping@didiglobal.com> wrote:
> > > > > > > > >
> > > > > > > > > If a program needs monitor lots of process's status, it needs two
> > > > > > > > > syscalls for every process. The first one is telling kernel which
> > > > > > > > > pid/tgid should be monitored by send a command(write socket) to kernel.
> > > > > > > > > The second one is read the statistics by read socket. This patch add
> > > > > > > > > a new interface /proc/taskstats to reduce two syscalls to one ioctl.
> > > > > > > > > The user just set the target pid/tgid to the struct taskstats.ac_pid,
> > > > > > > > > then kernel will collect statistics for that pid/tgid.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > > > > >
> > > > > > Could you elaborate on the overhead your seeing for the syscalls? I am not
> > > > > > in favour of adding new IOCTL's.
> > > > > >
> > > > > > Balbir Singh.
> > > > >
> > > > > Hello Balbir Singh,
> > > > >
> > > > > Sorry for late reply,
> > > > >
> > > > > I do a performance test between netlink mode and ioctl mode,
> > > > > monitor 1000 and 10000 sleep processes,
> > > > > the netlink mode cost more time than ioctl mode, that is to say
> > > > > ioctl mode can save some cpu resource and has a quickly reponse
> > > > > especially when monitor lot of process.
> > > > >
> > > > > proccess-count    netlink         ioctl
> > > > > ---------------------------------------------
> > > > > 1000              0.004446851     0.001553733
> > > > > 10000             0.047024986     0.023290664
> > > > >
> > > > > you can get the test demo code from the following link
> > > > > https://github.com/dublio/tools/tree/master/c/taskstat
> > > > >
> > > >
> > > > Let me try it out, I am opposed to adding the new IOCTL interface
> > > > you propose. How frequently do you monitor this data and how much
> > > > time in spent in making decision on the data? I presume the data
> > > > mentioned is the cost per call in seconds?
> > > >
> > > This program just read every process's taskstats from kernel and do not
> > > any extra data calculation, that is to say it just test the time spend on
> > > these syscalls. It read data every 1 second, the output is delta time spend to
> > > read all 1000 or 10000 processes's taskstat.
> > >
> > > t1 = clock_gettime();
> > > for_each_pid /* 1000 or 10000 */
> > >         read_pid_taskstat
> > > t2 = clock_gettime();
> > >
> > > delta = t2 - t1.
> > >
> > > > > proccess-count    netlink         ioctl
> > > > > ---------------------------------------------
> > > > > 1000              0.004446851     0.001553733
> > > > > 10000             0.047024986     0.023290664
> > >
> > > Since netlink mode needs two syscall and ioctl mode needs one syscall
> > > the test result shows  netlink cost double time compare to ioctl.
> > > So I want to add this interface to reduce the time cost by syscall.
> > >
> > > You can get the test script from:
> > > https://github.com/dublio/tools/tree/master/c/taskstat#test-the-performance-between-netlink-and-ioctl-mode
> > >
> > > Thanks
> > >
> >
> > Have you looked at the listener interface in taskstats, where one
> > can register to listen on a cpumask against all exiting processes?
> >
> > That provides a register once and listen and filter interface (based
> > on pids/tgids returned) and lets the task be done on exit as opposed
> > to polling for data.
> >
> That is a good feature to collect data async mode, now I want to collect
> those long-time running process's data in a fixed frequency, like iotop.
> So I try to reduce the overhead cost by these syscalls when I polling
> a lot of long-time running processes.
> 
> Thanks a ton

Still not convinced about it, I played around with it. The reason we did not
use ioctl in the first place is to get the benefits of TLA with netlink, which
ioctl's miss. IMHO, the overhead is not very significant even for
10,000 processes in your experiment. I am open to considering enhancing the
interface to do a set of pid's

Balbir Singh.
