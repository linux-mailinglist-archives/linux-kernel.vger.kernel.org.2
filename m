Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA5A3BFAD5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhGHND1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 09:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhGHND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 09:03:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22220C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 06:00:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625749243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XSB3tWPHPLoXXP571FN3OwytnCWtwq7P5shrf9i3W5E=;
        b=179A/gqmtepq18Nl3EuX65uw8Z0BfoTXl/2cGXjGFNjaGGfJXttCd1CVDT4RrA5olnuPkP
        MBk6Jxzxaw+JplZM2YfjdToLEDG+X3wIV1wyQbf/0Sljhe94fdsENUwfbNo+Ia+HNXCthP
        L7pFcjei9lsTRckNjNZvMYhJ+JmxE4Ha3Se+jhucWEvBk2PoCashE8E3PtArCdZQxVBJ4G
        BT+qTjFhEY05dhaTbASZVI4+Xe9VGLWnMCZFVq8L2S3MLKPUdlp2xgMIt70IW/JO2vc72n
        Og7wasWxqFpYXHl8vkignxhu0Y+7EdyvjMGMkQnexXzBGebs4Soxbtg4XPSO1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625749243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XSB3tWPHPLoXXP571FN3OwytnCWtwq7P5shrf9i3W5E=;
        b=lTyEFjM5aLx2WzuyOHaIEDTryCh6K4fUnIq5pjKDppc9QRKNmuLFR+OfVngRfQLpvstlRX
        DL7UDNikKy76g9CA==
To:     "Raj\, Ashok" <ashok.raj@intel.com>
Cc:     "Dey\, Megha" <megha.dey@intel.com>, linux-kernel@vger.kernel.org,
        "Jiang\, Dave" <dave.jiang@intel.com>,
        "Tian\, Kevin" <kevin.tian@intel.com>,
        "Pan\, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu\, Yi L" <yi.l.liu@intel.com>, jgg@mellanox.com,
        "Kumar\, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Van De Ven\, Arjan" <arjan.van.de.ven@intel.com>,
        "Williams\, Dan J" <dan.j.williams@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: Programming PASID in IMS entries
In-Reply-To: <20210707221216.GA56594@otc-nc-03>
References: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com> <87k0m2qzgz.ffs@nanos.tec.linutronix.de> <20210707221216.GA56594@otc-nc-03>
Date:   Thu, 08 Jul 2021 15:00:42 +0200
Message-ID: <87im1lot8l.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok,

On Wed, Jul 07 2021 at 15:12, Ashok Raj wrote:
> On Wed, Jul 07, 2021 at 10:50:52AM +0200, Thomas Gleixner wrote:
>> On Wed, Jul 07 2021 at 09:49, Megha Dey wrote:
>> > Per your suggestions during the last meeting, we wanted to confirm the 
>> > sequence to program the PASID into the IMS entries:
>> >
>> > 1. Add a PASID member to struct msi_desc (Add as part of a union. Other 
>> > source-id's such as Jason's vm-id can be added to it)
>> 
>> Yes. Though we also discussed storing the default PASID in struct device
>> to begin with which is then copied to the msi_desc entries during
>> allocation.
>
> Using default PASID in struct device will work for sub-devices until the
> guest needs to enable ENQCMD support. Since the guest kernel can ask for an
> interrupt by specifying something in the descriptor submitted via ENQCMD.
> Using the PASID in struct device won't be sufficient.

I'm well aware of that, but can we solve step 1 before step 2 please?

>> > In order to make IMS dynamic, we were thinking of the following 
>> > enhancements to the IMS core:
>> >
>> > 1. Device Driver specifies maximum number of interrupts the sub device 
>> > is allowed to request, while creating the dev-msi domain. E.g. in the 
>> > case of DSA, Driver can specify that each mdev created can have upto X
>> 
>> Why would this be mdev specific? IIRC the sub devices can be used on
>> bare metal as well.
>
> I guess so. I thought for bare metal we don't need to play these games
> since native abstraction is provided with things like uaccel for e.g. For
> things like SRIOV its much different.
>
> What the above limit accomplishes is telling the guest, you can request
> upto the limit, but you aren't guaranteed to get them. This avoids the
> static partitioning and becomes best effort by the host driver.

That's fine.

> Ideally we want to tell the guest it can have upto say 1k interrupts, but
> unlike MSIx where resources are commited in HW, we want to allow guest
> allocations to fail. 

Which as discussed requires a hypercall because silent fail is not an
option.

Thanks,

        tglx
