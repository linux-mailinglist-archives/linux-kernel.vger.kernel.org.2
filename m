Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C9130672A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 23:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhA0WUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237124AbhA0WUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:20:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCB5D64D9F;
        Wed, 27 Jan 2021 22:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611785986;
        bh=8Vumxy5sgtpiFy5Xedhu2PELo2yTfRiVO0cxvR9NpfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+exvneJjPwNmemiRRMMCCDV/jP1oLJ+aQrEuREFMgspANJbkg/FXhudzP0yP5ZgM
         1M8NHZBFIDOjbAFW3MA8I6puVO2XtP1rBLsFBsQxsanYPgsnkfK/0r+29S43cbxuNb
         UoPD74xkSFx69/x/gKvJvsx2263rEFhrBxYOOVuw2bVe7+I5H8ZvVDJ/z7k0btPMIi
         TqgIDTKznePyr7bNU6IqXYU9ZTXyShdxFiu1FMZDCwOyB0/yTXGI5IGM+F0tWtL7Um
         zKdO6hEwFFBGn0uJvP+E9EIcI1f9o1FQS9FFQxa/3t+HGtQx6/HruxigoOs2HM+f4a
         rYRFwy8YdNtPQ==
Date:   Wed, 27 Jan 2021 22:19:39 +0000
From:   Will Deacon <will@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Subject: Re: [PATCH v9 0/4] arm64: ARMv8.5-A: MTE: Add async mode support
Message-ID: <20210127221939.GA848@willie-the-truck>
References: <20210126134603.49759-1-vincenzo.frascino@arm.com>
 <CAAeHK+xTWrdJ2as6kBLX+z64iu3e6JEGppOkN-i_jsH74c6xoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xTWrdJ2as6kBLX+z64iu3e6JEGppOkN-i_jsH74c6xoA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 09:00:17PM +0100, Andrey Konovalov wrote:
> On Tue, Jan 26, 2021 at 2:46 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> >
> > This patchset implements the asynchronous mode support for ARMv8.5-A
> > Memory Tagging Extension (MTE), which is a debugging feature that allows
> > to detect with the help of the architecture the C and C++ programmatic
> > memory errors like buffer overflow, use-after-free, use-after-return, etc.
> >
> > MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
> > (Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
> > subset of its address space that is multiple of a 16 bytes granule. MTE
> > is based on a lock-key mechanism where the lock is the tag associated to
> > the physical memory and the key is the tag associated to the virtual
> > address.
> > When MTE is enabled and tags are set for ranges of address space of a task,
> > the PE will compare the tag related to the physical memory with the tag
> > related to the virtual address (tag check operation). Access to the memory
> > is granted only if the two tags match. In case of mismatch the PE will raise
> > an exception.
> >
> > The exception can be handled synchronously or asynchronously. When the
> > asynchronous mode is enabled:
> >   - Upon fault the PE updates the TFSR_EL1 register.
> >   - The kernel detects the change during one of the following:
> >     - Context switching
> >     - Return to user/EL0
> >     - Kernel entry from EL1
> >     - Kernel exit to EL1
> >   - If the register has been updated by the PE the kernel clears it and
> >     reports the error.
> >
> > The series is based on linux-next/akpm.
> >
> > To simplify the testing a tree with the new patches on top has been made
> > available at [1].
> >
> > [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v10.async.akpm
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Marco Elver <elver@google.com>
> > Cc: Evgenii Stepanov <eugenis@google.com>
> > Cc: Branislav Rankov <Branislav.Rankov@arm.com>
> > Cc: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Tested-by: Andrey Konovalov <andreyknvl@google.com>
> 
> > Vincenzo Frascino (4):
> >   arm64: mte: Add asynchronous mode support
> >   kasan: Add KASAN mode kernel parameter
> >   kasan: Add report for async mode
> >   arm64: mte: Enable async tag check fault
> 
> Andrew, could you pick this up into mm? The whole series will need to
> go through mm due to dependencies on the patches that are already
> there.

Please can you check that it doesn't conflict with the arm64 for-next/core
branch first?

Will
