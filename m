Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F61C3A7E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhFOMyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhFOMyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:54:15 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79572C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 05:52:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G47W63pNVz9sW4;
        Tue, 15 Jun 2021 22:52:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1623761528;
        bh=Icb+q+99mGMHkizmtBN1gv1DUcQ6b92Tf4owk9sjY90=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pnXatRtX3O9PXLI5mzdJsplvq7g1pyZ1+MUMTntplevtUc2nTFaak6uBq7TruCS3a
         hUeC1OrUOrcf/b55EVfntUE3JV+E/cwO+jML5YibMTYuS/yyyXfx9uR9uDhEwl+1Xh
         ged7uLvcm1W53IPuFXxEPOgsrmsfTVQI4Qf4ZzqfgYgHdoShCpkwourJZhFyJdkhMU
         H4ac3kUMnafFLwaf+cEcCsZ8j3sHDjaeNXT8nPXhoU/9l8PI5YHwJpxvfWjaX+v4mE
         u5QLg70qHyFDAp1OYNE+LZbKRvhDBPb7P4wybPht/I9CgNTXSrzuPUNsoTU1XUI0DZ
         LdXCFaTT9goyA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3 22/23] powerpc/vdso: Migrate native signals to
 generic vdso_base
In-Reply-To: <20210611180242.711399-23-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
 <20210611180242.711399-23-dima@arista.com>
Date:   Tue, 15 Jun 2021 22:52:00 +1000
Message-ID: <87mtrrthn3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Safonov <dima@arista.com> writes:
> Generic way to track the land vma area.
> Stat speaks for itself.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/powerpc/Kconfig                          |  1 +
>  arch/powerpc/include/asm/book3s/32/mmu-hash.h |  1 -
>  arch/powerpc/include/asm/book3s/64/mmu.h      |  1 -
>  arch/powerpc/include/asm/mmu_context.h        |  9 ------
>  arch/powerpc/include/asm/nohash/32/mmu-40x.h  |  1 -
>  arch/powerpc/include/asm/nohash/32/mmu-44x.h  |  1 -
>  arch/powerpc/include/asm/nohash/32/mmu-8xx.h  |  1 -
>  arch/powerpc/include/asm/nohash/mmu-book3e.h  |  1 -
>  arch/powerpc/kernel/signal_32.c               |  8 ++---
>  arch/powerpc/kernel/signal_64.c               |  4 +--
>  arch/powerpc/kernel/vdso.c                    | 31 +------------------
>  arch/powerpc/perf/callchain_32.c              |  8 ++---
>  arch/powerpc/perf/callchain_64.c              |  4 +--
>  arch/x86/include/asm/mmu_context.h            |  5 ---
>  include/asm-generic/mm_hooks.h                |  9 ++----
>  mm/mmap.c                                     |  7 -----
>  16 files changed, 16 insertions(+), 76 deletions(-)

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
