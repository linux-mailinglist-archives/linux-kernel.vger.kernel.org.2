Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA13639F9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhDSEE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:04:56 -0400
Received: from ozlabs.org ([203.11.71.1]:35679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233632AbhDSEEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:04:41 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVL75J0z9vGZ; Mon, 19 Apr 2021 14:04:10 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <7bf6f1600acad146e541a4e220940062f2e5b03d.1617895813.git.christophe.leroy@csgroup.eu>
References: <7bf6f1600acad146e541a4e220940062f2e5b03d.1617895813.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/9] powerpc/mem: Move cache flushing functions into mm/cacheflush.c
Message-Id: <161880480136.1398509.5120701716764549620.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 14:00:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 15:30:24 +0000 (UTC), Christophe Leroy wrote:
> Cache flushing functions are in the middle of completely
> unrelated stuff in mm/mem.c
> 
> Create a dedicated mm/cacheflush.c for those functions.
> 
> Also cleanup the list of included headers.

Applied to powerpc/next.

[1/9] powerpc/mem: Move cache flushing functions into mm/cacheflush.c
      https://git.kernel.org/powerpc/c/b26e8f27253a47bff90972b987112fd8396e9b8d
[2/9] powerpc/mem: Declare __flush_dcache_icache() static
      https://git.kernel.org/powerpc/c/bf26e0bbd2f82b52605cd7c880245eefe67e09f3
[3/9] powerpc/mem: Remove address argument to flush_coherent_icache()
      https://git.kernel.org/powerpc/c/131637a17dc97fde3d007ab224e30c7ff4e62f6e
[4/9] powerpc/mem: Call flush_coherent_icache() at higher level
      https://git.kernel.org/powerpc/c/e618c7aea1f2a2d615a99948f1f5cb4c11b6bf57
[5/9] powerpc/mem: Optimise flush_dcache_icache_hugepage()
      https://git.kernel.org/powerpc/c/cd97d9e8b5aa45a7f867a10e99f1d6ce0a5deb8b
[6/9] powerpc/mem: flush_dcache_icache_phys() is for HIGHMEM pages only
      https://git.kernel.org/powerpc/c/52d490437ffb1bab0a63ab7b1a64514d8c17dd4d
[7/9] powerpc/mem: Help GCC realise __flush_dcache_icache() flushes single pages
      https://git.kernel.org/powerpc/c/67b8e6af191a6ed717be548307eb15048f8181d8
[8/9] powerpc/mem: Inline flush_dcache_page()
      https://git.kernel.org/powerpc/c/6c96020882b17fb6f4fbf7f8cef8c606460fc14d
[9/9] powerpc/mem: Use kmap_local_page() in flushing functions
      https://git.kernel.org/powerpc/c/7e9ab144c128df7660a2f33c9c6d1422fe798060

cheers
