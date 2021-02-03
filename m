Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982D530D54B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhBCIeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhBCIeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:34:13 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC7DC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 00:33:32 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m22so32113410lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 00:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=7ShNda3d6u7Ghd1Q9qy6CjLV4Mbe3P/5rnrMwcMJtQ8=;
        b=L1gYCR/Sgy/ut07TyoVrFoAmyn0RyBOvFpmD3Jc8doGtIKqK93wapddQ/xPV2+wxa8
         uZbFPd68t5EWHkqbq4sicbKKIe8+b1ETtmkS6gFzaflcWXap0ST932i0kU+YJmdUwe5q
         5wWHl2p8bSjXa9E/KMPd6ynfxdOGnnclDWPSrUfAZLP9X7hkGtezc1m6e9a302PgxUh7
         CUhlSLioZ0JKlHyCNL0cRljmISp6CLFHewCW7xWmjqqUY5G3ukUlHLZ3rJLb/Fjr7sF7
         XaRrCZlh5kKmTNrJu9+EnLlS9j1HK8O6z0zw4wiG5ysgMT4VapZCDa64pQrlwPh4e4db
         xY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=7ShNda3d6u7Ghd1Q9qy6CjLV4Mbe3P/5rnrMwcMJtQ8=;
        b=rbBYYrLaKctRXjscSr3hpV3zAgTP7CKGn2LCV9oTsEMGRGVaYuNeKkJvmz71jigPuJ
         MJAcdvGN8WnIsM/MZptjmU63mJ+Q1jTewoTpkOVlpkV43j+tlEE+l1/IYh5u2z3U5kZG
         a5AAMb7YwNaHef2xp96Qa9MVhY/qEaxQYAxcHgZqrnT50NTj1Ajaf1lPTZ5p8mU7oJRh
         xb9IsFifdqKNksCYpJ1q4OddjTJgNBw5x8vlwQP8AQ//P+h6ee4AFMZk/0V0bDOkwyyM
         BQ6Xw0CQaS2OtOYJ5JMfgRjlDNvdkVZyzkm8r8lq79jiY6DSonX1sNm/fHOkcYiKTouO
         Jlxw==
X-Gm-Message-State: AOAM532IYl5J//P2tFN486YtY9sOVUmQW42oWIDdmC7T7lOBiEgYZf5K
        mU2F5DulOemwG4pnWQSQh4+MEg+l3HCYKcK88G1mrQ==
X-Google-Smtp-Source: ABdhPJxTCl+LD1X6OvGkFkhAjDA/55ddLTveroqthDeQFNkC1KR0rc2METhsIXdmtHUha/JdRzcJq7kMNoncPorGejQ=
X-Received: by 2002:a05:6512:214a:: with SMTP id s10mr1101305lfr.225.1612341210471;
 Wed, 03 Feb 2021 00:33:30 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Gomez <daniel@qtec.com>
Date:   Wed, 3 Feb 2021 09:33:19 +0100
Message-ID: <CAH1Ww+TPCSyiaC3oeoWPtsi-vDfDY=K4ByoLD37-onMvsAB5Rg@mail.gmail.com>
Subject: [amdgpu] deadlock
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a deadlock with the amdgpu mainline driver when running in parallel =
two
OpenCL applications. So far, we've been able to replicate it easily by exec=
uting
clinfo and MatrixMultiplication (from AMD opencl-samples). It's quite old t=
he
opencl-samples so, if you have any other suggestion for testing I'd be very
happy to test it as well.

How to replicate the issue:

# while true; do /usr/bin/MatrixMultiplication --device gpu \
    --deviceId 0 -x 1000 -y 1000 -z 1000 -q -t -i 50; done
# while true; do clinfo; done

Output:

After a minute or less (sometimes could be more) I can see that
MatrixMultiplication and clinfo hang. In addition, with radeontop you can s=
ee
how the Graphics pipe goes from ~50% to 100%. Also the shader clocks
goes up from ~35% to ~96%.

clinfo keeps printing:
ioctl(7, DRM_IOCTL_SYNCOBJ_WAIT, 0x7ffe46e5f950) =3D -1 ETIME (Timer expire=
d)

And MatrixMultiplication prints the following (strace) if you try to
kill the process:

sched_yield()                           =3D 0
futex(0x557e945343b8, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
NULL, FUTEX_BITSET_MATCH_ANYstrace: Process 651 detached
 <detached ...>

After this, the gpu is not functional at all and you'd need a power cycle r=
eset
to restore the system.

Hardware info:
CPU: AMD Ryzen Embedded V1605B with Radeon Vega Gfx (8) @ 2.000GHz
GPU: AMD ATI Radeon Vega Series / Radeon Vega Mobile Series

03:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Raven Ridge [Radeon Vega Series / Radeon Vega Mobile Series]
(rev 83)
    DeviceName: Broadcom 5762
    Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Raven Ridge
[Radeon Vega Series / Radeon Vega Mobile Series]
    Kernel driver in use: amdgpu
    Kernel modules: amdgpu

Linux kernel info:

root@qt5222:~# uname -a
Linux qt5222 5.11.0-rc6-qtec-standard #2 SMP Tue Feb 2 09:41:46 UTC
2021 x86_64 x86_64 x86_64 GNU/Linux

By enabling the kernel locks stats I could see the MatrixMultiplication is
hanged in the amdgpu_mn_invalidate_gfx function:

[  738.359202] 1 lock held by MatrixMultiplic/653:
[  738.359206]  #0: ffff88810e364fe0
(&adev->notifier_lock){+.+.}-{3:3}, at:
amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]

I can see in the the amdgpu_mn_invalidate_gfx function: the
dma_resv_wait_timeout_rcu uses wait_all (fences) and MAX_SCHEDULE_TIMEOUT s=
o, I
guess the code gets stuck there waiting forever. According to the
documentation: "When somebody tries to invalidate the page tables we block =
the
update until all operations on the pages in question are completed, then th=
ose
pages are marked  as accessed and also dirty if it wasn=E2=80=99t a read on=
ly access."
Looks like the fences are deadlocked and therefore, it never returns. Could=
 it
be possible? any hint to where can I look to fix this?

Thank you  in advance.

Here the full dmesg output:

[  738.337726] INFO: task MatrixMultiplic:653 blocked for more than 122 sec=
onds.
[  738.344937]       Not tainted 5.11.0-rc6-qtec-standard #2
[  738.350384] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  738.358240] task:MatrixMultiplic state:D stack:    0 pid:  653
ppid:     1 flags:0x00004000
[  738.358254] Call Trace:
[  738.358261]  ? dma_fence_default_wait+0x1eb/0x230
[  738.358276]  __schedule+0x370/0x960
[  738.358291]  ? dma_fence_default_wait+0x117/0x230
[  738.358297]  ? dma_fence_default_wait+0x1eb/0x230
[  738.358305]  schedule+0x51/0xc0
[  738.358312]  schedule_timeout+0x275/0x380
[  738.358324]  ? dma_fence_default_wait+0x1eb/0x230
[  738.358332]  ? mark_held_locks+0x4f/0x70
[  738.358341]  ? dma_fence_default_wait+0x117/0x230
[  738.358347]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
[  738.358353]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[  738.358362]  ? dma_fence_default_wait+0x117/0x230
[  738.358370]  ? dma_fence_default_wait+0x1eb/0x230
[  738.358375]  dma_fence_default_wait+0x214/0x230
[  738.358384]  ? dma_fence_release+0x1a0/0x1a0
[  738.358396]  dma_fence_wait_timeout+0x105/0x200
[  738.358405]  dma_resv_wait_timeout_rcu+0x1aa/0x5e0
[  738.358421]  amdgpu_mn_invalidate_gfx+0x55/0xa0 [amdgpu]
[  738.358688]  __mmu_notifier_release+0x1bb/0x210
[  738.358710]  exit_mmap+0x2f/0x1e0
[  738.358723]  ? find_held_lock+0x34/0xa0
[  738.358746]  mmput+0x39/0xe0
[  738.358756]  do_exit+0x5c3/0xc00
[  738.358763]  ? find_held_lock+0x34/0xa0
[  738.358780]  do_group_exit+0x47/0xb0
[  738.358791]  get_signal+0x15b/0xc50
[  738.358807]  arch_do_signal_or_restart+0xaf/0x710
[  738.358816]  ? lockdep_hardirqs_on_prepare+0xd4/0x180
[  738.358822]  ? _raw_spin_unlock_irqrestore+0x39/0x40
[  738.358831]  ? ktime_get_mono_fast_ns+0x50/0xa0
[  738.358844]  ? amdgpu_drm_ioctl+0x6b/0x80 [amdgpu]
[  738.359044]  exit_to_user_mode_prepare+0xf2/0x1b0
[  738.359054]  syscall_exit_to_user_mode+0x19/0x60
[  738.359062]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  738.359069] RIP: 0033:0x7f6b89a51887
[  738.359076] RSP: 002b:00007f6b82b54b18 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  738.359086] RAX: fffffffffffffe00 RBX: 00007f6b82b54b50 RCX: 00007f6b89a=
51887
[  738.359091] RDX: 00007f6b82b54b50 RSI: 00000000c02064c3 RDI: 00000000000=
00007
[  738.359096] RBP: 00000000c02064c3 R08: 0000000000000003 R09: 00007f6b82b=
54bbc
[  738.359101] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000165a=
0bc00
[  738.359106] R13: 0000000000000007 R14: 0000000000000001 R15: 00000000000=
00000
[  738.359129]
               Showing all locks held in the system:
[  738.359141] 1 lock held by khungtaskd/54:
[  738.359148]  #0: ffffffff829f6840 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x15/0x183
[  738.359187] 1 lock held by systemd-journal/174:
[  738.359202] 1 lock held by MatrixMultiplic/653:
[  738.359206]  #0: ffff88810e364fe0
(&adev->notifier_lock){+.+.}-{3:3}, at:
amdgpu_mn_invalidate_gfx+0x34/0xa0 [amdgpu]

Daniel
