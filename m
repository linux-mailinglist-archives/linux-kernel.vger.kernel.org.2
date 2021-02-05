Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6B31118D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhBESLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:11:45 -0500
Received: from foss.arm.com ([217.140.110.172]:36748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233109AbhBEPU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:20:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 081A9106F;
        Fri,  5 Feb 2021 08:54:43 -0800 (PST)
Received: from [10.37.8.15] (unknown [10.37.8.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3202E3F718;
        Fri,  5 Feb 2021 08:54:41 -0800 (PST)
Subject: Re: [PATCH v11 0/5] arm64: ARMv8.5-A: MTE: Add async mode support
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20210130165225.54047-1-vincenzo.frascino@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1477c6da-a0fe-903c-4257-84c45908c836@arm.com>
Date:   Fri, 5 Feb 2021 16:58:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210130165225.54047-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/21 4:52 PM, Vincenzo Frascino wrote:
> This patchset implements the asynchronous mode support for ARMv8.5-A
> Memory Tagging Extension (MTE), which is a debugging feature that allows
> to detect with the help of the architecture the C and C++ programmatic
> memory errors like buffer overflow, use-after-free, use-after-return, etc.
> 
> MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
> (Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
> subset of its address space that is multiple of a 16 bytes granule. MTE
> is based on a lock-key mechanism where the lock is the tag associated to
> the physical memory and the key is the tag associated to the virtual
> address.
> When MTE is enabled and tags are set for ranges of address space of a task,
> the PE will compare the tag related to the physical memory with the tag
> related to the virtual address (tag check operation). Access to the memory
> is granted only if the two tags match. In case of mismatch the PE will raise
> an exception.
> 
> The exception can be handled synchronously or asynchronously. When the
> asynchronous mode is enabled:
>   - Upon fault the PE updates the TFSR_EL1 register.
>   - The kernel detects the change during one of the following:
>     - Context switching
>     - Return to user/EL0
>     - Kernel entry from EL1
>     - Kernel exit to EL1
>   - If the register has been updated by the PE the kernel clears it and
>     reports the error.
> 
> The series is based on linux-next/akpm.
>

We are suspecting an issue with with the kernel access nofault functions
triggering async faults that impacts Android init process.
Please do not merge this series until this is sorted.

> To simplify the testing a tree with the new patches on top has been made
> available at [1].
> 
> [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v10.async.akpm
> 
> Changes:
> --------
> v11:
>   - Added patch that disables KUNIT tests in async mode
> v10:
>   - Rebase on the latest linux-next/akpm
>   - Address review comments.
> v9:
>   - Rebase on the latest linux-next/akpm
>   - Address review comments.
> v8:
>   - Address review comments.
> v7:
>   - Fix a warning reported by kernel test robot. This
>     time for real.
> v6:
>   - Drop patches that forbid KASAN KUNIT tests when async
>     mode is enabled.
>   - Fix a warning reported by kernel test robot.
>   - Address review comments.
> v5:
>   - Rebase the series on linux-next/akpm.
>   - Forbid execution for KASAN KUNIT tests when async
>     mode is enabled.
>   - Dropped patch to inline mte_assign_mem_tag_range().
>   - Address review comments.
> v4:
>   - Added support for kasan.mode (sync/async) kernel
>     command line parameter.
>   - Addressed review comments.
> v3:
>   - Exposed kasan_hw_tags_mode to convert the internal
>     KASAN represenetation.
>   - Added dsb() for kernel exit paths in arm64.
>   - Addressed review comments.
> v2:
>   - Fixed a compilation issue reported by krobot.
>   - General cleanup.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Evgenii Stepanov <eugenis@google.com>
> Cc: Branislav Rankov <Branislav.Rankov@arm.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Andrey Konovalov (1):
>   kasan: don't run tests in async mode
> 
> Vincenzo Frascino (4):
>   arm64: mte: Add asynchronous mode support
>   kasan: Add KASAN mode kernel parameter
>   kasan: Add report for async mode
>   arm64: mte: Enable async tag check fault
> 
>  Documentation/dev-tools/kasan.rst  |  9 +++++
>  arch/arm64/include/asm/memory.h    |  3 +-
>  arch/arm64/include/asm/mte-kasan.h |  9 ++++-
>  arch/arm64/include/asm/mte.h       | 32 ++++++++++++++++
>  arch/arm64/kernel/entry-common.c   |  6 +++
>  arch/arm64/kernel/mte.c            | 60 +++++++++++++++++++++++++++++-
>  include/linux/kasan.h              |  6 +++
>  lib/test_kasan.c                   |  6 ++-
>  mm/kasan/hw_tags.c                 | 51 ++++++++++++++++++++++++-
>  mm/kasan/kasan.h                   |  7 +++-
>  mm/kasan/report.c                  | 17 ++++++++-
>  11 files changed, 196 insertions(+), 10 deletions(-)
> 

-- 
Regards,
Vincenzo
