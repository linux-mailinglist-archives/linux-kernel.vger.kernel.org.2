Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2126731856C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 07:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBKGy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 01:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhBKGyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 01:54:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBD7760C40;
        Thu, 11 Feb 2021 06:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613026450;
        bh=IxBpgpXoqSmCQVQHUpTpaGs9ireN9YORDUebT0MkHtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=upXIfAhFwyr2OF/6pxiTGFTpN6o2uJoiSjZyT13xVRYAfQK/QCdV030NOO6f0Gbdp
         9qq64UCVqQF7tErcKZEUnmOqbJVjUxr/w52bPx1xuK2k3Nlud+g7vBf9jkyWnHt+i0
         ZLHt+RgRWA/FQ2u1+iD/EkStIpsiIFUQ36Fs81Es=
Date:   Thu, 11 Feb 2021 07:54:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] driver core: auxiliary bus: Fix calling stage for
 auxiliary bus init
Message-ID: <YCTUjimQhVi7VSrw@kroah.com>
References: <20210210201611.1611074-1-dave.jiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210201611.1611074-1-dave.jiang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 01:16:11PM -0700, Dave Jiang wrote:
> When the auxiliary device code is built into the kernel, it can be executed
> before the auxiliary bus is registered. This causes bus->p to be not
> allocated and triggers a NULL pointer dereference when the auxiliary bus
> device gets added with bus_add_device(). Call the auxiliary_bus_init()
> under driver_init() so the bus is initialized before devices.
> 
> Below is the kernel splat for the bug:
> [ 1.948215] BUG: kernel NULL pointer dereference, address: 0000000000000060
> [ 1.950670] #PF: supervisor read access in kernel mode
> [ 1.950670] #PF: error_code(0x0000) - not-present page
> [ 1.950670] PGD 0
> [ 1.950670] Oops: 0000 1 SMP NOPTI
> [ 1.950670] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-intel-nextsvmtest+ #2205
> [ 1.950670] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [ 1.950670] RIP: 0010:bus_add_device+0x64/0x140
> [ 1.950670] Code: 00 49 8b 75 20 48 89 df e8 59 a1 ff ff 41 89 c4 85 c0 75 7b 48 8b 53 50 48 85 d2 75 03 48 8b 13 49 8b 85 a0 00 00 00 48 89 de <48> 8
> 78 60 48 83 c7 18 e8 ef d9 a9 ff 41 89 c4 85 c0 75 45 48 8b
> [ 1.950670] RSP: 0000:ff46032ac001baf8 EFLAGS: 00010246
> [ 1.950670] RAX: 0000000000000000 RBX: ff4597f7414aa680 RCX: 0000000000000000
> [ 1.950670] RDX: ff4597f74142bbc0 RSI: ff4597f7414aa680 RDI: ff4597f7414aa680
> [ 1.950670] RBP: ff46032ac001bb10 R08: 0000000000000044 R09: 0000000000000228
> [ 1.950670] R10: ff4597f741141b30 R11: ff4597f740182a90 R12: 0000000000000000
> [ 1.950670] R13: ffffffffa5e936c0 R14: 0000000000000000 R15: 0000000000000000
> [ 1.950670] FS: 0000000000000000(0000) GS:ff4597f7bba00000(0000) knlGS:0000000000000000
> [ 1.950670] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1.950670] CR2: 0000000000000060 CR3: 000000002140c001 CR4: 0000000000f71ef0
> [ 1.950670] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1.950670] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [ 1.950670] PKRU: 55555554
> [ 1.950670] Call Trace:
> [ 1.950670] device_add+0x3ee/0x850
> [ 1.950670] __auxiliary_device_add+0x47/0x60
> [ 1.950670] idxd_pci_probe+0xf77/0x1180
> [ 1.950670] local_pci_probe+0x4a/0x90
> [ 1.950670] pci_device_probe+0xff/0x1b0
> [ 1.950670] really_probe+0x1cf/0x440
> [ 1.950670] ? rdinit_setup+0x31/0x31
> [ 1.950670] driver_probe_device+0xe8/0x150
> [ 1.950670] device_driver_attach+0x58/0x60
> [ 1.950670] __driver_attach+0x8f/0x150
> [ 1.950670] ? device_driver_attach+0x60/0x60
> [ 1.950670] ? device_driver_attach+0x60/0x60
> [ 1.950670] bus_for_each_dev+0x79/0xc0
> [ 1.950670] ? kmem_cache_alloc_trace+0x323/0x430
> [ 1.950670] driver_attach+0x1e/0x20
> [ 1.950670] bus_add_driver+0x154/0x1f0
> [ 1.950670] driver_register+0x70/0xc0
> [ 1.950670] __pci_register_driver+0x54/0x60
> [ 1.950670] idxd_init_module+0xe2/0xfc
> [ 1.950670] ? idma64_platform_driver_init+0x19/0x19
> [ 1.950670] do_one_initcall+0x4a/0x1e0
> [ 1.950670] kernel_init_freeable+0x1fc/0x25c
> [ 1.950670] ? rest_init+0xba/0xba
> [ 1.950670] kernel_init+0xe/0x116
> [ 1.950670] ret_from_fork+0x1f/0x30
> [ 1.950670] Modules linked in:
> [ 1.950670] CR2: 0000000000000060
> [ 1.950670] --[ end trace cd7d1b226d3ca901 ]--
> 
> Fixes: 7de3697e9cbd ("Add auxiliary bus support")
> Reported-by: Jacob Pan <jacob.jun.pan@intel.com>
> Acked-by: Dave Ertman <david.m.ertman@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> v3:
> - Change init function to return void. (GregKH)
> v2:
> - Call in driver_init() to ensure aux bus gets init before devices.  (GregKH)
> 
>  drivers/base/base.h      |  5 +++++
>  drivers/base/auxiliary.c | 13 +++----------
>  drivers/base/init.c      |  1 +
>  3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index f5600a83124f..52b3d7b75c27 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -119,6 +119,11 @@ static inline int hypervisor_init(void) { return 0; }
>  extern int platform_bus_init(void);
>  extern void cpu_dev_init(void);
>  extern void container_dev_init(void);
> +#ifdef CONFIG_AUXILIARY_BUS
> +extern void auxiliary_bus_init(void);
> +#else
> +static inline void auxiliary_bus_init(void) { }
> +#endif
>  
>  struct kobject *virtual_device_parent(struct device *dev);
>  
> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> index 8336535f1e11..d8b314e7d0fd 100644
> --- a/drivers/base/auxiliary.c
> +++ b/drivers/base/auxiliary.c
> @@ -15,6 +15,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/string.h>
>  #include <linux/auxiliary_bus.h>
> +#include "base.h"
>  
>  static const struct auxiliary_device_id *auxiliary_match_id(const struct auxiliary_device_id *id,
>  							    const struct auxiliary_device *auxdev)
> @@ -260,19 +261,11 @@ void auxiliary_driver_unregister(struct auxiliary_driver *auxdrv)
>  }
>  EXPORT_SYMBOL_GPL(auxiliary_driver_unregister);
>  
> -static int __init auxiliary_bus_init(void)
> +void __init auxiliary_bus_init(void)
>  {
> -	return bus_register(&auxiliary_bus_type);
> +	WARN_ON(bus_register(&auxiliary_bus_type));

If this fails you have worse problems, what is this WARN_ON() going to
help with except give you a crashdump right before something else in the
kernel dies?

Feels frivilous to me, but oh well, I'll take it for now...

thanks,

greg k-h
