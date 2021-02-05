Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0396731015D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhBEAJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhBEAJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:09:35 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D074C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:08:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id my11so5792513pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H6Wio6dqtUsYvNSHApTRZu6oF/HFE4gyHqwoq9YLRT0=;
        b=oS3Tqzct8M6ftdupZfMoQZ4kaQ8/aO2Tygv2Hj4rF7iK7VT8hA4iJo1v0s5JZABVt7
         eK1IAIS6ARjFbPJbkgHdG8xpDs37U1ZP78uB0vbPbxX2Jc/bmsnmSis8Dz5Dw4p6O+Uc
         afMzYknmhrrzbfgG0WQZ56qqoTeKesJmuJxgSJGJ6JwZ/Q07Zx4yDdxciEEcdjyazrCM
         9MNUMH+ZynRq98Fbm2WST+PpNq5H4uO/WfhwpFwL/WfJFZ7r42CzyJCbfvv3zH06k4Vd
         JNVM3bOjXMFT/YBPbywBFPRz1QuTwmVcJUM+qgnj6g/krhW+9b27QzSdtSw5DPvFo2AS
         fZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H6Wio6dqtUsYvNSHApTRZu6oF/HFE4gyHqwoq9YLRT0=;
        b=AifGiZw4ibepLrTnLqGGsqUcxwFvbNq2gsXgN6sGtqhrW/R9d5d+RDQNRLHpNzvPAd
         PV+HK5HSR9jgiJQJrZVA7LAmZX5fncyYxvuiAVW/DKGnzV1hgF/DRPzaOYL9ifP1Q5nI
         vFiDSVx8XCAWu1OEuu8YX/eqFdOff5mcco8BkJwb0IPGOrqiRClb7Fr3lrHkiFGshyUH
         MXZN3BX+4nGLrSGJSK6H6kta+XDrisciAuIQG2iVDNIZ73UEoOn9/+02y4zt0khm9GJu
         L5mo6JV5f7p1p2UkytCC2hawwTV9MbmQce/DiiCdJLakbkOibVVrWy6DNtejODkt9hQU
         +ocQ==
X-Gm-Message-State: AOAM533gE65sZdqPByImiQM0qZfnxBfJkzPS9AUiQBTT/lnRBCa5CxuV
        lGgbfpOMu0nQ3ANIVBdfZtA=
X-Google-Smtp-Source: ABdhPJyPCtcHCgQWtcDt+JXau+4Y1y6g5az8n0PSC4Os451lSkP44/ZHxkpW5BDfmO8CUUWzwyoWMQ==
X-Received: by 2002:a17:902:c942:b029:e1:5c7c:dff1 with SMTP id i2-20020a170902c942b02900e15c7cdff1mr1533880pla.64.1612483734962;
        Thu, 04 Feb 2021 16:08:54 -0800 (PST)
Received: from localhost (121-45-171-254.tpgi.com.au. [121.45.171.254])
        by smtp.gmail.com with ESMTPSA id o10sm6982476pfp.87.2021.02.04.16.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 16:08:51 -0800 (PST)
Date:   Fri, 5 Feb 2021 11:08:48 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     sblbir@amazon.com, davem@davemloft.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid
 status
Message-ID: <20210205000848.GB286763@balbir-desktop>
References: <20201217170009.GA29186@192.168.3.9>
 <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
 <CAA70yB5evFpMSy-D9txv91NNHTguXsSVstAFQ3sYTTkDMy6F=A@mail.gmail.com>
 <20210127111346.GB59838@balbir-desktop>
 <CAA70yB6P4_JsZnCrBkYg=7eyT5KW0XucUY+Y7T8YYMnXj6iVXA@mail.gmail.com>
 <20210204102020.GA286763@balbir-desktop>
 <CAA70yB4P2jhOSH=MSc+2NNSmaH8ckF4M0v_vGwE7c9qShMGKew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB4P2jhOSH=MSc+2NNSmaH8ckF4M0v_vGwE7c9qShMGKew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 10:37:20PM +0800, Weiping Zhang wrote:
> On Thu, Feb 4, 2021 at 6:20 PM Balbir Singh <bsingharora@gmail.com> wrote:
> >
> > On Sun, Jan 31, 2021 at 05:16:47PM +0800, Weiping Zhang wrote:
> > > On Wed, Jan 27, 2021 at 7:13 PM Balbir Singh <bsingharora@gmail.com> wrote:
> > > >
> > > > On Fri, Jan 22, 2021 at 10:07:50PM +0800, Weiping Zhang wrote:
> > > > > Hello Balbir Singh,
> > > > >
> > > > > Could you help review this patch, thanks
> > > > >
> > > > > On Mon, Dec 28, 2020 at 10:10 PM Weiping Zhang <zwp10758@gmail.com> wrote:
> > > > > >
> > > > > > Hi David,
> > > > > >
> > > > > > Could you help review this patch ?
> > > > > >
> > > > > > thanks
> > > > > >
> > > > > > On Fri, Dec 18, 2020 at 1:24 AM Weiping Zhang
> > > > > > <zhangweiping@didiglobal.com> wrote:
> > > > > > >
> > > > > > > If a program needs monitor lots of process's status, it needs two
> > > > > > > syscalls for every process. The first one is telling kernel which
> > > > > > > pid/tgid should be monitored by send a command(write socket) to kernel.
> > > > > > > The second one is read the statistics by read socket. This patch add
> > > > > > > a new interface /proc/taskstats to reduce two syscalls to one ioctl.
> > > > > > > The user just set the target pid/tgid to the struct taskstats.ac_pid,
> > > > > > > then kernel will collect statistics for that pid/tgid.
> > > > > > >
> > > > > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > > >
> > > > Could you elaborate on the overhead your seeing for the syscalls? I am not
> > > > in favour of adding new IOCTL's.
> > > >
> > > > Balbir Singh.
> > >
> > > Hello Balbir Singh,
> > >
> > > Sorry for late reply,
> > >
> > > I do a performance test between netlink mode and ioctl mode,
> > > monitor 1000 and 10000 sleep processes,
> > > the netlink mode cost more time than ioctl mode, that is to say
> > > ioctl mode can save some cpu resource and has a quickly reponse
> > > especially when monitor lot of process.
> > >
> > > proccess-count    netlink         ioctl
> > > ---------------------------------------------
> > > 1000              0.004446851     0.001553733
> > > 10000             0.047024986     0.023290664
> > >
> > > you can get the test demo code from the following link
> > > https://github.com/dublio/tools/tree/master/c/taskstat
> > >
> >
> > Let me try it out, I am opposed to adding the new IOCTL interface
> > you propose. How frequently do you monitor this data and how much
> > time in spent in making decision on the data? I presume the data
> > mentioned is the cost per call in seconds?
> >
> This program just read every process's taskstats from kernel and do not
> any extra data calculation, that is to say it just test the time spend on
> these syscalls. It read data every 1 second, the output is delta time spend to
> read all 1000 or 10000 processes's taskstat.
> 
> t1 = clock_gettime();
> for_each_pid /* 1000 or 10000 */
>         read_pid_taskstat
> t2 = clock_gettime();
> 
> delta = t2 - t1.
> 
> > > proccess-count    netlink         ioctl
> > > ---------------------------------------------
> > > 1000              0.004446851     0.001553733
> > > 10000             0.047024986     0.023290664
> 
> Since netlink mode needs two syscall and ioctl mode needs one syscall
> the test result shows  netlink cost double time compare to ioctl.
> So I want to add this interface to reduce the time cost by syscall.
> 
> You can get the test script from:
> https://github.com/dublio/tools/tree/master/c/taskstat#test-the-performance-between-netlink-and-ioctl-mode
> 
> Thanks
>

Have you looked at the listener interface in taskstats, where one
can register to listen on a cpumask against all exiting processes?

That provides a register once and listen and filter interface (based
on pids/tgids returned) and lets the task be done on exit as opposed
to polling for data.

Balbir Singh. 
