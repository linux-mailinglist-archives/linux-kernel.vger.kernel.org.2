Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32AD37B59B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 07:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhELFvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 01:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhELFvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 01:51:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB600C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 22:50:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso721496wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 22:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oG3Nmi47CRt0jgVT9ir6v5QgpqsEdqR88ZknZKF60qc=;
        b=YOFdFOwgRXMdT4FF/POx7llHFIuaDckEdcMKv6WGVfi4XRwFghDZF9ks3HSj31F7tR
         hg6+QoC+Dtm7gBiLL1GUUsIV5wXxWcvlPYr+Ybg5b9MSL8ylXOnsU31xcpWbpqrPYK6U
         BiMJ6Pfi2JkKwwlE5qsJoywx460Xn7o3YTGP8MnEMW1xw2zxuW35qvcd2C4DzWgjmjkP
         opuwt7OCHrxf5+ieYhzNxduoJzRWSrp7sCsPRathg+A2IvLO2+BAjoW0hJMmBTgD58Om
         efVUX+vhE1CIa+kggVshVxR0J6morH7NgHmYAjKfG5OwLDdDIdDxlpY3Zd4AMnE4aoTW
         mahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oG3Nmi47CRt0jgVT9ir6v5QgpqsEdqR88ZknZKF60qc=;
        b=Fg/j8rx219liuYlWUzi643BZNScCA2h8Nimv1W2gh1Q7DToCM0b4WNf2gBbo1St9ES
         xiekwCapPXk9RwIB0T1KqERdLDiZWoh4tzgtCSk24PgVclFvCRIpa4JBOfXOrbNV78o6
         GcksUtEplF9ze2tMMOzV4DOqVBTsN4X50WFLibMqQk0fhex0CKj6Es8WDf6FQzUUm1QZ
         PT9P19Vltyi1Sp3LseZNDgoi0RKaugGTOYmXPVEA+5Ec54t25Z6xegxr6QUERY7O5jKm
         0zdA+TYqZMQC0nKBiaJZ3a1eaXOUw87usC2iSbnOoRq+4tJ+Ev9xwMZblkEkOlDfHusp
         LjFA==
X-Gm-Message-State: AOAM531x6vMtYaCauOuWIhGmSu0sOanp246FB+tMM6wZzE33QRVggvxE
        SP2hHaqZoO4SSeuWwa3w/Lbsi+kzmblr/nczOsGJIA==
X-Google-Smtp-Source: ABdhPJxYfI2fdqHnpExM+wsbM/WVOFdEk26Mb8pXcYEN9NEeKORMspU5pN8HjIQzH5a4BNLrevhLcDSNVsyuvpkmjR8=
X-Received: by 2002:a7b:c002:: with SMTP id c2mr415156wmb.118.1620798641259;
 Tue, 11 May 2021 22:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210225090610.242623-1-allen.lkml@gmail.com> <20210507035816.426585-1-tyhicks@linux.microsoft.com>
 <720CDF03-42F9-43C3-B3B3-999E4A5E2864@linux.microsoft.com>
 <CAHUa44FHo2_EUzFzHnakkm3o7H-Nn+k4hgqT2WNFezZO6D8mxA@mail.gmail.com>
 <20210507131722.GI4967@sequoia> <CAHUa44F7AzRQ0ZUBtJV2Y39tk1mPGAbetn7i8-DVAsSFLbFgEg@mail.gmail.com>
 <20210512002338.GJ4967@sequoia>
In-Reply-To: <20210512002338.GJ4967@sequoia>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 12 May 2021 07:50:30 +0200
Message-ID: <CAHUa44E-FqviciKZgqMm89J496E6Hb02rdFiZ3Pm-eWBFzO+Sg@mail.gmail.com>
Subject: Re: [PATCH] optee: Disable shm cache when booting the crash kernel
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Allen Pais <apais@linux.microsoft.com>, zajec5@gmail.com,
        Allen Pais <allen.lkml@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 2:23 AM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
>
> On 2021-05-10 09:31:51, Jens Wiklander wrote:
> > On Fri, May 7, 2021 at 3:17 PM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> > >
> > > On 2021-05-07 11:23:17, Jens Wiklander wrote:
> > > > On Fri, May 7, 2021 at 9:00 AM Allen Pais <apais@linux.microsoft.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > On 07-May-2021, at 9:28 AM, Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> > > > > >
> > > > > > The .shutdown hook is not called after a kernel crash when a kdump
> > > > > > kernel is pre-loaded. A kexec into the kdump kernel takes place as
> > > > > > quickly as possible without allowing drivers to clean up.
> > > > > >
> > > > > > That means that the OP-TEE shared memory cache, which was initialized by
> > > > > > the kernel that crashed, is still in place when the kdump kernel is
> > > > > > booted. As the kdump kernel is shutdown, the .shutdown hook is called,
> > > > > > which calls optee_disable_shm_cache(), and OP-TEE's
> > > > > > OPTEE_SMC_DISABLE_SHM_CACHE API returns virtual addresses that are not
> > > > > > mapped for the kdump kernel since the cache was set up by the previous
> > > > > > kernel. Trying to dereference the tee_shm pointer or otherwise translate
> > > > > > the address results in a fault that cannot be handled:
> > > > > >
> > > > > > Unable to handle kernel paging request at virtual address ffff4317b9c09744
> > > > > > Mem abort info:
> > > > > >   ESR = 0x96000004
> > > > > >   EC = 0x25: DABT (current EL), IL = 32 bits
> > > > > >   SET = 0, FnV = 0
> > > > > >   EA = 0, S1PTW = 0
> > > > > > Data abort info:
> > > > > >   ISV = 0, ISS = 0x00000004
> > > > > >   CM = 0, WnR = 0
> > > > > > swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000970b1e000
> > > > > > [ffff4317b9c09744] pgd=0000000000000000, p4d=0000000000000000
> > > > > > Internal error: Oops: 96000004 [#1] SMP
> > > > > > Modules linked in: bnxt_en pcie_iproc_platform pcie_iproc diagbe(O)
> > > > > > CPU: 4 PID: 1 Comm: systemd-shutdow Tainted: G           O      5.10.19.8 #1
> > > > > > Hardware name: Redacted (DT)
> > > > > > pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=--)
> > > > > > pc : tee_shm_free (/usr/src/kernel/drivers/tee/tee_shm.c:363)
> > > > > > lr : optee_disable_shm_cache (/usr/src/kernel/drivers/tee/optee/call.c:441)
> > > > > > sp : ffff80001005bb70
> > > > > > x29: ffff80001005bb70 x28: ffff608e74648e00
> > > > > > x27: ffff80001005bb98 x26: dead000000000100
> > > > > > x25: ffff80001005bbb8 x24: aaaaaaaaaaaaaaaa
> > > > > > x23: ffff608e74cf8818 x22: ffff608e738be600
> > > > > > x21: ffff80001005bbc8 x20: ffff608e738be638
> > > > > > x19: ffff4317b9c09700 x18: ffffffffffffffff
> > > > > > x17: 0000000000000041 x16: ffffba61b5171764
> > > > > > x15: 0000000000000004 x14: 0000000000000fff
> > > > > > x13: ffffba61b5c9dfc8 x12: 0000000000000003
> > > > > > x11: 0000000000000000 x10: 0000000000000000
> > > > > > x9 : ffffba61b5413824 x8 : 00000000ffff4317
> > > > > > x7 : 0000000000000000 x6 : 0000000000000000
> > > > > > x5 : 0000000000000000 x4 : 0000000000000000
> > > > > > x3 : 0000000000000000 x2 : ffff4317b9c09700
> > > > > > x1 : 00000000ffff4317 x0 : ffff4317b9c09700
> > > > > > Call trace:
> > > > > > tee_shm_free (/usr/src/kernel/drivers/tee/tee_shm.c:363)
> > > > > > optee_disable_shm_cache (/usr/src/kernel/drivers/tee/optee/call.c:441)
> > > > > > optee_shutdown (/usr/src/kernel/drivers/tee/optee/core.c:636)
> > > > > > platform_drv_shutdown (/usr/src/kernel/drivers/base/platform.c:800)
> > > > > > device_shutdown (/usr/src/kernel/include/linux/device.h:758 /usr/src/kernel/drivers/base/core.c:4078)
> > > > > > kernel_restart (/usr/src/kernel/kernel/reboot.c:221 /usr/src/kernel/kernel/reboot.c:248)
> > > > > > __arm64_sys_reboot (/usr/src/kernel/kernel/reboot.c:349 /usr/src/kernel/kernel/reboot.c:312 /usr/src/kernel/kernel/reboot.c:312)
> > > > > > do_el0_svc (/usr/src/kernel/arch/arm64/kernel/syscall.c:56 /usr/src/kernel/arch/arm64/kernel/syscall.c:158 /usr/src/kernel/arch/arm64/kernel/syscall.c:197)
> > > > > > el0_svc (/usr/src/kernel/arch/arm64/kernel/entry-common.c:368)
> > > > > > el0_sync_handler (/usr/src/kernel/arch/arm64/kernel/entry-common.c:428)
> > > > > > el0_sync (/usr/src/kernel/arch/arm64/kernel/entry.S:671)
> > > > > > Code: aa0003f3 b5000060 12800003 14000002 (b9404663)
> > > > > >
> > > > > > When booting the kdump kernel, drain the shared memory cache while being
> > > > > > careful to not translate the addresses returned from
> > > > > > OPTEE_SMC_DISABLE_SHM_CACHE. Once the invalid cache objects are drained
> > > > > > and the cache is disabled, proceed with re-enabling the cache so that we
> > > > > > aren't dealing with invalid addresses while shutting down the kdump
> > > > > > kernel.
> > > > > >
> > > > > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > > > ---
> > > > > >
> > > > > > This patch fixes a crash introduced by "optee: fix tee out of memory
> > > > > > failure seen during kexec reboot"[1]. However, I don't think that the
> > > > > > original two patch series[2] plus this patch is the full solution to
> > > > > > properly handling OP-TEE shared memory across kexec.
> > > > > >
> > > > > > While testing this fix, I did about 10 kexec reboots and then triggered
> > > > > > a kernel crash by writing 'c' to /proc/sysrq-trigger. The kdump kernel
> > > > > > became unresponsive during boot while steadily streaming the following
> > > > > > errors to the serial console:
> > > > > >
> > > > > > arm-smmu 64000000.mmu: Blocked unknown Stream ID 0x2000; boot with "arm-smmu.disable_bypass=0" to allow, but this may have security implications
> > > > > > arm-smmu 64000000.mmu:     GFSR 0x00000002, GFSYNR0 0x00000002, GFSYNR1 0x00002000, GFSYNR2 0x00000000
> > > > > >
> > > > > > I suspect that this is related to the problems of OP-TEE shared memory
> > > > > > handling across kexec. My current hunch is that while we've disabled the
> > > > > > shared memory cache with this patch, we haven't unregistered all of the
> > > > > > addresses that the previous kernel (which crashed) had registered with
> > > > > > OP-TEE and that perhaps OP-TEE OS is still trying to make use those
> > > > > > addresses?
> > >
> > > @Jens did you have any thoughts on what could be happening here with the
> > > arm-smmu errors? Do I need to try to unregister the cached shared memory
> > > addresses when booting the kdump kernel, rather than just disabling the
> > > caches?
> >
> > No idea. There's no support for SMMU in upstream OP-TEE. Just
> > disabling the caches should be good enough. You could try to never
> > enable the cache so see if it makes any difference.
>
> I think this is unrelated to OP-TEE and more to do with ongoing DMA
> activity when the kernel has crashed and we've done an emergency kexec
> into the kdump kernel which didn't shutdown the SMMU. The SoC I'm using
> has a v2 SMMU and I think something similar to commit 3f54c447df34
> ("iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel") is needed for
> the v1/v2 SMMU driver. I've prototyped a patch that disables the SMMU
> interrupts (GFIE and GCFGFIE) in the kdump kernel and testing has looked
> good so far. I'll send that out as a separate patch after a little more
> testing.
>
> However, with that change and my earlier change to disable the shm cache
> during boot, I'm periodically seeing a different issue while the kdump
> kernel is coming up. I'm pretty certain it was already there before but
> I wasn't seeing it as often since the SMMU warnings were so "loud".
>
> The kernel waits indefinitely for a secure world thread and boot hangs
> completely:
>
> [  243.359489] INFO: task swapper/0:1 blocked for more than 120 seconds.
> [  243.366141]       Not tainted 5.4.83-microsoft-standard #1
> [  243.371802] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  243.379882] swapper/0       D    0     1      0 0x00000028
> [  243.385543] Call trace:
> [  243.388080]  __switch_to+0xc8/0x118
> [  243.391683]  __schedule+0x2e0/0x700
> [  243.395280]  schedule+0x38/0xb8
> [  243.398522]  schedule_timeout+0x258/0x388
> [  243.402659]  wait_for_completion+0x16c/0x4b8
> [  243.407067]  optee_cq_wait_for_completion+0x28/0xa8
> [  243.412100]  optee_disable_shm_cache+0xb8/0xf8
> [  243.416685]  optee_probe+0x560/0x61c
> [  243.420375]  platform_drv_probe+0x58/0xa8
> [  243.424512]  really_probe+0xe0/0x338
> [  243.428202]  driver_probe_device+0x5c/0xf0
> [  243.432427]  device_driver_attach+0x74/0x80
> [  243.436744]  __driver_attach+0x64/0xe0
> [  243.440611]  bus_for_each_dev+0x84/0xd8
> [  243.444570]  driver_attach+0x30/0x40
> [  243.448258]  bus_add_driver+0x188/0x1e8
> [  243.452215]  driver_register+0x64/0x110
> [  243.456172]  __platform_driver_register+0x54/0x60
> [  243.461027]  optee_driver_init+0x20/0x28
> [  243.465075]  do_one_initcall+0x54/0x24c
> [  243.469034]  kernel_init_freeable+0x1e8/0x2c0
> [  243.473529]  kernel_init+0x18/0x118
> [  243.477128]  ret_from_fork+0x10/0x18
>
> I'm unable to trigger a sysrq over the serial console of this remote
> machine so I don't yet know what the other threads on the system are
> doing during this time. I'll hack something together tomorrow to get a
> better idea.
>
> The blocked task warning reminded me of when you said this earlier:
>
> > Bear in mind that there are other times where we can't recover from a
> > kernel crash. For instance if a thread is executing in OP-TEE in
> > secure world.
>
> I suspect that it is related to what I'm seeing with this blocked task. Can you
> expand on why we can't recover from a kernel crash if a thread is
> executing in the secure world?

Threads in OP-TEE are scheduled by Linux so if a thread is executing
it may be preempted. In OP-TEE that's a suspended thread waiting to be
resumed. If the kernel restarts at this moment that thread will be
lost in a suspended state. It may actually explain what you're seeing
above. optee_disable_shm_cache() is supposed to try until all threads
in OP-TEE are free, that means no suspended threads either.

These suspended threads are a bit dangerous to a restarted kernel in
case they are resumed as they may very well be using some old shared
memory objects where the physical memory now is used for some other
purpose. Cleaning out those threads might be tricky since we can't
just reset the secure world state, instead I believe that they will
need to be given enough CPU time to eventually complete. However, this
is a case which we haven't tested in OP-TEE so there's a risk of
running into some not so well tested error paths.

Cheers,
Jens
