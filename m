Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B4130D61B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhBCJSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhBCJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:18:08 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045C4C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 01:17:28 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id w8so26036582oie.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 01:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9xe9R5cnbohgJWLL8bFWpt0rG0IoAak+q4Rzd+MbhNQ=;
        b=Rxnb6P+vCmqImmGNHbWeKV1eVeNMACUMToNomGiNCmaDQogoKWFcvkY7DXxjnZx12Z
         9Z7dOErEbVScSI5TV/pTmyA9v1jeYcbOzzbL0oiSYV1m/hwc37sMlYmfHEbV4xnvIzSC
         OtgLfikZYV4bV/2cTaDa6tlAOQvJIxk1Ogz6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9xe9R5cnbohgJWLL8bFWpt0rG0IoAak+q4Rzd+MbhNQ=;
        b=WoLoVmsz/89XRPM5Ch3NVDzqbJ5liR15CNXfV3kbFJY8CByhO8AAipXX8GTv7xR9Zu
         FVw/dvEEvtOOSddvmiC3AbvCkI86/bhVPfbzKmQgrFx9mUYTmN9eNTYfRBix6xufbGN6
         TPEs7iTR0n/CYIow5Me+5v4XLFXsityu1ru8ztFARz4pPBjTk85ZqyBLYEVmL3CSftoo
         +YzYXSAklehiWKFTr/6/7Xei6uIzkOcqkH0FtKb1UwjEJ5zqzDSXhP/WDJ0ZiN6y7mAk
         vP8ft0q0TtwuGnhfvlZOEniMyD7wFtxNQl0f68x5gLMkCqHWi3EfI/3JnOX+8kAwNA/U
         f9Xg==
X-Gm-Message-State: AOAM5302tMG5QZw8B6uDwGHcR0POdxSX2r0MIN7tGbG6tDQTCyQEM2Kn
        Tl4ke3dh1q9Nt/a3MQKkOGH+32tFwAmBi3Dpy9f4eg==
X-Google-Smtp-Source: ABdhPJye2PqDzNXl5T3JQTDe+DmDWslmAq6QUMYuRc5UGmnmPUo+lZnbBgiG/kH+NpAzjCgrkIZpl8tbgslkb9C6qks=
X-Received: by 2002:aca:4ac5:: with SMTP id x188mr1310056oia.14.1612343847385;
 Wed, 03 Feb 2021 01:17:27 -0800 (PST)
MIME-Version: 1.0
References: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
 <58e41b62-b8e0-b036-c87d-a84d53f5a26e@amd.com> <CAKMK7uGTFYWnBG+JtbAK=zQVT1dT=nKor_SHP-t958oebgn8_A@mail.gmail.com>
 <fa170c5c-2f46-58ef-6847-e0bc9907fc8b@amd.com>
In-Reply-To: <fa170c5c-2f46-58ef-6847-e0bc9907fc8b@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 3 Feb 2021 10:17:16 +0100
Message-ID: <CAKMK7uE8qNUSNpX3TS6Fgif-6rCc7uZth_-F-kYPrOUSz5K3_A@mail.gmail.com>
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

On Wed, Feb 3, 2021 at 9:51 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 03.02.21 um 09:48 schrieb Daniel Vetter:
> > On Wed, Feb 3, 2021 at 9:36 AM Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> >> Hi Daniel,
> >>
> >> this is not a deadlock, but rather a hardware lockup.
> > Are you sure? Ime getting stuck in dma_fence_wait has generally good
> > chance of being a dma_fence deadlock. GPU hang should never result in
> > a forever stuck dma_fence.
>
> Yes, I'm pretty sure. Otherwise the hardware clocks wouldn't go up like
> this.

Maybe clarifying, could be both. TDR should notice and get us out of
this, but if there's a dma_fence deadlock and we can't re-emit or
force complete the pending things, then we're stuck for good.
-Daniel

> Question is rather why we end up in the userptr handling for GFX? Our
> ROCm OpenCL stack shouldn't use this.
>
> > Daniel, can you pls re-hang your machine and then dump backtraces of
> > all tasks into dmesg with sysrq-t, and then attach that? Without all
> > the backtraces it's tricky to construct the full dependency chain of
> > what's going on. Also is this plain -rc6, not some more patches on
> > top?
>
> Yeah, that's still a good idea to have.
>
> Christian.
>
> > -Daniel
> >
> >> Which OpenCl stack are you using?
> >>
> >> Regards,
> >> Christian.
> >>
> >> Am 03.02.21 um 09:33 schrieb Daniel Gomez:
> >>> Hi all,
> >>>
> >>> I have a deadlock with the amdgpu mainline driver when running in par=
allel two
> >>> OpenCL applications. So far, we've been able to replicate it easily b=
y executing
> >>> clinfo and MatrixMultiplication (from AMD opencl-samples). It's quite=
 old the
> >>> opencl-samples so, if you have any other suggestion for testing I'd b=
e very
> >>> happy to test it as well.
> >>>
> >>> How to replicate the issue:
> >>>
> >>> # while true; do /usr/bin/MatrixMultiplication --device gpu \
> >>>       --deviceId 0 -x 1000 -y 1000 -z 1000 -q -t -i 50; done
> >>> # while true; do clinfo; done
> >>>
> >>> Output:
> >>>
> >>> After a minute or less (sometimes could be more) I can see that
> >>> MatrixMultiplication and clinfo hang. In addition, with radeontop you=
 can see
> >>> how the Graphics pipe goes from ~50% to 100%. Also the shader clocks
> >>> goes up from ~35% to ~96%.
> >>>
> >>> clinfo keeps printing:
> >>> ioctl(7, DRM_IOCTL_SYNCOBJ_WAIT, 0x7ffe46e5f950) =3D -1 ETIME (Timer =
expired)
> >>>
> >>> And MatrixMultiplication prints the following (strace) if you try to
> >>> kill the process:
> >>>
> >>> sched_yield()                           =3D 0
> >>> futex(0x557e945343b8, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME,=
 0,
> >>> NULL, FUTEX_BITSET_MATCH_ANYstrace: Process 651 detached
> >>>    <detached ...>
> >>>
> >>> After this, the gpu is not functional at all and you'd need a power c=
ycle reset
> >>> to restore the system.
> >>>
> >>> Hardware info:
> >>> CPU: AMD Ryzen Embedded V1605B with Radeon Vega Gfx (8) @ 2.000GHz
> >>> GPU: AMD ATI Radeon Vega Series / Radeon Vega Mobile Series
> >>>
> >>> 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> >>> [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series=
]
> >>> (rev 83)
> >>>       DeviceName: Broadcom 5762
> >>>       Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Raven Ridge
> >>> [Radeon Vega Series / Radeon Vega Mobile Series]
> >>>       Kernel driver in use: amdgpu
> >>>       Kernel modules: amdgpu
> >>>
> >>> Linux kernel info:
> >>>
> >>> root@qt5222:~# uname -a
> >>> Linux qt5222 5.11.0-rc6-qtec-standard #2 SMP Tue Feb 2 09:41:46 UTC
> >>> 2021 x86_64 x86_64 x86_64 GNU/Linux
> >>>
> >>> By enabling the kernel locks stats I could see the MatrixMultiplicati=
on is
> >>> hanged in the amdgpu_mn_invalidate_gfx function:
> >>>
> >>> [  738.359202] 1 lock held by MatrixMultiplic/653:
> >>> [  738.359206]  #0: ffff88810e364fe0
> >>> (&adev->notifier_lock){+.+.}-{3:3}, at:
> >>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> >>>
> >>> I can see in the the amdgpu_mn_invalidate_gfx function: the
> >>> dma_resv_wait_timeout_rcu uses wait_all (fences) and MAX_SCHEDULE_TIM=
EOUT so, I
> >>> guess the code gets stuck there waiting forever. According to the
> >>> documentation: "When somebody tries to invalidate the page tables we =
block the
> >>> update until all operations on the pages in question are completed, t=
hen those
> >>> pages are marked  as accessed and also dirty if it wasn=E2=80=99t a r=
ead only access."
> >>> Looks like the fences are deadlocked and therefore, it never returns.=
 Could it
> >>> be possible? any hint to where can I look to fix this?
> >>>
> >>> Thank you  in advance.
> >>>
> >>> Here the full dmesg output:
> >>>
> >>> [  738.337726] INFO: task MatrixMultiplic:653 blocked for more than 1=
22 seconds.
> >>> [  738.344937]       Not tainted 5.11.0-rc6-qtec-standard #2
> >>> [  738.350384] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >>> disables this message.
> >>> [  738.358240] task:MatrixMultiplic state:D stack:    0 pid:  653
> >>> ppid:     1 flags:0x00004000
> >>> [  738.358254] Call Trace:
> >>> [  738.358261]  ? dma_fence_default_wait+0x1eb/0x230
> >>> [  738.358276]  __schedule+0x370/0x960
> >>> [  738.358291]  ? dma_fence_default_wait+0x117/0x230
> >>> [  738.358297]  ? dma_fence_default_wait+0x1eb/0x230
> >>> [  738.358305]  schedule+0x51/0xc0
> >>> [  738.358312]  schedule_timeout+0x275/0x380
> >>> [  738.358324]  ? dma_fence_default_wait+0x1eb/0x230
> >>> [  738.358332]  ? mark_held_locks+0x4f/0x70
> >>> [  738.358341]  ? dma_fence_default_wait+0x117/0x230
> >>> [  738.358347]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> >>> [  738.358353]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> >>> [  738.358362]  ? dma_fence_default_wait+0x117/0x230
> >>> [  738.358370]  ? dma_fence_default_wait+0x1eb/0x230
> >>> [  738.358375]  dma_fence_default_wait+0x214/0x230
> >>> [  738.358384]  ? dma_fence_release+0x1a0/0x1a0
> >>> [  738.358396]  dma_fence_wait_timeout+0x105/0x200
> >>> [  738.358405]  dma_resv_wait_timeout_rcu+0x1aa/0x5e0
> >>> [  738.358421]  amdgpu_mn_invalidate_gfx+0x55/0xa0 [amdgpu]
> >>> [  738.358688]  __mmu_notifier_release+0x1bb/0x210
> >>> [  738.358710]  exit_mmap+0x2f/0x1e0
> >>> [  738.358723]  ? find_held_lock+0x34/0xa0
> >>> [  738.358746]  mmput+0x39/0xe0
> >>> [  738.358756]  do_exit+0x5c3/0xc00
> >>> [  738.358763]  ? find_held_lock+0x34/0xa0
> >>> [  738.358780]  do_group_exit+0x47/0xb0
> >>> [  738.358791]  get_signal+0x15b/0xc50
> >>> [  738.358807]  arch_do_signal_or_restart+0xaf/0x710
> >>> [  738.358816]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> >>> [  738.358822]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> >>> [  738.358831]  ? ktime_get_mono_fast_ns+0x50/0xa0
> >>> [  738.358844]  ? amdgpu_drm_ioctl+0x6b/0x80 [amdgpu]
> >>> [  738.359044]  exit_to_user_mode_prepare+0xf2/0x1b0
> >>> [  738.359054]  syscall_exit_to_user_mode+0x19/0x60
> >>> [  738.359062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>> [  738.359069] RIP: 0033:0x7f6b89a51887
> >>> [  738.359076] RSP: 002b:00007f6b82b54b18 EFLAGS: 00000246 ORIG_RAX:
> >>> 0000000000000010
> >>> [  738.359086] RAX: fffffffffffffe00 RBX: 00007f6b82b54b50 RCX: 00007=
f6b89a51887
> >>> [  738.359091] RDX: 00007f6b82b54b50 RSI: 00000000c02064c3 RDI: 00000=
00000000007
> >>> [  738.359096] RBP: 00000000c02064c3 R08: 0000000000000003 R09: 00007=
f6b82b54bbc
> >>> [  738.359101] R10: 0000000000000001 R11: 0000000000000246 R12: 00000=
00165a0bc00
> >>> [  738.359106] R13: 0000000000000007 R14: 0000000000000001 R15: 00000=
00000000000
> >>> [  738.359129]
> >>>                  Showing all locks held in the system:
> >>> [  738.359141] 1 lock held by khungtaskd/54:
> >>> [  738.359148]  #0: ffffffff829f6840 (rcu_read_lock){....}-{1:2}, at:
> >>> debug_show_all_locks+0x15/0x183
> >>> [  738.359187] 1 lock held by systemd-journal/174:
> >>> [  738.359202] 1 lock held by MatrixMultiplic/653:
> >>> [  738.359206]  #0: ffff88810e364fe0
> >>> (&adev->notifier_lock){+.+.}-{3:3}, at:
> >>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> >>>
> >>> Daniel
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli=
sts.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D04%7C01%7Cc=
hristian.koenig%40amd.com%7C81203e5bac5841b8e5a108d8c82087a9%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637479389339295622%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am=
p;sdata=3DRDSxD6OqD8HaOA2VnNfbJwLnKzhCLgOr5SVLjLF91bA%3D&amp;reserved=3D0
> >
> >
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
