Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDD430D6A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhBCJsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhBCJsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:48:20 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5848AC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 01:47:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f1so32396731lfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 01:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0AMrs3JS9ABopxu53Fe4YXqP4fCjBRvXi5TQqbzp9W0=;
        b=QPYIsTwnlspW+bG26mWcUpY2ycTyNoNCP1QCgGl0vpV/l0fykHWsWaY/LEIRQ23iSp
         cpyrUPPC51Ayf2WZxSElAx/gPyQTWc8col2KKEWhH1wZUTMrkherZKV4ZjpPWHsqSgBS
         yHMdw3/N2L6zsv1NgEAZLw6eKqAbyccVRkWWQvvzeFsftiqGB609HbmbBZ8q9yv2esOu
         yQgi9WMGAA2CV5pQSS6++HnW7EDByF7ysh0B8bOeCfdb6hMRpjKOdHZ7Kmco6tf8EZ7C
         L3UPT2AGavTMB5sYGOyDTCF0LVM34xaSFgNvuPuE71QrCXHCpSyiB4xbhk4PSU1KNyv+
         6n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0AMrs3JS9ABopxu53Fe4YXqP4fCjBRvXi5TQqbzp9W0=;
        b=R0uvbzMAOxyx5Mm0vspJwysHVbmCFpk41eVdew6fAhlfwGcJuVZj/yX73CeGr8QKhG
         XEesTK0g+oX3SVLWrh/YZjZd8QopM1tH9YYdTkPjM682UUEvT1MauGRKqnXaCa7qvGwU
         Gqc2I2zsOR1eZD5jQYUCUP0JNlLrGCyv5jeyRWhBxjD33mrA7j36JqMa1qnzMrHJMZ/d
         R44+b9hjEuIFreeHk/uAY3Ed8zx+LsYUcGBcZTslZcBm9iaD3wNhEp4EUDSOxGyHK0Aw
         dVYj9SfNtkGa4DWb3sAToF75he0IIVdW8/LaW/NU/qTY5B97yRnCfkJHNkeZLbC+BLwE
         wK7g==
X-Gm-Message-State: AOAM532e+N4+s0xML83I4zJCpjnwm6IEvJeVCTAHVNkbMjKYXBx6JO5b
        40BS0tnswkavKcQx/+FHNet38y7mHNLSqsAvolipJA==
X-Google-Smtp-Source: ABdhPJztv0I+QYsdikve3SGTojMXwgToTquGUc4v0DBtcSNNsxTQmHk0jy7ycRIoZeFDI80sw+cXwY6ETR0GQKlogv0=
X-Received: by 2002:a05:6512:2356:: with SMTP id p22mr1230693lfu.3.1612345658708;
 Wed, 03 Feb 2021 01:47:38 -0800 (PST)
MIME-Version: 1.0
References: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
 <58e41b62-b8e0-b036-c87d-a84d53f5a26e@amd.com> <CAKMK7uGTFYWnBG+JtbAK=zQVT1dT=nKor_SHP-t958oebgn8_A@mail.gmail.com>
 <fa170c5c-2f46-58ef-6847-e0bc9907fc8b@amd.com> <CAKMK7uE8qNUSNpX3TS6Fgif-6rCc7uZth_-F-kYPrOUSz5K3_A@mail.gmail.com>
In-Reply-To: <CAKMK7uE8qNUSNpX3TS6Fgif-6rCc7uZth_-F-kYPrOUSz5K3_A@mail.gmail.com>
From:   Daniel Gomez <daniel@qtec.com>
Date:   Wed, 3 Feb 2021 10:47:27 +0100
Message-ID: <CAH1Ww+QhiKYOJTWAigDhC761EhqeCUuh_bdZn=r4DAcEcb5Yyw@mail.gmail.com>
Subject: Re: [amdgpu] deadlock
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 at 10:17, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Feb 3, 2021 at 9:51 AM Christian K=C3=B6nig <christian.koenig@amd=
.com> wrote:
> >
> > Am 03.02.21 um 09:48 schrieb Daniel Vetter:
> > > On Wed, Feb 3, 2021 at 9:36 AM Christian K=C3=B6nig <christian.koenig=
@amd.com> wrote:
> > >> Hi Daniel,
> > >>
> > >> this is not a deadlock, but rather a hardware lockup.
> > > Are you sure? Ime getting stuck in dma_fence_wait has generally good
> > > chance of being a dma_fence deadlock. GPU hang should never result in
> > > a forever stuck dma_fence.
> >
> > Yes, I'm pretty sure. Otherwise the hardware clocks wouldn't go up like
> > this.
>
> Maybe clarifying, could be both. TDR should notice and get us out of
> this, but if there's a dma_fence deadlock and we can't re-emit or
> force complete the pending things, then we're stuck for good.
> -Daniel
>
> > Question is rather why we end up in the userptr handling for GFX? Our
> > ROCm OpenCL stack shouldn't use this.
> >
> > > Daniel, can you pls re-hang your machine and then dump backtraces of
> > > all tasks into dmesg with sysrq-t, and then attach that? Without all
> > > the backtraces it's tricky to construct the full dependency chain of
> > > what's going on. Also is this plain -rc6, not some more patches on
> > > top?
> >
> > Yeah, that's still a good idea to have.

Here the full backtrace dmesg logs after the hang:
https://pastebin.com/raw/kzivm2L3

This is another dmesg log with the backtraces after SIGKILL the matrix proc=
ess:
(I didn't have the sysrq enable at the time):
https://pastebin.com/raw/pRBwGcj1

> >
> > Christian.
> >
> > > -Daniel
> > >
> > >> Which OpenCl stack are you using?
> > >>
> > >> Regards,
> > >> Christian.
> > >>
> > >> Am 03.02.21 um 09:33 schrieb Daniel Gomez:
> > >>> Hi all,
> > >>>
> > >>> I have a deadlock with the amdgpu mainline driver when running in p=
arallel two
> > >>> OpenCL applications. So far, we've been able to replicate it easily=
 by executing
> > >>> clinfo and MatrixMultiplication (from AMD opencl-samples). It's qui=
te old the
> > >>> opencl-samples so, if you have any other suggestion for testing I'd=
 be very
> > >>> happy to test it as well.
> > >>>
> > >>> How to replicate the issue:
> > >>>
> > >>> # while true; do /usr/bin/MatrixMultiplication --device gpu \
> > >>>       --deviceId 0 -x 1000 -y 1000 -z 1000 -q -t -i 50; done
> > >>> # while true; do clinfo; done
> > >>>
> > >>> Output:
> > >>>
> > >>> After a minute or less (sometimes could be more) I can see that
> > >>> MatrixMultiplication and clinfo hang. In addition, with radeontop y=
ou can see
> > >>> how the Graphics pipe goes from ~50% to 100%. Also the shader clock=
s
> > >>> goes up from ~35% to ~96%.
> > >>>
> > >>> clinfo keeps printing:
> > >>> ioctl(7, DRM_IOCTL_SYNCOBJ_WAIT, 0x7ffe46e5f950) =3D -1 ETIME (Time=
r expired)
> > >>>
> > >>> And MatrixMultiplication prints the following (strace) if you try t=
o
> > >>> kill the process:
> > >>>
> > >>> sched_yield()                           =3D 0
> > >>> futex(0x557e945343b8, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIM=
E, 0,
> > >>> NULL, FUTEX_BITSET_MATCH_ANYstrace: Process 651 detached
> > >>>    <detached ...>
> > >>>
> > >>> After this, the gpu is not functional at all and you'd need a power=
 cycle reset
> > >>> to restore the system.
> > >>>
> > >>> Hardware info:
> > >>> CPU: AMD Ryzen Embedded V1605B with Radeon Vega Gfx (8) @ 2.000GHz
> > >>> GPU: AMD ATI Radeon Vega Series / Radeon Vega Mobile Series
> > >>>
> > >>> 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > >>> [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Seri=
es]
> > >>> (rev 83)
> > >>>       DeviceName: Broadcom 5762
> > >>>       Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Raven Ridge
> > >>> [Radeon Vega Series / Radeon Vega Mobile Series]
> > >>>       Kernel driver in use: amdgpu
> > >>>       Kernel modules: amdgpu
> > >>>
> > >>> Linux kernel info:
> > >>>
> > >>> root@qt5222:~# uname -a
> > >>> Linux qt5222 5.11.0-rc6-qtec-standard #2 SMP Tue Feb 2 09:41:46 UTC
> > >>> 2021 x86_64 x86_64 x86_64 GNU/Linux
> > >>>
> > >>> By enabling the kernel locks stats I could see the MatrixMultiplica=
tion is
> > >>> hanged in the amdgpu_mn_invalidate_gfx function:
> > >>>
> > >>> [  738.359202] 1 lock held by MatrixMultiplic/653:
> > >>> [  738.359206]  #0: ffff88810e364fe0
> > >>> (&adev->notifier_lock){+.+.}-{3:3}, at:
> > >>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> > >>>
> > >>> I can see in the the amdgpu_mn_invalidate_gfx function: the
> > >>> dma_resv_wait_timeout_rcu uses wait_all (fences) and MAX_SCHEDULE_T=
IMEOUT so, I
> > >>> guess the code gets stuck there waiting forever. According to the
> > >>> documentation: "When somebody tries to invalidate the page tables w=
e block the
> > >>> update until all operations on the pages in question are completed,=
 then those
> > >>> pages are marked  as accessed and also dirty if it wasn=E2=80=99t a=
 read only access."
> > >>> Looks like the fences are deadlocked and therefore, it never return=
s. Could it
> > >>> be possible? any hint to where can I look to fix this?
> > >>>
> > >>> Thank you  in advance.
> > >>>
> > >>> Here the full dmesg output:
> > >>>
> > >>> [  738.337726] INFO: task MatrixMultiplic:653 blocked for more than=
 122 seconds.
> > >>> [  738.344937]       Not tainted 5.11.0-rc6-qtec-standard #2
> > >>> [  738.350384] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > >>> disables this message.
> > >>> [  738.358240] task:MatrixMultiplic state:D stack:    0 pid:  653
> > >>> ppid:     1 flags:0x00004000
> > >>> [  738.358254] Call Trace:
> > >>> [  738.358261]  ? dma_fence_default_wait+0x1eb/0x230
> > >>> [  738.358276]  __schedule+0x370/0x960
> > >>> [  738.358291]  ? dma_fence_default_wait+0x117/0x230
> > >>> [  738.358297]  ? dma_fence_default_wait+0x1eb/0x230
> > >>> [  738.358305]  schedule+0x51/0xc0
> > >>> [  738.358312]  schedule_timeout+0x275/0x380
> > >>> [  738.358324]  ? dma_fence_default_wait+0x1eb/0x230
> > >>> [  738.358332]  ? mark_held_locks+0x4f/0x70
> > >>> [  738.358341]  ? dma_fence_default_wait+0x117/0x230
> > >>> [  738.358347]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> > >>> [  738.358353]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> > >>> [  738.358362]  ? dma_fence_default_wait+0x117/0x230
> > >>> [  738.358370]  ? dma_fence_default_wait+0x1eb/0x230
> > >>> [  738.358375]  dma_fence_default_wait+0x214/0x230
> > >>> [  738.358384]  ? dma_fence_release+0x1a0/0x1a0
> > >>> [  738.358396]  dma_fence_wait_timeout+0x105/0x200
> > >>> [  738.358405]  dma_resv_wait_timeout_rcu+0x1aa/0x5e0
> > >>> [  738.358421]  amdgpu_mn_invalidate_gfx+0x55/0xa0 [amdgpu]
> > >>> [  738.358688]  __mmu_notifier_release+0x1bb/0x210
> > >>> [  738.358710]  exit_mmap+0x2f/0x1e0
> > >>> [  738.358723]  ? find_held_lock+0x34/0xa0
> > >>> [  738.358746]  mmput+0x39/0xe0
> > >>> [  738.358756]  do_exit+0x5c3/0xc00
> > >>> [  738.358763]  ? find_held_lock+0x34/0xa0
> > >>> [  738.358780]  do_group_exit+0x47/0xb0
> > >>> [  738.358791]  get_signal+0x15b/0xc50
> > >>> [  738.358807]  arch_do_signal_or_restart+0xaf/0x710
> > >>> [  738.358816]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> > >>> [  738.358822]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> > >>> [  738.358831]  ? ktime_get_mono_fast_ns+0x50/0xa0
> > >>> [  738.358844]  ? amdgpu_drm_ioctl+0x6b/0x80 [amdgpu]
> > >>> [  738.359044]  exit_to_user_mode_prepare+0xf2/0x1b0
> > >>> [  738.359054]  syscall_exit_to_user_mode+0x19/0x60
> > >>> [  738.359062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >>> [  738.359069] RIP: 0033:0x7f6b89a51887
> > >>> [  738.359076] RSP: 002b:00007f6b82b54b18 EFLAGS: 00000246 ORIG_RAX=
:
> > >>> 0000000000000010
> > >>> [  738.359086] RAX: fffffffffffffe00 RBX: 00007f6b82b54b50 RCX: 000=
07f6b89a51887
> > >>> [  738.359091] RDX: 00007f6b82b54b50 RSI: 00000000c02064c3 RDI: 000=
0000000000007
> > >>> [  738.359096] RBP: 00000000c02064c3 R08: 0000000000000003 R09: 000=
07f6b82b54bbc
> > >>> [  738.359101] R10: 0000000000000001 R11: 0000000000000246 R12: 000=
0000165a0bc00
> > >>> [  738.359106] R13: 0000000000000007 R14: 0000000000000001 R15: 000=
0000000000000
> > >>> [  738.359129]
> > >>>                  Showing all locks held in the system:
> > >>> [  738.359141] 1 lock held by khungtaskd/54:
> > >>> [  738.359148]  #0: ffffffff829f6840 (rcu_read_lock){....}-{1:2}, a=
t:
> > >>> debug_show_all_locks+0x15/0x183
> > >>> [  738.359187] 1 lock held by systemd-journal/174:
> > >>> [  738.359202] 1 lock held by MatrixMultiplic/653:
> > >>> [  738.359206]  #0: ffff88810e364fe0
> > >>> (&adev->notifier_lock){+.+.}-{3:3}, at:
> > >>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> > >>>
> > >>> Daniel
> > >> _______________________________________________
> > >> dri-devel mailing list
> > >> dri-devel@lists.freedesktop.org
> > >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
lists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D04%7C01%7=
Cchristian.koenig%40amd.com%7C81203e5bac5841b8e5a108d8c82087a9%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637479389339295622%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&=
amp;sdata=3DRDSxD6OqD8HaOA2VnNfbJwLnKzhCLgOr5SVLjLF91bA%3D&amp;reserved=3D0
> > >
> > >
> >
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
