Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAC6407558
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 08:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhIKGrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 02:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbhIKGrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 02:47:43 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EA5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 23:46:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 5so2546960plo.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 23:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ByKf8o2ifV4HHvy4796HhC6Opwt/sZyJGXOIl2atvWo=;
        b=C3FJL64yBLoyVwpmOVdX1JSLUClHaS7UkL/mPuTxwDYgBfD3vf1AXB+alYiHzcP3ww
         FYzVh4LznDOvRoyC5eRG4Zn3R0R5/H02/y9es4IZYiR4PGLvRSuOv1B4kp6esMcpdxq9
         hi7qrjFI26AWWT/AIACJ1/8SGzBA7Jcl5HfTPzOhkvhQe2REEtuIrAR+MU6pnNtaeGSg
         /579/dQ2+hvcW2WIbe2Qg/w4UsKuvrqX92I94OnCe2erJLkIX2V9hrHaOBVh0hwmCK8R
         HaHm9pr/x7aBY+1BfLG+MY9lVqFJ5HDHQRvMbe7j/teAQBqpuQIr9vjJj5p8c7Ao/CL+
         XvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ByKf8o2ifV4HHvy4796HhC6Opwt/sZyJGXOIl2atvWo=;
        b=Jsv6RY18hGQ3S4lQEWnZWy7Y9RoYZKXxw9GuqqGdoEhsTL7snDk+BOOJzzfJeLvaNL
         c/42wgW6wC6L6jxaA1fzLfit7WvsxgLFMHe8SVjQQKYrnsONpN9pArfO/tFC6G5rjI5Y
         AIXQ95g1MD+X2NbuOQTZ/T770XfKHw8hGVUtZpVE2R3EfWNeaF5Wy6wC2fOaujUhzcDZ
         ggGnj27zKSb1KdtRM43RmLsOI+zhaWlaR/c9LAjzLPAxW6bV+Rv7eB8TuRrnPHEisvZK
         jBD1HeHYHXZP6kuMADQi+0qX+fySRVMAd5PvRyIGfjY7SnnkCGg3NZ7oEyJ9JMPMli/m
         Aa+A==
X-Gm-Message-State: AOAM531i2FBCcaGU4hFC08yBknhcd4z6D3HlMHg2/pJ0MdbkZUQ4/IFG
        tR7VyizbJP6KsQPy5PYD6ElLaA==
X-Google-Smtp-Source: ABdhPJzdUYUe3JH/bTFYrUMBzTBQBQYgsROtxBK5DKm8PVZJjnj/yQzcgGoYShFWlpdE/DUVOLMmrA==
X-Received: by 2002:a17:90b:4f8f:: with SMTP id qe15mr1619150pjb.126.1631342790582;
        Fri, 10 Sep 2021 23:46:30 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id k127sm706462pfd.1.2021.09.10.23.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 23:46:29 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:46:29 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Sep 2021 23:37:36 PDT (-0700)
Subject:     Re: [PATCH 1/1] riscv: select CONFIG_ARCH_KEEP_MEMBLOCK
In-Reply-To: <YRqzckNDbg0awrh4@kernel.org>
CC:     heinrich.schuchardt@canonical.com, wangkefeng.wang@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rppt@kernel.org
Message-ID: <mhng-9af4c9bc-0189-4727-8f2a-0fbbd41a96fd@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 11:50:26 PDT (-0700), rppt@kernel.org wrote:
> Hi Heinrich,
>
> On Mon, Aug 16, 2021 at 05:52:11PM +0200, Heinrich Schuchardt wrote:
>> On 8/16/21 5:30 PM, Kefeng Wang wrote:
>> >
>> > On 2021/8/16 22:47, Heinrich Schuchardt wrote:
>> > > For analyzing memory blocks we can either use the memblock=debug command
>> > > line argument which creates massive output or a debug file system.
>> > >
>> > > Select CONFIG_ARCH_KEEP_MEMBLOCK to provide a debugfs at
>> > > /sys/kernel/debug/memblock to analyze memory blocks. The
>> > > same is already done for arm, arm64, mips, powerpc.
>> > >
>> > > The actual provisioning of the file system depends on CONFIG_DEBUG_FS.
>> >
>> > Hi，for riscv, it don't use memblock(eg, no provide pfn_valid to use
>> > memblock),
>> >
>> > we could call memblock_discard() to discard memblock private memory to save
>> >
>> > some memory, right?  So I think we don't need this config for now.
>>
>> What do you mean by "it don't use memblock?
>>
>> If you boot the HiFive Unmatched with memblock=debug you will see output
>> like the one below. This is the information that you can see in the debug
>> file system if CONFIG_DEBUG_FS and CONFIG_ARCH_KEEP_MEMBLOCK will be
>> enabled.
>
> Indeed having this info in debugfs is more convenient, but it comes with a
> cost of several kilobytes of code and data for *every* riscv build.
>
> Why parsing "memblock=debug" output is not enough?
> What is the use-case that justifies the costs associated with having the
> debugfs entries?

If someone can provide a use case I'm happy to look at how to enable it.  
Otherwise I think we should just stick with the standard way of doing 
things, which according to 350e88bad496 ("mm: memblock: make keeping 
memblock memory opt-in rather than opt-out") seems to be that 
ARCH_KEEP_MEMBLOCK is for ports that need that information, not just 
those that pass it through to userspace.

>> [    0.000000] MEMBLOCK configuration:
>> [    0.000000]  memory size = 0x00000003ffe00000 reserved size =
>> 0x000000001290fb70
>> [    0.000000]  memory.cnt  = 0x25
>
> BTW, it seems that the memory allocation by firmware is, well, suboptimal
> and begs for fixes. I don't see why all these NOMAP areas cannot be put in
> one contiguous chunk. I doubt they need to be NOMAP at all, but mysterious
> the ways of ACPI.

We talked about this a bit in IRC and another thread, but it looks like 
this mess has ended up in the specs.  From my reading that was likely 
the result of a blind copy/paste from some other architecture, but it's 
in a released spec so it's cannon and I'm not really interested in 
trying to change it as I'm tired of getting yelled at by the foundation 
folks.

>> [    0.000000]  memory[0x0]     [0x0000000080200000-0x00000000fe6e2fff],
>> 0x000000007e4e3000 bytes flags: 0x0
>> [    0.000000]  memory[0x1]     [0x00000000fe6e3000-0x00000000fe6e5fff],
>> 0x0000000000003000 bytes flags: 0x4
>> [    0.000000]  memory[0x2]     [0x00000000fe6e6000-0x00000000fe709fff],
>> 0x0000000000024000 bytes flags: 0x0
>> [    0.000000]  memory[0x3]     [0x00000000fe70a000-0x00000000fe70bfff],
>> 0x0000000000002000 bytes flags: 0x4
>> [    0.000000]  memory[0x4]     [0x00000000fe70c000-0x00000000fe70ffff],
>> 0x0000000000004000 bytes flags: 0x0
>> [    0.000000]  memory[0x5]     [0x00000000fe710000-0x00000000fe710fff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0x6]     [0x00000000fe711000-0x00000000fe712fff],
>> 0x0000000000002000 bytes flags: 0x0
>> [    0.000000]  memory[0x7]     [0x00000000fe713000-0x00000000fe716fff],
>> 0x0000000000004000 bytes flags: 0x4
>> [    0.000000]  memory[0x8]     [0x00000000fe717000-0x00000000fe717fff],
>> 0x0000000000001000 bytes flags: 0x0
>> [    0.000000]  memory[0x9]     [0x00000000fe718000-0x00000000fe71cfff],
>> 0x0000000000005000 bytes flags: 0x4
>> [    0.000000]  memory[0xa]     [0x00000000fe71d000-0x00000000fe71dfff],
>> 0x0000000000001000 bytes flags: 0x0
>> [    0.000000]  memory[0xb]     [0x00000000fe71e000-0x00000000fe71efff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0xc]     [0x00000000fe71f000-0x00000000fe71ffff],
>> 0x0000000000001000 bytes flags: 0x0
>> [    0.000000]  memory[0xd]     [0x00000000fe720000-0x00000000fe720fff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0xe]     [0x00000000fe721000-0x00000000fe721fff],
>> 0x0000000000001000 bytes flags: 0x0
>> [    0.000000]  memory[0xf]     [0x00000000fe722000-0x00000000fe722fff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0x10]    [0x00000000fe723000-0x00000000fe723fff],
>> 0x0000000000001000 bytes flags: 0x0
>> [    0.000000]  memory[0x11]    [0x00000000fe724000-0x00000000fe724fff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0x12]    [0x00000000fe725000-0x00000000fe725fff],
>> 0x0000000000001000 bytes flags: 0x0
>> [    0.000000]  memory[0x13]    [0x00000000fe726000-0x00000000fe726fff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0x14]    [0x00000000fe727000-0x00000000fe728fff],
>> 0x0000000000002000 bytes flags: 0x0
>> [    0.000000]  memory[0x15]    [0x00000000fe729000-0x00000000fe729fff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0x16]    [0x00000000fe72a000-0x00000000fe72afff],
>> 0x0000000000001000 bytes flags: 0x0
>> [    0.000000]  memory[0x17]    [0x00000000fe72b000-0x00000000fe72cfff],
>> 0x0000000000002000 bytes flags: 0x4
>> [    0.000000]  memory[0x18]    [0x00000000fe72d000-0x00000000fe72dfff],
>> 0x0000000000001000 bytes flags: 0x0
>> [    0.000000]  memory[0x19]    [0x00000000fe72e000-0x00000000fe72efff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0x1a]    [0x00000000fe72f000-0x00000000fe72ffff],
>> 0x0000000000001000 bytes flags: 0x0
>> [    0.000000]  memory[0x1b]    [0x00000000fe730000-0x00000000fe730fff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0x1c]    [0x00000000fe731000-0x00000000fe731fff],
>> 0x0000000000001000 bytes flags: 0x0
>> [    0.000000]  memory[0x1d]    [0x00000000fe732000-0x00000000fe732fff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0x1e]    [0x00000000fe733000-0x00000000fe733fff],
>> 0x0000000000001000 bytes flags: 0x0
>> [    0.000000]  memory[0x1f]    [0x00000000fe734000-0x00000000fe734fff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0x20]    [0x00000000fe735000-0x00000000fe736fff],
>> 0x0000000000002000 bytes flags: 0x0
>> [    0.000000]  memory[0x21]    [0x00000000fe737000-0x00000000fe737fff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0x22]    [0x00000000fe738000-0x00000000fff60fff],
>> 0x0000000001829000 bytes flags: 0x0
>> [    0.000000]  memory[0x23]    [0x00000000fff61000-0x00000000fff61fff],
>> 0x0000000000001000 bytes flags: 0x4
>> [    0.000000]  memory[0x24]    [0x00000000fff62000-0x000000047fffffff],
>> 0x000000038009e000 bytes flags: 0x0
>> [    0.000000]  reserved.cnt  = 0xd
>> [    0.000000]  reserved[0x0]   [0x0000000080000000-0x000000008007ffff],
>> 0x0000000000080000 bytes flags: 0x0
>> [    0.000000]  reserved[0x1]   [0x0000000080200000-0x00000000815fffff],
>> 0x0000000001400000 bytes flags: 0x0
>> [    0.000000]  reserved[0x2]   [0x0000000087f00000-0x0000000087f05fff],
>> 0x0000000000006000 bytes flags: 0x0
>> [    0.000000]  reserved[0x3]   [0x00000000db0a2000-0x00000000db0a48b4],
>> 0x00000000000028b5 bytes flags: 0x0
>> [    0.000000]  reserved[0x4]   [0x00000000db2a2000-0x00000000dc709fff],
>> 0x0000000001468000 bytes flags: 0x0
>> [    0.000000]  reserved[0x5]   [0x00000000fe701000-0x00000000fe701fff],
>> 0x0000000000001000 bytes flags: 0x0
>> [    0.000000]  reserved[0x6]   [0x00000000fe704040-0x00000000fe70404f],
>> 0x0000000000000010 bytes flags: 0x0
>> [    0.000000]  reserved[0x7]   [0x000000046ffe1d40-0x000000047dfe253f],
>> 0x000000000e000800 bytes flags: 0x0
>> [    0.000000]  reserved[0x8]   [0x000000047dfe2548-0x000000047dfe2578],
>> 0x0000000000000031 bytes flags: 0x0
>> [    0.000000]  reserved[0x9]   [0x000000047dfe2580-0x000000047dfe25ae],
>> 0x000000000000002f bytes flags: 0x0
>> [    0.000000]  reserved[0xa]   [0x000000047dfe25b0-0x000000047dfe25de],
>> 0x000000000000002f bytes flags: 0x0
>> [    0.000000]  reserved[0xb]   [0x000000047dfe25e0-0x000000047dfefffb],
>> 0x000000000000da1c bytes flags: 0x0
>> [    0.000000]  reserved[0xc]   [0x000000047dff0000-0x000000047fffffff],
>> 0x0000000002010000 bytes flags: 0x0
>>
>> Best regards
>>
>> Heinrich
>>
>> >
>> > >
>> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> > > ---
>> > >   arch/riscv/Kconfig | 1 +
>> > >   1 file changed, 1 insertion(+)
>> > >
>> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > > index 4f7b70ae7c31..a6e57614c3fd 100644
>> > > --- a/arch/riscv/Kconfig
>> > > +++ b/arch/riscv/Kconfig
>> > > @@ -31,6 +31,7 @@ config RISCV
>> > >       select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
>> > >       select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
>> > >       select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>> > > +    select ARCH_KEEP_MEMBLOCK
>> > >       select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>> > >       select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>> > >       select ARCH_SUPPORTS_HUGETLBFS if MMU
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
