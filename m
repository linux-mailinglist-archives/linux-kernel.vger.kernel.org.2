Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6830E361062
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhDOQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 12:48:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32900 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 12:47:59 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618505255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ij+uTvdXS+i44BI8usBRso/TQwX1K1KTl2LSXZhUKWo=;
        b=vEAEiuyatSPvPasYmHicpnRVSKCmNLpbaupdo2cJ2KNDO3r9kLSwyDKKYfVEXJpfliRe8A
        vwS/CfbECdwH2oz4Rzgv+Gc1t4jzPaW1DULTHR+nYoZzq1rCJ1cPMqn/Mdvt5x9uUbNk51
        q3Oz6A550mCu4oUvX40/ueEc48sYLdRR3tV9cLqlsnu7NaHHnE+PAMLsAgT02BX2saN0LE
        ehblqAGvMD6PYC7vYqtPA40HliOUuFj8APztpRRnKsPLMX00SiVnHPts0dKrTRRr035n+A
        hnGr5g5mj+1u5ui7rNCchaF92y0hG/ngzUDQMMRH+/X5pQseUW96D5D4J6NgqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618505255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ij+uTvdXS+i44BI8usBRso/TQwX1K1KTl2LSXZhUKWo=;
        b=XIpKNyzm6L4xPG0HN3vGp+unsBCCbWn4VN6zHsp1zE+YXOWbwpcesZ4B+2yuQxMmc6N94c
        oNKzfDriw3Ix5MBg==
To:     Lorenzo Colitti <lorenzo@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
In-Reply-To: <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com>
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com> <YHXRWoVIYLL4rYG9@kroah.com> <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com>
Date:   Thu, 15 Apr 2021 18:47:35 +0200
Message-ID: <87r1jbv6jc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14 2021 at 11:49, Lorenzo Colitti wrote:
> On Wed, Apr 14, 2021 at 2:14 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>> To give context, the commit is now 46eb1701c046 ("hrtimer: Update
>> softirq_expires_next correctly after __hrtimer_get_next_event()") and is
>> attached below.
>>
>> The f_ncm.c driver is doing a lot of calls to hrtimer_start() with mode
>> HRTIMER_MODE_REL_SOFT for I think every packet it gets.  If that should
>> not be happening, we can easily fix it but I guess no one has actually
>> had fast USB devices that noticed this until now :)
>
> AIUI the purpose of this timer is to support packet aggregation. USB
> transfers are relatively expensive/high latency. 6 Gbps is 500k
> 1500-byte packets per second, or one every 2us. So f_ncm buffers as
> many packets as will fit into 16k (usually, 10 1500-byte packets), and
> only initiates a USB transfer when those packets have arrived. That
> ends up doing only one transfer every 20us. It sets a 300us timer to
> ensure that if the 10 packets haven't arrived, it still sends out
> whatever it has when the timer fires. The timer is set/updated on
> every packet buffered by ncm.
>
> Is this somehow much more expensive in 5.10.24 than it was before?
> Even if this driver is somehow "holding it wrong", might there not be
> other workloads that have a similar problem? What about regressions on
> those workloads?

Let's put the question of whether this hrtimer usage is sensible or not
aside for now.

I stared at the change for a while and did some experiments to recreate
the problem, but that didn't get me anywhere.

Could you please do the following?

Enable tracing and enable the following tracepoints:

    timers/hrtimer_cancel
    timers/hrtimer_start
    timers/hrtimer_expire_entry
    irq/softirq_raise
    irq/softirq_enter
    irq/softirq_exit

and function tracing filtered on ncm_wrap_ntb() and
package_for_tx() only (to reduce the noise).

Run the test on a kernels with and without that commit and collect trace
data for both.

That should give me a pretty clear picture what's going on.

Thanks,

        tglx
