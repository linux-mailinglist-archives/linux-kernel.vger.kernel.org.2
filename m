Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDA941C8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245471AbhI2Pu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243284AbhI2Puz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:50:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92CC9613DA;
        Wed, 29 Sep 2021 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632930553;
        bh=tJRSZMcN6OL6Z3bkEpmzAtyL7foeosZpo1d1Bfhkyqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yni+YWJS5mSL4yiEUpgHvShyKbR3i1LD26qG9yGY8zBkwyh9/W5QdBMs4x5v5zbrI
         O2NTsg5hCeOW7kt75tC6vtfEJxn87NhtBW0PPXS0/Cib7ds2SdXKA1Rzg946vmtQo9
         SfwAkUFP1DfyLHxzi0ChivCbvzLukuNC58lelUNDck9Zz3IkgUHyp5Oa4tbnBJY9FB
         v01MSeo5iYTn3/ymUBcEMByK3vOLgZf6ZiWWLgFHHFG1Et5QYLp59G4KQqXbg5So+z
         Yrm9MrSLPrxVxJd49q/SqIsuW1NPhtFSRYj++178UcLF2ybjDUVBEXulbMSqLxGBdo
         k7KUxP8Lpz5Dw==
Date:   Wed, 29 Sep 2021 16:49:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 0/5] arm64: ARMv8.7-A: MTE: Add asymm mode support
Message-ID: <20210929154907.GC22029@willie-the-truck>
References: <20210913081424.48613-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913081424.48613-1-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 09:14:19AM +0100, Vincenzo Frascino wrote:
> This series implements the asymmetric mode support for ARMv8.7-A Memory
> Tagging Extension (MTE), which is a debugging feature that allows to
> detect with the help of the architecture the C and C++ programmatic
> memory errors like buffer overflow, use-after-free, use-after-return, etc.
> 
> MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
> (Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
> subset of its address space that is multiple of a 16 bytes granule. MTE
> is based on a lock-key mechanism where the lock is the tag associated to
> the physical memory and the key is the tag associated to the virtual
> address.
> 
> When MTE is enabled and tags are set for ranges of address space of a task,
> the PE will compare the tag related to the physical memory with the tag
> related to the virtual address (tag check operation). Access to the memory
> is granted only if the two tags match. In case of mismatch the PE will raise
> an exception.
> 
> When asymmetric mode is present, the CPU triggers a fault on a tag mismatch
> during a load operation and asynchronously updates a register when a tag
> mismatch is detected during a store operation.
> 
> The series is based on linux-v5.15-rc1.
> 
> To simplify the testing a tree with the new patches on top has been made
> available at [1].
> 
> [1] https://git.gitlab.arm.com/linux-arm/linux-vf.git mte/v1.asymm
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
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Vincenzo Frascino (5):
>   kasan: Remove duplicate of kasan_flag_async
>   arm64: mte: Bitfield definitions for Asymm MTE
>   arm64: mte: CPU feature detection for Asymm MTE
>   arm64: mte: Add asymmetric mode support
>   kasan: Extend KASAN mode kernel parameter
> 
>  Documentation/dev-tools/kasan.rst  | 10 ++++++++--

I'm surprised not to see any update to:

	Documentation/arm64/memory-tagging-extension.rst

particularly regarding the per-cpu preferred tag checking modes. Is
asymmetric mode not supported there?

Will
