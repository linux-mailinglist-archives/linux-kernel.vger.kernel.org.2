Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13D0396640
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhEaRCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhEaPly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:41:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72051C0611B7
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 07:29:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622471360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iS72Lyc7K+Koe5Hwldg+FNigquGbqKC8+JuTLMLpsk8=;
        b=kr8TdLoWdSe1LsFejn8coqGEFv2CK98bMypXrjHUtOcK8XxDVTXyTP/6ILnRvNI/sFpJ2T
        skSem6rYERm//3EUFxZ+Yt6RVFY3qnolfLdBQxt4JztZ1JR0KpsE9mB1O684tpzoCOpnxo
        orRcSbx7iocfCo4gUH0WPscZRHd8wNi8wyrgp2X53fXOj177af7Fka2Tamr/fH40zZDvS+
        ffUI1aQVohJwJvNSxlU1bGM2rheMq7gNgDYup2y1nXdQCp5sI3kWMkTPhRlzr2zSnFOJn8
        yL0ZEO/LoUGYnihq37pc3iYu05zsVPRWdG8jOcuD/cBhb9Gq2nn2vL/dTJ2zXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622471360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iS72Lyc7K+Koe5Hwldg+FNigquGbqKC8+JuTLMLpsk8=;
        b=/oq0SpQ0lR3JGynw2ALXuql8FQREM6P3BWfK9ewYh8fiFGN+txZUgxJxEu7kxS8OHGUS31
        6iyQi/fDy6GwKNAw==
To:     Will Deacon <will@kernel.org>, Xin Hao <xhao@linux.alibaba.com>
Cc:     fweisbec@gmail.com, john.stultz@linaro.org,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo@google.com, maz@kernel.org,
        mika.penttila@nextfour.com, sboyd@kernel.org
Subject: Re: [PATCH v2 2/5] tick/broadcast: Split __tick_broadcast_oneshot_control() into a helper
In-Reply-To: <20210527115646.GD22019@willie-the-truck>
References: <20210524221818.15850-3-will@kernel.org> <c3573cd8-a4c8-43c2-be66-8b74d688a406@linux.alibaba.com> <20210527082219.GA21311@willie-the-truck> <e0f6523f-36f8-188c-da99-4dcb51375522@linux.alibaba.com> <20210527115646.GD22019@willie-the-truck>
Date:   Mon, 31 May 2021 16:29:20 +0200
Message-ID: <87k0nf3rjz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27 2021 at 12:56, Will Deacon wrote:

> On Thu, May 27, 2021 at 07:35:03PM +0800, Xin Hao wrote:
>>=20
>> =E5=9C=A8 2021/5/27 =E4=B8=8B=E5=8D=884:22, Will Deacon =E5=86=99=E9=81=
=93:
>> > On Thu, May 27, 2021 at 03:23:06PM +0800, Xin Hao wrote:
>> > >  =C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0 had backport you=C2=A0 tick/broadc=
ast: Prefer per-cpu relatives patches,
>> > >=20
>> > > but i did not get the true result,=C2=A0 the Wakeup Devices are all =
null, why?
>> > Probably because you don't have any suitable per-cpu timers to act as a
>> > wakeup. Do you have a per-cpu timer registered with CLOCK_EVT_FEAT_PER=
CPU
>>=20
>> Yes, you are right, but i want to know why the timer do not support=C2=A0
>> CLOCK_EVT_FEAT_PERCPU.
>
> I defer to Thomas on this one.

How should I know what kind of timers this hardware has?

Thanks,

        tglx

