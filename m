Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610C33979DB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhFASQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:16:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34714 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhFASQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:16:17 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622571273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONZTNvHfCInTdRpK2+6FPfc2/xcAyhA+vFwR7fck3So=;
        b=2jBZKwhKvZ3I9OMlunAJE7Z6BxDuhuAvm6K+jj9ACTcJcYMt/5QTsiXUURo8lVizfwyQfN
        jMnnXZuTUnSFfeQOe7/sdfHvWrWfAnvF3EiQF7Q3KsNusMIyxGIwIZvPzJ1/9P//a1KzRs
        xKLnbNF23sde9t10WmWXiQ2QZ9mTanTxhi+Kvg1gkBXVDRC8NeVcTZUJ+NRasUjlhLrM8p
        O4qUXNMnJjyZsyCp0QTSk+asAbsue67ruUPj3T1o95q3xKxZ52eMOIZhesKairQhvgsMJM
        Pa2stRHAWJlpgctRsuklBPtbxDORLqsaZPypFZFhGn6jge1+7Te7LG2qeERQ1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622571273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONZTNvHfCInTdRpK2+6FPfc2/xcAyhA+vFwR7fck3So=;
        b=4Aqo0PQDo0riJz6+LIJYM3gzoR7CsaRjMa0I9HwrzUCJ+eE3psp96HjGucLZ2z7i8mK8+g
        DtdGqgx3kfL064BQ==
To:     Will Deacon <will@kernel.org>
Cc:     Xin Hao <xhao@linux.alibaba.com>, fweisbec@gmail.com,
        john.stultz@linaro.org, kernel-team@android.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        lorenzo@google.com, maz@kernel.org, mika.penttila@nextfour.com,
        sboyd@kernel.org
Subject: Re: [PATCH v2 2/5] tick/broadcast: Split __tick_broadcast_oneshot_control() into a helper
In-Reply-To: <20210601121351.GA27832@willie-the-truck>
References: <20210524221818.15850-3-will@kernel.org> <c3573cd8-a4c8-43c2-be66-8b74d688a406@linux.alibaba.com> <20210527082219.GA21311@willie-the-truck> <e0f6523f-36f8-188c-da99-4dcb51375522@linux.alibaba.com> <20210527115646.GD22019@willie-the-truck> <87k0nf3rjz.ffs@nanos.tec.linutronix.de> <20210601121351.GA27832@willie-the-truck>
Date:   Tue, 01 Jun 2021 20:14:33 +0200
Message-ID: <8735u13112.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01 2021 at 13:13, Will Deacon wrote:
> On Mon, May 31, 2021 at 04:29:20PM +0200, Thomas Gleixner wrote:
>> On Thu, May 27 2021 at 12:56, Will Deacon wrote:
>>=20
>> > On Thu, May 27, 2021 at 07:35:03PM +0800, Xin Hao wrote:
>> >>=20
>> >> =E5=9C=A8 2021/5/27 =E4=B8=8B=E5=8D=884:22, Will Deacon =E5=86=99=E9=
=81=93:
>> >> > On Thu, May 27, 2021 at 03:23:06PM +0800, Xin Hao wrote:
>> >> > >  =C2=A0=C2=A0=C2=A0=C2=A0 I=C2=A0 had backport you=C2=A0 tick/bro=
adcast: Prefer per-cpu relatives patches,
>> >> > >=20
>> >> > > but i did not get the true result,=C2=A0 the Wakeup Devices are a=
ll null, why?
>> >> > Probably because you don't have any suitable per-cpu timers to act =
as a
>> >> > wakeup. Do you have a per-cpu timer registered with CLOCK_EVT_FEAT_=
PERCPU
>> >>=20
>> >> Yes, you are right, but i want to know why the timer do not support=
=C2=A0
>> >> CLOCK_EVT_FEAT_PERCPU.
>> >
>> > I defer to Thomas on this one.
>>=20
>> How should I know what kind of timers this hardware has?
>
> Duh, sorry, I replied to the wrong question. I meant to defer the decision
> about whether to print "<NULL>" if the wakeup timer is absent, or whether=
 to
> omit the line entirely.
>
> I went with the former in the patches you queued as it's both consistent
> with the rest of the code and probably (?) easier to parse.

That makes more sense. I just kept it as is. The <NULL> is fine.

Thanks,

        tglx
