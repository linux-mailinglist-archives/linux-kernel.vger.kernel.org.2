Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EFF31C8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBPK3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:29:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38332 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBPK3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:29:39 -0500
Date:   Tue, 16 Feb 2021 11:28:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613471337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fi4dPmQjSKkIkqOHrhkXxa2NNDUDTA/zX6+iQHjP4G0=;
        b=fJKpHlKp7w5dERhikQ1Mn5lP10phU43e5dVS5E3wvRdUnTIgNQN9oAI2kqW7iyYnLgb4BL
        YNN+Lu5081Nnm0s541/yDt1r7oYhMOxbAYCkzZT8kNLAO9CA4c0uR+xeY3Hbd9A7Ybn7kW
        BEN6dv5tHp6Td5UtyuWbUs6DIVxZ5moSemuiuXVPTkDpkgqOG8fnFot/PB+BarN6Tl9UPC
        kK3LGEiFmp5ppRp/IKT+HH82d1OK6lcsSgaUH+Am0BUdHGnf5xjB7cW+rFI1/gxgzFB2aW
        LzvWDS3StdVkNN8s5TvsjZsiY4JgMx4zhGA/tYWETKO2IC8/+UQKiv15ghnyLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613471337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fi4dPmQjSKkIkqOHrhkXxa2NNDUDTA/zX6+iQHjP4G0=;
        b=Ud4lDf/g0DQ1Htmf+oYmD8TH3i120nh3UNacSGK44/3epKNQfZLBzCKM1H2UMUuaemG/8b
        Cla5HiAArLA+UJCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v3] auxdisplay: Remove in_interrupt() usage.
Message-ID: <20210216102856.dnaycukt3oqxoszp@linutronix.de>
References: <20210208175824.381484-1-bigeasy@linutronix.de>
 <CANiq72kqfPOpgwvNo3hTesCJztODxVGonJXpeeX=S+O4roNZsw@mail.gmail.com>
 <20210208190735.ibq44r5pc4cwzt7j@linutronix.de>
 <CANiq72kq_d=5TvdhndP9zkyTD1pHF6WQb+qs01D68DEQH6jVjQ@mail.gmail.com>
 <20210208204136.sv4omzms3nadse6e@linutronix.de>
 <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
 <20210209090112.lewvvhnc2y7oyr27@linutronix.de>
 <CANiq72mG3zXA7j9KbC74hQ1BMgw713Hm3WDAcQBjKxgg0fLHeg@mail.gmail.com>
 <20210213165040.vzzieegx4aliyosd@linutronix.de>
 <CANiq72mkkSfbnNM_mmXE-TNKO1orsAeyByMKFy1N6hm+EBA40A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72mkkSfbnNM_mmXE-TNKO1orsAeyByMKFy1N6hm+EBA40A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-16 10:32:15 [+0100], Miguel Ojeda wrote:
> Hi Sebastian,
Hi,

> On Sat, Feb 13, 2021 at 5:50 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > charlcd_write() is invoked as a VFS->write() callback and as such it is
> > always invoked from preemptible context and may sleep.
> 
> Can we put this sentence as a comment in the code, right before the
> call to cond_resched()?
> 
> > charlcd_puts() is invoked from register/unregister callback which is
> > preemtible. The reboot notifier callback is also invoked from
> 
> Same for this one.

Could we please avoid documenting the obvious? It is more or less common
knowledge that the write callback (like any other) is preemptible user
context (in which write occurs). The same is true for register/probe
functions. The non-preemptible / atomic is mostly the exception because
of the callback. Like from a timer or an interrupt.

> In addition, somehow the spelling fixes got lost from the previous version.
> 
> Same for the "code quotes": some have no quotes, others have `` or `'.
> No big deal, I can fix it on my side if needed, but just letting you
> know! :-)

I'm so sorry. I must have taken the wrong patch while doing the update.
My apologies. Once we sorted out the above, I will provide an update.

> Thanks!
> 
> Cheers,
> Miguel

Sebastian
