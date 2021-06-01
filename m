Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD2C397309
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhFAMPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhFAMPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:15:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA031610FC;
        Tue,  1 Jun 2021 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622549637;
        bh=6cjRp6SlAWCo4Dw1FiAWmmubRlNl72lq+OCOpGHgrFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHjU64PRYKt0XsLDK/M5TxG/CkswdPH7a3xMheB5+GlBPsHPgDg4L8XW8tX+ouaUn
         dIVVJjwAeGDK+Y7dNNr5wCdsoD96rDa3C88pdOpSqaplaexvHzZvpyZAe8QLw2h96X
         2E/A8auPusAmyYdTFxmjicQZc3zRYg+hY8zi/YoXve3fyaqQr0fTK05WN2sN82JVgP
         vbxbz/Wywjg1ETwXu05VIILQWq7Du4kTm0yGBYxpiklN8BL6GEmrgt7S6YrY3YvbiB
         AGV5YgPWs/CIvDx37ozVsIV7KMye6NwbthCE6vDALdFCee2ZtO8VMbsrJGlecWyquk
         ypwYV7wUUBN7w==
Date:   Tue, 1 Jun 2021 13:13:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Xin Hao <xhao@linux.alibaba.com>, fweisbec@gmail.com,
        john.stultz@linaro.org, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lorenzo@google.com, maz@kernel.org, mika.penttila@nextfour.com,
        sboyd@kernel.org
Subject: Re: [PATCH v2 2/5] tick/broadcast: Split
 __tick_broadcast_oneshot_control() into a helper
Message-ID: <20210601121351.GA27832@willie-the-truck>
References: <20210524221818.15850-3-will@kernel.org>
 <c3573cd8-a4c8-43c2-be66-8b74d688a406@linux.alibaba.com>
 <20210527082219.GA21311@willie-the-truck>
 <e0f6523f-36f8-188c-da99-4dcb51375522@linux.alibaba.com>
 <20210527115646.GD22019@willie-the-truck>
 <87k0nf3rjz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0nf3rjz.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, May 31, 2021 at 04:29:20PM +0200, Thomas Gleixner wrote:
> On Thu, May 27 2021 at 12:56, Will Deacon wrote:
> 
> > On Thu, May 27, 2021 at 07:35:03PM +0800, Xin Hao wrote:
> >> 
> >> 在 2021/5/27 下午4:22, Will Deacon 写道:
> >> > On Thu, May 27, 2021 at 03:23:06PM +0800, Xin Hao wrote:
> >> > >       I  had backport you  tick/broadcast: Prefer per-cpu relatives patches,
> >> > > 
> >> > > but i did not get the true result,  the Wakeup Devices are all null, why?
> >> > Probably because you don't have any suitable per-cpu timers to act as a
> >> > wakeup. Do you have a per-cpu timer registered with CLOCK_EVT_FEAT_PERCPU
> >> 
> >> Yes, you are right, but i want to know why the timer do not support 
> >> CLOCK_EVT_FEAT_PERCPU.
> >
> > I defer to Thomas on this one.
> 
> How should I know what kind of timers this hardware has?

Duh, sorry, I replied to the wrong question. I meant to defer the decision
about whether to print "<NULL>" if the wakeup timer is absent, or whether to
omit the line entirely.

I went with the former in the patches you queued as it's both consistent
with the rest of the code and probably (?) easier to parse.

Will
