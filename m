Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785D23D57D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhGZKOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:14:35 -0400
Received: from foss.arm.com ([217.140.110.172]:50110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231792AbhGZKOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:14:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B49911B3;
        Mon, 26 Jul 2021 03:55:02 -0700 (PDT)
Received: from bogus (unknown [10.57.64.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 161663F70D;
        Mon, 26 Jul 2021 03:54:59 -0700 (PDT)
Date:   Mon, 26 Jul 2021 11:54:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jerome Forissier <jerome@forissier.org>,
        sughosh.ganu@linaro.org
Subject: Re: [PATCH v3 0/5] Add FF-A support in OP-TEE driver
Message-ID: <20210726105400.2li4fj223u3vajly@bogus>
References: <20210722121757.1944658-1-jens.wiklander@linaro.org>
 <CAFA6WYMgWizZoJmk7U0g8zP7Jf_SHLXi3ydMCg2iH5HEQmF=zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMgWizZoJmk7U0g8zP7Jf_SHLXi3ydMCg2iH5HEQmF=zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 03:59:36PM +0530, Sumit Garg wrote:
> Hi Jens,
> 
> On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Hi all,
> >
> > This adds supports for the OP-TEE driver to communicate with secure world
> > using FF-A [1] as transport.
> >
> > There is one change to the TEE subsystem with "tee: add sec_world_id to
> > struct tee_shm" to add support for holding globally unique handle assigned
> > by the FF-A. This is a field that I believe could useful for the AMDTEE
> > driver too.
> >
> > For communication the OP-TEE message protocol is still used, but with a new
> > type of memory reference, struct optee_msg_param_fmem, to carry the
> > information needed by FF-A. The OP-TEE driver is refactored internally with
> > to sets of callbacks, one for the old SMC based communication and another
> > set with FF-A as transport. The functions relating to the SMC based ABI
> > are moved to smc_abi.c while the FF-A based ABI is added in a ffa_abi.c.
> >
> > There is also a difference in how the drivers are instantiated. With the
> > SMC based transport we have a platform driver, module_platform_driver(),
> > today which we're keeping as is for this configuration. In a FF-A system we
> > have a FF-A driver, module_ffa_driver(), instead.
> >
> > The OP-TEE driver can be compiled for both targets at the same time and
> > it's up to runtime configuration (device tree or ACPI) to decide how it's
> > initialized. Note that it's only the old SMC based driver instance that
> > need device tree or ACPI to initialize. The FF-A based driver relies on the
> > FF-A bus instead.
> >
> > This can be tested QEMU
> > The repo for SPMC at S-EL1 retrieved by
> > repo init -u https://github.com/jenswi-linaro/manifest.git -m
> > qemu_v8.xml -b ffav4_spmc
> > repo sync
> > # Then checkout the branch optee_ffa_v3 from
> > # git://git.linaro.org/people/jens.wiklander/linux-tee.git
> > # in the linux directory
> >
> > To build do:
> > cd build
> > make toolchains
> > make all
> >
> > To boot:
> > make run-only
> >
> > Test with xtest, perhaps only with the command "xtest 1004" in case you're
> > not interested in too many tests.
> 
> Thanks Jens for sharing instructions to test this feature. So I tried
> to reproduce using following repo versions:
>
> linux-tee, branch: optee_ffa_v3
> trusted-firmware-a, branch: ffav4_sel1_spmc
> build, branch: ffav4_spmc
>
> and rest of the repos synced to the latest version as per upstream
> qemu_v8.xml [1] but I don't see OP-TEE driver being probed during boot
> [2]. Am I missing something?
>
> [1] https://github.com/OP-TEE/manifest/blob/master/qemu_v8.xml
> [2]
> Welcome to Buildroot, type root or test to login
> buildroot login: root
> # dmesg | grep optee
>

Do you see ARM FF-A driver initialised successfully ?
You must see "ARM FF-A Version 1.0 found" or something similar based on
the actual version supported.

If so, can you check if the partitions are correctly populated by
the driver using the discover API.

$ grep "" /sys/bus/arm_ffa/devices/*/uuid

If uuid reads zeros, then the devices are populated, just the matching
driver is not found(due to the workaround for v1.0 spec)

--
Regards,
Sudeep
