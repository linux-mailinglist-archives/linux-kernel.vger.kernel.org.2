Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FA935B47A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhDKNC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 09:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235569AbhDKNC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 09:02:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EE7A610C8;
        Sun, 11 Apr 2021 13:02:38 +0000 (UTC)
Date:   Sun, 11 Apr 2021 14:02:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v16 0/9] arm64: ARMv8.5-A: MTE: Add async mode support
Message-ID: <20210411130236.GB23778@arm.com>
References: <20210315132019.33202-1-vincenzo.frascino@arm.com>
 <20210318185607.GD10758@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318185607.GD10758@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:56:07PM +0000, Catalin Marinas wrote:
> On Mon, Mar 15, 2021 at 01:20:10PM +0000, Vincenzo Frascino wrote:
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
> 
> Andrew, could you please pick these patches up via the mm tree? They
> depend on kasan patches already queued.

Andrew, are you ok for me to queue these patches via the arm64 tree for
5.13 or you'd rather take them in the mm tree? There is a conflict with
the mm tree in lib/test_kasan.c, I think commit ce816b430b5a ("kasan:
detect false-positives in tests").

Thanks.

-- 
Catalin
