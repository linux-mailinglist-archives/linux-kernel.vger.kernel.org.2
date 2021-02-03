Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2F30DC00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhBCN5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhBCN5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:57:11 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAB0C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 05:56:30 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id d1so23355250otl.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 05:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fX6R08/kfXfKsDyBS+U7IdCT1MlEtFTqTVFSXRaHR9Q=;
        b=XxSUWeCujhdgtlQelSG2N4FWSQgXEJIVq2bxw948T3Jnf93Ca4dT3P1eGbqDheH46F
         c9LxUiY+REx1h2XR4TkxkIWlIrlTV+qYKjt2pz8BLA5gM+NKeR1pjoKqkIsclCW9gZza
         4L1KtvJov/yMxiwiT9Rnz7Ioq9IIAY5NyHYAJS92tMHJEPccK32FCgzYfaH9Ttue3dHc
         Fr8Mq8cbK4VRolfXrPV8ylcZ7oS+ulRs6GRh/cVg4aoE6Y6CCOgcg5uHrCUcSUnwdTbN
         ejUT4J7x2YZlGuqq4hvKflnJFnF85/uB9OWBUwQpFdMXA5IkkgDxPeJw4tWH1HUAV/yn
         FwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fX6R08/kfXfKsDyBS+U7IdCT1MlEtFTqTVFSXRaHR9Q=;
        b=ff9FX5b40w39xLzztufvBqLVbjfKr8G40T9rCXNUUDHGp41BE6rpUZ+XMOC1ssGKs4
         Ap1rujeLQAxe+Tkd5HE4cSyYzTfScsbu6wSNQ9hlApGUkomXrknhXm4/SQYwY1/tkk4N
         4c4YE5XNLBS7jIxnQoJ4aGIVGJCO4w/rI6SDZBY6/GajAwRG16Ege4l6WvembeODY8hi
         iTmItnUxIpSHEOKKj9v4qXKoUQy8QmLUZCPej6UCoMkmuZqY1gfqa9Q32yI6BCGPhQvm
         lw3+ZdB72wludc4eZ4wevp4enr6AfsUsJGkJqT29pOLJFdQjd68pf4jkr7jp7/rH1tCR
         Kb0A==
X-Gm-Message-State: AOAM533nUn6Lov2h3QRE69p/qNE4kDeS9katyk1UIvzokVo6Ua0YmMqd
        /MSD2vXQLuq+jgHJxVVx/T5cYAF5DHyV9JaZI+g=
X-Google-Smtp-Source: ABdhPJxcQaQWZaP8NxVpXLfPivQ1Bco1XBzSNhLgU3cMq6Cdq0ryUzHCA5PgEX+9VcSfc1yBRjD7tZXjSqWlYJ8t6To=
X-Received: by 2002:a9d:ec7:: with SMTP id 65mr2077244otj.311.1612360589679;
 Wed, 03 Feb 2021 05:56:29 -0800 (PST)
MIME-Version: 1.0
References: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
 <58e41b62-b8e0-b036-c87d-a84d53f5a26e@amd.com> <CAKMK7uGTFYWnBG+JtbAK=zQVT1dT=nKor_SHP-t958oebgn8_A@mail.gmail.com>
 <fa170c5c-2f46-58ef-6847-e0bc9907fc8b@amd.com> <CAKMK7uE8qNUSNpX3TS6Fgif-6rCc7uZth_-F-kYPrOUSz5K3_A@mail.gmail.com>
 <CAH1Ww+QhiKYOJTWAigDhC761EhqeCUuh_bdZn=r4DAcEcb5Yyw@mail.gmail.com>
 <CAH1Ww+Q=9TnxB2QW1=wb-NAoYmt0_+DueFj8vowqPjPFe_Cw8w@mail.gmail.com>
 <538682ee-3e12-a345-2205-2c0f16b496ff@gmail.com> <YBqWCgTPTLomYvAt@phenom.ffwll.local>
 <e34c8d2a-aded-a3be-334a-2adc4d552373@amd.com>
In-Reply-To: <e34c8d2a-aded-a3be-334a-2adc4d552373@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 3 Feb 2021 08:56:17 -0500
Message-ID: <CADnq5_NA2oGMyP8b0qNH9kmuYD4+A70pkw41uGErRDOvzF0RxA@mail.gmail.com>
Subject: Re: [amdgpu] deadlock
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Daniel Gomez <daniel@qtec.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 7:30 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 03.02.21 um 13:24 schrieb Daniel Vetter:
> > On Wed, Feb 03, 2021 at 01:21:20PM +0100, Christian K=C3=B6nig wrote:
> >> Am 03.02.21 um 12:45 schrieb Daniel Gomez:
> >>> On Wed, 3 Feb 2021 at 10:47, Daniel Gomez <daniel@qtec.com> wrote:
> >>>> On Wed, 3 Feb 2021 at 10:17, Daniel Vetter <daniel@ffwll.ch> wrote:
> >>>>> On Wed, Feb 3, 2021 at 9:51 AM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
> >>>>>> Am 03.02.21 um 09:48 schrieb Daniel Vetter:
> >>>>>>> On Wed, Feb 3, 2021 at 9:36 AM Christian K=C3=B6nig <christian.ko=
enig@amd.com> wrote:
> >>>>>>>> Hi Daniel,
> >>>>>>>>
> >>>>>>>> this is not a deadlock, but rather a hardware lockup.
> >>>>>>> Are you sure? Ime getting stuck in dma_fence_wait has generally g=
ood
> >>>>>>> chance of being a dma_fence deadlock. GPU hang should never resul=
t in
> >>>>>>> a forever stuck dma_fence.
> >>>>>> Yes, I'm pretty sure. Otherwise the hardware clocks wouldn't go up=
 like
> >>>>>> this.
> >>>>> Maybe clarifying, could be both. TDR should notice and get us out o=
f
> >>>>> this, but if there's a dma_fence deadlock and we can't re-emit or
> >>>>> force complete the pending things, then we're stuck for good.
> >>>>> -Daniel
> >>>>>
> >>>>>> Question is rather why we end up in the userptr handling for GFX? =
Our
> >>>>>> ROCm OpenCL stack shouldn't use this.
> >>>>>>
> >>>>>>> Daniel, can you pls re-hang your machine and then dump backtraces=
 of
> >>>>>>> all tasks into dmesg with sysrq-t, and then attach that? Without =
all
> >>>>>>> the backtraces it's tricky to construct the full dependency chain=
 of
> >>>>>>> what's going on. Also is this plain -rc6, not some more patches o=
n
> >>>>>>> top?
> >>>>>> Yeah, that's still a good idea to have.
> >>>> Here the full backtrace dmesg logs after the hang:
> >>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
pastebin.com%2Fraw%2Fkzivm2L3&amp;data=3D04%7C01%7Cchristian.koenig%40amd.c=
om%7C04065956e74d4ea73b2408d8c83eb15a%7C3dd8961fe4884e608e11a82d994e183d%7C=
0%7C0%7C637479518885971019%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ=
IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3Da3934SOOSFtRU=
3RraUe%2BWDgAEDefENxQZcd0prmSZXs%3D&amp;reserved=3D0
> >>>>
> >>>> This is another dmesg log with the backtraces after SIGKILL the matr=
ix process:
> >>>> (I didn't have the sysrq enable at the time):
> >>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
pastebin.com%2Fraw%2FpRBwGcj1&amp;data=3D04%7C01%7Cchristian.koenig%40amd.c=
om%7C04065956e74d4ea73b2408d8c83eb15a%7C3dd8961fe4884e608e11a82d994e183d%7C=
0%7C0%7C637479518885981018%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ=
IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DnPom9VwIrEZF0=
2hSEnC5Ef8lHdQURMELCapIhwKk2JE%3D&amp;reserved=3D0
> >>> I've now removed all our v4l2 patches and did the same test with the =
'plain'
> >>> mainline version (-rc6).
> >>>
> >>> Reference: 3aaf0a27ffc29b19a62314edd684b9bc6346f9a8
> >>>
> >>> Same error, same behaviour. Full dmesg log attached:
> >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp=
astebin.com%2Fraw%2FKgaEf7Y1&amp;data=3D04%7C01%7Cchristian.koenig%40amd.co=
m%7C04065956e74d4ea73b2408d8c83eb15a%7C3dd8961fe4884e608e11a82d994e183d%7C0=
%7C0%7C637479518885981018%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI=
joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DWQw6g9oA38aT1V=
uuZ8%2F1Y43pG%2BPlV%2F9%2FRHjKdGvZLK4%3D&amp;reserved=3D0
> >>> Note:
> >>>     dmesg with sysrq-t before running the test starts in [  122.01650=
2]
> >>> sysrq: Show State
> >>>     dmesg with sysrq-t after the test starts in: [  495.587671] sysrq=
: Show State
> >> There is nothing amdgpu related in there except for waiting for the
> >> hardware.
> > Yeah, but there's also no other driver that could cause a stuck dma_fen=
ce,
> > so why is reset not cleaning up the mess here? Irrespective of why the =
gpu
> > is stuck, the kernel should at least complete all the dma_fences even i=
f
> > the gpu for some reason is terminally ill ...
>
> That's a good question as well. I'm digging into this.
>
> My best theory is that the amdgpu packages disabled GPU reset for some
> reason.

The timeout for compute queues is infinite because of long running
compute kernels.  You can override with the amdgpu.lockup_timeout
parameter.

Alex

>
> But the much more interesting question is why we end up in this call
> path. I've pinged internally, but east coast is not awake yet :)
>
> Christian.
>
> > -Daniel
> >
> >> This is a pretty standard hardware lockup, but I'm still waiting for a=
n
> >> explanation why we end up in this call path in the first place.
> >>
> >> Christian.
> >>
> >>>
> >>>>>> Christian.
> >>>>>>
> >>>>>>> -Daniel
> >>>>>>>
> >>>>>>>> Which OpenCl stack are you using?
> >>>>>>>>
> >>>>>>>> Regards,
> >>>>>>>> Christian.
> >>>>>>>>
> >>>>>>>> Am 03.02.21 um 09:33 schrieb Daniel Gomez:
> >>>>>>>>> Hi all,
> >>>>>>>>>
> >>>>>>>>> I have a deadlock with the amdgpu mainline driver when running =
in parallel two
> >>>>>>>>> OpenCL applications. So far, we've been able to replicate it ea=
sily by executing
> >>>>>>>>> clinfo and MatrixMultiplication (from AMD opencl-samples). It's=
 quite old the
> >>>>>>>>> opencl-samples so, if you have any other suggestion for testing=
 I'd be very
> >>>>>>>>> happy to test it as well.
> >>>>>>>>>
> >>>>>>>>> How to replicate the issue:
> >>>>>>>>>
> >>>>>>>>> # while true; do /usr/bin/MatrixMultiplication --device gpu \
> >>>>>>>>>         --deviceId 0 -x 1000 -y 1000 -z 1000 -q -t -i 50; done
> >>>>>>>>> # while true; do clinfo; done
> >>>>>>>>>
> >>>>>>>>> Output:
> >>>>>>>>>
> >>>>>>>>> After a minute or less (sometimes could be more) I can see that
> >>>>>>>>> MatrixMultiplication and clinfo hang. In addition, with radeont=
op you can see
> >>>>>>>>> how the Graphics pipe goes from ~50% to 100%. Also the shader c=
locks
> >>>>>>>>> goes up from ~35% to ~96%.
> >>>>>>>>>
> >>>>>>>>> clinfo keeps printing:
> >>>>>>>>> ioctl(7, DRM_IOCTL_SYNCOBJ_WAIT, 0x7ffe46e5f950) =3D -1 ETIME (=
Timer expired)
> >>>>>>>>>
> >>>>>>>>> And MatrixMultiplication prints the following (strace) if you t=
ry to
> >>>>>>>>> kill the process:
> >>>>>>>>>
> >>>>>>>>> sched_yield()                           =3D 0
> >>>>>>>>> futex(0x557e945343b8, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REA=
LTIME, 0,
> >>>>>>>>> NULL, FUTEX_BITSET_MATCH_ANYstrace: Process 651 detached
> >>>>>>>>>      <detached ...>
> >>>>>>>>>
> >>>>>>>>> After this, the gpu is not functional at all and you'd need a p=
ower cycle reset
> >>>>>>>>> to restore the system.
> >>>>>>>>>
> >>>>>>>>> Hardware info:
> >>>>>>>>> CPU: AMD Ryzen Embedded V1605B with Radeon Vega Gfx (8) @ 2.000=
GHz
> >>>>>>>>> GPU: AMD ATI Radeon Vega Series / Radeon Vega Mobile Series
> >>>>>>>>>
> >>>>>>>>> 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> >>>>>>>>> [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile =
Series]
> >>>>>>>>> (rev 83)
> >>>>>>>>>         DeviceName: Broadcom 5762
> >>>>>>>>>         Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Raven=
 Ridge
> >>>>>>>>> [Radeon Vega Series / Radeon Vega Mobile Series]
> >>>>>>>>>         Kernel driver in use: amdgpu
> >>>>>>>>>         Kernel modules: amdgpu
> >>>>>>>>>
> >>>>>>>>> Linux kernel info:
> >>>>>>>>>
> >>>>>>>>> root@qt5222:~# uname -a
> >>>>>>>>> Linux qt5222 5.11.0-rc6-qtec-standard #2 SMP Tue Feb 2 09:41:46=
 UTC
> >>>>>>>>> 2021 x86_64 x86_64 x86_64 GNU/Linux
> >>>>>>>>>
> >>>>>>>>> By enabling the kernel locks stats I could see the MatrixMultip=
lication is
> >>>>>>>>> hanged in the amdgpu_mn_invalidate_gfx function:
> >>>>>>>>>
> >>>>>>>>> [  738.359202] 1 lock held by MatrixMultiplic/653:
> >>>>>>>>> [  738.359206]  #0: ffff88810e364fe0
> >>>>>>>>> (&adev->notifier_lock){+.+.}-{3:3}, at:
> >>>>>>>>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> >>>>>>>>>
> >>>>>>>>> I can see in the the amdgpu_mn_invalidate_gfx function: the
> >>>>>>>>> dma_resv_wait_timeout_rcu uses wait_all (fences) and MAX_SCHEDU=
LE_TIMEOUT so, I
> >>>>>>>>> guess the code gets stuck there waiting forever. According to t=
he
> >>>>>>>>> documentation: "When somebody tries to invalidate the page tabl=
es we block the
> >>>>>>>>> update until all operations on the pages in question are comple=
ted, then those
> >>>>>>>>> pages are marked  as accessed and also dirty if it wasn=E2=80=
=99t a read only access."
> >>>>>>>>> Looks like the fences are deadlocked and therefore, it never re=
turns. Could it
> >>>>>>>>> be possible? any hint to where can I look to fix this?
> >>>>>>>>>
> >>>>>>>>> Thank you  in advance.
> >>>>>>>>>
> >>>>>>>>> Here the full dmesg output:
> >>>>>>>>>
> >>>>>>>>> [  738.337726] INFO: task MatrixMultiplic:653 blocked for more =
than 122 seconds.
> >>>>>>>>> [  738.344937]       Not tainted 5.11.0-rc6-qtec-standard #2
> >>>>>>>>> [  738.350384] "echo 0 > /proc/sys/kernel/hung_task_timeout_sec=
s"
> >>>>>>>>> disables this message.
> >>>>>>>>> [  738.358240] task:MatrixMultiplic state:D stack:    0 pid:  6=
53
> >>>>>>>>> ppid:     1 flags:0x00004000
> >>>>>>>>> [  738.358254] Call Trace:
> >>>>>>>>> [  738.358261]  ? dma_fence_default_wait+0x1eb/0x230
> >>>>>>>>> [  738.358276]  __schedule+0x370/0x960
> >>>>>>>>> [  738.358291]  ? dma_fence_default_wait+0x117/0x230
> >>>>>>>>> [  738.358297]  ? dma_fence_default_wait+0x1eb/0x230
> >>>>>>>>> [  738.358305]  schedule+0x51/0xc0
> >>>>>>>>> [  738.358312]  schedule_timeout+0x275/0x380
> >>>>>>>>> [  738.358324]  ? dma_fence_default_wait+0x1eb/0x230
> >>>>>>>>> [  738.358332]  ? mark_held_locks+0x4f/0x70
> >>>>>>>>> [  738.358341]  ? dma_fence_default_wait+0x117/0x230
> >>>>>>>>> [  738.358347]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> >>>>>>>>> [  738.358353]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> >>>>>>>>> [  738.358362]  ? dma_fence_default_wait+0x117/0x230
> >>>>>>>>> [  738.358370]  ? dma_fence_default_wait+0x1eb/0x230
> >>>>>>>>> [  738.358375]  dma_fence_default_wait+0x214/0x230
> >>>>>>>>> [  738.358384]  ? dma_fence_release+0x1a0/0x1a0
> >>>>>>>>> [  738.358396]  dma_fence_wait_timeout+0x105/0x200
> >>>>>>>>> [  738.358405]  dma_resv_wait_timeout_rcu+0x1aa/0x5e0
> >>>>>>>>> [  738.358421]  amdgpu_mn_invalidate_gfx+0x55/0xa0 [amdgpu]
> >>>>>>>>> [  738.358688]  __mmu_notifier_release+0x1bb/0x210
> >>>>>>>>> [  738.358710]  exit_mmap+0x2f/0x1e0
> >>>>>>>>> [  738.358723]  ? find_held_lock+0x34/0xa0
> >>>>>>>>> [  738.358746]  mmput+0x39/0xe0
> >>>>>>>>> [  738.358756]  do_exit+0x5c3/0xc00
> >>>>>>>>> [  738.358763]  ? find_held_lock+0x34/0xa0
> >>>>>>>>> [  738.358780]  do_group_exit+0x47/0xb0
> >>>>>>>>> [  738.358791]  get_signal+0x15b/0xc50
> >>>>>>>>> [  738.358807]  arch_do_signal_or_restart+0xaf/0x710
> >>>>>>>>> [  738.358816]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> >>>>>>>>> [  738.358822]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> >>>>>>>>> [  738.358831]  ? ktime_get_mono_fast_ns+0x50/0xa0
> >>>>>>>>> [  738.358844]  ? amdgpu_drm_ioctl+0x6b/0x80 [amdgpu]
> >>>>>>>>> [  738.359044]  exit_to_user_mode_prepare+0xf2/0x1b0
> >>>>>>>>> [  738.359054]  syscall_exit_to_user_mode+0x19/0x60
> >>>>>>>>> [  738.359062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >>>>>>>>> [  738.359069] RIP: 0033:0x7f6b89a51887
> >>>>>>>>> [  738.359076] RSP: 002b:00007f6b82b54b18 EFLAGS: 00000246 ORIG=
_RAX:
> >>>>>>>>> 0000000000000010
> >>>>>>>>> [  738.359086] RAX: fffffffffffffe00 RBX: 00007f6b82b54b50 RCX:=
 00007f6b89a51887
> >>>>>>>>> [  738.359091] RDX: 00007f6b82b54b50 RSI: 00000000c02064c3 RDI:=
 0000000000000007
> >>>>>>>>> [  738.359096] RBP: 00000000c02064c3 R08: 0000000000000003 R09:=
 00007f6b82b54bbc
> >>>>>>>>> [  738.359101] R10: 0000000000000001 R11: 0000000000000246 R12:=
 0000000165a0bc00
> >>>>>>>>> [  738.359106] R13: 0000000000000007 R14: 0000000000000001 R15:=
 0000000000000000
> >>>>>>>>> [  738.359129]
> >>>>>>>>>                    Showing all locks held in the system:
> >>>>>>>>> [  738.359141] 1 lock held by khungtaskd/54:
> >>>>>>>>> [  738.359148]  #0: ffffffff829f6840 (rcu_read_lock){....}-{1:2=
}, at:
> >>>>>>>>> debug_show_all_locks+0x15/0x183
> >>>>>>>>> [  738.359187] 1 lock held by systemd-journal/174:
> >>>>>>>>> [  738.359202] 1 lock held by MatrixMultiplic/653:
> >>>>>>>>> [  738.359206]  #0: ffff88810e364fe0
> >>>>>>>>> (&adev->notifier_lock){+.+.}-{3:3}, at:
> >>>>>>>>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> >>>>>>>>>
> >>>>>>>>> Daniel
> >>>>>>>> _______________________________________________
> >>>>>>>> dri-devel mailing list
> >>>>>>>> dri-devel@lists.freedesktop.org
> >>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D04%7C=
01%7Cchristian.koenig%40amd.com%7C04065956e74d4ea73b2408d8c83eb15a%7C3dd896=
1fe4884e608e11a82d994e183d%7C0%7C0%7C637479518885981018%7CUnknown%7CTWFpbGZ=
sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3=
000&amp;sdata=3DOkFv8jiehNoa46Q%2B5yOXUg29cRbzl8voV2GqC8j1V9Q%3D&amp;reserv=
ed=3D0
> >>>>> --
> >>>>> Daniel Vetter
> >>>>> Software Engineer, Intel Corporation
> >>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2F=
blog.ffwll.ch%2F&amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C04065956=
e74d4ea73b2408d8c83eb15a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63747=
9518885981018%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3Dm0e9DrqnuYQoJYwwZAyonKlSfk=
p9hFTRNoT53OY3IbU%3D&amp;reserved=3D0
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx@lists.freedesktop.org
> >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cch=
ristian.koenig%40amd.com%7C04065956e74d4ea73b2408d8c83eb15a%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637479518885981018%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp=
;sdata=3DBuUCnnGsKhSQc0ldgBPVBIQxYUnvIPwqqLMe81ynrgY%3D&amp;reserved=3D0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
