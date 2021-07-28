Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0E43D8BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhG1KWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1KWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:22:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A63C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 03:22:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u3so2924329lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+CYqNWSBCWww4TQUy0lzL2nycuKrk7QBc1xySlfmW4=;
        b=AhOcFrg/zDt/sIAilSJRA0NU8HUD8sf7woz/gYtV9P0byplhgRnbrjwQTVQvhXAuZu
         u0DINsDBiBz/L9Lxp7ocxJhixaS2HpEJI0d6iFaDfgjjhMz4OIPXRbE7I3WwmVNS0+kG
         E8iwuHJ7hQwiJyIOBpHnxh952RvAhgycbJ1WohtlJnMXaThPc76gSgTZT6b5Duo+p+wE
         vdZCxkFgNiJMhZUxOUE8kRLUE3AfckYNEIWoFoCQtUwkzj7f7uyboTIUJWP0bSVUi4L2
         MpiPcVsSdWYc9oMq598R4zU4uHQWdgcuTYPiFBJDMcL/w2+g8c3W3c/Jr5HCcd2ozkzM
         8yJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+CYqNWSBCWww4TQUy0lzL2nycuKrk7QBc1xySlfmW4=;
        b=gok0HYP+EDF+h7ZRCMt0u/zJD3AahnwyaNlr/oCOYZeRNobSSfEv+HS3CKXP5ogatm
         oSYLSDwR1xQ3tQRtCx471gCeHiYmVgGGmNbwDaEm+swfOMJ9rqMMcglvZ5tw5y85ILam
         my6x/F8HCJMPpo6hWYXjgvQOa11TH3fZmv9ggrTAZrSL5VgRups7UkGPCemkZ1GRiNB5
         bLiPECyJmJP8qoTFejw92hbwPD59RE458zB0sohnHj7OWZk93St4YwpYF0ZuSEiPmLA/
         +4ZQdhIuqSXTOV9plNnocYn/i4UPKGaYFUT5ECJAkQVwJIuE4Oa7X5wo1zGeudyOWVIs
         7VDg==
X-Gm-Message-State: AOAM531CrV6xG6ihg/K51vSCCV5m+PLqog46sSOjTvHNco0ynPQ4DkbZ
        eBMzUcEHHAwRUJmrpC/vjdhj0zIAoRB3lfbXpmV+pw==
X-Google-Smtp-Source: ABdhPJzXF+hG65HYVKX+BaSkwaNXZ+6dlJCDuVgjJM/Xhvp9t+/VHAJEWWJfyjTcIdCJspZUGAVs+nJhmuRahrpCUIU=
X-Received: by 2002:a19:6e0d:: with SMTP id j13mr19421582lfc.108.1627467755908;
 Wed, 28 Jul 2021 03:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210722121757.1944658-1-jens.wiklander@linaro.org>
 <CAFA6WYMgWizZoJmk7U0g8zP7Jf_SHLXi3ydMCg2iH5HEQmF=zw@mail.gmail.com>
 <20210726105400.2li4fj223u3vajly@bogus> <CAFA6WYPJChHggVyeQKe9vi8fHpN-Ddq6Bf7DHe2ZpG9BUmvFMw@mail.gmail.com>
 <CAHUa44Guj5bu_tYsyLDzMJ==mtL+SaKT_vEG8Nz2VGcPuOx25g@mail.gmail.com>
 <CAFA6WYPZHuEoaxo=05qfbNQ_gamPuMA4+=2giC88DK=RkMLgOg@mail.gmail.com> <CAHUa44EsbWX9QBQ5Y=E_pZa2qKnU5FibzjoGjgO98kq35psaLg@mail.gmail.com>
In-Reply-To: <CAHUa44EsbWX9QBQ5Y=E_pZa2qKnU5FibzjoGjgO98kq35psaLg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 28 Jul 2021 15:52:24 +0530
Message-ID: <CAFA6WYNz51RGkeDEhR0Cb1FR3XBN4P65XmuUjq4R9zg+zRunLg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add FF-A support in OP-TEE driver
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        Sughosh Ganu <sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 at 12:11, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Tue, Jul 27, 2021 at 8:13 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Mon, 26 Jul 2021 at 20:55, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Mon, Jul 26, 2021 at 1:41 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > On Mon, 26 Jul 2021 at 16:25, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > >
> > > > > On Mon, Jul 26, 2021 at 03:59:36PM +0530, Sumit Garg wrote:
> > > > > > Hi Jens,
> > > > > >
> > > > > > On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi all,
> > > > > > >
> > > > > > > This adds supports for the OP-TEE driver to communicate with secure world
> > > > > > > using FF-A [1] as transport.
> > > > > > >
> > > > > > > There is one change to the TEE subsystem with "tee: add sec_world_id to
> > > > > > > struct tee_shm" to add support for holding globally unique handle assigned
> > > > > > > by the FF-A. This is a field that I believe could useful for the AMDTEE
> > > > > > > driver too.
> > > > > > >
> > > > > > > For communication the OP-TEE message protocol is still used, but with a new
> > > > > > > type of memory reference, struct optee_msg_param_fmem, to carry the
> > > > > > > information needed by FF-A. The OP-TEE driver is refactored internally with
> > > > > > > to sets of callbacks, one for the old SMC based communication and another
> > > > > > > set with FF-A as transport. The functions relating to the SMC based ABI
> > > > > > > are moved to smc_abi.c while the FF-A based ABI is added in a ffa_abi.c.
> > > > > > >
> > > > > > > There is also a difference in how the drivers are instantiated. With the
> > > > > > > SMC based transport we have a platform driver, module_platform_driver(),
> > > > > > > today which we're keeping as is for this configuration. In a FF-A system we
> > > > > > > have a FF-A driver, module_ffa_driver(), instead.
> > > > > > >
> > > > > > > The OP-TEE driver can be compiled for both targets at the same time and
> > > > > > > it's up to runtime configuration (device tree or ACPI) to decide how it's
> > > > > > > initialized. Note that it's only the old SMC based driver instance that
> > > > > > > need device tree or ACPI to initialize. The FF-A based driver relies on the
> > > > > > > FF-A bus instead.
> > > > > > >
> > > > > > > This can be tested QEMU
> > > > > > > The repo for SPMC at S-EL1 retrieved by
> > > > > > > repo init -u https://github.com/jenswi-linaro/manifest.git -m
> > > > > > > qemu_v8.xml -b ffav4_spmc
> > > > > > > repo sync
> > > > > > > # Then checkout the branch optee_ffa_v3 from
> > > > > > > # git://git.linaro.org/people/jens.wiklander/linux-tee.git
> > > > > > > # in the linux directory
> > > > > > >
> > > > > > > To build do:
> > > > > > > cd build
> > > > > > > make toolchains
> > > > > > > make all
> > > > > > >
> > > > > > > To boot:
> > > > > > > make run-only
> > > > > > >
> > > > > > > Test with xtest, perhaps only with the command "xtest 1004" in case you're
> > > > > > > not interested in too many tests.
> > > > > >
> > > > > > Thanks Jens for sharing instructions to test this feature. So I tried
> > > > > > to reproduce using following repo versions:
> > > > > >
> > > > > > linux-tee, branch: optee_ffa_v3
> > > > > > trusted-firmware-a, branch: ffav4_sel1_spmc
> > > > > > build, branch: ffav4_spmc
> > > > > >
> > > > > > and rest of the repos synced to the latest version as per upstream
> > > > > > qemu_v8.xml [1] but I don't see OP-TEE driver being probed during boot
> > > > > > [2]. Am I missing something?
> > > > > >
> > > > > > [1] https://github.com/OP-TEE/manifest/blob/master/qemu_v8.xml
> > > > > > [2]
> > > > > > Welcome to Buildroot, type root or test to login
> > > > > > buildroot login: root
> > > > > > # dmesg | grep optee
> > > > > >
> > > > >
> > > > > Do you see ARM FF-A driver initialised successfully ?
> > > > > You must see "ARM FF-A Version 1.0 found" or something similar based on
> > > > > the actual version supported.
> > > > >
> > > > > If so, can you check if the partitions are correctly populated by
> > > > > the driver using the discover API.
> > > > >
> > > > > $ grep "" /sys/bus/arm_ffa/devices/*/uuid
> > > > >
> > > > > If uuid reads zeros, then the devices are populated, just the matching
> > > > > driver is not found(due to the workaround for v1.0 spec)
> > > > >
> > > >
> > > > It turns out to be an issue with my build environment, I re-built from
> > > > scratch and I could see OP-TEE being probed successfully:
> > > >
> > > > # dmesg | grep FF-A
> > > > [    0.356382] ARM FF-A: Version 1.0 found
> > > > #
> > > > # cat /sys/bus/arm_ffa/devices/arm-ffa-8001/uuid
> > > > 486178e0-e7f8-11e3-bc5e-0002a5d5c51b
> > > > #
> > > > # dmesg | grep optee
> > > > [    4.991472] optee: revision 3.14 (49dbb9ef)
> > > > [    5.010110] optee: initialized driver
> > > > #
> > >
> > > That's good.
> > >
> > > > From xtest logs it looks like the pseudo TA interface isn't working for me:
> > > >
> > > > * regression_1001 Core self tests
> > > >  - 1001 -   skip test, pseudo TA not found
> > > >   regression_1001 OK
> > > >
> > > > * regression_1002 PTA parameters
> > > >  - 1002 -   skip test, pseudo TA not found
> > > >   regression_1002 OK
> > > >
> > > > * regression_1003 Core internal read/write mutex
> > > >  - 1003 -   skip test, pseudo TA not found
> > > >   regression_1003 OK
> > >
> > > The test PTAs are disabled by default.
> > >
> >
> > Ah, I missed the CFG_ENABLE_EMBEDDED_TESTS option in OP-TEE. BTW, I
> > think it should be enabled for OP-TEE Qemu build as we mostly use it
> > as a test platform.
>
> That makes sense. Perhaps in the build git?
>

Yeah, build git sounds appropriate location.

-Sumit

> >
> > > >
> > > > Similarly, pseudo TAs acting as TEE bus devices doesn't work as well
> > > > as I see following devices directory being empty:
> > > >
> > > > # ls /sys/bus/tee/devices/
> > > > #
> > > >
> > > > As otherwise with OP-TEE SMC ABI, we should have at least the default
> > > > pseudo TA [1] kernel device there.
> > > >
> > > > So is pseudo TA functional with this new FF-A interface?
> > >
> > > Yes, everything is supposed to work.
> > >
> >
> > So yes, xtest and TEE kernel bus framework works for me as well with
> > this new FF-A interface. FWIW:
> >
> > Tested-by: Sumit Garg <sumit.garg@linaro.org>
>
> Thanks for confirming.
>
> Cheers,
> Jens
