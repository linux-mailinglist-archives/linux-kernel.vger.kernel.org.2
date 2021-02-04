Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04DE30F55B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhBDOsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbhBDOkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:40:02 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BADC061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:38:55 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id w11so1767927qvz.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/yRcIj7Ri9v/Iuf2m4A5vPR9JhrB8gLvi7llcT4qLU=;
        b=KPRd1fBPasbam1KhitLLM8BTeKPhJhT8CbnVd6mMy1jnuAM5aFdVRuYvWFnL8QoUC9
         qRGmu9a+l0uhPffRqRAvv0GF9W86V71h08lwLCNMecERwm6WsiD9ciIePKfV6c7HXixV
         203qSNb4U9rHQfPgNx2YLWAEf86Gk1R5atey3S/OoucymOThEt73V/EcivgMXBrXe7fK
         GCvXXXUBwvRY/KRDMFoygCuZP9WGJFlmom2d1ZG476Y1SOj39MWKkqw13LExaWHyMRRy
         g/N2+QolMJ8izsz5x0ybb27l8hgce/X4OPoyq5kmkrz1NbYFYEfTUrzDRuCxGXkixI32
         dbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/yRcIj7Ri9v/Iuf2m4A5vPR9JhrB8gLvi7llcT4qLU=;
        b=gOcgmscbFd+1HAIk1y/JU9lGigcRu/aab6yiC++bL/BmxHpXwa7D5fokX7QEwfm66r
         RMJ3jQ9anSH/XeDrCQe3llqEEQgVZ0Y1E/YxLhw2nF9re4BEdofkr6hQTmi30Jj0vbME
         5Y2VLmVn7Hm7iYRJ4WAadI4E9DaRqdT1bzT/5Sjg44rtTuETxHmEtaE189pzAbcRL+s/
         oj15oGp1U8/3zsi28oT7CYveuhrJE+81cKuMjdlV0SbswFne5kgX7yT/yVc5L7jA7D3q
         O4P0GnimoHCPPpu++sEnTzhIINIyuu1kPKJK7Sgp0AnVYd6yl+yVp7gMh4ofPJOqhT+E
         NCiw==
X-Gm-Message-State: AOAM530iFhomA7MWexoUW6BxOCApNxjmIGiMndA6faA20xC+Q3iMLohg
        LMNwgBKspnJ5Gk3N45Y6tRM4SoIP/zBD0bPqLb4=
X-Google-Smtp-Source: ABdhPJyXm+2YkEQLmnYIYD5mpxbyYgbatgX+ActRniiUaH4fDtHrS0TAEsAYnI+SsnxP6TDkagk/BzUbuGyLO0g78t4=
X-Received: by 2002:a0c:f7d2:: with SMTP id f18mr7615667qvo.39.1612449534837;
 Thu, 04 Feb 2021 06:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20201217170009.GA29186@192.168.3.9> <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
 <CAA70yB5evFpMSy-D9txv91NNHTguXsSVstAFQ3sYTTkDMy6F=A@mail.gmail.com>
 <20210127111346.GB59838@balbir-desktop> <CAA70yB6P4_JsZnCrBkYg=7eyT5KW0XucUY+Y7T8YYMnXj6iVXA@mail.gmail.com>
 <20210204102020.GA286763@balbir-desktop>
In-Reply-To: <20210204102020.GA286763@balbir-desktop>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Thu, 4 Feb 2021 22:37:20 +0800
Message-ID: <CAA70yB4P2jhOSH=MSc+2NNSmaH8ckF4M0v_vGwE7c9qShMGKew@mail.gmail.com>
Subject: Re: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid status
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     sblbir@amazon.com, davem@davemloft.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 6:20 PM Balbir Singh <bsingharora@gmail.com> wrote:
>
> On Sun, Jan 31, 2021 at 05:16:47PM +0800, Weiping Zhang wrote:
> > On Wed, Jan 27, 2021 at 7:13 PM Balbir Singh <bsingharora@gmail.com> wrote:
> > >
> > > On Fri, Jan 22, 2021 at 10:07:50PM +0800, Weiping Zhang wrote:
> > > > Hello Balbir Singh,
> > > >
> > > > Could you help review this patch, thanks
> > > >
> > > > On Mon, Dec 28, 2020 at 10:10 PM Weiping Zhang <zwp10758@gmail.com> wrote:
> > > > >
> > > > > Hi David,
> > > > >
> > > > > Could you help review this patch ?
> > > > >
> > > > > thanks
> > > > >
> > > > > On Fri, Dec 18, 2020 at 1:24 AM Weiping Zhang
> > > > > <zhangweiping@didiglobal.com> wrote:
> > > > > >
> > > > > > If a program needs monitor lots of process's status, it needs two
> > > > > > syscalls for every process. The first one is telling kernel which
> > > > > > pid/tgid should be monitored by send a command(write socket) to kernel.
> > > > > > The second one is read the statistics by read socket. This patch add
> > > > > > a new interface /proc/taskstats to reduce two syscalls to one ioctl.
> > > > > > The user just set the target pid/tgid to the struct taskstats.ac_pid,
> > > > > > then kernel will collect statistics for that pid/tgid.
> > > > > >
> > > > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > >
> > > Could you elaborate on the overhead your seeing for the syscalls? I am not
> > > in favour of adding new IOCTL's.
> > >
> > > Balbir Singh.
> >
> > Hello Balbir Singh,
> >
> > Sorry for late reply,
> >
> > I do a performance test between netlink mode and ioctl mode,
> > monitor 1000 and 10000 sleep processes,
> > the netlink mode cost more time than ioctl mode, that is to say
> > ioctl mode can save some cpu resource and has a quickly reponse
> > especially when monitor lot of process.
> >
> > proccess-count    netlink         ioctl
> > ---------------------------------------------
> > 1000              0.004446851     0.001553733
> > 10000             0.047024986     0.023290664
> >
> > you can get the test demo code from the following link
> > https://github.com/dublio/tools/tree/master/c/taskstat
> >
>
> Let me try it out, I am opposed to adding the new IOCTL interface
> you propose. How frequently do you monitor this data and how much
> time in spent in making decision on the data? I presume the data
> mentioned is the cost per call in seconds?
>
This program just read every process's taskstats from kernel and do not
any extra data calculation, that is to say it just test the time spend on
these syscalls. It read data every 1 second, the output is delta time spend to
read all 1000 or 10000 processes's taskstat.

t1 = clock_gettime();
for_each_pid /* 1000 or 10000 */
        read_pid_taskstat
t2 = clock_gettime();

delta = t2 - t1.

> > proccess-count    netlink         ioctl
> > ---------------------------------------------
> > 1000              0.004446851     0.001553733
> > 10000             0.047024986     0.023290664

Since netlink mode needs two syscall and ioctl mode needs one syscall
the test result shows  netlink cost double time compare to ioctl.
So I want to add this interface to reduce the time cost by syscall.

You can get the test script from:
https://github.com/dublio/tools/tree/master/c/taskstat#test-the-performance-between-netlink-and-ioctl-mode

Thanks

> Balbir Singh
>
