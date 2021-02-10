Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E9D3172AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhBJVuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhBJVuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:50:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA94C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:49:28 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q2so4769677eds.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 13:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HEg/p/WyMTvPZiaGO8k/zYmzd8UuVe0Ha4OjKTPPAeI=;
        b=dG8X7JruLehchFEm+K56W50XEmSpnEhFu/jKNniepofGTYcNcVbJUiMZhyxm2yl2YU
         rGymHQl1BHmeQYbhgOBJ7uP93weTifYxs6FMq+Mdg4GyYzzLVwg3C+QtJYsfyNJMwD+j
         Bi5nH/O2+uKiz+FQFtXDQUHGMNCNgcU5/ABy8Whf1l49DjMOFTG+wbbqBPhJaOYNF/29
         fIPWdn84/AE9gNnhrmlagc/jCc7BFffCeut/O4MEZoOlxyS8gVmxRT9SfiMTjU2RALdW
         Kv7PZg9fm2XjwTKBmeHj71g1IDY8MBsni+rQ8N2gO5BNEdBWmmvOo8PcRaSsA4VVlOgh
         pQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=HEg/p/WyMTvPZiaGO8k/zYmzd8UuVe0Ha4OjKTPPAeI=;
        b=HYFZjROwVsTkagpxz9ogYQg/iWhr7GDptHPoeKrXVAHLoNJ0a3cddjE29hCSx5Udzd
         2etILcksyRQra+dYqX9NJayHR60/J5EZuyMByqupx89LgvB5y7y3RfIvyzGIrYYEgSch
         OP7SoHJfisqWtyi95CRWYgjiz4Un+TN9NOmguh8AGXwzOiJzT206qkm49nm6ZAsGlqKA
         HKbHYsUL2dyjjZPxBUVdHnzCFPN1DCrpVQL6UzgOt+pNrfJ+A/iphtIcLgya6Kd5Fs98
         mg7HzPIgI9fdveMJOylABFtWluxKH0IdN8KLmNcIN/ZdgwO37+YefTxs2Fd9FbxoZkjs
         5AVg==
X-Gm-Message-State: AOAM5317Q4qme+0/rlvZkciNsMHc4osP/UKN6OsSx/ildXFwdkzrgZ1J
        LbyvsIkIbg9ChA4TnXSroZKaO1AY+aWf2QC3hShIvA==
X-Google-Smtp-Source: ABdhPJwDp4E+9V17rfcnpOClG0Ip8/cDgkFaBvpgxmnlqeaFleibfBY/K/PzlCnAgR+LNfSB7AVic7NxDCM6UZgt+Dw=
X-Received: by 2002:a50:ee10:: with SMTP id g16mr5201462eds.62.1612993767199;
 Wed, 10 Feb 2021 13:49:27 -0800 (PST)
MIME-Version: 1.0
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 10 Feb 2021 16:48:51 -0500
Message-ID: <CA+CK2bC7Qe-EDX8mZ_OvfH+9rfiYHCGK++znivu+SKvi8HGpkg@mail.gmail.com>
Subject: improving crash dump discussion
To:     sourabhjain@linux.ibm.com, hbathini@linux.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>, vgoyal@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to start a discussion about how we can improve Linux
crash dump facility, and use warm reboot  / firmware assistance in
order to more reliably collect crash dumps while using fewer
memory resources and being more performant.

Currently, the main way to collect crash dumps on Linux is to use
kdump.  Kdump uses kexec in order to collect dumps. Kdump makes
use of kexec, which is mature and portable (does not depend on
firmware), but using kexec is not ideal.

I will list some problems with kexec/kdump, and then discuss how some
of them (hopefully most) can be addressed.

1. Expecting a crashing kernel to do the right thing: properly quiesce
devices, CPUs and prepare the machine for the new kernel.

The amount of code that is executed to perform crash kexec reboot is
not trivial. Unfortunately, since we are panicking we already lost
control at some point and the goal would be to reduce the amount of
code executed by the panic handler in order to be able to reliably
collect dumps. There are some ways to improve the reliability of crash
kexec reboot. For example, passing maxcpus=3D1 kernel parameter is now
the required on almost all platforms, which, unfortunately, has the
downside of forcing crash kernel to use only a single thread to save
core, and thus "makedumpfile --num-thread" is useless if used from
crash kernel.

2. Unlike booting from firmware, the PCI, CPUs, interrupt controllers,
DMAs mappings, and I/O devices are not reinitialized and might not be
in a consistent state.

The reset_devices, irqpoll, and other kernel parameters also intend to
mitigate these shortfalls by requiring drivers to do the resetting
themselves. Also, the kernel is usually smart enough to ignore
spurious interrupts, but this is fragile.

3. There is a blackout window during boot where collecting a crash dump
is not possible.

With current kdump it is possible to collect crashes that occur after
the kernel early boot is finished. During early boot we do a lot:
determine platform, initialize mm, initialize clock, scheduler, and
start other CPUs. Only after entering usermode, we are able to kexec
load crash kernel into memory after which crash can be collected.

4. Kdump is not compatible with hardware watchdog resets

When a hardware watchdog causes a reset, software is not involved, and
therefore we lose the entire machine state.

5. Crash kernel requires memory reservation

Crash kernel can't use the memory that was used by the crashing
kernel, therefore memory must always be reserved that is wasted during
normal operation, and only contains the image of the crash kernel.

6. Crash kernel requires special image and two reboots

Special crash image is usually required to reduce the number of loaded
modules, and also to reduce the system to the bare minimum so that it
can be booted in the small reserved space. Also, after the crash
kernel collects the core dump, we reboot back to the normal kernel,
thus two reboots are needed in order to recover after the crash.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

On the other hand, powerpc can optionally use firmware assisted
kdump (fadump). The benefits of fadump:

1. reboot through firmware happens, and thus all devices are reset to
their initial state

2. memory for the crash kernel does not need to be reserved if CMA is
used and user pages do not need to be preserved (commonly there is no
need to preserve user pages to debug kernel panics).

3. fadump crash format is identical to kdump (ELF /proc/vmcore),
therefore tools are the same, i.e. crash(8), makedumpfile, and other
all can be used.

4. No need to have a special crash kernel image and no need to do a
second reboot from the crash kernel.

The following services are expected from firmware in order for fadump to wo=
rk:

1. Ability to do warm reboot

Preserve memory content across reboot. Firmware must not zero
(initialize) memory content. From my experience, this is actually
common nowadays: I see this happens on my AMD desktop with x570 chip +
UEFI BIOS, we do this at Microsoft both on larger Xeon servers with
UEFI firmware, and on small arm64 devices which use device trees instead
of EFI for performance reasons, and also to preserve emulated pmem
devices across reboot. We also did it at Oracle on SPARC sun4v machines
where sun4v hypervisor would not reset memory content on every reboot for
performance reasons.

2. Ability to register preserved memory region with firmware

The first kernel uses firmware to reserve a region of memory that must
be preserved when rebooted. Firmware and bootloader must not allocate
from preserved regions.

3. Ability to copy boot memory source to destination.

On powerpc, boot must start from a lower address, similar like on x86.
Also, boot memory is a region of memory that can be used by the kernel
to boot, and the rest is added later once the kernel decides to
unreserve it: i.e. after vmcore is saved.

The copy boot memory is not strictly necessary: the panicking kernel
can do the copy on platforms where boot must start from a lower
address, and on other platforms where boot can be done from any
address the copy is not needed at all (i.e. ARM64, x64).

What it comes down to is that there is little that firmware needs to
do in order to help Linux to do a more reliable crash dump. It must
provide an ability by the kernel to reserve a region of memory from
which firmware/bootloader won=E2=80=99t do allocations, and optionally on
platforms where the kernel must always boot from a predefined physical
address firmware should be able to copy boot memory content. The rest
can be done by the kernel alone.

Support for hardware watchdog resets is a little more complicated as
it would involve firmware to copy CPUs registers content to a
predefined place, but it should also be achievable.

We could agree on an interface that the kernel would support for both
EFI based firmware and device-tree based firmware. We could also add
this support to open source projects such as linuxboot, coreboot, OVMF
type of firmware and to boot loaders u-boot, grub.

Pasha
