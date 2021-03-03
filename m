Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78732BF7B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579106AbhCCSaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:30:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44752 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346454AbhCCQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:26:22 -0500
Date:   Wed, 3 Mar 2021 17:25:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614788738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZTWagemQNz5GewyT7WLvXb542uz2adDEH/FcE9xr60=;
        b=04FeecnoD791eRCnuIapqbYbszpcear1aoTSi4bwph+Ji3+tzubpMcrX7IYLb5MxNVJbZQ
        YNOLCmhyls9pXmT9YslRHad0pq+9Ho9J/vvbJSXjPDdBrqu4IFPVd4By2gOr7vMQpx8mvT
        1E7DnoktHaW5MMDJ4MLivuIe7krDl27NGMh99rE/LIZUeucoxq1LAG8pi71bhTxNnBWjMS
        G+VnfXhHeyUJBCe2wiUddO1jNG5y9UmQyTXcy5FqM2NmJQM4fTRyruwCOJUI+5BSfCXmSk
        tuMKzswSCaCohn6ijb7cE8dsaKZlUPQhydkaZXI28JllHLv42pUq4f/K/jvNiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614788738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZTWagemQNz5GewyT7WLvXb542uz2adDEH/FcE9xr60=;
        b=TzMe2izdxY/zYPdm7KPUQ+ax3HYivtKMx1s+0Lq59lYDeLPFMXSFNjO6jjeWVV9EhlrfHR
        oV3LCokLuQLqI+BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] kthread: Move prio/affinite change into the newly
 created thread
Message-ID: <20210303162537.mkcqi3y6qki33hjh@linutronix.de>
References: <20201110113848.801379-1-bigeasy@linutronix.de>
 <20201110113848.801379-2-bigeasy@linutronix.de>
 <20201117124503.GI3121406@hirez.programming.kicks-ass.net>
 <87a6vbnfm3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87a6vbnfm3.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-21 11:55:48 [+0100], Thomas Gleixner wrote:
> On Tue, Nov 17 2020 at 13:45, Peter Zijlstra wrote:
> > On Tue, Nov 10, 2020 at 12:38:47PM +0100, Sebastian Andrzej Siewior wro=
te:
> >
> > Moo... yes this is certainly the easiest solution, because nouveau is a
> > horrible rats nest. But when I spoke to Greg KH about this, he suggested
> > nouveau ought to be fixed.
> >
> > Ben, I got terminally lost when trying to untangle nouvea init, is there
> > any chance this can be fixed to not hold that nvkm_device::mutex thing
> > while doing request_irq() ?
>=20
> OTOH, creating a dependency chain vs. cpuset_rwsem and whatever lock is
> held by the caller via request_irq() or kthread_create() is not
> necessarily restricted to the nivea driver. struct device::mutex (not
> the nkvm_device::mutex) is always held when a driver is probed.
>=20
> The cpuset_rwsem -> mmap_lock dependency is a given, so we're one step
> away from a circular dependency vs. mmap_lock.
>=20
> That was my reasoning to move the stuff out into the thread context.

Just a friendly ping that this is still in my queue=E2=80=A6

Ben could please reply here stating your view of the situation?

> Thanks,
>=20
>         tglx

Sebastian
