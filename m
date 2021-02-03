Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDEB30D58B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhBCItr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbhBCItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:49:31 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4354EC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 00:48:51 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id d7so22659236otf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 00:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VwNp0a42H2HJdUXf2U+NyyGMLQI597ulmFnoEoIfRg8=;
        b=bp4qJgQbbTLWXuU91TsSZAOI41pytifc2W9dIiVN6dXquO6uybAKvlcCPaPH1NpkHd
         P0Mq76vN/q5u7f/lrfgPGRqu2/rWYgb0PAnpfpAeEQ4C/t0wMWRE7aOx1JX0e82Xot46
         WQy0xA2TsNhyd9sdod7biEaozcsh5EHAWKcec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VwNp0a42H2HJdUXf2U+NyyGMLQI597ulmFnoEoIfRg8=;
        b=GKE5b/3ac2Nc4AW/M6+JxtwwPvf6zR5WUKGHeqZmHKf+VXVDtfGkXr4KgBBaKCPn1z
         l1AqIwAYdEkG3Aj/NlD4SmTfYNxqjrZ4IA0YNpGx/ISNTLgoHctIKSBHFqaXccNWR0xs
         eOV3CTsRY9AM9f8LFNhGIpP9VPY5Tfk7eADfWrGDijSDbTZxBtCvL66ojsO7ug58wC5i
         RHMAqcD10HN779gWfAva4bguZSi6+cG5IMXgtoKMJ42Zd+BVhZdoepqPRCvmi0x+CX2s
         2tkn6ZeFianj2GBTh4+yQ+0ohXjCdlwenKkM4uZ1jPtsHv1WehHTJouO2IBhjJh8iw33
         HmUA==
X-Gm-Message-State: AOAM531HeQt49sjrgQ3LzA7rVwjsKk9O/15OXN6KF8Yu+BVtu89hkGPQ
        1aRLlY9711dJPgpWHzpIA1pZ/tdgI2clq5dyXGoe4w==
X-Google-Smtp-Source: ABdhPJwFJFhQYQVJPg8AcL5xpSmXQT4nU/vhOSOoGYxm48EBQ+vEBz006Z/ZUAjAOMfXzIp+7+twjGV9i1z1MNucNfM=
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr1296084otr.303.1612342130615;
 Wed, 03 Feb 2021 00:48:50 -0800 (PST)
MIME-Version: 1.0
References: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
 <58e41b62-b8e0-b036-c87d-a84d53f5a26e@amd.com>
In-Reply-To: <58e41b62-b8e0-b036-c87d-a84d53f5a26e@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 3 Feb 2021 09:48:39 +0100
Message-ID: <CAKMK7uGTFYWnBG+JtbAK=zQVT1dT=nKor_SHP-t958oebgn8_A@mail.gmail.com>
Subject: Re: [amdgpu] deadlock
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Daniel Gomez <daniel@qtec.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 9:36 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Hi Daniel,
>
> this is not a deadlock, but rather a hardware lockup.

Are you sure? Ime getting stuck in dma_fence_wait has generally good
chance of being a dma_fence deadlock. GPU hang should never result in
a forever stuck dma_fence.

Daniel, can you pls re-hang your machine and then dump backtraces of
all tasks into dmesg with sysrq-t, and then attach that? Without all
the backtraces it's tricky to construct the full dependency chain of
what's going on. Also is this plain -rc6, not some more patches on
top?
-Daniel

> Which OpenCl stack are you using?
>
> Regards,
> Christian.
>
> Am 03.02.21 um 09:33 schrieb Daniel Gomez:
> > Hi all,
> >
> > I have a deadlock with the amdgpu mainline driver when running in paral=
lel two
> > OpenCL applications. So far, we've been able to replicate it easily by =
executing
> > clinfo and MatrixMultiplication (from AMD opencl-samples). It's quite o=
ld the
> > opencl-samples so, if you have any other suggestion for testing I'd be =
very
> > happy to test it as well.
> >
> > How to replicate the issue:
> >
> > # while true; do /usr/bin/MatrixMultiplication --device gpu \
> >      --deviceId 0 -x 1000 -y 1000 -z 1000 -q -t -i 50; done
> > # while true; do clinfo; done
> >
> > Output:
> >
> > After a minute or less (sometimes could be more) I can see that
> > MatrixMultiplication and clinfo hang. In addition, with radeontop you c=
an see
> > how the Graphics pipe goes from ~50% to 100%. Also the shader clocks
> > goes up from ~35% to ~96%.
> >
> > clinfo keeps printing:
> > ioctl(7, DRM_IOCTL_SYNCOBJ_WAIT, 0x7ffe46e5f950) =3D -1 ETIME (Timer ex=
pired)
> >
> > And MatrixMultiplication prints the following (strace) if you try to
> > kill the process:
> >
> > sched_yield()                           =3D 0
> > futex(0x557e945343b8, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0=
,
> > NULL, FUTEX_BITSET_MATCH_ANYstrace: Process 651 detached
> >   <detached ...>
> >
> > After this, the gpu is not functional at all and you'd need a power cyc=
le reset
> > to restore the system.
> >
> > Hardware info:
> > CPU: AMD Ryzen Embedded V1605B with Radeon Vega Gfx (8) @ 2.000GHz
> > GPU: AMD ATI Radeon Vega Series / Radeon Vega Mobile Series
> >
> > 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series]
> > (rev 83)
> >      DeviceName: Broadcom 5762
> >      Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Raven Ridge
> > [Radeon Vega Series / Radeon Vega Mobile Series]
> >      Kernel driver in use: amdgpu
> >      Kernel modules: amdgpu
> >
> > Linux kernel info:
> >
> > root@qt5222:~# uname -a
> > Linux qt5222 5.11.0-rc6-qtec-standard #2 SMP Tue Feb 2 09:41:46 UTC
> > 2021 x86_64 x86_64 x86_64 GNU/Linux
> >
> > By enabling the kernel locks stats I could see the MatrixMultiplication=
 is
> > hanged in the amdgpu_mn_invalidate_gfx function:
> >
> > [  738.359202] 1 lock held by MatrixMultiplic/653:
> > [  738.359206]  #0: ffff88810e364fe0
> > (&adev->notifier_lock){+.+.}-{3:3}, at:
> > amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> >
> > I can see in the the amdgpu_mn_invalidate_gfx function: the
> > dma_resv_wait_timeout_rcu uses wait_all (fences) and MAX_SCHEDULE_TIMEO=
UT so, I
> > guess the code gets stuck there waiting forever. According to the
> > documentation: "When somebody tries to invalidate the page tables we bl=
ock the
> > update until all operations on the pages in question are completed, the=
n those
> > pages are marked  as accessed and also dirty if it wasn=E2=80=99t a rea=
d only access."
> > Looks like the fences are deadlocked and therefore, it never returns. C=
ould it
> > be possible? any hint to where can I look to fix this?
> >
> > Thank you  in advance.
> >
> > Here the full dmesg output:
> >
> > [  738.337726] INFO: task MatrixMultiplic:653 blocked for more than 122=
 seconds.
> > [  738.344937]       Not tainted 5.11.0-rc6-qtec-standard #2
> > [  738.350384] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [  738.358240] task:MatrixMultiplic state:D stack:    0 pid:  653
> > ppid:     1 flags:0x00004000
> > [  738.358254] Call Trace:
> > [  738.358261]  ? dma_fence_default_wait+0x1eb/0x230
> > [  738.358276]  __schedule+0x370/0x960
> > [  738.358291]  ? dma_fence_default_wait+0x117/0x230
> > [  738.358297]  ? dma_fence_default_wait+0x1eb/0x230
> > [  738.358305]  schedule+0x51/0xc0
> > [  738.358312]  schedule_timeout+0x275/0x380
> > [  738.358324]  ? dma_fence_default_wait+0x1eb/0x230
> > [  738.358332]  ? mark_held_locks+0x4f/0x70
> > [  738.358341]  ? dma_fence_default_wait+0x117/0x230
> > [  738.358347]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> > [  738.358353]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> > [  738.358362]  ? dma_fence_default_wait+0x117/0x230
> > [  738.358370]  ? dma_fence_default_wait+0x1eb/0x230
> > [  738.358375]  dma_fence_default_wait+0x214/0x230
> > [  738.358384]  ? dma_fence_release+0x1a0/0x1a0
> > [  738.358396]  dma_fence_wait_timeout+0x105/0x200
> > [  738.358405]  dma_resv_wait_timeout_rcu+0x1aa/0x5e0
> > [  738.358421]  amdgpu_mn_invalidate_gfx+0x55/0xa0 [amdgpu]
> > [  738.358688]  __mmu_notifier_release+0x1bb/0x210
> > [  738.358710]  exit_mmap+0x2f/0x1e0
> > [  738.358723]  ? find_held_lock+0x34/0xa0
> > [  738.358746]  mmput+0x39/0xe0
> > [  738.358756]  do_exit+0x5c3/0xc00
> > [  738.358763]  ? find_held_lock+0x34/0xa0
> > [  738.358780]  do_group_exit+0x47/0xb0
> > [  738.358791]  get_signal+0x15b/0xc50
> > [  738.358807]  arch_do_signal_or_restart+0xaf/0x710
> > [  738.358816]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> > [  738.358822]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> > [  738.358831]  ? ktime_get_mono_fast_ns+0x50/0xa0
> > [  738.358844]  ? amdgpu_drm_ioctl+0x6b/0x80 [amdgpu]
> > [  738.359044]  exit_to_user_mode_prepare+0xf2/0x1b0
> > [  738.359054]  syscall_exit_to_user_mode+0x19/0x60
> > [  738.359062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [  738.359069] RIP: 0033:0x7f6b89a51887
> > [  738.359076] RSP: 002b:00007f6b82b54b18 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000010
> > [  738.359086] RAX: fffffffffffffe00 RBX: 00007f6b82b54b50 RCX: 00007f6=
b89a51887
> > [  738.359091] RDX: 00007f6b82b54b50 RSI: 00000000c02064c3 RDI: 0000000=
000000007
> > [  738.359096] RBP: 00000000c02064c3 R08: 0000000000000003 R09: 00007f6=
b82b54bbc
> > [  738.359101] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000=
165a0bc00
> > [  738.359106] R13: 0000000000000007 R14: 0000000000000001 R15: 0000000=
000000000
> > [  738.359129]
> >                 Showing all locks held in the system:
> > [  738.359141] 1 lock held by khungtaskd/54:
> > [  738.359148]  #0: ffffffff829f6840 (rcu_read_lock){....}-{1:2}, at:
> > debug_show_all_locks+0x15/0x183
> > [  738.359187] 1 lock held by systemd-journal/174:
> > [  738.359202] 1 lock held by MatrixMultiplic/653:
> > [  738.359206]  #0: ffff88810e364fe0
> > (&adev->notifier_lock){+.+.}-{3:3}, at:
> > amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> >
> > Daniel
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
