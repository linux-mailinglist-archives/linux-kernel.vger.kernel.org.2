Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B45431325
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhJRJUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhJRJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:20:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BABBC061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:18:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 5so37867732edw.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aLlmgHnuhA1/ROy7+zrFqL9FIiWkD7fVE+0wV9VNoxs=;
        b=dVj/eB58UTHPvhQOG73AXJms5NusneVxXNA38zTLiU2DfcJM/gxaYsQa4DerqgEQtu
         045ZeVDoINNS+fYNgB9lIBoJGSC4nYxiiEhoWYrQGjyoCjDWRPGsGHoGyUKPtvYgtQZs
         QwSOHf2VgwS8KChAsIsA+xqTw4aFZfYYBZVy1/uRcrbj0uxp5mcwz1GzXmV4NhCnsqjF
         uLkqh8l/nAFhS7aZxn4nj77T5LrHNqeoe2MV5K+PSng/d0s+eTHiCeFArptVGoJIW0va
         f9+md9941WIByPA1pGOG9FWJZvWbnjfJhDt56pQpgR2swUI9utPGv37IRGHhVc6gfzL0
         XjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aLlmgHnuhA1/ROy7+zrFqL9FIiWkD7fVE+0wV9VNoxs=;
        b=Cb4qssnbrLtlCEO80eDClvLZwpaDIUP+2Uq+mNJOWDclZQySQFlxWlJJE/r2YQvOlP
         uTp2J6zenZQpnlHff9HlK/WY+bbvaEw/r56m6eSZMGZ1jkwdteib93WVik90YBFYzTjv
         jUHCo58DZRgiej1ySlTHKDoTR6u5NukW2WHg5UHr5Auj36qM4ZsXLHT+3IZRT5etpjl2
         /s848SExyKBW7vdxXwxNT3IvkfHbRhmOnezf37/Ye8TEA9oz9irfjV6gPRxzKDuNKH7k
         oGKCypmK7f+xoleqr8oX3g8U5NZcAi2EOgWTN/wtkj4u14VmbQNpF/COO66wWdFWQaZg
         LWkQ==
X-Gm-Message-State: AOAM531QUWdIfZIei/F02oa2lOHVKR4Hr9zjF4wb5VM5LlZL0jTBf11K
        kHSB29wc+byBfFdZ9f32klHjhrX1kTrEhWLr8gk=
X-Google-Smtp-Source: ABdhPJyXRGfzQEODa9AHKIFsAhPS47gRCXAkhXcVTa/3cBh1dzz8U/ZQA26zpqyjx8XfkbcCYzx0VkrnSEb2t8IlARY=
X-Received: by 2002:a17:906:f6cd:: with SMTP id jo13mr27789835ejb.563.1634548687386;
 Mon, 18 Oct 2021 02:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAD-N9QWd6Orm8d9AMk7mybByAKZod=GJ-HSNPOfhFDStSPwSUA@mail.gmail.com>
 <CAPj211vRdmJZBQvM-DE+saiY=LwoQdOu0hV-YFcny6worQ46rg@mail.gmail.com> <CAD-N9QW0NEi6Jzh-bu0Bb=RFB6405G28t_jtctk_t8Kw+HUpVQ@mail.gmail.com>
In-Reply-To: <CAD-N9QW0NEi6Jzh-bu0Bb=RFB6405G28t_jtctk_t8Kw+HUpVQ@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 18 Oct 2021 17:17:41 +0800
Message-ID: <CAD-N9QV69ttLMn07tAiK7iz9ZWaREv51RYwWVP55ChPiVjgHGQ@mail.gmail.com>
Subject: Re: Any tracing mechanism can track the executed instructions of a
 user process in the kernel?
To:     FMDF <fmdefrancesco@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Brendan Gregg

On Mon, Oct 18, 2021 at 4:41 PM Dongliang Mu <mudongliangabcd@gmail.com> wr=
ote:
>
> On Mon, Oct 18, 2021 at 4:07 PM FMDF <fmdefrancesco@gmail.com> wrote:
> >
> > On Mon, 18 Oct 2021, 04:46 Dongliang Mu, <mudongliangabcd@gmail.com> wr=
ote:
> >>
> >> Hi all,
> >>
> >> I am writing to kindly ask one question: is there any tracing
> >> mechanism in Linux kernel that can trace all the executed instructions
> >> of a user process? If this user process is run on different
> >> processors, traces of this process on different processors should be
> >> also recorded.
> >
> >
> > You've not explained in detail what is the purpose of the tracing that =
you want to do. Missing this information I can only provide you a list of l=
inks to various tools and methods. Take a look by yourself and try to figur=
e out what is better suited for your needs...
>
> I want to log all the executed instructions of a user process (e.g.,
> poc.c in syzkaller) in the kernel mode and then would like to leverage
> backward analysis to capture the root cause of kernel panic/crash.
>
> Therefore, I need the instruction-level tracing mechanisms or tools.
>
> >
> > https://lwn.net/Kernel/Index/#Development_tools-Kernel_tracing
> > trace-cmd: https://trace-cmd.org
>
> Ftrace is working at the function level. Therefore, ftrace and tracers
> based on ftrace are not suitable for my scenario.
>
> > perf ftrace: <Linux source>/tools/perf/Documentation/perf-trace.txt
> > perf-tools: https://github.com/brendangregg/perf-tools
>
> I am not familiar with the perf tool and cannot verify if it works for
> my scenario.
>
> >
> > In particular, the "function_graph" tracer of ftrace seems to be suited=
 for your purposes:
> >
> > https://man7.org/linux/man-pages/man1/trace-cmd.1.html
> > https://man7.org/linux/man-pages/man1/trace-cmd-record.1.html
> > https://man7.org/linux/man-pages/man1/trace-cmd-report.1.html
> >
> > Obviously, gdb (and friends) is still invaluable (but it may be difficu=
lt to use, depending on your knowledge and experience, so use it if you rea=
lly know that  you need it):
> >
> > https://www.kernel.org/doc/html/latest/dev-tools/gdb-kernel-debugging.h=
tml
> > https://www.kernel.org/doc/html/latest/dev-tools/kgdb.html
> >
> > Regards,
> >
> > Fabio M. De Francesco
> >
> >>
> >> Any comment is welcome.
> >>
> >> --
> >> My best regards to you.
> >>
> >>      No System Is Safe!
> >>      Dongliang Mu
> >>
> >> _______________________________________________
> >> Kernelnewbies mailing list
> >> Kernelnewbies@kernelnewbies.org
> >> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
