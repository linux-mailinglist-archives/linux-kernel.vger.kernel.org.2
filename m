Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309753874BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347826AbhERJJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347853AbhERJI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:08:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78313C06138F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z17so9310942wrq.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADDayVk4Qz3RebSncnQnj7JK7MDvRH4LKy1tOcA7Z5U=;
        b=oJAxGGq4pSoZdHoGLHa8cdOV68iYQlw6AoMfnSwxAxhPbZrN73s5i48kGm1iT9/RP7
         L57o+mz87fNmXrhHRx3O8FWlcGe+vDadMt7LABzz+QyOHAUHl2NAecc4tKl2L1bRwEqA
         7tiReT3KRaE4BdjmBcjkB9khA7HJ82uhWfpZCveiCA0ZTqxRATiEO7P0OGmsaLZyzaq7
         upPLsPch3pGRRmAcprqzHJuNYLbi0WpNm5N7iHU8wsK96GFAhc1+wFBFIaJig8/xqVrL
         HxVT0/g3TcyNthPRRdhyxAXcspLLHteb4Uowj2nEA4Lwj3D1x6j0bcIh+5YpFiBjl5Ay
         bHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADDayVk4Qz3RebSncnQnj7JK7MDvRH4LKy1tOcA7Z5U=;
        b=l+IlkNPimsr9snEo9+JIKvsdKFkiVlHqAnm8zJtSps6q2DmilMh4dtcY3a4dN+hJTU
         ngfEBABLFng/nv7IVqdNZpnyTWFkDXe7cGR+ws4w5TN3Mq0yG+eeCYab/QD6I0dE4zbN
         DeBPD4l2KSfmVeVEAXgKp5OOxJ9hnHDRuo6cQFCz/y1+KjjxSMZaqOpoie3RMuh47qUY
         LhqIIazYCiko/5im8w6Dp8Sbk/c5EoyO6z0NNS/4kBoUB5UiyRvk9w30iTs1L8Mr3bLr
         OqfdfgPy5/X7KIxEOh2EBrjRyLxTgG3vI524QnPb5QA/h1rSaOhRWOb6WDrMGRA2j237
         Q1NQ==
X-Gm-Message-State: AOAM533l8nycBWoh+s+BLGlFAu8R8ycML1oGXHXDawKyAASJiMo1q0//
        dxGpxjlLzrKz5zscGnLtEvo1xVfjHkKIMGaS
X-Google-Smtp-Source: ABdhPJydhN3IpzYYwVZJCX41dvMvdVUEKRUFLXKFely2dl1uRFiMKVyQVJ7A6A69OTPFG2NIiElKPg==
X-Received: by 2002:adf:f80f:: with SMTP id s15mr5471649wrp.341.1621328827182;
        Tue, 18 May 2021 02:07:07 -0700 (PDT)
Received: from amanieu-laptop.home ([2a00:23c6:f081:f801:91cf:b949:c46c:f5a9])
        by smtp.gmail.com with ESMTPSA id z17sm7520306wrt.81.2021.05.18.02.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 02:07:06 -0700 (PDT)
From:   Amanieu d'Antras <amanieu@gmail.com>
Cc:     Amanieu d'Antras <amanieu@gmail.com>,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 0/8] arm64: Allow 64-bit tasks to invoke compat syscalls
Date:   Tue, 18 May 2021 10:06:50 +0100
Message-Id: <20210518090658.9519-1-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series allows AArch64 tasks to perform 32-bit syscalls by setting
the top bit of x8 and using AArch32 compat syscall numbers:

    syscall(0x80000000 | __ARM_NR_write, 1, "foo\n", 4);

Internally, setting this bit does the following:
- The remainder of x8 is treated as a compat syscall number and is used
  to index the compat syscall table.
- in_compat_syscall will return true for the duration of the syscall.
- VM allocations performed by the syscall will be located in the lower
  4G of the address space. A separate compat_mmap_base is used so that
  these allocations are still properly randomized.
- Interrupted compat syscalls are properly restarted as compat syscalls.
- Seccomp will treats the syscall as having AUDIT_ARCH_ARM instead of
  AUDIT_ARCH_AARCH64. This affects the arch value seen by seccomp
  filters and reported by SIGSYS.
- PTRACE_GET_SYSCALL_INFO also treats the syscall as having
  AUDIT_ARCH_ARM. Recent versions of strace will correctly report the
  syscall name and parameters when an AArch64 task mixes 32-bit and
  64-bit syscalls.

This feature is intended for use in software compatibility layers which
emulate a 32-bit program on AArch64. This patch has been tested on two
such emulators:
- Tango [1], which enables AArch32 binaries to run on AArch64 CPUs which
  do not have hardware support for AArch32. Tango is used to run virtual
  Android devices on AArch64 servers.
- FEX [2], an emulator for running x86 and x86_64 binaries on AArch64.
  FEX can already run many x86_64 programs including 3D games, but
  requires kernel support for running 32-bit x86 binaries.

Both FEX and Tango have previously attempted to translate 32-bit
syscalls purely in user mode like QEMU does for its user mode
emulation. While this works for simple programs, there are many
limitations which cannot be solved without kernel support, for example:
- There are a huge number of ioctls which behave differently in 32-bit
  mode. It is impractical and error prone to manually emulate them all
  in user mode. Specifically, the kernel already has a well-tested and
  reliable compatibility layer and it makes sense to reuse this. QEMU
  supports emulating some ioctls in userspace but this still does not
  cover devices like GPUs which are needed for accelerated rendering.
- The 64-bit set_robust_list is not compatible with the 32-bit ABI. The
  compat version of set_robust_list must be used. Emulating this in user
  mode is not reliable since SIGKILL cannot be caught.
- io_uring uses iovec structures as part of its API, which have
  different sizes on 32-bit and 64-bit.
- ext4 represents positions in directories as 64-bit hashes, which break
  if they are truncated to 32 bits. There is special support for 32-bit
  off_t in the ext4 driver but this is only used when in_compat_syscall
  is true: https://bugzilla.kernel.org/show_bug.cgi?id=205957
- The io_setup syscall allocates a VM area for the AIO context and
  returns it. But there is no way to control where this context is
  allocated so it will almost always end up above the 4GB limit.
- Some ioctls will also perform VM allocations, with the same issues as
  io_setup. Search for "vm_mmap" in drivers/.
- Some file descriptors have alignment requirements which are not known
  to userspace. For example, a hugetlbfs file can only be mmaped at a
  huge page alignment but there is no way for userspace to know this
  when it needs to manually select an address below 4GB for the mapping.

All of these issues are solved in FEX and Tango by invoking compat
syscalls directly. In the case of FEX, there remain some differences
between the arm and x86 ABIs due to alignment issues, but these are few
enough to be individually handled in userspace.

There is a precedent for exposing this functionality to userspace:
x86_64 has 2 ways to invoke 32-bit syscalls. The first is to use int
0x80 with a 32-bit syscall number and the second is to use
__X32_SYSCALL_BIT with a 64-bit syscall number. As such, the generic
kernel code is already able to properly handle tasks that invoke both
32-bit and 64-bit syscalls.

[1] https://www.amanieusystems.com/
[2] https://github.com/FEX-Emu/FEX

Changelog since v3:
- Renamed aarch64_compat_syscall to use_compat_syscall and enable it
  permanently for AArch32 tasks.

Changelog since v2:
- Complete rewrite, based on the patch that was previously posted as:
  [PATCH v2] [RFC] arm64: Exposes support for 32-bit syscalls

Amanieu d'Antras (8):
  mm: Add arch_get_mmap_base_topdown macro
  hugetlbfs: Use arch_get_mmap_* macros
  mm: Support mmap_compat_base with the generic layout
  arm64: Separate in_compat_syscall from is_compat_task
  arm64: mm: Use HAVE_ARCH_COMPAT_MMAP_BASES
  arm64: Add a compat syscall flag to thread_info
  arm64: Forbid calling compat sigreturn from 64-bit tasks
  arm64: Allow 64-bit tasks to invoke compat syscalls

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/compat.h      | 24 ++++++++++++---
 arch/arm64/include/asm/elf.h         | 21 ++++++++++---
 arch/arm64/include/asm/ftrace.h      |  2 +-
 arch/arm64/include/asm/processor.h   | 32 +++++++++++--------
 arch/arm64/include/asm/syscall.h     |  6 ++--
 arch/arm64/include/asm/thread_info.h |  6 ++++
 arch/arm64/include/uapi/asm/unistd.h |  2 ++
 arch/arm64/kernel/ptrace.c           |  2 +-
 arch/arm64/kernel/signal.c           |  5 +++
 arch/arm64/kernel/signal32.c         |  8 +++++
 arch/arm64/kernel/syscall.c          | 23 ++++++++++++--
 arch/arm64/mm/mmap.c                 | 33 ++++++++++++++++++++
 fs/hugetlbfs/inode.c                 | 22 ++++++++++---
 mm/mmap.c                            | 14 ++++++---
 mm/util.c                            | 46 +++++++++++++++++++++++-----
 16 files changed, 202 insertions(+), 45 deletions(-)

-- 
2.31.1

