Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11082365393
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 09:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhDTHyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 03:54:20 -0400
Received: from foss.arm.com ([217.140.110.172]:58014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229552AbhDTHyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:54:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BA771435;
        Tue, 20 Apr 2021 00:53:39 -0700 (PDT)
Received: from bogus (unknown [10.57.52.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F2973F85F;
        Tue, 20 Apr 2021 00:53:38 -0700 (PDT)
Date:   Tue, 20 Apr 2021 08:53:32 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Jones <pjones@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efifb: Fix runtime pm calls for non PCI efifb device
Message-ID: <20210420075332.t56dlpppb6bnpjzd@bogus>
References: <20210415102224.2764054-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415102224.2764054-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Ping! There is boot failure because of this issue with linux-next
on few arm platforms with non PCIe efifb. Please review and get the fix
merged ASAP so the testing on these platforms can continue with linux-next.

On Thu, Apr 15, 2021 at 11:22:24AM +0100, Sudeep Holla wrote:
> Commit a6c0fd3d5a8b ("efifb: Ensure graphics device for efifb stays at PCI D0")
> added runtime pm calls to probe and remove routines to ensure the PCI
> device for efifb stays in D0 state. However not ever efifb is based on
> PCI device and efifb_pci_dev can be NULL if that is the case.
>
> In such cases, we will get a boot splat like below due to NULL dereference:
> -->8
>  Console: switching to colour frame buffer device 240x67
>  fb0: EFI VGA frame buffer device
>  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000270
>  Mem abort info:
>    ESR = 0x96000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>  Data abort info:
>    ISV = 0, ISS = 0x00000004
>    CM = 0, WnR = 0
>  [0000000000000270] user address but active_mm is swapper
>  Internal error: Oops: 96000004 [#1] PREEMPT SMP
>  Modules linked in:
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc7-next-20210413 #1
>  Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
>  pc : pm_runtime_drop_link+0x12c/0x338
>  lr : efifb_probe+0x7bc/0x7f0
>  Call trace:
>   pm_runtime_drop_link+0x12c/0x338
>   efifb_probe+0x7bc/0x7f0
>   platform_probe+0x68/0xd8
>   really_probe+0xe4/0x3a8
>   driver_probe_device+0x64/0xc8
>   device_driver_attach+0x74/0x80
>   __driver_attach+0x64/0xf0
>   bus_for_each_dev+0x70/0xc0
>   driver_attach+0x24/0x30
>   bus_add_driver+0x150/0x1f8
>   driver_register+0x64/0x120
>   __platform_driver_register+0x28/0x38
>   efifb_driver_init+0x1c/0x28
>   do_one_initcall+0x48/0x2b0
>   kernel_init_freeable+0x1e8/0x258
>   kernel_init+0x14/0x118
>   ret_from_fork+0x10/0x30
>  Code: 88027c01 35ffffa2 17fff706 f9800051 (885f7c40)
>  ---[ end trace 17d8da630bf8ff77 ]---
>  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> -->8
>
> Fix the issue by checking for non-NULL efifb_pci_dev before dereferencing
> for runtime pm calls in probe and remove routines.
>
> Fixes: a6c0fd3d5a8b ("efifb: Ensure graphics device for efifb stays at PCI D0")
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Peter Jones <pjones@redhat.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/video/fbdev/efifb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index f58a545b3bf3..8ea8f079cde2 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -575,7 +575,8 @@ static int efifb_probe(struct platform_device *dev)
>  		goto err_fb_dealoc;
>  	}
>  	fb_info(info, "%s frame buffer device\n", info->fix.id);
> -	pm_runtime_get_sync(&efifb_pci_dev->dev);
> +	if (efifb_pci_dev)
> +		pm_runtime_get_sync(&efifb_pci_dev->dev);
>  	return 0;
>
>  err_fb_dealoc:
> @@ -602,7 +603,8 @@ static int efifb_remove(struct platform_device *pdev)
>  	unregister_framebuffer(info);
>  	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
>  	framebuffer_release(info);
> -	pm_runtime_put(&efifb_pci_dev->dev);
> +	if (efifb_pci_dev)
> +		pm_runtime_put(&efifb_pci_dev->dev);
>
>  	return 0;
>  }
> --
> 2.25.1
>

--
Regards,
Sudeep
