Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470C0309B36
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 10:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhAaJR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 04:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhAaJRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 04:17:40 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390FCC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 01:16:59 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id h21so6718247qvb.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 01:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hx2GPHzlwmPIRAoDcggObfL1uTwYd5oeF3q85xHfwrU=;
        b=bHybQXZW3macaYAj1HO2ut7C1yneeG3kETaS/cLSpVLKxoscrV327tg12FAs5KC5C6
         G6JDmqe6iDIdhtMffu62Orrathzz4yUIkt25S2QQIPw2JDRPArbE8Bh61s1f1vReUDPh
         cNHCfqBO5yJXZru/2Nk0GJGn7nRSS1StKw3AqgAL44nhD1lt4yUUmekw4MBIqODO5ps0
         uD057LKtMj1QjX9WRQRIoDMsskOnGcnsZAmBqThjZ/ckUT1R/X7FhkSeinJuFZ/sK0Jw
         dCOrShG8SOypi5djXR/DqqX7nQZM+xVDaZr2+HBWTr0Gyxi/x9IaxUhfjyOvuFuX3bz1
         TGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hx2GPHzlwmPIRAoDcggObfL1uTwYd5oeF3q85xHfwrU=;
        b=c9Wzwemfg/MZeEzMelNlMIr/d/SQkyAbk0xMk9h6py2BZ9BmMdpV4kD98OL5LkXC+9
         s4PeQR6oKjBhwwW5WgZ9sI4VxpW4xuHxrr3VyrtX3hvLkMwIPB3sPf5HDHI04DmiZDUw
         c/seYu6AaaLKwlGsIQx5bfJHDGh/aP1U70zeJsvipKl8tWtbsDCMMKgdRs0YNqb53Jt5
         6wu0ouAwBzFBcGt0OCvPePbOXBdLHVgaif/5KUomB3QEHTnf0+dG+HSFFwsfuLthgQkS
         iLOLCQikrBVKeK82pQW0I3RB9uEqWYLjZTvb1xMhb4sFDcKVU2XBdpi2/9tbtXfhOp3x
         esOA==
X-Gm-Message-State: AOAM530naP+kghb6bZTb6/JVzsa1vH/18fhUzcm5lToMVTPMV2AkaHWA
        YMXQDBeeOMEuq960Wrz/cKeDsa+ILD+aM9ed1pNhz7qB0zFYGg==
X-Google-Smtp-Source: ABdhPJz2R6zElSF7DulNuBEeIkzVVJYLemum9+r3gxNIbEZRMI9ek1vdba1JvoTuKXCASj//f9WOS9yYI6K6iJ0ARho=
X-Received: by 2002:a0c:ebc2:: with SMTP id k2mr7998014qvq.0.1612084618439;
 Sun, 31 Jan 2021 01:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20201217170009.GA29186@192.168.3.9> <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
 <CAA70yB5evFpMSy-D9txv91NNHTguXsSVstAFQ3sYTTkDMy6F=A@mail.gmail.com> <20210127111346.GB59838@balbir-desktop>
In-Reply-To: <20210127111346.GB59838@balbir-desktop>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Sun, 31 Jan 2021 17:16:47 +0800
Message-ID: <CAA70yB6P4_JsZnCrBkYg=7eyT5KW0XucUY+Y7T8YYMnXj6iVXA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid status
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     sblbir@amazon.com, davem@davemloft.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 7:13 PM Balbir Singh <bsingharora@gmail.com> wrote:
>
> On Fri, Jan 22, 2021 at 10:07:50PM +0800, Weiping Zhang wrote:
> > Hello Balbir Singh,
> >
> > Could you help review this patch, thanks
> >
> > On Mon, Dec 28, 2020 at 10:10 PM Weiping Zhang <zwp10758@gmail.com> wrote:
> > >
> > > Hi David,
> > >
> > > Could you help review this patch ?
> > >
> > > thanks
> > >
> > > On Fri, Dec 18, 2020 at 1:24 AM Weiping Zhang
> > > <zhangweiping@didiglobal.com> wrote:
> > > >
> > > > If a program needs monitor lots of process's status, it needs two
> > > > syscalls for every process. The first one is telling kernel which
> > > > pid/tgid should be monitored by send a command(write socket) to kernel.
> > > > The second one is read the statistics by read socket. This patch add
> > > > a new interface /proc/taskstats to reduce two syscalls to one ioctl.
> > > > The user just set the target pid/tgid to the struct taskstats.ac_pid,
> > > > then kernel will collect statistics for that pid/tgid.
> > > >
> > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
>
> Could you elaborate on the overhead your seeing for the syscalls? I am not
> in favour of adding new IOCTL's.
>
> Balbir Singh.

Hello Balbir Singh,

Sorry for late reply,

I do a performance test between netlink mode and ioctl mode,
monitor 1000 and 10000 sleep processes,
the netlink mode cost more time than ioctl mode, that is to say
ioctl mode can save some cpu resource and has a quickly reponse
especially when monitor lot of process.

proccess-count    netlink         ioctl
---------------------------------------------
1000              0.004446851     0.001553733
10000             0.047024986     0.023290664

you can get the test demo code from the following link
https://github.com/dublio/tools/tree/master/c/taskstat

Thanks
Weiping
