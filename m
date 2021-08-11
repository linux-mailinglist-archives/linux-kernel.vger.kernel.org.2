Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FD23E932F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 16:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhHKOBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 10:01:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51890 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhHKOBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:01:38 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628690473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/WQG4wAuQpuciWFmnWQOW1DW6+lNNLda5gvClzQMmo=;
        b=L2Qfc8IPdYQA8OK206g61OR25VDGpx9aVDK+5cL8bJC9oc12iTf48/DWAXFLTCc13QL7xf
        WGk78vxsFSvW8gqmQktn1ZcQLQrv52uI1eHCZdt0dDEYIaGlu4WWz7fTcD9JMaK239jJBU
        Zq3vQVQNWe1ZOyv8+cl+nVbNLKdekNwLc12ILR09z4khVNOKofbCXTmuA+GcauzqGKT4y6
        6J898+vGIulr/Y8iSn8FIwY2Q+ArhMeUEPFkoOt6qE1jBGmLdJcdbVoYkFum88Fq+JFGfT
        HwcawB5/eT0Vc4JoBepzvlj6q65mHm+5RwQQfBU47Al+UTxMRA0O2zIDsWSnLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628690473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/WQG4wAuQpuciWFmnWQOW1DW6+lNNLda5gvClzQMmo=;
        b=NBQF6I389MtOsXvROySoBQW2pdb5tCMcS8xABm2LV8SY5WEb+iftTwrhx2AFkKBtexOMlq
        GOVLeZ9V3sAS83Dg==
To:     brookxu <brookxu.cn@gmail.com>, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] clocksource: skip check while watchdog hung up or
 unstable
In-Reply-To: <2614d5ac-3392-20d1-d772-7a18bec40fa2@gmail.com>
References: <63064a758eb087febce3eff5b2c736a5449b3dd2.1628675461.git.brookxu@tencent.com>
 <877dgsp2vp.ffs@tglx> <2614d5ac-3392-20d1-d772-7a18bec40fa2@gmail.com>
Date:   Wed, 11 Aug 2021 16:01:13 +0200
Message-ID: <87wnoshyhi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11 2021 at 21:18, brookxu wrote:
> Thomas Gleixner wrote on 2021/8/11 8:44 =E4=B8=8B=E5=8D=88:
>> On Wed, Aug 11 2021 at 17:55, brookxu wrote:
>>> From: Chunguang Xu <brookxu@tencent.com>
>>>
>>> After patch 1f45f1f3 (clocksource: Make clocksource validation work
>>> for all clocksources), md_nsec may be 0 in some scenarios, such as
>>> the watchdog is delayed for a long time or the watchdog has a
>>> time-warp.
>>=20
>> Maybe 0? There is exactly one single possibility for it to be zero:
>>=20
>>   cs->wd_last =3D=3D wdnow, i.e. delta =3D 0 -> wd_nsec =3D 0
>>=20
>> So how does that condition solve any long delay or wrap around of the
>> watchdog? It's more than unlikely to hit exactly this case where the
>> readout is identical to the previous readout unless the watchdog stopped
>> counting.
>
> Maybe I missed something. Like this example, when watchdog run ,hpet have
> wrap around:
>
> 'hpet' wd_now: d76e5a69 wd_last: f929eb3c mask: ffffffff
>
> We can calculate the number of elapsed cycles:
> cycles =3D wd_now - wd_last =3D 0xde446f2d
>
> clocksource_delta() uses the MSB to determine an invalid inteval and retu=
rns
> 0, but for 0xde446f2d, this judgment should be wrong.

You're right. I forgot about the MSB check which is enabled on x86.

>>> We found a problem when testing nvme disks with fio, when multiple
>>> queue interrupts of a disk were mapped to a single CPU. IO interrupt
>>> processing will cause the watchdog to be delayed for a long time
>>> (155 seconds), the system reports TSC unstable and switches the clock
>>=20
>> If you hold off the softirq from running for 155 seconds then the TSC
>> watchdog is the least of your problems.
>
> To be precise, we are processing interrupts in handle_edge_irq() for a lo=
ng
> time. Since the interrupts of multiple hardware queues are mapped to a si=
ngle
> CPU, multiple cores are continuously issuing IO, and then a single core is
> processing IO. Perhaps the test case can be optimized, but shouldn't this=
 lead
> to switching clocks in principle?

The clocksource watchdog failure is only _ONE_ consequence. Processing
hard interrupts for 155 seconds straight will trigger lockup detectors
of all sorts if you have them enabled.

So just papering over the clocksource watchdog does not solve anything,
really. Next week you have to add similar hacks to the lockup detectors,
RCU and whatever.

Thanks,

        tglx
