Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6418730D91E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhBCLqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbhBCLqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:46:42 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D23C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:46:01 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id s18so27893717ljg.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=82vkGadaqicN7Tk0VfCI70MnP1jxfzaftnQhzpB8AaI=;
        b=gHDGrM/nCNxehsyPVk4p7rTlCVV7lkHDXfFNeV64VEfiBrTn7C0oOCLjUC8FiqTM9T
         HDCUfOML2wkV2DlMrJb1NK7JyDt9MIthkd/7k8uEAzgHpZX+5HsPpH/Lml7mF34PPu0U
         AiZAVqswid5r3u4Hhz8b2Sxlre5SE1g3o8wTrhYg8tIKDtzcJBhTEUbHH3BBAJQ7Q2oX
         9uwYZpBlAeJvU4jncbDVrXbjvXxKlZsIdPVQC/zwHqQFkI7VR10fkVpeModZ5fDOiIin
         ZleG359No6dVKvFAsDL17weS8eSZaIWlk2ShPClYkcb2G6ZlnYN3RW6P0oFaj5G0hfPl
         OnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=82vkGadaqicN7Tk0VfCI70MnP1jxfzaftnQhzpB8AaI=;
        b=qBel27iNViYqwDfRdAnVwmwHP2sM4K1bs+rPBy5vYu1aabgDqaX5m3plqb8MWI2ozt
         G+RpYYU10iKzCsCXZXW6sR2pj0Vsb/F+t00oZF+cGcdo5nxeCO+xMW0vpepeYx+YfNcd
         72+PIrcMnBpRw/ghaIALEDwKfuqDY5RMfaOtY9lvwdt+1dACzA9VwjNqGszDycaWSl8s
         5xbRT7D8Snalthsr/vMY/7Njwfgidde+jLgZ2nTTsH86Nyi/04/VL1r1hxoDzTFd1eTi
         mUa9YWcPjPftnT7AT2fFS9d36lx1sTdb4Zv3St3ZVXEdMDYw+i23USHsLYJISiHgFH0+
         x6VA==
X-Gm-Message-State: AOAM532uLpgo3KdIsbHoNz9IQ5SnJhTVfeD9prQd18KFKPgiH7WssJqt
        1gl81qIhtgwtADJ8dyzgJ8RwlXigOqzoNgHQu5ZVbg==
X-Google-Smtp-Source: ABdhPJx5WJxfTDQR4lc3TqyTdSknVm2xU71HBHKFEeC22W/rYhPDSGQiuqlOHFD8NpHl91uJo9VYfj7lp8AzbZ33PiU=
X-Received: by 2002:a2e:990c:: with SMTP id v12mr1588826lji.8.1612352760306;
 Wed, 03 Feb 2021 03:46:00 -0800 (PST)
MIME-Version: 1.0
References: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
 <58e41b62-b8e0-b036-c87d-a84d53f5a26e@amd.com> <CAKMK7uGTFYWnBG+JtbAK=zQVT1dT=nKor_SHP-t958oebgn8_A@mail.gmail.com>
 <fa170c5c-2f46-58ef-6847-e0bc9907fc8b@amd.com> <CAKMK7uE8qNUSNpX3TS6Fgif-6rCc7uZth_-F-kYPrOUSz5K3_A@mail.gmail.com>
 <CAH1Ww+QhiKYOJTWAigDhC761EhqeCUuh_bdZn=r4DAcEcb5Yyw@mail.gmail.com>
In-Reply-To: <CAH1Ww+QhiKYOJTWAigDhC761EhqeCUuh_bdZn=r4DAcEcb5Yyw@mail.gmail.com>
From:   Daniel Gomez <daniel@qtec.com>
Date:   Wed, 3 Feb 2021 12:45:49 +0100
Message-ID: <CAH1Ww+Q=9TnxB2QW1=wb-NAoYmt0_+DueFj8vowqPjPFe_Cw8w@mail.gmail.com>
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

On Wed, 3 Feb 2021 at 10:47, Daniel Gomez <daniel@qtec.com> wrote:
>
> On Wed, 3 Feb 2021 at 10:17, Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Feb 3, 2021 at 9:51 AM Christian K=C3=B6nig <christian.koenig@a=
md.com> wrote:
> > >
> > > Am 03.02.21 um 09:48 schrieb Daniel Vetter:
> > > > On Wed, Feb 3, 2021 at 9:36 AM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
> > > >> Hi Daniel,
> > > >>
> > > >> this is not a deadlock, but rather a hardware lockup.
> > > > Are you sure? Ime getting stuck in dma_fence_wait has generally goo=
d
> > > > chance of being a dma_fence deadlock. GPU hang should never result =
in
> > > > a forever stuck dma_fence.
> > >
> > > Yes, I'm pretty sure. Otherwise the hardware clocks wouldn't go up li=
ke
> > > this.
> >
> > Maybe clarifying, could be both. TDR should notice and get us out of
> > this, but if there's a dma_fence deadlock and we can't re-emit or
> > force complete the pending things, then we're stuck for good.
> > -Daniel
> >
> > > Question is rather why we end up in the userptr handling for GFX? Our
> > > ROCm OpenCL stack shouldn't use this.
> > >
> > > > Daniel, can you pls re-hang your machine and then dump backtraces o=
f
> > > > all tasks into dmesg with sysrq-t, and then attach that? Without al=
l
> > > > the backtraces it's tricky to construct the full dependency chain o=
f
> > > > what's going on. Also is this plain -rc6, not some more patches on
> > > > top?
> > >
> > > Yeah, that's still a good idea to have.
>
> Here the full backtrace dmesg logs after the hang:
> https://pastebin.com/raw/kzivm2L3
>
> This is another dmesg log with the backtraces after SIGKILL the matrix pr=
ocess:
> (I didn't have the sysrq enable at the time):
> https://pastebin.com/raw/pRBwGcj1

I've now removed all our v4l2 patches and did the same test with the 'plain=
'
mainline version (-rc6).

Reference: 3aaf0a27ffc29b19a62314edd684b9bc6346f9a8

Same error, same behaviour. Full dmesg log attached:
https://pastebin.com/raw/KgaEf7Y1
Note:
  dmesg with sysrq-t before running the test starts in [  122.016502]
sysrq: Show State
  dmesg with sysrq-t after the test starts in: [  495.587671] sysrq: Show S=
tate


>
> > >
> > > Christian.
> > >
> > > > -Daniel
> > > >
> > > >> Which OpenCl stack are you using?
> > > >>
> > > >> Regards,
> > > >> Christian.
> > > >>
> > > >> Am 03.02.21 um 09:33 schrieb Daniel Gomez:
> > > >>> Hi all,
> > > >>>
> > > >>> I have a deadlock with the amdgpu mainline driver when running in=
 parallel two
> > > >>> OpenCL applications. So far, we've been able to replicate it easi=
ly by executing
> > > >>> clinfo and MatrixMultiplication (from AMD opencl-samples). It's q=
uite old the
> > > >>> opencl-samples so, if you have any other suggestion for testing I=
'd be very
> > > >>> happy to test it as well.
> > > >>>
> > > >>> How to replicate the issue:
> > > >>>
> > > >>> # while true; do /usr/bin/MatrixMultiplication --device gpu \
> > > >>>       --deviceId 0 -x 1000 -y 1000 -z 1000 -q -t -i 50; done
> > > >>> # while true; do clinfo; done
> > > >>>
> > > >>> Output:
> > > >>>
> > > >>> After a minute or less (sometimes could be more) I can see that
> > > >>> MatrixMultiplication and clinfo hang. In addition, with radeontop=
 you can see
> > > >>> how the Graphics pipe goes from ~50% to 100%. Also the shader clo=
cks
> > > >>> goes up from ~35% to ~96%.
> > > >>>
> > > >>> clinfo keeps printing:
> > > >>> ioctl(7, DRM_IOCTL_SYNCOBJ_WAIT, 0x7ffe46e5f950) =3D -1 ETIME (Ti=
mer expired)
> > > >>>
> > > >>> And MatrixMultiplication prints the following (strace) if you try=
 to
> > > >>> kill the process:
> > > >>>
> > > >>> sched_yield()                           =3D 0
> > > >>> futex(0x557e945343b8, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALT=
IME, 0,
> > > >>> NULL, FUTEX_BITSET_MATCH_ANYstrace: Process 651 detached
> > > >>>    <detached ...>
> > > >>>
> > > >>> After this, the gpu is not functional at all and you'd need a pow=
er cycle reset
> > > >>> to restore the system.
> > > >>>
> > > >>> Hardware info:
> > > >>> CPU: AMD Ryzen Embedded V1605B with Radeon Vega Gfx (8) @ 2.000GH=
z
> > > >>> GPU: AMD ATI Radeon Vega Series / Radeon Vega Mobile Series
> > > >>>
> > > >>> 03:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > > >>> [AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Se=
ries]
> > > >>> (rev 83)
> > > >>>       DeviceName: Broadcom 5762
> > > >>>       Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Raven Rid=
ge
> > > >>> [Radeon Vega Series / Radeon Vega Mobile Series]
> > > >>>       Kernel driver in use: amdgpu
> > > >>>       Kernel modules: amdgpu
> > > >>>
> > > >>> Linux kernel info:
> > > >>>
> > > >>> root@qt5222:~# uname -a
> > > >>> Linux qt5222 5.11.0-rc6-qtec-standard #2 SMP Tue Feb 2 09:41:46 U=
TC
> > > >>> 2021 x86_64 x86_64 x86_64 GNU/Linux
> > > >>>
> > > >>> By enabling the kernel locks stats I could see the MatrixMultipli=
cation is
> > > >>> hanged in the amdgpu_mn_invalidate_gfx function:
> > > >>>
> > > >>> [  738.359202] 1 lock held by MatrixMultiplic/653:
> > > >>> [  738.359206]  #0: ffff88810e364fe0
> > > >>> (&adev->notifier_lock){+.+.}-{3:3}, at:
> > > >>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> > > >>>
> > > >>> I can see in the the amdgpu_mn_invalidate_gfx function: the
> > > >>> dma_resv_wait_timeout_rcu uses wait_all (fences) and MAX_SCHEDULE=
_TIMEOUT so, I
> > > >>> guess the code gets stuck there waiting forever. According to the
> > > >>> documentation: "When somebody tries to invalidate the page tables=
 we block the
> > > >>> update until all operations on the pages in question are complete=
d, then those
> > > >>> pages are marked  as accessed and also dirty if it wasn=E2=80=99t=
 a read only access."
> > > >>> Looks like the fences are deadlocked and therefore, it never retu=
rns. Could it
> > > >>> be possible? any hint to where can I look to fix this?
> > > >>>
> > > >>> Thank you  in advance.
> > > >>>
> > > >>> Here the full dmesg output:
> > > >>>
> > > >>> [  738.337726] INFO: task MatrixMultiplic:653 blocked for more th=
an 122 seconds.
> > > >>> [  738.344937]       Not tainted 5.11.0-rc6-qtec-standard #2
> > > >>> [  738.350384] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > >>> disables this message.
> > > >>> [  738.358240] task:MatrixMultiplic state:D stack:    0 pid:  653
> > > >>> ppid:     1 flags:0x00004000
> > > >>> [  738.358254] Call Trace:
> > > >>> [  738.358261]  ? dma_fence_default_wait+0x1eb/0x230
> > > >>> [  738.358276]  __schedule+0x370/0x960
> > > >>> [  738.358291]  ? dma_fence_default_wait+0x117/0x230
> > > >>> [  738.358297]  ? dma_fence_default_wait+0x1eb/0x230
> > > >>> [  738.358305]  schedule+0x51/0xc0
> > > >>> [  738.358312]  schedule_timeout+0x275/0x380
> > > >>> [  738.358324]  ? dma_fence_default_wait+0x1eb/0x230
> > > >>> [  738.358332]  ? mark_held_locks+0x4f/0x70
> > > >>> [  738.358341]  ? dma_fence_default_wait+0x117/0x230
> > > >>> [  738.358347]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> > > >>> [  738.358353]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> > > >>> [  738.358362]  ? dma_fence_default_wait+0x117/0x230
> > > >>> [  738.358370]  ? dma_fence_default_wait+0x1eb/0x230
> > > >>> [  738.358375]  dma_fence_default_wait+0x214/0x230
> > > >>> [  738.358384]  ? dma_fence_release+0x1a0/0x1a0
> > > >>> [  738.358396]  dma_fence_wait_timeout+0x105/0x200
> > > >>> [  738.358405]  dma_resv_wait_timeout_rcu+0x1aa/0x5e0
> > > >>> [  738.358421]  amdgpu_mn_invalidate_gfx+0x55/0xa0 [amdgpu]
> > > >>> [  738.358688]  __mmu_notifier_release+0x1bb/0x210
> > > >>> [  738.358710]  exit_mmap+0x2f/0x1e0
> > > >>> [  738.358723]  ? find_held_lock+0x34/0xa0
> > > >>> [  738.358746]  mmput+0x39/0xe0
> > > >>> [  738.358756]  do_exit+0x5c3/0xc00
> > > >>> [  738.358763]  ? find_held_lock+0x34/0xa0
> > > >>> [  738.358780]  do_group_exit+0x47/0xb0
> > > >>> [  738.358791]  get_signal+0x15b/0xc50
> > > >>> [  738.358807]  arch_do_signal_or_restart+0xaf/0x710
> > > >>> [  738.358816]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
> > > >>> [  738.358822]  ? _raw_spin_unlock_irqrestore+0x39/0x40
> > > >>> [  738.358831]  ? ktime_get_mono_fast_ns+0x50/0xa0
> > > >>> [  738.358844]  ? amdgpu_drm_ioctl+0x6b/0x80 [amdgpu]
> > > >>> [  738.359044]  exit_to_user_mode_prepare+0xf2/0x1b0
> > > >>> [  738.359054]  syscall_exit_to_user_mode+0x19/0x60
> > > >>> [  738.359062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > >>> [  738.359069] RIP: 0033:0x7f6b89a51887
> > > >>> [  738.359076] RSP: 002b:00007f6b82b54b18 EFLAGS: 00000246 ORIG_R=
AX:
> > > >>> 0000000000000010
> > > >>> [  738.359086] RAX: fffffffffffffe00 RBX: 00007f6b82b54b50 RCX: 0=
0007f6b89a51887
> > > >>> [  738.359091] RDX: 00007f6b82b54b50 RSI: 00000000c02064c3 RDI: 0=
000000000000007
> > > >>> [  738.359096] RBP: 00000000c02064c3 R08: 0000000000000003 R09: 0=
0007f6b82b54bbc
> > > >>> [  738.359101] R10: 0000000000000001 R11: 0000000000000246 R12: 0=
000000165a0bc00
> > > >>> [  738.359106] R13: 0000000000000007 R14: 0000000000000001 R15: 0=
000000000000000
> > > >>> [  738.359129]
> > > >>>                  Showing all locks held in the system:
> > > >>> [  738.359141] 1 lock held by khungtaskd/54:
> > > >>> [  738.359148]  #0: ffffffff829f6840 (rcu_read_lock){....}-{1:2},=
 at:
> > > >>> debug_show_all_locks+0x15/0x183
> > > >>> [  738.359187] 1 lock held by systemd-journal/174:
> > > >>> [  738.359202] 1 lock held by MatrixMultiplic/653:
> > > >>> [  738.359206]  #0: ffff88810e364fe0
> > > >>> (&adev->notifier_lock){+.+.}-{3:3}, at:
> > > >>> amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]
> > > >>>
> > > >>> Daniel
> > > >> _______________________________________________
> > > >> dri-devel mailing list
> > > >> dri-devel@lists.freedesktop.org
> > > >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D04%7C01=
%7Cchristian.koenig%40amd.com%7C81203e5bac5841b8e5a108d8c82087a9%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637479389339295622%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100=
0&amp;sdata=3DRDSxD6OqD8HaOA2VnNfbJwLnKzhCLgOr5SVLjLF91bA%3D&amp;reserved=
=3D0
> > > >
> > > >
> > >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
