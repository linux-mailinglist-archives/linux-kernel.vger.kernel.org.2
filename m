Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4745235DB90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbhDMJsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 05:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230386AbhDMJsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 05:48:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 572C0613B6;
        Tue, 13 Apr 2021 09:47:54 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Subject: Re: [PATCH v16 0/9] arm64: ARMv8.5-A: MTE: Add async mode support
Date:   Tue, 13 Apr 2021 10:47:37 +0100
Message-Id: <161830715687.1113.4436583872879811764.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210315132019.33202-1-vincenzo.frascino@arm.com>
References: <20210315132019.33202-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 13:20:10 +0000, Vincenzo Frascino wrote:
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
> [...]

Applied to arm64 (for-next/mte-async-kernel-mode) but with a note that
I'll drop them if Andrew prefers to take the patches via the mm tree.
Thanks!

[1/9] arm64: mte: Add asynchronous mode support
      https://git.kernel.org/arm64/c/f3b7deef8dca
[2/9] kasan: Add KASAN mode kernel parameter
      https://git.kernel.org/arm64/c/2603f8a78dfb
[3/9] arm64: mte: Drop arch_enable_tagging()
      https://git.kernel.org/arm64/c/c137c6145b11
[4/9] kasan: Add report for async mode
      https://git.kernel.org/arm64/c/8f7b5054755e
[5/9] arm64: mte: Enable TCO in functions that can read beyond buffer limits
      https://git.kernel.org/arm64/c/e60beb95c08b
[6/9] arm64: mte: Conditionally compile mte_enable_kernel_*()
      https://git.kernel.org/arm64/c/d8969752cc4e
[7/9] arm64: mte: Enable async tag check fault
      https://git.kernel.org/arm64/c/65812c6921cc
[8/9] arm64: mte: Report async tag faults before suspend
      https://git.kernel.org/arm64/c/eab0e6e17d87
[9/9] kasan, arm64: tests supports for HW_TAGS async mode
      https://git.kernel.org/arm64/c/e80a76aa1a91

-- 
Catalin

