Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE4A30E0AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhBCRP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhBCRPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:15:22 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34320C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 09:14:43 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id o12so526681ote.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 09:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6kqie61NFyAoFMh8uKiaVDiQqqY9fQce0n4ay65kf7E=;
        b=OqvOPNgRjN6WpgOB79LV785tURztuLq5xtq7Ow2sInC1huStyKzZcdUHjRGePieV4C
         yfZYfRelfoWGXQCEPUCQVk6GsazhCIrxGvvNdivKJ0MCwTOd8hZdezm7CajNqaPu4GsO
         4CdfPbABOmGP7RgciYtvlyjrp9WLQ/ocQ5dyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6kqie61NFyAoFMh8uKiaVDiQqqY9fQce0n4ay65kf7E=;
        b=BcZ4O5J8XsI9mwZuanznfNW49MiNvB25foDgT4MmGTjIg87NvWVtGBMoKu8wXWEU09
         o3jyRexjeO1eCo07eJczdN+SgLGs4DPhb7KsdlRRpdcF9DATLnRoA+TZ49uAU9tsKsRQ
         4bJ1d3hmvJQFlWnJewO3Aa5Y4Jzwvdk7gkk5S7P20JrydjBSDRGaPEC5X1yCEvVDfxeZ
         up9OX94T8WGoj8TVR50EfJCGRoCD8CY6SiOGMapnAO2IuvDQO2WpdVYYT5LFPHC9NWHl
         k25s1q6fd/anHgTnMLlNFua8ZBdjtARJLn9vvuwszAL0BZwdcQHz5O1GNurMQColWmTw
         jzBA==
X-Gm-Message-State: AOAM531q+T+QL74wDjyVFsV5CiUkytt4SBrjPETyefcLRXZIBAr9VHv4
        edKui+eVbk9GJknFe+xLoTL/by7men/NmPhzyUXQcg==
X-Google-Smtp-Source: ABdhPJyaPHSDti4Vh7Z7NtGD97kbazfkjKT9R+zfPBVtRxytfQv2cbl3ylVcZKBHA+fdaiA4I+i9qth3PlhbrQ1Jg/g=
X-Received: by 2002:a9d:b85:: with SMTP id 5mr2774577oth.281.1612372482573;
 Wed, 03 Feb 2021 09:14:42 -0800 (PST)
MIME-Version: 1.0
References: <58e41b62-b8e0-b036-c87d-a84d53f5a26e@amd.com> <CAKMK7uGTFYWnBG+JtbAK=zQVT1dT=nKor_SHP-t958oebgn8_A@mail.gmail.com>
 <fa170c5c-2f46-58ef-6847-e0bc9907fc8b@amd.com> <CAKMK7uE8qNUSNpX3TS6Fgif-6rCc7uZth_-F-kYPrOUSz5K3_A@mail.gmail.com>
 <CAH1Ww+QhiKYOJTWAigDhC761EhqeCUuh_bdZn=r4DAcEcb5Yyw@mail.gmail.com>
 <CAH1Ww+Q=9TnxB2QW1=wb-NAoYmt0_+DueFj8vowqPjPFe_Cw8w@mail.gmail.com>
 <538682ee-3e12-a345-2205-2c0f16b496ff@gmail.com> <YBqWCgTPTLomYvAt@phenom.ffwll.local>
 <e34c8d2a-aded-a3be-334a-2adc4d552373@amd.com> <CADnq5_NA2oGMyP8b0qNH9kmuYD4+A70pkw41uGErRDOvzF0RxA@mail.gmail.com>
 <YBqytmXrUNL6BQIa@phenom.ffwll.local> <20210203143306.6185044.76520.552644@amd.com>
 <CAKMK7uGkJea-5YL8C0AYQ+nm9C6Ep10is+A0YAOFrGfUKGqpDA@mail.gmail.com> <CADnq5_M+HkZ-r_nfwWkZaea8BP5XCM=gt+ws1UmOtwT_R7ui7w@mail.gmail.com>
In-Reply-To: <CADnq5_M+HkZ-r_nfwWkZaea8BP5XCM=gt+ws1UmOtwT_R7ui7w@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 3 Feb 2021 18:14:31 +0100
Message-ID: <CAKMK7uHRiu175GvQ_oRWinJ91XeU8O6yp92YWxSzGgZth1vw2Q@mail.gmail.com>
Subject: Re: [amdgpu] deadlock
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Bridgman, John" <John.Bridgman@amd.com>,
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

On Wed, Feb 3, 2021 at 5:42 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Feb 3, 2021 at 9:42 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Feb 3, 2021 at 3:33 PM Bridgman, John <John.Bridgman@amd.com> w=
rote:
> > >
> > > =E2=80=8E>>Uh, that doesn't work. If you want infinite compute queues=
 you need the
> > > amdkfd model with preempt-ctx dma_fence. If you allow normal cs ioctl=
 to
> > > run forever, you just hang the kernel whenever userspace feels like. =
Not
> > > just the gpu, the kernel (anything that allocates memory, irrespectiv=
e of
> > > process can hang). That's no good.
> > >
> > > We have moved from using gfx paths to using kfd paths as of the 20.45=
 release a couple of months ago. Not sure if that applies to APU's yet but =
if not I would expect it to just be a matter of time.
> >
> > Yeah but that still leaves a DOS attack open. I think we have to
> > change the reset timeout for compute kernels to something reasonable
> > to close that (and eat some of the angry bug reporters and politely
> > tell them to pls upgrade). Hanging gpu's is kinda fine (but shouldn't
> > affect other process really, if at all possible), hanging kernels at
> > large not so much.
>
> This can also potentially affect long running Vulkan or OpenGL compute
> kernels.  Not sure we have a good solution for them.  People are
> starting to build ML stuff on vulkan.

Yeah they need the compute mode with userspace fences and long running
batches for that. It wont work on legacy implict synced cs, at least
not with major surgery. That's why I asked whether the entirely
separate amdkfd world for compute is really such a great idea, since I
expect it'll come and bite us pretty bad.

Fundamentally you can't have indefinite fences with implicit synced
CS, and long running jobs is just one of these indefinite fences.
-Daniel

>
> Alex
>
>
> > -Daniel
> >
> > > Thanks,
> > > John
> > >   Original Message
> > > From: Daniel Vetter
> > > Sent: Wednesday, February 3, 2021 9:27 AM
> > > To: Alex Deucher
> > > Cc: Linux Kernel Mailing List; dri-devel; amd-gfx list; Deucher, Alex=
ander; Daniel Gomez; Koenig, Christian
> > > Subject: Re: [amdgpu] deadlock
> > >
> > >
> > > On Wed, Feb 03, 2021 at 08:56:17AM -0500, Alex Deucher wrote:
> > > > On Wed, Feb 3, 2021 at 7:30 AM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
> > > > >
> > > > > Am 03.02.21 um 13:24 schrieb Daniel Vetter:
> > > > > > On Wed, Feb 03, 2021 at 01:21:20PM +0100, Christian K=C3=B6nig =
wrote:
> > > > > >> Am 03.02.21 um 12:45 schrieb Daniel Gomez:
> > > > > >>> On Wed, 3 Feb 2021 at 10:47, Daniel Gomez <daniel@qtec.com> w=
rote:
> > > > > >>>> On Wed, 3 Feb 2021 at 10:17, Daniel Vetter <daniel@ffwll.ch>=
 wrote:
> > > > > >>>>> On Wed, Feb 3, 2021 at 9:51 AM Christian K=C3=B6nig <christ=
ian.koenig@amd.com> wrote:
> > > > > >>>>>> Am 03.02.21 um 09:48 schrieb Daniel Vetter:
> > > > > >>>>>>> On Wed, Feb 3, 2021 at 9:36 AM Christian K=C3=B6nig <chri=
stian.koenig@amd.com> wrote:
> > > > > >>>>>>>> Hi Daniel,
> > > > > >>>>>>>>
> > > > > >>>>>>>> this is not a deadlock, but rather a hardware lockup.
> > > > > >>>>>>> Are you sure? Ime getting stuck in dma_fence_wait has gen=
erally good
> > > > > >>>>>>> chance of being a dma_fence deadlock. GPU hang should nev=
er result in
> > > > > >>>>>>> a forever stuck dma_fence.
> > > > > >>>>>> Yes, I'm pretty sure. Otherwise the hardware clocks wouldn=
't go up like
> > > > > >>>>>> this.
> > > > > >>>>> Maybe clarifying, could be both. TDR should notice and get =
us out of
> > > > > >>>>> this, but if there's a dma_fence deadlock and we can't re-e=
mit or
> > > > > >>>>> force complete the pending things, then we're stuck for goo=
d.
> > > > > >>>>> -Daniel
> > > > > >>>>>
> > > > > >>>>>> Question is rather why we end up in the userptr handling f=
or GFX? Our
> > > > > >>>>>> ROCm OpenCL stack shouldn't use this.
> > > > > >>>>>>
> > > > > >>>>>>> Daniel, can you pls re-hang your machine and then dump ba=
cktraces of
> > > > > >>>>>>> all tasks into dmesg with sysrq-t, and then attach that? =
Without all
> > > > > >>>>>>> the backtraces it's tricky to construct the full dependen=
cy chain of
> > > > > >>>>>>> what's going on. Also is this plain -rc6, not some more p=
atches on
> > > > > >>>>>>> top?
> > > > > >>>>>> Yeah, that's still a good idea to have.
> > > > > >>>> Here the full backtrace dmesg logs after the hang:
> > > > > >>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fpastebin.com%2Fraw%2Fkzivm2L3&amp;data=3D04%7C01%7Cjohn.bridgman%40=
amd.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637479592320075525%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA=
iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dz5%2FBK1=
akJi7%2BGrUZOA8cmyN7uOAn02ckU4tv1EprVQk%3D&amp;reserved=3D0
> > > > > >>>>
> > > > > >>>> This is another dmesg log with the backtraces after SIGKILL =
the matrix process:
> > > > > >>>> (I didn't have the sysrq enable at the time):
> > > > > >>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%=
3A%2F%2Fpastebin.com%2Fraw%2FpRBwGcj1&amp;data=3D04%7C01%7Cjohn.bridgman%40=
amd.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe4884e608e11a82d994e18=
3d%7C0%7C0%7C637479592320075525%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA=
iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DTPt%2BS8=
l6%2Boza78KQwGplTf%2FHj5guCctbJGq3WiioIGg%3D&amp;reserved=3D0
> > > > > >>> I've now removed all our v4l2 patches and did the same test w=
ith the 'plain'
> > > > > >>> mainline version (-rc6).
> > > > > >>>
> > > > > >>> Reference: 3aaf0a27ffc29b19a62314edd684b9bc6346f9a8
> > > > > >>>
> > > > > >>> Same error, same behaviour. Full dmesg log attached:
> > > > > >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Fpastebin.com%2Fraw%2FKgaEf7Y1&amp;data=3D04%7C01%7Cjohn.bridgman%40a=
md.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe4884e608e11a82d994e183=
d%7C0%7C0%7C637479592320075525%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi=
LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DwG%2Bex7Z=
OJWd%2B4ZQyhJA%2BHTVbzZXC2lRPSvzYfZlzwIY%3D&amp;reserved=3D0
> > > > > >>> Note:
> > > > > >>>     dmesg with sysrq-t before running the test starts in [  1=
22.016502]
> > > > > >>> sysrq: Show State
> > > > > >>>     dmesg with sysrq-t after the test starts in: [  495.58767=
1] sysrq: Show State
> > > > > >> There is nothing amdgpu related in there except for waiting fo=
r the
> > > > > >> hardware.
> > > > > > Yeah, but there's also no other driver that could cause a stuck=
 dma_fence,
> > > > > > so why is reset not cleaning up the mess here? Irrespective of =
why the gpu
> > > > > > is stuck, the kernel should at least complete all the dma_fence=
s even if
> > > > > > the gpu for some reason is terminally ill ...
> > > > >
> > > > > That's a good question as well. I'm digging into this.
> > > > >
> > > > > My best theory is that the amdgpu packages disabled GPU reset for=
 some
> > > > > reason.
> > > >
> > > > The timeout for compute queues is infinite because of long running
> > > > compute kernels.  You can override with the amdgpu.lockup_timeout
> > > > parameter.
> > >
> > > Uh, that doesn't work. If you want infinite compute queues you need t=
he
> > > amdkfd model with preempt-ctx dma_fence. If you allow normal cs ioctl=
 to
> > > run forever, you just hang the kernel whenever userspace feels like. =
Not
> > > just the gpu, the kernel (anything that allocates memory, irrespectiv=
e of
> > > process can hang). That's no good.
> > > -Daniel
> > >
> > > >
> > > > Alex
> > > >
> > > > >
> > > > > But the much more interesting question is why we end up in this c=
all
> > > > > path. I've pinged internally, but east coast is not awake yet :)
> > > > >
> > > > > Christian.
> > > > >
> > > > > > -Daniel
> > > > > >
> > > > > >> This is a pretty standard hardware lockup, but I'm still waiti=
ng for an
> > > > > >> explanation why we end up in this call path in the first place=
.
> > > > > >>
> > > > > >> Christian.
> > > > > >>
> > > > > >>>
> > > > > >>>>>> Christian.
> > > > > >>>>>>
> > > > > >>>>>>> -Daniel
> > > > > >>>>>>>
> > > > > >>>>>>>> Which OpenCl stack are you using?
> > > > > >>>>>>>>
> > > > > >>>>>>>> Regards,
> > > > > >>>>>>>> Christian.
> > > > > >>>>>>>>
> > > > > >>>>>>>> Am 03.02.21 um 09:33 schrieb Daniel Gomez:
> > > > > >>>>>>>>> Hi all,
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> I have a deadlock with the amdgpu mainline driver when =
running in parallel two
> > > > > >>>>>>>>> OpenCL applications. So far, we've been able to replica=
te it easily by executing
> > > > > >>>>>>>>> clinfo and MatrixMultiplication (from AMD opencl-sample=
s). It's quite old the
> > > > > >>>>>>>>> opencl-samples so, if you have any other suggestion for=
 testing I'd be very
> > > > > >>>>>>>>> happy to test it as well.
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> How to replicate the issue:
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> # while true; do /usr/bin/MatrixMultiplication --device=
 gpu \
> > > > > >>>>>>>>>         --deviceId 0 -x 1000 -y 1000 -z 1000 -q -t -i 5=
0; done
> > > > > >>>>>>>>> # while true; do clinfo; done
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> Output:
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> After a minute or less (sometimes could be more) I can =
see that
> > > > > >>>>>>>>> MatrixMultiplication and clinfo hang. In addition, with=
 radeontop you can see
> > > > > >>>>>>>>> how the Graphics pipe goes from ~50% to 100%. Also the =
shader clocks
> > > > > >>>>>>>>> goes up from ~35% to ~96%.
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> clinfo keeps printing:
> > > > > >>>>>>>>> ioctl(7, DRM_IOCTL_SYNCOBJ_WAIT, 0x7ffe46e5f950) =3D -1=
 ETIME (Timer expired)
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> And MatrixMultiplication prints the following (strace) =
if you try to
> > > > > >>>>>>>>> kill the process:
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> sched_yield()                           =3D 0
> > > > > >>>>>>>>> futex(0x557e945343b8, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_C=
LOCK_REALTIME, 0,
> > > > > >>>>>>>>> NULL, FUTEX_BITSET_MATCH_ANYstrace: Process 651 detache=
d
> > > > > >>>>>>>>>      <detached ...>
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> After this, the gpu is not functional at all and you'd =
need a power cycle reset
> > > > > >>>>>>>>> to restore the system.
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> Hardware info:
> > > > > >>>>>>>>> CPU: AMD Ryzen Embedded V1605B with Radeon Vega Gfx (8)=
 @ 2.000GHz
> > > > > >>>>>>>>> GPU: AMD ATI Radeon Vega Series / Radeon Vega Mobile Se=
ries
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> 03:00.0 VGA compatible controller: Advanced Micro Devic=
es, Inc.
> > > > > >>>>>>>>> [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega=
 Mobile Series]
> > > > > >>>>>>>>> (rev 83)
> > > > > >>>>>>>>>         DeviceName: Broadcom 5762
> > > > > >>>>>>>>>         Subsystem: Advanced Micro Devices, Inc. [AMD/AT=
I] Raven Ridge
> > > > > >>>>>>>>> [Radeon Vega Series / Radeon Vega Mobile Series]
> > > > > >>>>>>>>>         Kernel driver in use: amdgpu
> > > > > >>>>>>>>>         Kernel modules: amdgpu
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> Linux kernel info:
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> root@qt5222:~# uname -a
> > > > > >>>>>>>>> Linux qt5222 5.11.0-rc6-qtec-standard #2 SMP Tue Feb 2 =
09:41:46 UTC
> > > > > >>>>>>>>> 2021 x86_64 x86_64 x86_64 GNU/Linux
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> By enabling the kernel locks stats I could see the Matr=
ixMultiplication is
> > > > > >>>>>>>>> hanged in the amdgpu_mn_invalidate_gfx function:
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> [  738.359202] 1 lock held by MatrixMultiplic/653:
> > > > > >>>>>>>>> [  738.359206]  #0: ffff88810e364fe0
> > > > > >>>>>>>>> (&adev->notifier_lock){+.+.}-{3:3}, at:
> > > > > >>>>>>>>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> I can see in the the amdgpu_mn_invalidate_gfx function:=
 the
> > > > > >>>>>>>>> dma_resv_wait_timeout_rcu uses wait_all (fences) and MA=
X_SCHEDULE_TIMEOUT so, I
> > > > > >>>>>>>>> guess the code gets stuck there waiting forever. Accord=
ing to the
> > > > > >>>>>>>>> documentation: "When somebody tries to invalidate the p=
age tables we block the
> > > > > >>>>>>>>> update until all operations on the pages in question ar=
e completed, then those
> > > > > >>>>>>>>> pages are marked  as accessed and also dirty if it wasn=
=E2=80=99t a read only access."
> > > > > >>>>>>>>> Looks like the fences are deadlocked and therefore, it =
never returns. Could it
> > > > > >>>>>>>>> be possible? any hint to where can I look to fix this?
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> Thank you  in advance.
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> Here the full dmesg output:
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> [  738.337726] INFO: task MatrixMultiplic:653 blocked f=
or more than 122 seconds.
> > > > > >>>>>>>>> [  738.344937]       Not tainted 5.11.0-rc6-qtec-standa=
rd #2
> > > > > >>>>>>>>> [  738.350384] "echo 0 > /proc/sys/kernel/hung_task_tim=
eout_secs"
> > > > > >>>>>>>>> disables this message.
> > > > > >>>>>>>>> [  738.358240] task:MatrixMultiplic state:D stack:    0=
 pid:  653
> > > > > >>>>>>>>> ppid:     1 flags:0x00004000
> > > > > >>>>>>>>> [  738.358254] Call Trace:
> > > > > >>>>>>>>> [  738.358261]  ? dma_fence_default_wait+0x1eb/0x230
> > > > > >>>>>>>>> [  738.358276]  __schedule+0x370/0x960
> > > > > >>>>>>>>> [  738.358291]  ? dma_fence_default_wait+0x117/0x230
> > > > > >>>>>>>>> [  738.358297]  ? dma_fence_default_wait+0x1eb/0x230
> > > > > >>>>>>>>> [  738.358305]  schedule+0x51/0xc0
> > > > > >>>>>>>>> [  738.358312]  schedule_timeout+0x275/0x380
> > > > > >>>>>>>>> [  738.358324]  ? dma_fence_default_wait+0x1eb/0x230
> > > > > >>>>>>>>> [  738.358332]  ? mark_held_locks+0x4f/0x70
> > > > > >>>>>>>>> [  738.358341]  ? dma_fence_default_wait+0x117/0x230
> > > > > >>>>>>>>> [  738.358347]  ? lockdep_hardirqs_on_prepare+0xd4/0x18=
0
> > > > > >>>>>>>>> [  738.358353]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> > > > > >>>>>>>>> [  738.358362]  ? dma_fence_default_wait+0x117/0x230
> > > > > >>>>>>>>> [  738.358370]  ? dma_fence_default_wait+0x1eb/0x230
> > > > > >>>>>>>>> [  738.358375]  dma_fence_default_wait+0x214/0x230
> > > > > >>>>>>>>> [  738.358384]  ? dma_fence_release+0x1a0/0x1a0
> > > > > >>>>>>>>> [  738.358396]  dma_fence_wait_timeout+0x105/0x200
> > > > > >>>>>>>>> [  738.358405]  dma_resv_wait_timeout_rcu+0x1aa/0x5e0
> > > > > >>>>>>>>> [  738.358421]  amdgpu_mn_invalidate_gfx+0x55/0xa0 [amd=
gpu]
> > > > > >>>>>>>>> [  738.358688]  __mmu_notifier_release+0x1bb/0x210
> > > > > >>>>>>>>> [  738.358710]  exit_mmap+0x2f/0x1e0
> > > > > >>>>>>>>> [  738.358723]  ? find_held_lock+0x34/0xa0
> > > > > >>>>>>>>> [  738.358746]  mmput+0x39/0xe0
> > > > > >>>>>>>>> [  738.358756]  do_exit+0x5c3/0xc00
> > > > > >>>>>>>>> [  738.358763]  ? find_held_lock+0x34/0xa0
> > > > > >>>>>>>>> [  738.358780]  do_group_exit+0x47/0xb0
> > > > > >>>>>>>>> [  738.358791]  get_signal+0x15b/0xc50
> > > > > >>>>>>>>> [  738.358807]  arch_do_signal_or_restart+0xaf/0x710
> > > > > >>>>>>>>> [  738.358816]  ? lockdep_hardirqs_on_prepare+0xd4/0x18=
0
> > > > > >>>>>>>>> [  738.358822]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> > > > > >>>>>>>>> [  738.358831]  ? ktime_get_mono_fast_ns+0x50/0xa0
> > > > > >>>>>>>>> [  738.358844]  ? amdgpu_drm_ioctl+0x6b/0x80 [amdgpu]
> > > > > >>>>>>>>> [  738.359044]  exit_to_user_mode_prepare+0xf2/0x1b0
> > > > > >>>>>>>>> [  738.359054]  syscall_exit_to_user_mode+0x19/0x60
> > > > > >>>>>>>>> [  738.359062]  entry_SYSCALL_64_after_hwframe+0x44/0xa=
9
> > > > > >>>>>>>>> [  738.359069] RIP: 0033:0x7f6b89a51887
> > > > > >>>>>>>>> [  738.359076] RSP: 002b:00007f6b82b54b18 EFLAGS: 00000=
246 ORIG_RAX:
> > > > > >>>>>>>>> 0000000000000010
> > > > > >>>>>>>>> [  738.359086] RAX: fffffffffffffe00 RBX: 00007f6b82b54=
b50 RCX: 00007f6b89a51887
> > > > > >>>>>>>>> [  738.359091] RDX: 00007f6b82b54b50 RSI: 00000000c0206=
4c3 RDI: 0000000000000007
> > > > > >>>>>>>>> [  738.359096] RBP: 00000000c02064c3 R08: 0000000000000=
003 R09: 00007f6b82b54bbc
> > > > > >>>>>>>>> [  738.359101] R10: 0000000000000001 R11: 0000000000000=
246 R12: 0000000165a0bc00
> > > > > >>>>>>>>> [  738.359106] R13: 0000000000000007 R14: 0000000000000=
001 R15: 0000000000000000
> > > > > >>>>>>>>> [  738.359129]
> > > > > >>>>>>>>>                    Showing all locks held in the system=
:
> > > > > >>>>>>>>> [  738.359141] 1 lock held by khungtaskd/54:
> > > > > >>>>>>>>> [  738.359148]  #0: ffffffff829f6840 (rcu_read_lock){..=
..}-{1:2}, at:
> > > > > >>>>>>>>> debug_show_all_locks+0x15/0x183
> > > > > >>>>>>>>> [  738.359187] 1 lock held by systemd-journal/174:
> > > > > >>>>>>>>> [  738.359202] 1 lock held by MatrixMultiplic/653:
> > > > > >>>>>>>>> [  738.359206]  #0: ffff88810e364fe0
> > > > > >>>>>>>>> (&adev->notifier_lock){+.+.}-{3:3}, at:
> > > > > >>>>>>>>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> > > > > >>>>>>>>>
> > > > > >>>>>>>>> Daniel
> > > > > >>>>>>>> _______________________________________________
> > > > > >>>>>>>> dri-devel mailing list
> > > > > >>>>>>>> dri-devel@lists.freedesktop.org
> > > > > >>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=
=3D04%7C01%7Cjohn.bridgman%40amd.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3=
dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637479592320075525%7CUnknown%7CTW=
FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7C1000&amp;sdata=3D5lN%2Fc2Kncy31PnJEJIUC%2BFAItXAmXAtKAHp%2F6d%2Burgo%3D=
&amp;reserved=3D0
> > > > > >>>>> --
> > > > > >>>>> Daniel Vetter
> > > > > >>>>> Software Engineer, Intel Corporation
> > > > > >>>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%=
3A%2F%2Fblog.ffwll.ch%2F&amp;data=3D04%7C01%7Cjohn.bridgman%40amd.com%7Cbe4=
d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C=
637479592320085517%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu=
MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DE6uF1FUrp9RSryVDLD1zI=
PaMFJU5aP5xvx7F9Mgf53s%3D&amp;reserved=3D0
> > > > > >>> _______________________________________________
> > > > > >>> amd-gfx mailing list
> > > > > >>> amd-gfx@lists.freedesktop.org
> > > > > >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3=
A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7=
C01%7Cjohn.bridgman%40amd.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637479592320085517%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100=
0&amp;sdata=3DsXukJnECw3PKXuY9V4JeUQtn86qH7EHHjHZ9brfILK0%3D&amp;reserved=
=3D0
> > > > >
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D04%7C0=
1%7Cjohn.bridgman%40amd.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637479592320085517%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&=
amp;sdata=3D2OSwOUbIkoQYy%2F5JGiDyNEK2oOFR%2FGFd9kiP65z15F0%3D&amp;reserved=
=3D0
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D04%7C01%=
7Cjohn.bridgman%40amd.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637479592320085517%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am=
p;sdata=3D2OSwOUbIkoQYy%2F5JGiDyNEK2oOFR%2FGFd9kiP65z15F0%3D&amp;reserved=
=3D0
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fbl=
og.ffwll.ch%2F&amp;data=3D04%7C01%7Cjohn.bridgman%40amd.com%7Cbe4d5642b5224=
2dd9fdb08d8c84fca13%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6374795923=
20085517%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi=
I6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DE6uF1FUrp9RSryVDLD1zIPaMFJU5aP5=
xvx7F9Mgf53s%3D&amp;reserved=3D0
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cjo=
hn.bridgman%40amd.com%7Cbe4d5642b52242dd9fdb08d8c84fca13%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637479592320085517%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sd=
ata=3DsXukJnECw3PKXuY9V4JeUQtn86qH7EHHjHZ9brfILK0%3D&amp;reserved=3D0
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
