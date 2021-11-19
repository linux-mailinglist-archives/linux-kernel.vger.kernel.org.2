Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904B245758D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhKSRji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:39:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46850 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbhKSRji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:39:38 -0500
Date:   Fri, 19 Nov 2021 18:36:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637343395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rE+uR55T3NDrAl5EkS1HQVSaK3QHtEm2rur2ZfB1Dxs=;
        b=FfSf660nfUjJvA6SSNJNsxc7ygR2+ZoBk+3LwceBC45e38NqVSkoWlC4h25cR6B7ldkWZi
        4PON7dpuzX0HwA6V2VtjD2MLifShuZ+1lvcvoWhsIwObn4oVx3/3hWR7UxZZWBw6Prv42p
        wK4j045upCS2AqZZE5Xona/PB0oefoN5BLtuVmUSWMqBNmwvSOtxKybU/ib2OG0i2tVfHO
        0zEjCtp/ru75D0p1ht2EmngzVGHkOMoKNUZQdPbrcwKflIlrBmTPgFYLqCVuGad/6MRgEV
        Nzqad1Wh/W6VTKNmB4AYPu84zC1TAW6ZLYa6uUUDGOlzL/MxfepFId+hHLBsGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637343395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rE+uR55T3NDrAl5EkS1HQVSaK3QHtEm2rur2ZfB1Dxs=;
        b=ajhPhWzO3mMQocZyNH7dM5VpWCzOQj8glOZoG8UmdFf8axNmi+J3dWZkTOVx7/IyAEz99+
        CQtjZiDUZOIxPGAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [RFC] cpu/hotplug: allow the cpu in UP_PREPARE state to bringup
 again
Message-ID: <20211119173633.ktoxddq63zklquev@linutronix.de>
References: <20210901051143.2752-1-longpeng2@huawei.com>
 <20210930140118.z352cj3uzjscctcb@linutronix.de>
 <dae48783927d4c8f916bfe0776a4a341@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <dae48783927d4c8f916bfe0776a4a341@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for forgetting=E2=80=A6

On 2021-10-08 03:10:34 [+0000], Longpeng (Mike, Cloud Infrastructure Servic=
e Product Dept.) wrote:
> > -----Original Message-----
> > From: Sebastian Andrzej Siewior [mailto:bigeasy@linutronix.de]
> > Sent: Thursday, September 30, 2021 10:01 PM
> > To: Longpeng (Mike, Cloud Infrastructure Service Product Dept.)
> > <longpeng2@huawei.com>
> > Cc: peterz@infradead.org; valentin.schneider@arm.com; mingo@kernel.org;
> > tglx@linutronix.de; linux-kernel@vger.kernel.org; Gonglei (Arei)
> > <arei.gonglei@huawei.com>
> > Subject: Re: [RFC] cpu/hotplug: allow the cpu in UP_PREPARE state to br=
ingup
> > again
> >=20
> > On 2021-09-01 13:11:43 [+0800], Longpeng(Mike) wrote:
> > > The cpu's cpu_hotplug_state will be set to CPU_UP_PREPARE before
> > > the cpu is waken up, but it won't be reset when the failure occurs.
> > > Then the user cannot to make the cpu online anymore, because the
> > > CPU_UP_PREPARE state makes cpu_check_up_prepare() unhappy.
> > >
> > > We should allow the user to try again in this case.
> >=20
> > Can you please describe where it failed / what did you reach that state?
> >=20
>=20
> native_cpu_up
>   cpu_check_up_prepare
>   do_boot_cpu
>     /* Wait 10s total for first sign of life from AP */
>=20
> It will fail if the AP doesn't response in 10s and then cpu_hotplug_state
> will stay in CPU_UP_PREPARE state.
>=20
> This could happen on a virtualized system, especially in some special usa=
ges,
> e.g. Software Enclaves [1][2]

So wakeup_cpu_via_init_nmi() / wakeup_secondary_cpu() succeeds but the
CPU does not show up with 10 seconds.
Does the CPU come in later and spins in wait_for_master_cpu() or is the
CPU completely missing?

> [1] https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave.html
> [2] https://www.alibabacloud.com/help/doc-detail/203433.htm?spm=3Da3c0i.2=
3986742.6981761520.1.7e30715eZCRXmk
>=20
>=20
> > > Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> > > ---
> > >  kernel/smpboot.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> > > index f6bc0bc..d18f8ff 100644
> > > --- a/kernel/smpboot.c
> > > +++ b/kernel/smpboot.c
> > > @@ -392,6 +392,13 @@ int cpu_check_up_prepare(int cpu)
> > >  		 */
> > >  		return -EAGAIN;
> > >
> > > +	case CPU_UP_PREPARE:
> > > +		/*
> > > +		 * The CPU failed to bringup last time, allow the user
> > > +		 * continue to try to start it up.
> > > +		 */
> > > +		return 0;
> > > +
> > >  	default:
> > >
> > >  		/* Should not happen.  Famous last words. */

Sebastian
