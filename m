Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F304643DDB7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 11:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhJ1J3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 05:29:23 -0400
Received: from foss.arm.com ([217.140.110.172]:52670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1J3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 05:29:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 357BA1FB;
        Thu, 28 Oct 2021 02:26:55 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34C5A3F5A1;
        Thu, 28 Oct 2021 02:26:54 -0700 (PDT)
Date:   Thu, 28 Oct 2021 10:26:51 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v7 2/2] firmware: arm_scmi: Add optee transport
Message-ID: <20211028092651.GE6526@e120937-lin>
References: <20211028075344.1688-1-etienne.carriere@linaro.org>
 <20211028075344.1688-2-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028075344.1688-2-etienne.carriere@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 09:53:44AM +0200, Etienne Carriere wrote:
> Add a new transport channel to the SCMI firmware interface driver for
> SCMI message exchange based on optee transport channel. The optee
> transport is realized by connecting and invoking OP-TEE SCMI service
> interface PTA.
> 

Hi Etienne,

I was going to just add Reviewed-by...but...

> Optee transport support (CONFIG_ARM_SCMI_TRANSPORT_OPTEE) is default
> enabled when optee driver (CONFIG_OPTEE) is enabled. Effective optee
> transport is setup upon OP-TEE SCMI service discovery at optee
> device initialization. For this SCMI UUID is registered to the optee
> bus for probing. This is done from the link_supplier operator of the
> SCMI optee transport.
> 
> The optee transport can use a statically defined shared memory in
> which case SCMI device tree node defines it using an "arm,scmi-shmem"
> compatible phandle through property shmem. Alternatively, optee transport
> allocates the shared memory buffer from the optee driver when no shmem
> property is defined.
> 
> The protocol used to exchange SCMI message over that shared memory is
> negotiated between optee transport driver and the OP-TEE service through
> capabilities exchange.
> 
> OP-TEE SCMI service is integrated in OP-TEE since its release tag 3.13.0.
> The service interface is published in [1].
> 
> Link: [1] https://github.com/OP-TEE/optee_os/blob/3.13.0/lib/libutee/include/pta_scmi_client.h
> Cc: Cristian Marussi <cristian.marussi@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>

I build tested again...and booted without using it really, just to try load/unload
of the core SCMI module (so building with ARM_SCMI_PROTOCOL=m) and unfortunately
I spotted this warning:

root@deb-buster-arm64:~# insmod ./scmi-module.ko
root@deb-buster-arm64:~# rmmod ./scmi-module.ko

[   99.860225] ------------[ cut here ]------------
[   99.865006] Unexpected driver unregister!
[   99.869116] WARNING: CPU: 0 PID: 339 at drivers/base/driver.c:194 driver_unregister+0x50/0x60
[   99.877684] Modules linked in: scmi_module(-) [last unloaded: scmi_hwmon]
[   99.884501] CPU: 0 PID: 339 Comm: rmmod Not tainted 5.15.0-rc1-00003-g46a1949d5e4f #8
[   99.892352] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jun 30 2020
[   99.903156] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   99.910136] pc : driver_unregister+0x50/0x60
[   99.914419] lr : driver_unregister+0x50/0x60
[   99.918701] sp : ffff80001259bd50
[   99.922018] x29: ffff80001259bd50 x28: ffff0008010a5280 x27: 0000000000000000
[   99.929182] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[   99.936344] x23: 0000000000000000 x22: ffff8000121446d8 x21: ffff800011e19948
[   99.943506] x20: ffff800011ea7548 x19: ffff80000900b340 x18: 0000000000000010
[   99.950669] x17: 31333d4d554e5145 x16: 53007375623d4d45 x15: 000000000000017c
[   99.957831] x14: ffff80001259ba60 x13: 00000000ffffffea x12: ffff800011ea2e70
[   99.964994] x11: 0000000000000003 x10: ffff800011e8ae30 x9 : ffff800011e8ae88
[   99.972156] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : ffff00097ef4e988
[   99.979318] x5 : ffff00097ef4e988 x4 : 0000000000000000 x3 : ffff00097ef51910
[   99.986480] x2 : ffff00097ef51910 x1 : c33162034fce8d00 x0 : 0000000000000000
[   99.993643] Call trace:
[   99.996092]  driver_unregister+0x50/0x60
[  100.000028]  scmi_optee_exit+0x1c/0x28 [scmi_module]
[  100.005040]  scmi_driver_exit+0x58/0x7c [scmi_module]
[  100.010131]  __arm64_sys_delete_module+0x19c/0x228
[  100.014938]  invoke_syscall+0x44/0x108
[  100.018700]  el0_svc_common.constprop.3+0x94/0xf8
[  100.023418]  do_el0_svc+0x24/0x88
[  100.026743]  el0_svc+0x20/0x50
[  100.029807]  el0t_64_sync_handler+0x90/0xb8
[  100.034001]  el0t_64_sync+0x180/0x184
[  100.037674] ---[ end trace 4c09a5e866689fa7 ]---

I suppose it could be that on my system I have not defined an OPTEE DT node, so
the transport is NEVER initialized (and driver_register) since you are doing it
in .link_supplier not in .transport_init, BUT then it is indeed always .exited
by the usual .transport_exit.

I would recommend adding a check on your exit to avoid this (probably using
scmi_optee_private to avoid unregistering if never registered ?).

Sorry, I think I thought about telling you about this check on .exit in previous
version but I did not eventaully.

Additionally, I have a slight concern if default-enabling it or not; as an
example virtio is default-N just because it felt like a more esoteric
transport not generally needed...but this will probably change indeed with all the
work you guys are doing on virtualizing the stack, so no strong opinion here ...

...and I'll happily let Sudeep decide on this :D.

Thanks,
Cristian
