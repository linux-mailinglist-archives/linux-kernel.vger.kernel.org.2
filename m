Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0499142504F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 11:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbhJGJuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 05:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231797AbhJGJuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:50:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5343E6117A;
        Thu,  7 Oct 2021 09:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633600105;
        bh=CJtI7f8Rh9Fv++7pKPZEjjbm1cWva+2zCLRS+PeQ0fQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBohsxHTk9tBwDOAjZzghbX5J3brnFoPCeHbXYXwhFdNnmMioRWJPIsPzTq+npsPx
         sI7qa0GVljtTEkUUGyVFBwsgQZSkkGeym2RC5kMQADgpkmjgSnoHJtH1bwe+5XJotk
         fks76cDexb+ojSLodvdSTFw3InQLkLpi0kaCmZElxDUQpvHUzm0I+pWgd3gz1GQeIJ
         bzU4Kb/bF2sIn2IAmE2Dk8i77QwT/9P+amPj+qTa5lWIhjSXytsClypJSgPZZPs4Ht
         xXh/JwqtaGqoq4pHkiKX6WQkcbf93WdN/gavkTQUD5FjhgDbfIFpAF0Qu8+BdmFcN6
         NQP1M7Pog4V+Q==
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH v3 0/5] arm64: ARMv8.7-A: MTE: Add asymm in-kernel support
Date:   Thu,  7 Oct 2021 10:48:16 +0100
Message-Id: <163359491823.3122938.443758719431046592.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211006154751.4463-1-vincenzo.frascino@arm.com>
References: <20211006154751.4463-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 16:47:46 +0100, Vincenzo Frascino wrote:
> This series implements the in-kernel asymmetric mode support for
> ARMv8.7-A Memory Tagging Extension (MTE), which is a debugging feature
> that allows to detect with the help of the architecture the C and C++
> programmatic memory errors like buffer overflow, use-after-free,
> use-after-return, etc.
> 
> MTE is built on top of the AArch64 v8.0 virtual address tagging TBI
> (Top Byte Ignore) feature and allows a task to set a 4 bit tag on any
> subset of its address space that is multiple of a 16 bytes granule. MTE
> is based on a lock-key mechanism where the lock is the tag associated to
> the physical memory and the key is the tag associated to the virtual
> address.
> 
> [...]

Applied to arm64 (for-next/mte), thanks!

[1/5] kasan: Remove duplicate of kasan_flag_async
      https://git.kernel.org/arm64/c/f5627ec1ff2c
[2/5] arm64: mte: Bitfield definitions for Asymm MTE
      https://git.kernel.org/arm64/c/ba1a98e8b172
[3/5] arm64: mte: CPU feature detection for Asymm MTE
      https://git.kernel.org/arm64/c/d73c162e0733
[4/5] arm64: mte: Add asymmetric mode support
      https://git.kernel.org/arm64/c/ec0288369f0c
[5/5] kasan: Extend KASAN mode kernel parameter
      https://git.kernel.org/arm64/c/2d27e5851473

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
