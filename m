Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83CC35B340
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 12:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhDKK6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 06:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhDKK6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 06:58:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 03:58:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618138711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i9IFb43irFo++N1G97Ay7bqy0xrC2SvYxqEarZQIq1I=;
        b=a50t4Lljcmx4u/n4R4s95mjjitD86u690YGBq3x811x/UgMGi/HJRcvE+WftsFA5Yv5qYS
        O8SWjmIx22uiCKga58sgV5lBw/QDTxj5Z6V5AIJmTJiMd0AjCLZxaIjasEH+pGWGGWPHNH
        nLyuedD672MOIE5aOScBKWgd+49KtZOs69OYevBwQg1imWx7AONmYGMl1MOCclUwQ6TWLm
        KrgmB+qZ8TB931RSbJJTDjuIzTlGP8GZk1QihG6eG+1lxn4xtuFDudd2+NQ6JtsUk5X7zT
        cO3Q6vXaJScQRDcpCqCc2n+I9niIgKz0+Q4PfMFgbbSAtXozH564WJZkmUwZYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618138711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i9IFb43irFo++N1G97Ay7bqy0xrC2SvYxqEarZQIq1I=;
        b=igpePDEEzudDnf1SNaU3K28b+YvP2R/MtBzhAZqn9bMImEHn0HzGvrumOe5uTXmMjLOnJN
        8GgqzhvEL6RMtBAw==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource] Do not mark clocks unstable due to delays for v5.13
In-Reply-To: <20210410232644.GT4510@paulmck-ThinkPad-P17-Gen-1>
References: <20210402202929.GA22273@paulmck-ThinkPad-P72> <20210402203137.22479-1-paulmck@kernel.org> <87pmzc498v.ffs@nanos.tec.linutronix.de> <20210402224828.GA3683@paulmck-ThinkPad-P72> <87im4u4lft.ffs@nanos.tec.linutronix.de> <20210410232644.GT4510@paulmck-ThinkPad-P17-Gen-1>
Date:   Sun, 11 Apr 2021 12:58:31 +0200
Message-ID: <875z0t2ilk.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10 2021 at 16:26, Paul E. McKenney wrote:
> On Sat, Apr 10, 2021 at 10:01:58AM +0200, Thomas Gleixner wrote:
>> On Fri, Apr 02 2021 at 15:48, Paul E. McKenney wrote:
>> I buy the vCPU preemption part and TBH guests should not have that
>> watchdog thing active at all for exactly this reason.
>
> Agreed, one approch is to enable the the clocksource watchdog only in
> the hypervisor, and have some action on the guests triggered when the
> host detects clock skew.
>
> This works quite well, at least until something breaks in a way that
> messes up clock reads from the guest but not from the host.  And I
> am sure that any number of hardware guys will tell me that this just
> isn't possible, but if failing hardware operated according to their
> expectations, that hardware wouldn't be considered to be failing.
> Or it wouldn't be hardware, firmware, or clock-driver bringup, as the
> case may be.

Don't tell me. The fact that this code exists at all is a horror on it's
own.

>> SMI, NMI injecting 62.5ms delay? If that happens then the performance of
>> the clocksource is the least of your worries.
>
> I was kind of hoping that you would tell me why the skew must be all the
> way up to 62.5ms before the clock is disabled.  The watchdog currently
> is quite happy with more than 10% skew between clocks.
>
> 100HZ clocks or some such?

Histerical raisins. When the clocksource watchdog was introduced it
replaced a x86 specific validation which was jiffies based. I have faint
memories that we wanted to have at least jiffies based checks preserved
in absence of other hardware, which had other problems and we gave up on
it. But obviously nobody thought about revisiting the threshold.

Yes, it's way too big. The slowest watchdog frequency on x86 is ~3.5 Mhz
(ACPI PMtimer). Don't know about the reference frequency on MIPS which
is the only other user of this.

Thanks,

        tglx

