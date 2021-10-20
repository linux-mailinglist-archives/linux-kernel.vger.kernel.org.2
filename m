Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163174345F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhJTHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhJTHkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:40:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 158C36115A;
        Wed, 20 Oct 2021 07:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634715512;
        bh=hHwnLaLrOlh4ein+wgq0kGtFmejmYnZL6dYr/jOIn5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAIJl8wJ8s8EoUbawaoqyPQL5Q05zIweAja6WxDHbET41ALyEyRUfbBw/CPY8EmSQ
         t+MEWDGuedLJ3/n+XpQU688pxD4HDU+jiUbW0m98ClZhiwcie8f1twRsnDAH4oswA5
         r3mJGmCjJMnPp3Zn33hy0RnR1iZtOBdkY7J+XWVQcZtC4Fh9hmWToKeKny0FoFB1yI
         KGzK4s1ovvbOzdF1NCFHEEc7w56C+b2d7XoMWA4QGfS02Jmt8STD0xr9qYJst/Zkl9
         EZWtjH0gGs47qRwFdCy3bGeMDbP2x2CCqR+WRMlw29/1pl3XaiYWujZFMfgqiUaSaZ
         hCYOqYjTk7FxQ==
Date:   Wed, 20 Oct 2021 10:38:23 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] memblock: exclude NOMAP regions from kmemleak
Message-ID: <YW/Hb4sVWGOIxzUk@kernel.org>
References: <20211013054756.12177-1-rppt@kernel.org>
 <c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com>
 <YW5bjV128Qk1foIv@kernel.org>
 <YW6t5tBe/IjSYWn3@arm.com>
 <089478ad-3755-b085-d9aa-c68e9792895c@quicinc.com>
 <YW7p3ARYbpxmeLCF@arm.com>
 <8da41896-dc11-8246-54cf-1174f617ac39@quicinc.com>
 <YW8PZ0Q5UeRH4W4R@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW8PZ0Q5UeRH4W4R@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 09:33:11PM +0300, Mike Rapoport wrote:
> On Tue, Oct 19, 2021 at 01:59:22PM -0400, Qian Cai wrote:
> > 
> > On 10/19/2021 11:53 AM, Catalin Marinas wrote:
> > > Thanks. I guess the log here is with the Mike's patch reverted.
> > 
> > Yes.
> > 
> > > Try "earlycon=pl011,mmio32,0x12600000" on the kernel command line
> > > and hopefully we get some early log.
> > 
> > Thanks for the suggestion, Catalin. I did not realize that a
> > manually-provided "earlycon" started earlier than just "earlycon"
> > and not defer to ACPI to populate parameters. Anyway,
> > 
> > [	0.000000][	T0] Booting Linux on physical CPU 0x0000000000 [0x503f0002]
> > [	0.000000][	T0] Linux version 5.15.0-rc6-next-20211019+ (root@admin5) (gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #104 SMP Tue Oct 19 17:36:17 UTC 2021
> > [	0.000000][	T0] earlycon: pl11 at MMIO32 0x0000000012600000 (options '')
> > [	0.000000][	T0] printk: bootconsole [pl11] enabled
> > [	0.000000][	T0] efi: Getting UEFI parameters from /chosen in DT:
> > [	0.000000][	T0] efi:   System Table     	: 0x0000009ff7de0018
> > [	0.000000][	T0] efi:   MemMap Address   	: 0x0000009fe6dae018
> > [	0.000000][	T0] efi:   MemMap Size      	: 0x0000000000000600
> > [	0.000000][	T0] efi:   MemMap Desc. Size	: 0x0000000000000030
> > [	0.000000][	T0] efi:   MemMap Desc. Version : 0x0000000000000001
> > [	0.000000][	T0] efi: EFI v2.70 by American Megatrends
> > [	0.000000][	T0] efi: ACPI 2.0=0x9ff5b40000 SMBIOS 3.0=0x9ff686fd98 ESRT=0x9ff1d18298 MEMRESERVE=0x9fe6dacd98  
> > [	0.000000][	T0] efi: Processing EFI memory map:
> > [	0.000000][	T0] efi:   0x000090000000-0x000091ffffff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|WT|WC|UC]
> > [	0.000000][	T0] efi:   0x000092000000-0x0000928fffff [Runtime Data|RUN|  |  |  |  |  |  |  |  |   |WB|WT|WC|UC]
> > [	0.000000][	T0] ------------[ cut here ]------------
> > [	0.000000][	T0] kernel BUG at mm/kmemleak.c:1140!
> > [	0.000000][	T0] Internal error: Oops - BUG: 0 [#1] SMP
> > 
> > I did not quite figure out where this BUG() was triggered and I did not
> 
> This is from here:
> arch/arm64/include/asm/memory.h:
> 
> #define PHYS_OFFSET         ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
> 
> kmemleak_free_part_phys() does __va() which uses PHYS_OFFSET and all this
> happens before memstart_addr is set.
> 
> I'll try to see how this can be untangled...
 
This late in the cycle I can only think of reverting kmemleak wavier from
memblock_mark_nomap() and putting it in
early_init_dt_alloc_reserved_memory_arch() being the only user setting
MEMBLOCK_NOMAP to an allocated chunk rather than marking NOMAP "unusable"
memory reported by firmware.

Thoughts?

-- 
Sincerely yours,
Mike.
