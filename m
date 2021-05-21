Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C5338C8A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbhEUNvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:51:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54146 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhEUNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:51:03 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621604979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HCaRskSS01bIv3f54A3vpRo8CfM3PmECUijGdGwwaZM=;
        b=tsNUav2Duagwr1OktGXOly/chOAYD2bmyTPog0/54KKIKgYWZsSj/KoA1Do9CIlOHdRrAy
        l8Wckg+es45UV29dbhRXSgApo2+AA7VfG6Kv4QP5t2xotRhoPFrD14s879TsrebIlT2oHp
        bmNW0TCc/ml3Cs7HILsyp5pOHK9OrPtqv5Y8e3lTC7X0YK987RaccdtTlPYiwjKqO4KpMq
        +WnGTkwEG6unkbj+4hC1rK180OyD1MXnnm3yMzvzH3FbMRvu0BIFrhKb1Y5k0eOTUagNu9
        AbR2TCX062iTP9D1yquicr4ZkyTLQ/IxM5ro0kAK9v0hx2uk7VbtIo+KNQZieQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621604979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HCaRskSS01bIv3f54A3vpRo8CfM3PmECUijGdGwwaZM=;
        b=rnSbMyottTAmrHZEvgHBOGGBmuadQg48n9AQwtQ/zr3dDfwTnr15r9+PCVzal5FQ9yr1WI
        vVjVECQFwutUJeDg==
To:     Will Deacon <will@kernel.org>,
        Mika =?utf-8?Q?Penttil=C3=A4?= <mika.penttila@nextfour.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH 3/5] tick/broadcast: Prefer per-cpu oneshot wakeup timers to broadcast
In-Reply-To: <20210521112503.GA11850@willie-the-truck>
References: <20210520184705.10845-1-will@kernel.org> <20210520184705.10845-4-will@kernel.org> <a269c869-b966-75d5-5fe1-6ed6921c1b83@nextfour.com> <20210521112503.GA11850@willie-the-truck>
Date:   Fri, 21 May 2021 15:49:39 +0200
Message-ID: <87tumw9oy4.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21 2021 at 12:25, Will Deacon wrote:
> On Fri, May 21, 2021 at 05:25:41AM +0300, Mika Penttil=C3=A4 wrote:
>> On 20.5.2021 21.47, Will Deacon wrote:
>> >   /*
>> >    * Conditionally install/replace broadcast device
>> >    */
>> > -void tick_install_broadcast_device(struct clock_event_device *dev)
>> > +void tick_install_broadcast_device(struct clock_event_device *dev, in=
t cpu)
>> >   {
>> >   	struct clock_event_device *cur =3D tick_broadcast_device.evtdev;
>> > +	if (tick_set_oneshot_wakeup_device(dev, cpu))
>> > +		return;
>> > +
>> >   	if (!tick_check_broadcast_device(cur, dev))
>> >   		return;
>>=20
>> Does this disable hpet registering as a global broadcast device on x86 ?=
 I
>> think it starts with cpumask =3D cpu0 so it qualifies for a percpu wakeup
>> timer.
>
> Well spotted, I think you're probably right. I'll try to reproduce on my
> laptop to confirm, but I hadn't noticed the tricks played with the cpumask
> on x86.
>
> I'll probably need to rework things so that we install the broadcast timer
> first, but prefer global devices.

HPET has cpumask(0) but does not have CLOCK_EVT_FEAT_PERCPU set. The
feature flag is a clear indicator for per cpu.

Thanks,

        tglx
