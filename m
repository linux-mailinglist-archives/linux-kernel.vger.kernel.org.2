Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48232348A82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhCYHu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:50:57 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:38442 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhCYHub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:50:31 -0400
Received: by mail-ot1-f54.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so1109176otk.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DWiVkjv15kephT2GuuRqWZyH8IK51XtxhMmDfGaWMkc=;
        b=i56RCNPnugTKEwAV1/gUd4sl9sVCSHz70lva0/IrhM0YlrDMBluYNwErhDblfGY//i
         6CQPo3OlLiEdkvOvomOomdXdSAWoNraZTnZYiwSasARxEyFix8GwjHcjSAdoKxXe2xMh
         epIm8UVtAE5R8zj615qjk7WhlMQ4r4OJYswfeq+HQOcqFD7+yJjCEsxJ8x1qSCaQak+H
         0DqCNfeAgBHRwQIH7vNvdBAGBzau7ord26qDKhP33SYmFWDryfz1Fcf0wU1bs8Boje41
         htJqR+gREXksHpMNnRxMe/BDX3hO3ji0SWc2S2Xcq1xxSpuNCv+tlstquSOB04t84Xmu
         PVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DWiVkjv15kephT2GuuRqWZyH8IK51XtxhMmDfGaWMkc=;
        b=fVscQJX2GX8Kv7/kLHVBUs1oBwMSKWirG56FG8tfGffhcFD/CjcKf4Zlk6cqEmBXHi
         tDFJqZDe0GDjJCqQRjH+u5yD6MIsOPOIMWPABDDsWsGBEFoykZotcte+2IaIYVPr2YOf
         3gjemWuHQA41Z/XORCqV2EpKCFDbO7JDCEG82nOChktEJUzqmF4FotCeXjTyR1EB77+y
         lmaxFNHlRu052n9+9n9L+kDj5tBpzN447ovWGmthPk31ucleqnPcytJjNZ/PPLwBD1Y+
         VoVDZrR0H1F0yP7fszd2J9RiGJgqjQOw4wDZYAl5Jfl0t+b1OsaTMiTqBj+YY45dMKBy
         psjQ==
X-Gm-Message-State: AOAM533gTx2mwM49QxXAwcuWRzrUQuwn8h+4YJJC221kk/OFYIP8kwl7
        IfaIwwH59/cQFNGrdhQaVtUT1IuKh7mRdzGz/E7lp7P4HCFg7g==
X-Google-Smtp-Source: ABdhPJwe1Ru7+fgTgjPqMkXuOvvfP7zlp+d9c5V5X32VtYhY3zu8xu7M3mzJOJVJIerSymgvzTtIiMIWJDLXt9KUBxo=
X-Received: by 2002:a9d:701d:: with SMTP id k29mr6601948otj.268.1616658570369;
 Thu, 25 Mar 2021 00:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210210144409.36ecdaed@xhacker.debian> <20210324143407.GA8717@roeck-us.net>
 <20210324144853.GA5718@roeck-us.net> <20210324105313.4ff3ad07@gandalf.local.home>
 <20210325115043.6c00a33e@xhacker.debian>
In-Reply-To: <20210325115043.6c00a33e@xhacker.debian>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 25 Mar 2021 07:49:19 +0000
Message-ID: <CAHUa44GC9Co3v6RqqwpnAVRnGzWZyPnr=7Ww8C5_deoBpruPTg@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 3:50 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> On Wed, 24 Mar 2021 10:53:13 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> >
> > On Wed, 24 Mar 2021 07:48:53 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > > On Wed, Mar 24, 2021 at 07:34:07AM -0700, Guenter Roeck wrote:
> > > > On Wed, Feb 10, 2021 at 02:44:09PM +0800, Jisheng Zhang wrote:
> > > > > Add tracepoints to retrieve information about the invoke_fn. This would
> > > > > help to measure how many invoke_fn are triggered and how long it takes
> > > > > to complete one invoke_fn call.
> > > > >
> > > > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > >
> > > > arm64:defconfig:
> > > >
> > > > make-arm64 -j drivers/tee/optee/call.o
> > > >   CALL    scripts/atomic/check-atomics.sh
> > > >   CALL    scripts/checksyscalls.sh
> > > >   CC      drivers/tee/optee/call.o
> > > > In file included from drivers/tee/optee/optee_trace.h:67,
> > > >                  from drivers/tee/optee/call.c:18:
> > > > ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No such file or directory
> > > >    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > > >       |                                          ^
> > > > compilation terminated.
>
> Interesting, I always build linux kernel with "O=", didn't see such build error
> and IIRC, we didn't receive any lkp robot build error report.
>
> My steps are:
>
> mkdir /tmp/test
>
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=/tmp/test defconfig
>
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=/tmp/test drivers/tee/optee/
>
> Today, I tried to build the linux kernel w/o "O=...", I reproduced this error!
> This is the first time I saw "O=" make a different behavior.

I'm also compiling with O=... and couldn't understand what was going
on. Thanks for saving me from digging any deeper.

>
> I'll send out a patch to fix it.

Thanks,
Jens
