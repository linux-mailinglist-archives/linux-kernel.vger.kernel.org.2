Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13923D58A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhGZLBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbhGZLBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:01:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF2EC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 04:41:51 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id n6so10888095ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 04:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZuVrCrmHjpjL5nwYjM6Baj5CFqr8jovuMILOLb4fFo=;
        b=mxRn6iHfS9WwQEtMGMY18K6+d3nuR4uQUEo6AF6U7L4xJedNtBqq5C7QRT8euHyyEV
         QuQKGSfpeTn25k4MRVGKUYn306/yWYt5qZCcLLek8/51SVgKgl0uvPZbJX+D2ZR5NPB9
         vCxfvbdGeWspBoJLxzUltaOZqHEk+D04329MDH3RY0KUFKS5pv6Ymj3N/ZRr+wiee8qV
         bM4gIIOJgRPp7Xc5MCBYn1LQdQSn0G67xsQR3m86TrzB9W+v+5tRAfLHfcae1FncNACA
         bCRBkdq1gW8xNW6eU0mi/jIepqI6mu+nGtha5oAcqzjd2xFGSSxVlfaCyEWRrwIwh5X3
         z2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZuVrCrmHjpjL5nwYjM6Baj5CFqr8jovuMILOLb4fFo=;
        b=Veaqrfka9JZr80+GdC6Q4kmTTFL6bz7gS6uz3kTMrUoieZo+XvCKF4yl3rUNJ1ZXcK
         DYa0jKJgSCXioREvlIO84g/ISki62EwevamDPEgDFu1ShVVgntZVW40lWK8MvHYLaSCL
         NBun87YD/q2IIE/X6//5wp5RvtX8jpb4+NG/pnOF66YQ4XmW72NCCn+PqB9jHa4YE2KW
         46e+lCJe/RrnATnHyB90cmTpKROgdERbmix4C43sgiSzK25XABumUUwrd2aPe/bzswBY
         vcVp2bx3C9t6v58V7494iwGZyqpy+9LSMJPXdyJlBgUAuvxdp4zxhGuItNMPaC10CSdr
         cEag==
X-Gm-Message-State: AOAM533knV+PlgZnpdt3Qir4j7jrgBPNrcdyU8HBfw9x5MIWc01fS96n
        pJEQc5FNGX1Vpg0KVWPIQWfpZvVPBTuR0BdtkSmq/g==
X-Google-Smtp-Source: ABdhPJw4ywcPKCOc/jjboSoEbR2hBjD5vacvYbQ2vwhdkWX/oxkuvjCBgpqOiNR9LG/s2YDBiBMddr+lu0bA8se0dzM=
X-Received: by 2002:a2e:5348:: with SMTP id t8mr11560444ljd.343.1627299709949;
 Mon, 26 Jul 2021 04:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210722121757.1944658-1-jens.wiklander@linaro.org>
 <CAFA6WYMgWizZoJmk7U0g8zP7Jf_SHLXi3ydMCg2iH5HEQmF=zw@mail.gmail.com> <20210726105400.2li4fj223u3vajly@bogus>
In-Reply-To: <20210726105400.2li4fj223u3vajly@bogus>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 26 Jul 2021 17:11:38 +0530
Message-ID: <CAFA6WYPJChHggVyeQKe9vi8fHpN-Ddq6Bf7DHe2ZpG9BUmvFMw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add FF-A support in OP-TEE driver
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 at 16:25, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Jul 26, 2021 at 03:59:36PM +0530, Sumit Garg wrote:
> > Hi Jens,
> >
> > On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi all,
> > >
> > > This adds supports for the OP-TEE driver to communicate with secure world
> > > using FF-A [1] as transport.
> > >
> > > There is one change to the TEE subsystem with "tee: add sec_world_id to
> > > struct tee_shm" to add support for holding globally unique handle assigned
> > > by the FF-A. This is a field that I believe could useful for the AMDTEE
> > > driver too.
> > >
> > > For communication the OP-TEE message protocol is still used, but with a new
> > > type of memory reference, struct optee_msg_param_fmem, to carry the
> > > information needed by FF-A. The OP-TEE driver is refactored internally with
> > > to sets of callbacks, one for the old SMC based communication and another
> > > set with FF-A as transport. The functions relating to the SMC based ABI
> > > are moved to smc_abi.c while the FF-A based ABI is added in a ffa_abi.c.
> > >
> > > There is also a difference in how the drivers are instantiated. With the
> > > SMC based transport we have a platform driver, module_platform_driver(),
> > > today which we're keeping as is for this configuration. In a FF-A system we
> > > have a FF-A driver, module_ffa_driver(), instead.
> > >
> > > The OP-TEE driver can be compiled for both targets at the same time and
> > > it's up to runtime configuration (device tree or ACPI) to decide how it's
> > > initialized. Note that it's only the old SMC based driver instance that
> > > need device tree or ACPI to initialize. The FF-A based driver relies on the
> > > FF-A bus instead.
> > >
> > > This can be tested QEMU
> > > The repo for SPMC at S-EL1 retrieved by
> > > repo init -u https://github.com/jenswi-linaro/manifest.git -m
> > > qemu_v8.xml -b ffav4_spmc
> > > repo sync
> > > # Then checkout the branch optee_ffa_v3 from
> > > # git://git.linaro.org/people/jens.wiklander/linux-tee.git
> > > # in the linux directory
> > >
> > > To build do:
> > > cd build
> > > make toolchains
> > > make all
> > >
> > > To boot:
> > > make run-only
> > >
> > > Test with xtest, perhaps only with the command "xtest 1004" in case you're
> > > not interested in too many tests.
> >
> > Thanks Jens for sharing instructions to test this feature. So I tried
> > to reproduce using following repo versions:
> >
> > linux-tee, branch: optee_ffa_v3
> > trusted-firmware-a, branch: ffav4_sel1_spmc
> > build, branch: ffav4_spmc
> >
> > and rest of the repos synced to the latest version as per upstream
> > qemu_v8.xml [1] but I don't see OP-TEE driver being probed during boot
> > [2]. Am I missing something?
> >
> > [1] https://github.com/OP-TEE/manifest/blob/master/qemu_v8.xml
> > [2]
> > Welcome to Buildroot, type root or test to login
> > buildroot login: root
> > # dmesg | grep optee
> >
>
> Do you see ARM FF-A driver initialised successfully ?
> You must see "ARM FF-A Version 1.0 found" or something similar based on
> the actual version supported.
>
> If so, can you check if the partitions are correctly populated by
> the driver using the discover API.
>
> $ grep "" /sys/bus/arm_ffa/devices/*/uuid
>
> If uuid reads zeros, then the devices are populated, just the matching
> driver is not found(due to the workaround for v1.0 spec)
>

It turns out to be an issue with my build environment, I re-built from
scratch and I could see OP-TEE being probed successfully:

# dmesg | grep FF-A
[    0.356382] ARM FF-A: Version 1.0 found
#
# cat /sys/bus/arm_ffa/devices/arm-ffa-8001/uuid
486178e0-e7f8-11e3-bc5e-0002a5d5c51b
#
# dmesg | grep optee
[    4.991472] optee: revision 3.14 (49dbb9ef)
[    5.010110] optee: initialized driver
#

Jens,

From xtest logs it looks like the pseudo TA interface isn't working for me:

* regression_1001 Core self tests
 - 1001 -   skip test, pseudo TA not found
  regression_1001 OK

* regression_1002 PTA parameters
 - 1002 -   skip test, pseudo TA not found
  regression_1002 OK

* regression_1003 Core internal read/write mutex
 - 1003 -   skip test, pseudo TA not found
  regression_1003 OK

Similarly, pseudo TAs acting as TEE bus devices doesn't work as well
as I see following devices directory being empty:

# ls /sys/bus/tee/devices/
#

As otherwise with OP-TEE SMC ABI, we should have at least the default
pseudo TA [1] kernel device there.

So is pseudo TA functional with this new FF-A interface?

[1] https://github.com/OP-TEE/optee_os/blob/master/core/pta/tests/invoke.c#L445

-Sumit

> --
> Regards,
> Sudeep
