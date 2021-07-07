Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B33BE6DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 13:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhGGLIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhGGLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:08:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B2C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 04:05:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j199so1781664pfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4kTl0PGqTmSM/vcOdTLIDqeuriihxTsqaNVsQc07grU=;
        b=Bwhf8xhbHyJyqtm4LVlsXUTEBtOv5Vgg7kD+bxs9Bs1+vQIORtgOpWqY7NXUzGfkRH
         Y5bP9ePf0oGgrkUCYpVfgf/EjyHNFFeoSpiCqskZKjv4QeUB+r01jCssN16CR16fKsuh
         AX91QCh436gJXQIeNvBr/zZxKsf529boRi8LgLwwraiafi4xAeEj8XlHHx6bmpUT6FaA
         OOEVKuAN+X6bnPzIGwcr4XLtwr9yLKwRmV6IDyCKSw3dRp40+Q/O0AfN6z3vTS3C4hn5
         CptRlttUzk1SAGqjR1NWzRmjz5eGSn9dXaCK2BC6B72aKN94A5+IDTPFzqQWLE3Qtf0J
         Fskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4kTl0PGqTmSM/vcOdTLIDqeuriihxTsqaNVsQc07grU=;
        b=N2NXzTefmvfSnhsNI4hCQ8jqQd6lmcUgivbBAr+Xuo165cvroLH3JHgNEQ3yNb5w4h
         Mz2MOMrCOYSX0mT6onogD6bwltVMGYXKs2XiVr+PKQB7/Q+XmCsiK7s+rMV3Wh/7g/WN
         7XMVhCNL2b0x9TItTlSBrje1h9d19HzaGDV+HLnkzpgQicyw1DFd7Y6IY8krprqoc/eT
         ZvFJqxJ98EtedpMtM7noa2sZ95VfjD3LqfN4RnS10EUzCFU5f1WXEjnVlmv8gIo38BLE
         8RI4artpHr0zULkn4lgdK+QLduEViSoopKd0c5oWKDNyB97jkTqjmtY4uk3Rc84K9ZD2
         Y+zw==
X-Gm-Message-State: AOAM532qJxCr9GUgT/JGmC8z1ZoUG4obcczbU2f88ftwtIeOzGgNfaBe
        odpi/zjXuYaUp9yXa6//xQht6g==
X-Google-Smtp-Source: ABdhPJz3PjdRDmZzI0XYTQQ4WmTSvBzHfz+rLXybFS8EFTkekYOUVt9V2Q7eMhqYfM4CAazBA0dAvw==
X-Received: by 2002:a63:471b:: with SMTP id u27mr26183969pga.301.1625655928056;
        Wed, 07 Jul 2021 04:05:28 -0700 (PDT)
Received: from 192.168.1.6 ([115.96.127.142])
        by smtp.googlemail.com with ESMTPSA id n23sm22275564pgv.76.2021.07.07.04.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 04:05:27 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <anisinha@anisinha.ca>
Date:   Wed, 7 Jul 2021 16:35:07 +0530 (IST)
X-X-Sender: anisinha@anisinha-lenovo
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Ani Sinha <ani@anisinha.ca>, linux-kernel@vger.kernel.org,
        anirban.sinha@nokia.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v1] Print a log when the sched clock is marked unstable
In-Reply-To: <8735sqqvoh.ffs@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.22.394.2107071629490.194292@anisinha-lenovo>
References: <20210627064911.2179786-1-ani@anisinha.ca> <8735sqqvoh.ffs@nanos.tec.linutronix.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tglx,

On Wed, 7 Jul 2021, Thomas Gleixner wrote:

> Ani,
>
> On Sun, Jun 27 2021 at 12:19, Ani Sinha wrote:
>
> I asked you to read Documentation/process carefully and I told you:
>
>         Also your subject line want's a proper prefix.
>
> Your patch is missing a prefix again. Hint:
>
>   git log kernel/sched/clock.c
>

OK thanks for the pointer. Its my bad that staring at the computer for so
many hours stuck at home makes me read "prefix" as "fix". So I read

Also your subject line want's a proper fix


> > In other parts of the kernel when the sched clock transitions from
> > stable to unstable and vice versa, a kernel info log is printed.  When
> > the sched clock is marked explicitly as unstable, we should print an
> > information log as well. This patch addresses this. It is useful in
>
> git grep 'This patch' Documentation/process/
>
> Also please avoid the 'we' wording. 'We should print' does not make
> sense if you really think about it.

Please understand that Linux kernel is not the only upstream software
where I am contrinuting. Each community has their own rules. Maybe add a
check in checkpatch.pl in the kernel so that these things maybe caught
automatically?

>
> > cases where for example, we want to understand why a certain feature
> > like NOHZ, which depends on a stable sched clock, is not available.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  kernel/sched/clock.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > See also thread
> > https://lkml.org/lkml/2021/6/20/32
> >
> > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > index c2b2859ddd82..5a403b2c9b3f 100644
> > --- a/kernel/sched/clock.c
> > +++ b/kernel/sched/clock.c
> > @@ -192,8 +192,10 @@ void clear_sched_clock_stable(void)
> >
> >  	smp_mb(); /* matches sched_clock_init_late() */
> >
> > -	if (static_key_count(&sched_clock_running.key) == 2)
> > +	if (static_key_count(&sched_clock_running.key) == 2) {
> > +		pr_info("sched_clock: Marking unstable.\n");
> >  		__clear_sched_clock_stable();
>
> Why isn't that in __clear_sched_clock_stable() ?
>

updated in v2. Makes sense do emit the log at the lowest level of
abstraction so that all code paths are potentially caught.

Ani

