Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE36330F074
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhBDKVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhBDKVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:21:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D4CC061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 02:20:25 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cl8so1442897pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 02:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dteaa9WctumlnSF4vEfWhEQww005qkrMHIV+0A4eBtA=;
        b=kwLnqVciucPAvi368GbGCaKJIsQwuQIBTaogGyWd0a6U86Tmba/Lnh/wP3ljFnAZuW
         RSLLJ+I6y4nNtYR8dJDzWHrSGIfPKJf4xOwwP4cH/7ZNsZ6ebREEnMmgMdTIKKJuDRUd
         Ir07V0gipzM4YFutoUHoYWInTioInsXMGcpicGH20GbHvP182bp82TurfdG01QRt+Y+D
         le1JEhB5IGJFNrblIPXQ3ogX2bkK3DxucdxhWYZY++siZ8pbHzGMTY1Nl1hTct1R8+Iw
         NSlcnx6u6xoBEFmjs9HWY9WKzJUGgqU0zlKJjaoKtQAHQhUd/MOrANqoVfxjdM4TpEmp
         oLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dteaa9WctumlnSF4vEfWhEQww005qkrMHIV+0A4eBtA=;
        b=iYecqqsECzXYEYelt6VvX09+M9ic6IPFcP6Ypp5WZlahoqwIxFM23aJfFyKOpNRxPZ
         0m8UmxzKb6il0JlmGjrWEdPmB+yhtPbM5ZaYi/SmfYuRcGSouNnHT1H+gbuKbApTdV9X
         4zbpcjGskBQwKMWvGdd8xcg/5lHpPKVvOqOE1ElnhbqpeNmxSFtOL1KEraJ86u5grh25
         biKZtQ6WbfrJbfdSoJ+fIDn5uEnrJB3gYtZLf5UqHhqM0Fel2fmkw316LxMJV8b/70zS
         mhavhfM6PMuT2wlX0OeMMpdQtPF233QO9EHFTVRjh7Ta3P0PZR6dDT0e7ts36ZRT3wxv
         nPtw==
X-Gm-Message-State: AOAM5316AM6iJVfdvl4O2GMN8GsOzWbfPK1Cq+buT+qtQsqC97xsEMQW
        YOZg45kMuWe/7nbN5zTaSBY=
X-Google-Smtp-Source: ABdhPJytPD0e3m8uJApCH5wpc6GGtPnocqhzzMPZav3VL1HXp/ePH9jXZmTeBVcMH6RyeuiZTbWEAw==
X-Received: by 2002:a17:902:ea0f:b029:de:5fd5:abb9 with SMTP id s15-20020a170902ea0fb02900de5fd5abb9mr7327223plg.46.1612434024703;
        Thu, 04 Feb 2021 02:20:24 -0800 (PST)
Received: from localhost (121-45-171-254.tpgi.com.au. [121.45.171.254])
        by smtp.gmail.com with ESMTPSA id 123sm5363785pfd.91.2021.02.04.02.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 02:20:23 -0800 (PST)
Date:   Thu, 4 Feb 2021 21:20:20 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     sblbir@amazon.com, davem@davemloft.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] taskstats: add /proc/taskstats to fetch pid/tgid
 status
Message-ID: <20210204102020.GA286763@balbir-desktop>
References: <20201217170009.GA29186@192.168.3.9>
 <CAA70yB6O2on1tpoA8TpT+Hp03iu_Xrpaa_d0HjVa75UFMTA4yg@mail.gmail.com>
 <CAA70yB5evFpMSy-D9txv91NNHTguXsSVstAFQ3sYTTkDMy6F=A@mail.gmail.com>
 <20210127111346.GB59838@balbir-desktop>
 <CAA70yB6P4_JsZnCrBkYg=7eyT5KW0XucUY+Y7T8YYMnXj6iVXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA70yB6P4_JsZnCrBkYg=7eyT5KW0XucUY+Y7T8YYMnXj6iVXA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 05:16:47PM +0800, Weiping Zhang wrote:
> On Wed, Jan 27, 2021 at 7:13 PM Balbir Singh <bsingharora@gmail.com> wrote:
> >
> > On Fri, Jan 22, 2021 at 10:07:50PM +0800, Weiping Zhang wrote:
> > > Hello Balbir Singh,
> > >
> > > Could you help review this patch, thanks
> > >
> > > On Mon, Dec 28, 2020 at 10:10 PM Weiping Zhang <zwp10758@gmail.com> wrote:
> > > >
> > > > Hi David,
> > > >
> > > > Could you help review this patch ?
> > > >
> > > > thanks
> > > >
> > > > On Fri, Dec 18, 2020 at 1:24 AM Weiping Zhang
> > > > <zhangweiping@didiglobal.com> wrote:
> > > > >
> > > > > If a program needs monitor lots of process's status, it needs two
> > > > > syscalls for every process. The first one is telling kernel which
> > > > > pid/tgid should be monitored by send a command(write socket) to kernel.
> > > > > The second one is read the statistics by read socket. This patch add
> > > > > a new interface /proc/taskstats to reduce two syscalls to one ioctl.
> > > > > The user just set the target pid/tgid to the struct taskstats.ac_pid,
> > > > > then kernel will collect statistics for that pid/tgid.
> > > > >
> > > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> >
> > Could you elaborate on the overhead your seeing for the syscalls? I am not
> > in favour of adding new IOCTL's.
> >
> > Balbir Singh.
> 
> Hello Balbir Singh,
> 
> Sorry for late reply,
> 
> I do a performance test between netlink mode and ioctl mode,
> monitor 1000 and 10000 sleep processes,
> the netlink mode cost more time than ioctl mode, that is to say
> ioctl mode can save some cpu resource and has a quickly reponse
> especially when monitor lot of process.
> 
> proccess-count    netlink         ioctl
> ---------------------------------------------
> 1000              0.004446851     0.001553733
> 10000             0.047024986     0.023290664
> 
> you can get the test demo code from the following link
> https://github.com/dublio/tools/tree/master/c/taskstat
>

Let me try it out, I am opposed to adding the new IOCTL interface
you propose. How frequently do you monitor this data and how much
time in spent in making decision on the data? I presume the data
mentioned is the cost per call in seconds?

Balbir Singh
 
