Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2433653C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhDTINM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:13:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33201 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhDTINL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:13:11 -0400
Received: from mail-lj1-f200.google.com ([209.85.208.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lYlUs-0001f4-V3
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 08:12:39 +0000
Received: by mail-lj1-f200.google.com with SMTP id i10-20020a2e808a0000b02900bdf90c5ca7so7109591ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IV9Eebskso7YyD0zMzspoNTbhY3LJpAmQOuTJ1c9y40=;
        b=FdEshr8ACeNLbsj3jowUlOYxEc92Lw9rDksLo3pMroBoXQZRELVADnmvnbxYoFzzmZ
         JutucusxC3SWZHfXSiimjHLI62gG0S65Mysd63DVnmmM9vwSb87ZFVZjB9BUu3QUtKsO
         9zAFxEp9b9mxIUg5ZWQKcFz+wuykXfUtfKxwUl7YcH739T34re5HsR2Qeq6TQZJZOgdb
         xDkbWLU2Gi/nmiy4IL56wMi67vQcnNOxZQt3TTkIhkk+7Ajs3loEgIS28UaOMvs8AFUR
         cD/e7NfkJT13//kabRKL7gJ9Hjfhjw2CHrEwTvv9NXIgk+MSQx2AqvF6mmQZUYst9A+b
         KETA==
X-Gm-Message-State: AOAM531ak70ERa84yJ27UIyqgw0duwn7x1sjnfyHSNbwCxQGe/BHlgY4
        rwdJ3e7PvCGEU9xWqLJVNDAtca/MYzPoXSbed3eAZtpg1XpW8VUa3liVvRoj1sbKBxMu62lU82D
        vrsvay8ex3Y9AOap8R5fIebEJ+yesMc7gE2v4M/5DKlfJlsAO402XIvfptg==
X-Received: by 2002:ac2:5f1b:: with SMTP id 27mr14782461lfq.425.1618906358348;
        Tue, 20 Apr 2021 01:12:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGj+Hlh1J4/cwN5jCaEklO5slca58XNB7qVuci1XVRA8XrEJfTHTIictY7IK+d0qKQHdTKXplsFsdyezE44Ec=
X-Received: by 2002:ac2:5f1b:: with SMTP id 27mr14782427lfq.425.1618906357768;
 Tue, 20 Apr 2021 01:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210415102224.2764054-1-sudeep.holla@arm.com> <20210420075332.t56dlpppb6bnpjzd@bogus>
In-Reply-To: <20210420075332.t56dlpppb6bnpjzd@bogus>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 20 Apr 2021 16:12:26 +0800
Message-ID: <CAAd53p6zti5rmJ5LjW3WbYsSGBs5CgBuOztHv-nvMObGBh7Q+A@mail.gmail.com>
Subject: Re: [PATCH] efifb: Fix runtime pm calls for non PCI efifb device
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Jones <pjones@redhat.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Tue, Apr 20, 2021 at 3:53 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Gentle Ping! There is boot failure because of this issue with linux-next
> on few arm platforms with non PCIe efifb. Please review and get the fix
> merged ASAP so the testing on these platforms can continue with linux-next.

It was merged in drm-tip as d510c88cfbb2 ("efifb: Check efifb_pci_dev
before using it").

Kai-Heng

>
> On Thu, Apr 15, 2021 at 11:22:24AM +0100, Sudeep Holla wrote:
> > Commit a6c0fd3d5a8b ("efifb: Ensure graphics device for efifb stays at PCI D0")
> > added runtime pm calls to probe and remove routines to ensure the PCI
> > device for efifb stays in D0 state. However not ever efifb is based on
> > PCI device and efifb_pci_dev can be NULL if that is the case.
> >
> > In such cases, we will get a boot splat like below due to NULL dereference:
> > -->8
> >  Console: switching to colour frame buffer device 240x67
> >  fb0: EFI VGA frame buffer device
> >  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000270
> >  Mem abort info:
> >    ESR = 0x96000004
> >    EC = 0x25: DABT (current EL), IL = 32 bits
> >    SET = 0, FnV = 0
> >    EA = 0, S1PTW = 0
> >  Data abort info:
> >    ISV = 0, ISS = 0x00000004
> >    CM = 0, WnR = 0
> >  [0000000000000270] user address but active_mm is swapper
> >  Internal error: Oops: 96000004 [#1] PREEMPT SMP
> >  Modules linked in:
> >  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc7-next-20210413 #1
> >  Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform
> >  pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> >  pc : pm_runtime_drop_link+0x12c/0x338
> >  lr : efifb_probe+0x7bc/0x7f0
> >  Call trace:
> >   pm_runtime_drop_link+0x12c/0x338
> >   efifb_probe+0x7bc/0x7f0
> >   platform_probe+0x68/0xd8
> >   really_probe+0xe4/0x3a8
> >   driver_probe_device+0x64/0xc8
> >   device_driver_attach+0x74/0x80
> >   __driver_attach+0x64/0xf0
> >   bus_for_each_dev+0x70/0xc0
> >   driver_attach+0x24/0x30
> >   bus_add_driver+0x150/0x1f8
> >   driver_register+0x64/0x120
> >   __platform_driver_register+0x28/0x38
> >   efifb_driver_init+0x1c/0x28
> >   do_one_initcall+0x48/0x2b0
> >   kernel_init_freeable+0x1e8/0x258
> >   kernel_init+0x14/0x118
> >   ret_from_fork+0x10/0x30
> >  Code: 88027c01 35ffffa2 17fff706 f9800051 (885f7c40)
> >  ---[ end trace 17d8da630bf8ff77 ]---
> >  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> > -->8
> >
> > Fix the issue by checking for non-NULL efifb_pci_dev before dereferencing
> > for runtime pm calls in probe and remove routines.
> >
> > Fixes: a6c0fd3d5a8b ("efifb: Ensure graphics device for efifb stays at PCI D0")
> > Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Peter Jones <pjones@redhat.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/video/fbdev/efifb.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> > index f58a545b3bf3..8ea8f079cde2 100644
> > --- a/drivers/video/fbdev/efifb.c
> > +++ b/drivers/video/fbdev/efifb.c
> > @@ -575,7 +575,8 @@ static int efifb_probe(struct platform_device *dev)
> >               goto err_fb_dealoc;
> >       }
> >       fb_info(info, "%s frame buffer device\n", info->fix.id);
> > -     pm_runtime_get_sync(&efifb_pci_dev->dev);
> > +     if (efifb_pci_dev)
> > +             pm_runtime_get_sync(&efifb_pci_dev->dev);
> >       return 0;
> >
> >  err_fb_dealoc:
> > @@ -602,7 +603,8 @@ static int efifb_remove(struct platform_device *pdev)
> >       unregister_framebuffer(info);
> >       sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
> >       framebuffer_release(info);
> > -     pm_runtime_put(&efifb_pci_dev->dev);
> > +     if (efifb_pci_dev)
> > +             pm_runtime_put(&efifb_pci_dev->dev);
> >
> >       return 0;
> >  }
> > --
> > 2.25.1
> >
>
> --
> Regards,
> Sudeep
