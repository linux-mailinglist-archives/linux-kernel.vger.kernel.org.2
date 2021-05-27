Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D03392D50
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhE0L5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233683AbhE0L5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:57:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E6AD6103E;
        Thu, 27 May 2021 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622116536;
        bh=pHiGUksg5cPGxFG52DohbH7Ek7e5+uWKvRCAt78JGuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+QbYfvAoCsAgbrebJg9SYxXHOdc8rxHRTVP325dkWl2AsEgjAKWDTDLkJkpwW1F6
         a2zW/EZ1oYLp+z6XTTtH+oiFNIGL3HSRDvRes24O6klHUIeFUGk//BqZvVOO8lRs+p
         w+KXjBpIubYEtVdQIZP//s2yg7SoGuGHuoJY4xPWR5/C0vqKXl16C+5k7snFn3wwZV
         mGl36KkoX894qY51Go560soaXldvQ1NV7tk4UP+15/ooNArfMZjaFpqEONTJQ6gA9z
         DZe5Gy9DSBl9QkeWkL013nEO30BkTlaDHXoUZgPaDRB0VRuz3IyGdHOwQbR6Pjf+Rh
         nXEvY5tq7HaeQ==
Date:   Thu, 27 May 2021 12:55:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     fweisbec@gmail.com, john.stultz@linaro.org,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo@google.com, maz@kernel.org,
        mika.penttila@nextfour.com, sboyd@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 2/5] tick/broadcast: Split
 __tick_broadcast_oneshot_control() into a helper
Message-ID: <20210527115530.GC22019@willie-the-truck>
References: <20210524221818.15850-3-will@kernel.org>
 <c3573cd8-a4c8-43c2-be66-8b74d688a406@linux.alibaba.com>
 <20210527082219.GA21311@willie-the-truck>
 <e0f6523f-36f8-188c-da99-4dcb51375522@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0f6523f-36f8-188c-da99-4dcb51375522@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 07:35:03PM +0800, Xin Hao wrote:
> 
> 在 2021/5/27 下午4:22, Will Deacon 写道:
> > On Thu, May 27, 2021 at 03:23:06PM +0800, Xin Hao wrote:
> > >       I  had backport you  tick/broadcast: Prefer per-cpu relatives patches,
> > > 
> > > but i did not get the true result,  the Wakeup Devices are all null, why?
> > Probably because you don't have any suitable per-cpu timers to act as a
> > wakeup. Do you have a per-cpu timer registered with CLOCK_EVT_FEAT_PERCPU
> 
> Yes, you are right, but i want to know why the timer do not support 
> CLOCK_EVT_FEAT_PERCPU.

I suspect there may be drivers with the feature missing simply because it
wasn't really used for much until now (I think it just prevented use for
broadcast). However, before adding that to a timer, you do need to make
sure that it really is banked per-cpu (or at least handles racing accesses)
as well as having the per-cpu irq.

Will
