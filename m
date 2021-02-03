Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7535130D5AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhBCI5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbhBCI47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:56:59 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ACBC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 00:56:18 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f19so27375449ljn.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 00:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7VtGuTTwjMO6mpNXbKVMrE+2YoiVu6/714JznKzcbZ4=;
        b=UpBBVrcWqp+GZpqqOekOilwGerhoRHJK9ujUN7rUfqfSpJR9r2sYcIU6wkuUnw3zK4
         2NlAzQf56cg+Xgx4VgfBIg9g7eTLK/CJ1cUq2T+uG2Mm5NUrTPIHTPGc+kbHiD+o19f8
         pfmhOk4yyV2fcNWFXxCWufCfaJ5fl3QQOKsrvrOsSk/wf0aix5TBQKEDi6h3aNPOZEij
         35LL290YkLnZfcw6hcs1TNGilJQMjwzEZIA7/AzbKp1zg/Dzd6lqBQxGU5CqEEBIQW1/
         6pIuAyNcAoa3MIIbiTbjtJcDkNIR99IAHSNg9rRQPHA6hINzjBEqj4WaoCasTnfkFnpp
         8tYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7VtGuTTwjMO6mpNXbKVMrE+2YoiVu6/714JznKzcbZ4=;
        b=YfegDUI33ayeiiIrtS6GsqbuBpURsbFpzCupFbs/twnz2IO6DrpjSb+h8xVHh+wMAZ
         //u2h1DByk73GiN1XDinwECxMF+sA/ftqNiiflKvh3D3V0oOhsnOfGFK74+WLShg/1MY
         qj8xktMxp+8p0uQYIkyZZ80l1J/5gc+O08OuJynpTvzXU+zqdYqWY48mJMcd/XWHukSa
         f80epSqMfX15IBNUI9ZEs5gH97dcRLTHUa/gBxSSL+SXL9exg2V64Ds2X/Mj7lxYd2bm
         teWbleSwxTc5H1nci16OFzebufgzb4Zn/6uqOYh9yKkH276WHD86/l+P8Tu8v7q8hUo+
         9d8A==
X-Gm-Message-State: AOAM533AU23U9XoOSqRiVq905+ctDwGkjdjhrx0w1EcuHkM2utSLXRAi
        MfvUWBDNAALZ03P3FIRRI0b81JEQrnYO5rG/M7BTyg==
X-Google-Smtp-Source: ABdhPJwQq0DtkhMoi1AaTB8fwcMWj8IeZrjR/5TryzCh4sFGC4ByEEYbBPALPkRsoiRq7Fp4dsOp7gcTL0qu3ydkNTg=
X-Received: by 2002:a2e:91d0:: with SMTP id u16mr1179126ljg.480.1612342577190;
 Wed, 03 Feb 2021 00:56:17 -0800 (PST)
MIME-Version: 1.0
References: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
 <58e41b62-b8e0-b036-c87d-a84d53f5a26e@amd.com> <CAKMK7uGTFYWnBG+JtbAK=zQVT1dT=nKor_SHP-t958oebgn8_A@mail.gmail.com>
 <fa170c5c-2f46-58ef-6847-e0bc9907fc8b@amd.com>
In-Reply-To: <fa170c5c-2f46-58ef-6847-e0bc9907fc8b@amd.com>
From:   Daniel Gomez <daniel@qtec.com>
Date:   Wed, 3 Feb 2021 09:56:06 +0100
Message-ID: <CAH1Ww+QkS54PW4LZ42KtqGtjACmsAt_Y_rd3fiR5PUHQR65Hpg@mail.gmail.com>
Subject: Re: [amdgpu] deadlock
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 at 09:51, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
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
>
> Question is rather why we end up in the userptr handling for GFX? Our
> ROCm OpenCL stack shouldn't use this.
>
> > Daniel, can you pls re-hang your machine and then dump backtraces of
> > all tasks into dmesg with sysrq-t, and then attach that? Without al
yes, I'll try it again.
> > the backtraces it's tricky to construct the full dependency chain of
> > what's going on. Also is this plain -rc6, not some more patches on
> > top?
It's plain -rc6 in regards to amdgpu and dma fences. I have some other patc=
hes
on top but they are v4l2 related.
>
> Yeah, that's still a good idea to have.
>
> Christian.
>
> > -Daniel
> >
> >> Which OpenCl stack are you using?
Radeon Software for Linux 20.20.
https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-20-=
20

I've also noticed the 'latest' linux-firmware adds support for the
20.45 version but
I haven't tested it yet since I couldn't bring it up properly the
support as I was doing for
the previous versions. Somehow the libamdocl64.so got reduced from 80 Mb to
1.2 Mb and I couldn't figure out what has been changed.

Should I use ROCm instead of Radeon for Linux?

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
