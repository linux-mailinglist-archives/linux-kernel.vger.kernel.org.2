Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3800B434724
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJTIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:44:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhJTIos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:44:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A83A61004;
        Wed, 20 Oct 2021 08:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634719354;
        bh=MHBvccfg0JwTU+CXuSh0R6J6oYNHZE8t6dgpeztT6ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LFZW0NNmwO3pGqS9Aj8Lr9v1SepIjAQQ4SoZ0vSRlepepkzuAiH0qRQeGu6xP/tdl
         hiSUgcO5+mOqF1wvgyPIH7rtaXPdMygvwvtcsxhwaPCriOC83uOjEw76mwGJvPADwu
         4XfWUZ5zq70jVYnlOCnRwhnS3dlLJG1fAnQE9aLqYBJJ0QygG5/7QT/16gq8CAGj6w
         aUpfacbzDhd2jMGJGj3QmczB8daadDRUA8MvB2/8CQBv60QaMYEVaWmNU3jZfcQJu8
         dsalOTLgMjaNNdIssNHihAO7nZMccwUMQL62GH9VOgT4xVAb0spRKMeVvBmxRoRcci
         ofZgvHRSgsFdw==
Date:   Wed, 20 Oct 2021 11:42:28 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] memblock: exclude NOMAP regions from kmemleak
Message-ID: <YW/WdAnUP32Dhclh@kernel.org>
References: <20211013054756.12177-1-rppt@kernel.org>
 <c30ff0a2-d196-c50d-22f0-bd50696b1205@quicinc.com>
 <YW5bjV128Qk1foIv@kernel.org>
 <YW6t5tBe/IjSYWn3@arm.com>
 <089478ad-3755-b085-d9aa-c68e9792895c@quicinc.com>
 <YW7p3ARYbpxmeLCF@arm.com>
 <8da41896-dc11-8246-54cf-1174f617ac39@quicinc.com>
 <YW8PZ0Q5UeRH4W4R@kernel.org>
 <YW/Hb4sVWGOIxzUk@kernel.org>
 <YW/Q5kjvurcYVrow@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW/Q5kjvurcYVrow@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:18:46AM +0100, Catalin Marinas wrote:
> On Wed, Oct 20, 2021 at 10:38:23AM +0300, Mike Rapoport wrote:
> > On Tue, Oct 19, 2021 at 09:33:11PM +0300, Mike Rapoport wrote:
> > > On Tue, Oct 19, 2021 at 01:59:22PM -0400, Qian Cai wrote:
> > > > [	0.000000][	T0] Booting Linux on physical CPU 0x0000000000 [0x503f0002]
> > > > [	0.000000][	T0] Linux version 5.15.0-rc6-next-20211019+ (root@admin5) (gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #104 SMP Tue Oct 19 17:36:17 UTC 2021
> > > > [	0.000000][	T0] earlycon: pl11 at MMIO32 0x0000000012600000 (options '')
> > > > [	0.000000][	T0] printk: bootconsole [pl11] enabled
> > > > [	0.000000][	T0] efi: Getting UEFI parameters from /chosen in DT:
> > > > [	0.000000][	T0] efi:   System Table     	: 0x0000009ff7de0018
> > > > [	0.000000][	T0] efi:   MemMap Address   	: 0x0000009fe6dae018
> > > > [	0.000000][	T0] efi:   MemMap Size      	: 0x0000000000000600
> > > > [	0.000000][	T0] efi:   MemMap Desc. Size	: 0x0000000000000030
> > > > [	0.000000][	T0] efi:   MemMap Desc. Version : 0x0000000000000001
> > > > [	0.000000][	T0] efi: EFI v2.70 by American Megatrends
> > > > [	0.000000][	T0] efi: ACPI 2.0=0x9ff5b40000 SMBIOS 3.0=0x9ff686fd98 ESRT=0x9ff1d18298 MEMRESERVE=0x9fe6dacd98  
> > > > [	0.000000][	T0] efi: Processing EFI memory map:
> > > > [	0.000000][	T0] efi:   0x000090000000-0x000091ffffff [Conventional|   |  |  |  |  |  |  |  |  |   |WB|WT|WC|UC]
> > > > [	0.000000][	T0] efi:   0x000092000000-0x0000928fffff [Runtime Data|RUN|  |  |  |  |  |  |  |  |   |WB|WT|WC|UC]
> > > > [	0.000000][	T0] ------------[ cut here ]------------
> > > > [	0.000000][	T0] kernel BUG at mm/kmemleak.c:1140!
> > > > [	0.000000][	T0] Internal error: Oops - BUG: 0 [#1] SMP
> > > > 
> > > > I did not quite figure out where this BUG() was triggered and I did not
> > > 
> > > This is from here:
> > > arch/arm64/include/asm/memory.h:
> > > 
> > > #define PHYS_OFFSET         ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
> > > 
> > > kmemleak_free_part_phys() does __va() which uses PHYS_OFFSET and all this
> > > happens before memstart_addr is set.
> > > 
> > > I'll try to see how this can be untangled...
> >  
> > This late in the cycle I can only think of reverting kmemleak wavier from
> > memblock_mark_nomap() and putting it in
> > early_init_dt_alloc_reserved_memory_arch() being the only user setting
> > MEMBLOCK_NOMAP to an allocated chunk rather than marking NOMAP "unusable"
> > memory reported by firmware.
> 
> It makes sense, there aren't many places or nomap is called.
> 
> I think arch_reserve_mem_area() called from acpi_table_upgrade() also
> follows a memblock allocation. But I'd call kmemleak in
> acpi_table_upgrade() directly rather than in the arch back-end.

Hmm, not sure this is correct for x86. I don't see why can't it track the
memory allocated in acpi_table_upgrade().
 
> Regarding which callback, I think kmemleak_ignore_phys() is better
> suited here since kmemleak still keeps track of the object but won't
> scan it.

Ok.

-- 
Sincerely yours,
Mike.
