Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3098330DD1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhBCOm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhBCOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:42:44 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20784C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:42:02 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id h6so73311oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l9SYTwCym/cA/ZU7Ns3Ivx4Ms+v5cpqplYP+ZRtaOf8=;
        b=lI7JBdDvxf0yPPRy7VrNPcdWBWSgi7HOt5eJPrfCRso1IAuU0nYSh+BLN3LTzLVZFo
         o99kxxloBELSjS0wRzg9XrR8tAc86ccz2Jy+Sj1gaaZJuxXY12+oJMWkze4smJ3V7F0e
         85cxTY8euBBq9zUarq1ITISLW0YTVwroB6O58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l9SYTwCym/cA/ZU7Ns3Ivx4Ms+v5cpqplYP+ZRtaOf8=;
        b=KTdZs4lwp48X0/2BTfSZfMW5nntk55v5O9zWRLgFUrV1eP+f1iNMub7FnDD3o0PrHW
         AKX4ZwGg/z5DPWwpbaSVodClfdKb+txJmnpwTrBjJU64Y61upbILp3RLnjWAyis/VA7o
         r6rndvtgF9uSduLv9KgB77A+NOqOv0HsDzBRx79hpLm08nzIpN3hEDHqhS/Q1JIy8x0Q
         FcDK76S7KxRBXqRaUKHltR3dFGPB27bgqzHotNXLMFdT0aDcJphqE1THlsN/eNC6H7Nw
         pqu+/QysUCByvS9Ill0+/nPy2FuGsfvpIXjONzMiyNOLvKneqfM3Dw/3F4GAQz+BdVgQ
         Ow1w==
X-Gm-Message-State: AOAM531EwLEoqTl+23q8BtoGqUp3j5nviVgNuNBgQaGeyKdQ9/flrO75
        731U6r6Wf6RZ+fUXrOcWZ/8oYVusavvWaN5g+EAzEg==
X-Google-Smtp-Source: ABdhPJy2ai/lej1qC5BZRChBXzPs4W4jLS9cf2v1SktkjbCfKVjE5kg0b+9l6Ge/ZUXfNt+pf5frq/Q38Eyg/QJ1mng=
X-Received: by 2002:aca:1906:: with SMTP id l6mr2158846oii.101.1612363321479;
 Wed, 03 Feb 2021 06:42:01 -0800 (PST)
MIME-Version: 1.0
References: <58e41b62-b8e0-b036-c87d-a84d53f5a26e@amd.com> <CAKMK7uGTFYWnBG+JtbAK=zQVT1dT=nKor_SHP-t958oebgn8_A@mail.gmail.com>
 <fa170c5c-2f46-58ef-6847-e0bc9907fc8b@amd.com> <CAKMK7uE8qNUSNpX3TS6Fgif-6rCc7uZth_-F-kYPrOUSz5K3_A@mail.gmail.com>
 <CAH1Ww+QhiKYOJTWAigDhC761EhqeCUuh_bdZn=r4DAcEcb5Yyw@mail.gmail.com>
 <CAH1Ww+Q=9TnxB2QW1=wb-NAoYmt0_+DueFj8vowqPjPFe_Cw8w@mail.gmail.com>
 <538682ee-3e12-a345-2205-2c0f16b496ff@gmail.com> <YBqWCgTPTLomYvAt@phenom.ffwll.local>
 <e34c8d2a-aded-a3be-334a-2adc4d552373@amd.com> <CADnq5_NA2oGMyP8b0qNH9kmuYD4+A70pkw41uGErRDOvzF0RxA@mail.gmail.com>
 <YBqytmXrUNL6BQIa@phenom.ffwll.local> <20210203143306.6185044.76520.552644@amd.com>
In-Reply-To: <20210203143306.6185044.76520.552644@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 3 Feb 2021 15:41:50 +0100
Message-ID: <CAKMK7uGkJea-5YL8C0AYQ+nm9C6Ep10is+A0YAOFrGfUKGqpDA@mail.gmail.com>
Subject: Re: [amdgpu] deadlock
To:     "Bridgman, John" <John.Bridgman@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Daniel Gomez <daniel@qtec.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 3:33 PM Bridgman, John <John.Bridgman@amd.com> wrote=
:
>
> =E2=80=8E>>Uh, that doesn't work. If you want infinite compute queues you=
 need the
> amdkfd model with preempt-ctx dma_fence. If you allow normal cs ioctl to
> run forever, you just hang the kernel whenever userspace feels like. Not
> just the gpu, the kernel (anything that allocates memory, irrespective of
> process can hang). That's no good.
>
> We have moved from using gfx paths to using kfd paths as of the 20.45 rel=
ease a couple of months ago. Not sure if that applies to APU's yet but if n=
ot I would expect it to just be a matter of time.

Yeah but that still leaves a DOS attack open. I think we have to
change the reset timeout for compute kernels to something reasonable
to close that (and eat some of the angry bug reporters and politely
tell them to pls upgrade). Hanging gpu's is kinda fine (but shouldn't
affect other process really, if at all possible), hanging kernels at
large not so much.
-Daniel

> Thanks,
> John
>   Original Message
> From: Daniel Vetter
> Sent: Wednesday, February 3, 2021 9:27 AM
> To: Alex Deucher
> Cc: Linux Kernel Mailing List; dri-devel; amd-gfx list; Deucher, Alexande=
r; Daniel Gomez; Koenig, Christian
> Subject: Re: [amdgpu] deadlock
>
>
> On Wed, Feb 03, 2021 at 08:56:17AM -0500, Alex Deucher wrote:
> > On Wed, Feb 3, 2021 at 7:30 AM Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> > >
> > > Am 03.02.21 um 13:24 schrieb Daniel Vetter:
> > > > On Wed, Feb 03, 2021 at 01:21:20PM +0100, Christian K=C3=B6nig wrot=
e:
> > > >> Am 03.02.21 um 12:45 schrieb Daniel Gomez:
> > > >>> On Wed, 3 Feb 2021 at 10:47, Daniel Gomez <daniel@qtec.com> wrote=
:
> > > >>>> On Wed, 3 Feb 2021 at 10:17, Daniel Vetter <daniel@ffwll.ch> wro=
te:
> > > >>>>> On Wed, Feb 3, 2021 at 9:51 AM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> > > >>>>>> Am 03.02.21 um 09:48 schrieb Daniel Vetter:
> > > >>>>>>> On Wed, Feb 3, 2021 at 9:36 AM Christian K=C3=B6nig <christia=
n.koenig@amd.com> wrote:
> > > >>>>>>>> Hi Daniel,
> > > >>>>>>>>
> > > >>>>>>>> this is not a deadlock, but rather a hardware lockup.
> > > >>>>>>> Are you sure? Ime getting stuck in dma_fence_wait has general=
ly good
> > > >>>>>>> chance of being a dma_fence deadlock. GPU hang should never r=
esult in
> > > >>>>>>> a forever stuck dma_fence.
> > > >>>>>> Yes, I'm pretty sure. Otherwise the hardware clocks wouldn't g=
o up like
> > > >>>>>> this.
> > > >>>>> Maybe clarifying, could be both. TDR should notice and get us o=
ut of
> > > >>>>> this, but if there's a dma_fence deadlock and we can't re-emit =
or
> > > >>>>> force complete the pending things, then we're stuck for good.
> > > >>>>> -Daniel
> > > >>>>>
> > > >>>>>> Question is rather why we end up in the userptr handling for G=
FX? Our
> > > >>>>>> ROCm OpenCL stack shouldn't use this.
> > > >>>>>>
> > > >>>>>>> Daniel, can you pls re-hang your machine and then dump backtr=
aces of
> > > >>>>>>> all tasks into dmesg with sysrq-t, and then attach that? With=
out all
> > > >>>>>>> the backtraces it's tricky to construct the full dependency c=
hain of
> > > >>>>>>> what's going on. Also is this plain -rc6, not some more patch=
es on
> > > >>>>>>> top?
> > > >>>>>> Yeah, that's still a good idea to have.
> > > >>>> Here the full backtrace dmesg logs after the hang:
> > > >>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fpastebin.com%2Fraw%2Fkzivm2L3&amp;data=3D04%7C01%7Cjohn.bridgman%40amd.=
com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637479592320075525%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dz5%2FBK1akJi=
7%2BGrUZOA8cmyN7uOAn02ckU4tv1EprVQk%3D&amp;reserved=3D0
> > > >>>>
> > > >>>> This is another dmesg log with the backtraces after SIGKILL the =
matrix process:
> > > >>>> (I didn't have the sysrq enable at the time):
> > > >>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Fpastebin.com%2Fraw%2FpRBwGcj1&amp;data=3D04%7C01%7Cjohn.bridgman%40amd.=
com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe4884e608e11a82d994e183d%7=
C0%7C0%7C637479592320075525%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ=
QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTPt%2BS8l6%2=
Boza78KQwGplTf%2FHj5guCctbJGq3WiioIGg%3D&amp;reserved=3D0
> > > >>> I've now removed all our v4l2 patches and did the same test with =
the 'plain'
> > > >>> mainline version (-rc6).
> > > >>>
> > > >>> Reference: 3aaf0a27ffc29b19a62314edd684b9bc6346f9a8
> > > >>>
> > > >>> Same error, same behaviour. Full dmesg log attached:
> > > >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fpastebin.com%2Fraw%2FKgaEf7Y1&amp;data=3D04%7C01%7Cjohn.bridgman%40amd.c=
om%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe4884e608e11a82d994e183d%7C=
0%7C0%7C637479592320075525%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ=
IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DwG%2Bex7ZOJWd=
%2B4ZQyhJA%2BHTVbzZXC2lRPSvzYfZlzwIY%3D&amp;reserved=3D0
> > > >>> Note:
> > > >>>     dmesg with sysrq-t before running the test starts in [  122.0=
16502]
> > > >>> sysrq: Show State
> > > >>>     dmesg with sysrq-t after the test starts in: [  495.587671] s=
ysrq: Show State
> > > >> There is nothing amdgpu related in there except for waiting for th=
e
> > > >> hardware.
> > > > Yeah, but there's also no other driver that could cause a stuck dma=
_fence,
> > > > so why is reset not cleaning up the mess here? Irrespective of why =
the gpu
> > > > is stuck, the kernel should at least complete all the dma_fences ev=
en if
> > > > the gpu for some reason is terminally ill ...
> > >
> > > That's a good question as well. I'm digging into this.
> > >
> > > My best theory is that the amdgpu packages disabled GPU reset for som=
e
> > > reason.
> >
> > The timeout for compute queues is infinite because of long running
> > compute kernels.  You can override with the amdgpu.lockup_timeout
> > parameter.
>
> Uh, that doesn't work. If you want infinite compute queues you need the
> amdkfd model with preempt-ctx dma_fence. If you allow normal cs ioctl to
> run forever, you just hang the kernel whenever userspace feels like. Not
> just the gpu, the kernel (anything that allocates memory, irrespective of
> process can hang). That's no good.
> -Daniel
>
> >
> > Alex
> >
> > >
> > > But the much more interesting question is why we end up in this call
> > > path. I've pinged internally, but east coast is not awake yet :)
> > >
> > > Christian.
> > >
> > > > -Daniel
> > > >
> > > >> This is a pretty standard hardware lockup, but I'm still waiting f=
or an
> > > >> explanation why we end up in this call path in the first place.
> > > >>
> > > >> Christian.
> > > >>
> > > >>>
> > > >>>>>> Christian.
> > > >>>>>>
> > > >>>>>>> -Daniel
> > > >>>>>>>
> > > >>>>>>>> Which OpenCl stack are you using?
> > > >>>>>>>>
> > > >>>>>>>> Regards,
> > > >>>>>>>> Christian.
> > > >>>>>>>>
> > > >>>>>>>> Am 03.02.21 um 09:33 schrieb Daniel Gomez:
> > > >>>>>>>>> Hi all,
> > > >>>>>>>>>
> > > >>>>>>>>> I have a deadlock with the amdgpu mainline driver when runn=
ing in parallel two
> > > >>>>>>>>> OpenCL applications. So far, we've been able to replicate i=
t easily by executing
> > > >>>>>>>>> clinfo and MatrixMultiplication (from AMD opencl-samples). =
It's quite old the
> > > >>>>>>>>> opencl-samples so, if you have any other suggestion for tes=
ting I'd be very
> > > >>>>>>>>> happy to test it as well.
> > > >>>>>>>>>
> > > >>>>>>>>> How to replicate the issue:
> > > >>>>>>>>>
> > > >>>>>>>>> # while true; do /usr/bin/MatrixMultiplication --device gpu=
 \
> > > >>>>>>>>>         --deviceId 0 -x 1000 -y 1000 -z 1000 -q -t -i 50; d=
one
> > > >>>>>>>>> # while true; do clinfo; done
> > > >>>>>>>>>
> > > >>>>>>>>> Output:
> > > >>>>>>>>>
> > > >>>>>>>>> After a minute or less (sometimes could be more) I can see =
that
> > > >>>>>>>>> MatrixMultiplication and clinfo hang. In addition, with rad=
eontop you can see
> > > >>>>>>>>> how the Graphics pipe goes from ~50% to 100%. Also the shad=
er clocks
> > > >>>>>>>>> goes up from ~35% to ~96%.
> > > >>>>>>>>>
> > > >>>>>>>>> clinfo keeps printing:
> > > >>>>>>>>> ioctl(7, DRM_IOCTL_SYNCOBJ_WAIT, 0x7ffe46e5f950) =3D -1 ETI=
ME (Timer expired)
> > > >>>>>>>>>
> > > >>>>>>>>> And MatrixMultiplication prints the following (strace) if y=
ou try to
> > > >>>>>>>>> kill the process:
> > > >>>>>>>>>
> > > >>>>>>>>> sched_yield()                           =3D 0
> > > >>>>>>>>> futex(0x557e945343b8, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK=
_REALTIME, 0,
> > > >>>>>>>>> NULL, FUTEX_BITSET_MATCH_ANYstrace: Process 651 detached
> > > >>>>>>>>>      <detached ...>
> > > >>>>>>>>>
> > > >>>>>>>>> After this, the gpu is not functional at all and you'd need=
 a power cycle reset
> > > >>>>>>>>> to restore the system.
> > > >>>>>>>>>
> > > >>>>>>>>> Hardware info:
> > > >>>>>>>>> CPU: AMD Ryzen Embedded V1605B with Radeon Vega Gfx (8) @ 2=
.000GHz
> > > >>>>>>>>> GPU: AMD ATI Radeon Vega Series / Radeon Vega Mobile Series
> > > >>>>>>>>>
> > > >>>>>>>>> 03:00.0 VGA compatible controller: Advanced Micro Devices, =
Inc.
> > > >>>>>>>>> [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mob=
ile Series]
> > > >>>>>>>>> (rev 83)
> > > >>>>>>>>>         DeviceName: Broadcom 5762
> > > >>>>>>>>>         Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] R=
aven Ridge
> > > >>>>>>>>> [Radeon Vega Series / Radeon Vega Mobile Series]
> > > >>>>>>>>>         Kernel driver in use: amdgpu
> > > >>>>>>>>>         Kernel modules: amdgpu
> > > >>>>>>>>>
> > > >>>>>>>>> Linux kernel info:
> > > >>>>>>>>>
> > > >>>>>>>>> root@qt5222:~# uname -a
> > > >>>>>>>>> Linux qt5222 5.11.0-rc6-qtec-standard #2 SMP Tue Feb 2 09:4=
1:46 UTC
> > > >>>>>>>>> 2021 x86_64 x86_64 x86_64 GNU/Linux
> > > >>>>>>>>>
> > > >>>>>>>>> By enabling the kernel locks stats I could see the MatrixMu=
ltiplication is
> > > >>>>>>>>> hanged in the amdgpu_mn_invalidate_gfx function:
> > > >>>>>>>>>
> > > >>>>>>>>> [  738.359202] 1 lock held by MatrixMultiplic/653:
> > > >>>>>>>>> [  738.359206]  #0: ffff88810e364fe0
> > > >>>>>>>>> (&adev->notifier_lock){+.+.}-{3:3}, at:
> > > >>>>>>>>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> > > >>>>>>>>>
> > > >>>>>>>>> I can see in the the amdgpu_mn_invalidate_gfx function: the
> > > >>>>>>>>> dma_resv_wait_timeout_rcu uses wait_all (fences) and MAX_SC=
HEDULE_TIMEOUT so, I
> > > >>>>>>>>> guess the code gets stuck there waiting forever. According =
to the
> > > >>>>>>>>> documentation: "When somebody tries to invalidate the page =
tables we block the
> > > >>>>>>>>> update until all operations on the pages in question are co=
mpleted, then those
> > > >>>>>>>>> pages are marked  as accessed and also dirty if it wasn=E2=
=80=99t a read only access."
> > > >>>>>>>>> Looks like the fences are deadlocked and therefore, it neve=
r returns. Could it
> > > >>>>>>>>> be possible? any hint to where can I look to fix this?
> > > >>>>>>>>>
> > > >>>>>>>>> Thank you  in advance.
> > > >>>>>>>>>
> > > >>>>>>>>> Here the full dmesg output:
> > > >>>>>>>>>
> > > >>>>>>>>> [  738.337726] INFO: task MatrixMultiplic:653 blocked for m=
ore than 122 seconds.
> > > >>>>>>>>> [  738.344937]       Not tainted 5.11.0-rc6-qtec-standard #=
2
> > > >>>>>>>>> [  738.350384] "echo 0 > /proc/sys/kernel/hung_task_timeout=
_secs"
> > > >>>>>>>>> disables this message.
> > > >>>>>>>>> [  738.358240] task:MatrixMultiplic state:D stack:    0 pid=
:  653
> > > >>>>>>>>> ppid:     1 flags:0x00004000
> > > >>>>>>>>> [  738.358254] Call Trace:
> > > >>>>>>>>> [  738.358261]  ? dma_fence_default_wait+0x1eb/0x230
> > > >>>>>>>>> [  738.358276]  __schedule+0x370/0x960
> > > >>>>>>>>> [  738.358291]  ? dma_fence_default_wait+0x117/0x230
> > > >>>>>>>>> [  738.358297]  ? dma_fence_default_wait+0x1eb/0x230
> > > >>>>>>>>> [  738.358305]  schedule+0x51/0xc0
> > > >>>>>>>>> [  738.358312]  schedule_timeout+0x275/0x380
> > > >>>>>>>>> [  738.358324]  ? dma_fence_default_wait+0x1eb/0x230
> > > >>>>>>>>> [  738.358332]  ? mark_held_locks+0x4f/0x70
> > > >>>>>>>>> [  738.358341]  ? dma_fence_default_wait+0x117/0x230
> > > >>>>>>>>> [  738.358347]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> > > >>>>>>>>> [  738.358353]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> > > >>>>>>>>> [  738.358362]  ? dma_fence_default_wait+0x117/0x230
> > > >>>>>>>>> [  738.358370]  ? dma_fence_default_wait+0x1eb/0x230
> > > >>>>>>>>> [  738.358375]  dma_fence_default_wait+0x214/0x230
> > > >>>>>>>>> [  738.358384]  ? dma_fence_release+0x1a0/0x1a0
> > > >>>>>>>>> [  738.358396]  dma_fence_wait_timeout+0x105/0x200
> > > >>>>>>>>> [  738.358405]  dma_resv_wait_timeout_rcu+0x1aa/0x5e0
> > > >>>>>>>>> [  738.358421]  amdgpu_mn_invalidate_gfx+0x55/0xa0 [amdgpu]
> > > >>>>>>>>> [  738.358688]  __mmu_notifier_release+0x1bb/0x210
> > > >>>>>>>>> [  738.358710]  exit_mmap+0x2f/0x1e0
> > > >>>>>>>>> [  738.358723]  ? find_held_lock+0x34/0xa0
> > > >>>>>>>>> [  738.358746]  mmput+0x39/0xe0
> > > >>>>>>>>> [  738.358756]  do_exit+0x5c3/0xc00
> > > >>>>>>>>> [  738.358763]  ? find_held_lock+0x34/0xa0
> > > >>>>>>>>> [  738.358780]  do_group_exit+0x47/0xb0
> > > >>>>>>>>> [  738.358791]  get_signal+0x15b/0xc50
> > > >>>>>>>>> [  738.358807]  arch_do_signal_or_restart+0xaf/0x710
> > > >>>>>>>>> [  738.358816]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> > > >>>>>>>>> [  738.358822]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> > > >>>>>>>>> [  738.358831]  ? ktime_get_mono_fast_ns+0x50/0xa0
> > > >>>>>>>>> [  738.358844]  ? amdgpu_drm_ioctl+0x6b/0x80 [amdgpu]
> > > >>>>>>>>> [  738.359044]  exit_to_user_mode_prepare+0xf2/0x1b0
> > > >>>>>>>>> [  738.359054]  syscall_exit_to_user_mode+0x19/0x60
> > > >>>>>>>>> [  738.359062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > >>>>>>>>> [  738.359069] RIP: 0033:0x7f6b89a51887
> > > >>>>>>>>> [  738.359076] RSP: 002b:00007f6b82b54b18 EFLAGS: 00000246 =
ORIG_RAX:
> > > >>>>>>>>> 0000000000000010
> > > >>>>>>>>> [  738.359086] RAX: fffffffffffffe00 RBX: 00007f6b82b54b50 =
RCX: 00007f6b89a51887
> > > >>>>>>>>> [  738.359091] RDX: 00007f6b82b54b50 RSI: 00000000c02064c3 =
RDI: 0000000000000007
> > > >>>>>>>>> [  738.359096] RBP: 00000000c02064c3 R08: 0000000000000003 =
R09: 00007f6b82b54bbc
> > > >>>>>>>>> [  738.359101] R10: 0000000000000001 R11: 0000000000000246 =
R12: 0000000165a0bc00
> > > >>>>>>>>> [  738.359106] R13: 0000000000000007 R14: 0000000000000001 =
R15: 0000000000000000
> > > >>>>>>>>> [  738.359129]
> > > >>>>>>>>>                    Showing all locks held in the system:
> > > >>>>>>>>> [  738.359141] 1 lock held by khungtaskd/54:
> > > >>>>>>>>> [  738.359148]  #0: ffffffff829f6840 (rcu_read_lock){....}-=
{1:2}, at:
> > > >>>>>>>>> debug_show_all_locks+0x15/0x183
> > > >>>>>>>>> [  738.359187] 1 lock held by systemd-journal/174:
> > > >>>>>>>>> [  738.359202] 1 lock held by MatrixMultiplic/653:
> > > >>>>>>>>> [  738.359206]  #0: ffff88810e364fe0
> > > >>>>>>>>> (&adev->notifier_lock){+.+.}-{3:3}, at:
> > > >>>>>>>>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> > > >>>>>>>>>
> > > >>>>>>>>> Daniel
> > > >>>>>>>> _______________________________________________
> > > >>>>>>>> dri-devel mailing list
> > > >>>>>>>> dri-devel@lists.freedesktop.org
> > > >>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D0=
4%7C01%7Cjohn.bridgman%40amd.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd89=
61fe4884e608e11a82d994e183d%7C0%7C0%7C637479592320075525%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
1000&amp;sdata=3D5lN%2Fc2Kncy31PnJEJIUC%2BFAItXAmXAtKAHp%2F6d%2Burgo%3D&amp=
;reserved=3D0
> > > >>>>> --
> > > >>>>> Daniel Vetter
> > > >>>>> Software Engineer, Intel Corporation
> > > >>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2=
F%2Fblog.ffwll.ch%2F&amp;data=3D04%7C01%7Cjohn.bridgman%40amd.com%7Cbe4d564=
2b52242dd9fdb08d8c84fca13%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6374=
79592320085517%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi=
LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DE6uF1FUrp9RSryVDLD1zIPaMF=
JU5aP5xvx7F9Mgf53s%3D&amp;reserved=3D0
> > > >>> _______________________________________________
> > > >>> amd-gfx mailing list
> > > >>> amd-gfx@lists.freedesktop.org
> > > >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%=
7Cjohn.bridgman%40amd.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637479592320085517%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am=
p;sdata=3DsXukJnECw3PKXuY9V4JeUQtn86qH7EHHjHZ9brfILK0%3D&amp;reserved=3D0
> > >
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D04%7C01%7C=
john.bridgman%40amd.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637479592320085517%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;=
sdata=3D2OSwOUbIkoQYy%2F5JGiDyNEK2oOFR%2FGFd9kiP65z15F0%3D&amp;reserved=3D0
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D04%7C01%7Cjo=
hn.bridgman%40amd.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637479592320085517%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd=
ata=3D2OSwOUbIkoQYy%2F5JGiDyNEK2oOFR%2FGFd9kiP65z15F0%3D&amp;reserved=3D0
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fblog.f=
fwll.ch%2F&amp;data=3D04%7C01%7Cjohn.bridgman%40amd.com%7Cbe4d5642b52242dd9=
fdb08d8c84fca13%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63747959232008=
5517%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik=
1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DE6uF1FUrp9RSryVDLD1zIPaMFJU5aP5xvx7=
F9Mgf53s%3D&amp;reserved=3D0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cjohn.b=
ridgman%40amd.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637479592320085517%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM=
C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DsXukJnECw3PKXuY9V4JeUQtn86qH7EHHjHZ9brfILK0%3D&amp;reserved=3D0



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
