Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF94E3C195D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 20:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhGHSsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 14:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhGHSsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 14:48:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5C1C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 11:45:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625769949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SldBbRL1As6HH2M61BP/ubphyI2dj2XqtlsppF+Xl4Q=;
        b=05maXRbVnoMnncjd+n3nI80cb9PMpyto6MNDRX76X4aZSwtmykUGITG3mxpqrFSIaxhde3
        W/fwU2kSrLAzzE1b0dGsHgNDJYoWGstMmXBZ/c+YwT/2F3FwW3PV2HK5MdkpDQ14Bz/dGD
        PYnsJ+bMauWnjdlL5Ort4QLKWG6a23ekQH2eHe+a37614F16h16+5+AF5HS9K2PXOEY3b0
        GPWM66Dbw2XtA570v2xwT7egqsJE4QpxBVg8cggwpBIKiITiGZexVKx+ESUbO6wFDZqsYD
        v/4LzoTyms5bm2ENUlaEJiwLhdq/MQsaXG13/+6JxaZwuekfd3yTosJNQEEdFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625769949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SldBbRL1As6HH2M61BP/ubphyI2dj2XqtlsppF+Xl4Q=;
        b=SVWqV/oyKYTmODZ7FmPa7CtEG5lKr9FGR+ben8tsLurWtZK1DKjp8+T5Ud6ekQ1bV70Ard
        dLd0LV+IeSkLoCAA==
To:     "Raj\, Ashok" <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Dey\, Megha" <megha.dey@intel.com>, linux-kernel@vger.kernel.org,
        "Jiang\, Dave" <dave.jiang@intel.com>,
        "Tian\, Kevin" <kevin.tian@intel.com>,
        "Pan\, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu\, Yi L" <yi.l.liu@intel.com>,
        "Kumar\, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Van De Ven\, Arjan" <arjan.van.de.ven@intel.com>,
        "Williams\, Dan J" <dan.j.williams@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: Programming PASID in IMS entries
In-Reply-To: <20210708143657.GA70042@otc-nc-03>
References: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com> <87k0m2qzgz.ffs@nanos.tec.linutronix.de> <20210707221216.GA56594@otc-nc-03> <20210707235822.GB4459@nvidia.com> <20210708003335.GC56594@otc-nc-03> <20210708120846.GD4459@nvidia.com> <20210708143657.GA70042@otc-nc-03>
Date:   Thu, 08 Jul 2021 20:45:48 +0200
Message-ID: <87v95kod9f.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok,

On Thu, Jul 08 2021 at 07:36, Ashok Raj wrote:
> On Thu, Jul 08, 2021 at 09:08:46AM -0300, Jason Gunthorpe wrote:
>> On Wed, Jul 07, 2021 at 05:33:35PM -0700, Raj, Ashok wrote:
>> > On Wed, Jul 07, 2021 at 08:58:22PM -0300, Jason Gunthorpe wrote:
>> > > > Using default PASID in struct device will work for sub-devices until the
>> > > > guest needs to enable ENQCMD support. Since the guest kernel can ask for an
>> > > > interrupt by specifying something in the descriptor submitted via ENQCMD.
>> > > > Using the PASID in struct device won't be sufficient.
>> > > 
>> > > Could you could store a pasid table in the struct device and index it
>> > > by vector?
>> > 
>> > Possibly... what ever Thomas things is clean. The device specific driver
>> > would have this already. So providing some call to get this filled in vs
>> > storing that in struct device. Someone close at heart to the driver model
>> > is best to comment :-)
>> > 
>> > IMS core owns the format of the entries right now vs device specific driver. 
>> > I suppose your use case requiring a vm_id might have a different format. 
>> > So this is yet another one the core needs to learn and adapt?
>> 
>> All entry format stuff is device specific, it shouldn't be in "core"
>> code.
>
> Well, this is how it started way back last year. 
>
> https://lore.kernel.org/lkml/158751209583.36773.15917761221672315662.stgit@djiang5-desk3.ch.intel.com/

Which is wrong on so many levels as we all know.

> Where the driver functions for mask/unmask/write_msg etc. So the core
> needs

Needs what?

> So the format or layout is device specific, but core can dictate the exact
> message that needs to be written.

Sorry, I don't grok what you want to say here.

>> It is is the same reason that the IRQ chip driver for IDXD should have
>> IDXD in the name, it is not a generic "IMS core" thing.
>> 
>> The question mark is probably the locking model, but if IDXD
>> guarentees the pasid table doesn't change while the irq is active then
>> maybe it works out well enough.
>
> I think this must be gauranteed at a min? changing things underneath when
> the interrupts are unmasked would be bad usage.

That's one way to look at it. OTOH, _if_ the association of some
arbitrary information to interrupts becomes a common scheme, then we are
surely better off to have some enforcement at the irq core level.

Thanks,

        tglx
