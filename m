Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195E23EDD55
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhHPSvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhHPSvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:51:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02D0860F35;
        Mon, 16 Aug 2021 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629139836;
        bh=LxwCB0dEXSFWp0Koknfu2wbU6Ki3lHdsZgoVEtbnQkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KByfxGcCEC/ScmfCWUuXLIDSI6+j03UT8G1IYez+IJYvLhI3+/6PaBzWEBpNdwMTc
         92um5cMbWJfPxYtEQFqQExlB+IuA2RgXwvu/88tU9h7sB9qrkEJl60xj32cNQINELM
         bW95ZIh6HTFqHXD1I4FP9d6vrLQsv3ugiv3G8EOkC8SRovXwvtoCkmFJ8tlNG0l8VQ
         Vzv19MLgziT3Qtpcml0KfbQV6J6I6PsJX6GQ4R9atM/TrkKm+PQAs2Uqd11e7kouSs
         xHdH49+NQXJTx3cMHNnTrHUo1Kbxi0ReB7xISJRd5SY4m3qUkDoJYaScjdE8uc8wN6
         xuJRXaMj8nAoQ==
Date:   Mon, 16 Aug 2021 21:50:26 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 1/1] riscv: select CONFIG_ARCH_KEEP_MEMBLOCK
Message-ID: <YRqzckNDbg0awrh4@kernel.org>
References: <20210816144728.1425121-1-heinrich.schuchardt@canonical.com>
 <bef20bf2-538d-1319-ba22-6774efa10ebc@huawei.com>
 <d9d9f764-2bc7-ddf4-2353-dac323e4416d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9d9f764-2bc7-ddf4-2353-dac323e4416d@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heinrich,

On Mon, Aug 16, 2021 at 05:52:11PM +0200, Heinrich Schuchardt wrote:
> On 8/16/21 5:30 PM, Kefeng Wang wrote:
> > 
> > On 2021/8/16 22:47, Heinrich Schuchardt wrote:
> > > For analyzing memory blocks we can either use the memblock=debug command
> > > line argument which creates massive output or a debug file system.
> > > 
> > > Select CONFIG_ARCH_KEEP_MEMBLOCK to provide a debugfs at
> > > /sys/kernel/debug/memblock to analyze memory blocks. The
> > > same is already done for arm, arm64, mips, powerpc.
> > > 
> > > The actual provisioning of the file system depends on CONFIG_DEBUG_FS.
> > 
> > Hi，for riscv, it don't use memblock(eg, no provide pfn_valid to use
> > memblock),
> > 
> > we could call memblock_discard() to discard memblock private memory to save
> > 
> > some memory, right?  So I think we don't need this config for now.
> 
> What do you mean by "it don't use memblock?
> 
> If you boot the HiFive Unmatched with memblock=debug you will see output
> like the one below. This is the information that you can see in the debug
> file system if CONFIG_DEBUG_FS and CONFIG_ARCH_KEEP_MEMBLOCK will be
> enabled.

Indeed having this info in debugfs is more convenient, but it comes with a
cost of several kilobytes of code and data for *every* riscv build.

Why parsing "memblock=debug" output is not enough?
What is the use-case that justifies the costs associated with having the
debugfs entries?
 
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x00000003ffe00000 reserved size =
> 0x000000001290fb70
> [    0.000000]  memory.cnt  = 0x25

BTW, it seems that the memory allocation by firmware is, well, suboptimal
and begs for fixes. I don't see why all these NOMAP areas cannot be put in
one contiguous chunk. I doubt they need to be NOMAP at all, but mysterious
the ways of ACPI.

> [    0.000000]  memory[0x0]     [0x0000000080200000-0x00000000fe6e2fff],
> 0x000000007e4e3000 bytes flags: 0x0
> [    0.000000]  memory[0x1]     [0x00000000fe6e3000-0x00000000fe6e5fff],
> 0x0000000000003000 bytes flags: 0x4
> [    0.000000]  memory[0x2]     [0x00000000fe6e6000-0x00000000fe709fff],
> 0x0000000000024000 bytes flags: 0x0
> [    0.000000]  memory[0x3]     [0x00000000fe70a000-0x00000000fe70bfff],
> 0x0000000000002000 bytes flags: 0x4
> [    0.000000]  memory[0x4]     [0x00000000fe70c000-0x00000000fe70ffff],
> 0x0000000000004000 bytes flags: 0x0
> [    0.000000]  memory[0x5]     [0x00000000fe710000-0x00000000fe710fff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x6]     [0x00000000fe711000-0x00000000fe712fff],
> 0x0000000000002000 bytes flags: 0x0
> [    0.000000]  memory[0x7]     [0x00000000fe713000-0x00000000fe716fff],
> 0x0000000000004000 bytes flags: 0x4
> [    0.000000]  memory[0x8]     [0x00000000fe717000-0x00000000fe717fff],
> 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  memory[0x9]     [0x00000000fe718000-0x00000000fe71cfff],
> 0x0000000000005000 bytes flags: 0x4
> [    0.000000]  memory[0xa]     [0x00000000fe71d000-0x00000000fe71dfff],
> 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  memory[0xb]     [0x00000000fe71e000-0x00000000fe71efff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0xc]     [0x00000000fe71f000-0x00000000fe71ffff],
> 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  memory[0xd]     [0x00000000fe720000-0x00000000fe720fff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0xe]     [0x00000000fe721000-0x00000000fe721fff],
> 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  memory[0xf]     [0x00000000fe722000-0x00000000fe722fff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x10]    [0x00000000fe723000-0x00000000fe723fff],
> 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  memory[0x11]    [0x00000000fe724000-0x00000000fe724fff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x12]    [0x00000000fe725000-0x00000000fe725fff],
> 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  memory[0x13]    [0x00000000fe726000-0x00000000fe726fff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x14]    [0x00000000fe727000-0x00000000fe728fff],
> 0x0000000000002000 bytes flags: 0x0
> [    0.000000]  memory[0x15]    [0x00000000fe729000-0x00000000fe729fff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x16]    [0x00000000fe72a000-0x00000000fe72afff],
> 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  memory[0x17]    [0x00000000fe72b000-0x00000000fe72cfff],
> 0x0000000000002000 bytes flags: 0x4
> [    0.000000]  memory[0x18]    [0x00000000fe72d000-0x00000000fe72dfff],
> 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  memory[0x19]    [0x00000000fe72e000-0x00000000fe72efff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x1a]    [0x00000000fe72f000-0x00000000fe72ffff],
> 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  memory[0x1b]    [0x00000000fe730000-0x00000000fe730fff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x1c]    [0x00000000fe731000-0x00000000fe731fff],
> 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  memory[0x1d]    [0x00000000fe732000-0x00000000fe732fff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x1e]    [0x00000000fe733000-0x00000000fe733fff],
> 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  memory[0x1f]    [0x00000000fe734000-0x00000000fe734fff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x20]    [0x00000000fe735000-0x00000000fe736fff],
> 0x0000000000002000 bytes flags: 0x0
> [    0.000000]  memory[0x21]    [0x00000000fe737000-0x00000000fe737fff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x22]    [0x00000000fe738000-0x00000000fff60fff],
> 0x0000000001829000 bytes flags: 0x0
> [    0.000000]  memory[0x23]    [0x00000000fff61000-0x00000000fff61fff],
> 0x0000000000001000 bytes flags: 0x4
> [    0.000000]  memory[0x24]    [0x00000000fff62000-0x000000047fffffff],
> 0x000000038009e000 bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0xd
> [    0.000000]  reserved[0x0]   [0x0000000080000000-0x000000008007ffff],
> 0x0000000000080000 bytes flags: 0x0
> [    0.000000]  reserved[0x1]   [0x0000000080200000-0x00000000815fffff],
> 0x0000000001400000 bytes flags: 0x0
> [    0.000000]  reserved[0x2]   [0x0000000087f00000-0x0000000087f05fff],
> 0x0000000000006000 bytes flags: 0x0
> [    0.000000]  reserved[0x3]   [0x00000000db0a2000-0x00000000db0a48b4],
> 0x00000000000028b5 bytes flags: 0x0
> [    0.000000]  reserved[0x4]   [0x00000000db2a2000-0x00000000dc709fff],
> 0x0000000001468000 bytes flags: 0x0
> [    0.000000]  reserved[0x5]   [0x00000000fe701000-0x00000000fe701fff],
> 0x0000000000001000 bytes flags: 0x0
> [    0.000000]  reserved[0x6]   [0x00000000fe704040-0x00000000fe70404f],
> 0x0000000000000010 bytes flags: 0x0
> [    0.000000]  reserved[0x7]   [0x000000046ffe1d40-0x000000047dfe253f],
> 0x000000000e000800 bytes flags: 0x0
> [    0.000000]  reserved[0x8]   [0x000000047dfe2548-0x000000047dfe2578],
> 0x0000000000000031 bytes flags: 0x0
> [    0.000000]  reserved[0x9]   [0x000000047dfe2580-0x000000047dfe25ae],
> 0x000000000000002f bytes flags: 0x0
> [    0.000000]  reserved[0xa]   [0x000000047dfe25b0-0x000000047dfe25de],
> 0x000000000000002f bytes flags: 0x0
> [    0.000000]  reserved[0xb]   [0x000000047dfe25e0-0x000000047dfefffb],
> 0x000000000000da1c bytes flags: 0x0
> [    0.000000]  reserved[0xc]   [0x000000047dff0000-0x000000047fffffff],
> 0x0000000002010000 bytes flags: 0x0
> 
> Best regards
> 
> Heinrich
> 
> > 
> > > 
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   arch/riscv/Kconfig | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 4f7b70ae7c31..a6e57614c3fd 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -31,6 +31,7 @@ config RISCV
> > >       select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
> > >       select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
> > >       select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> > > +    select ARCH_KEEP_MEMBLOCK
> > >       select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> > >       select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> > >       select ARCH_SUPPORTS_HUGETLBFS if MMU
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Sincerely yours,
Mike.
