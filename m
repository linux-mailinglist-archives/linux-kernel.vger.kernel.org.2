Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E45447E26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhKHKlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:41:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238668AbhKHKkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:40:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF4DA61359;
        Mon,  8 Nov 2021 10:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636367887;
        bh=xj1zISrLJM071lTGH9/U7IsLw03GBjukAVuQNFLuOtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTjpBMeiq1Xurb+GdXKUNM668W7EB9VmxXmVaCt4c2QaSR66OQCqYw0jwadLnybOA
         1cIS7Xfw3G2kDEsaAfb+gLZUWtID2QvdBdizRtoqGgPXYHFj3igkt74urNV9LArNZ+
         Ke3+2w5lZXMVCfSQwlatNdTobCywO4bs9OkG+SVWV6vCWqs8KXEeVs1e6MgYAGpbQp
         nGEtd4VO3Z31AZ6J0JbLqYjGmZoYBd0kKh8BadOMEkJ7yl3bNrItunA2mpJxr5Cwkq
         ZyJt+UBCq7YHlNWCQUsvWbFqbgwTpGIodHuFHF9mdzqkWjgkdeZhyNO8MtAvych8o0
         oI2vPUb+c74GQ==
From:   Will Deacon <will@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Potapenko <glider@google.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] arm64: Track no early_pgtable_alloc() for kmemleak
Date:   Mon,  8 Nov 2021 10:37:52 +0000
Message-Id: <163636592237.15032.12831105402698814160.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211105150509.7826-1-quic_qiancai@quicinc.com>
References: <20211105150509.7826-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2021 11:05:09 -0400, Qian Cai wrote:
> After switched page size from 64KB to 4KB on several arm64 servers here,
> kmemleak starts to run out of early memory pool due to a huge number of
> those early_pgtable_alloc() calls:
> 
>   kmemleak_alloc_phys()
>   memblock_alloc_range_nid()
>   memblock_phys_alloc_range()
>   early_pgtable_alloc()
>   init_pmd()
>   alloc_init_pud()
>   __create_pgd_mapping()
>   __map_memblock()
>   paging_init()
>   setup_arch()
>   start_kernel()
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: Track no early_pgtable_alloc() for kmemleak
      https://git.kernel.org/arm64/c/c6975d7cab5b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
