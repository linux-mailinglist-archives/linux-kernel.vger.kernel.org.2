Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F099630D21C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 04:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhBCDWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 22:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbhBCDNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 22:13:20 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC92C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 19:04:47 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r38so16277608pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 19:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Vdh1Qq63m3XfmV6DImv16T62V42d9pjMQXcqf3Ym7EI=;
        b=wgBkFphGweD3WECMTHTmbOH4w02odKqMUOdnQM3s7BMucZQ6IIzBeW7ZeyOq+iZ4kB
         wGo9RbJlt91NeM+RFug+FuigT1br4iUJD1XRBbLgwqpiEYiph8kX8ZDK1MPFcwAz7Y0L
         sNwZdy79RqP/gxQr+bCa0iYka6cCIunrnfrkrI8TmJE3wHBNq7jXaW4eWd+N+P9zAJcy
         ci4Dex33qOWS7OBKeXfnx1BVBimDM/qJzmQrsM0Pl7WQDt48lKnbl2FjvmZQqMNAV8r6
         KHkx4Ui8jlzbsHtJPl0xn88GCpFThOZPPHBhR61MQygy4rks7yJ026chqYViX0T7eSFL
         sAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Vdh1Qq63m3XfmV6DImv16T62V42d9pjMQXcqf3Ym7EI=;
        b=nNAnzTHR0MEXNAiZc/He7OLIUAhso007znK+Hwsx9tX435Qtttp7YH734mc0GSr7PA
         E+0vYvP409IsEtAL2y1oz0PPNAzkfSBpf9mm/u+XmfC7w4AQ9ug8BCvTBxjUGXfteMuF
         QQqqvfjpwHyeJTiTpCj0YdmsNhWtqM/bYp/ej9gTNIG5xe2egHy46CEwuE5ob2/uXM/n
         wgR9hpqh0nhjZmeRWtrDwoWQB7O2gjbdz0wg5UbzNF/z3kIljUrPJzHZD1zPlPoKke3G
         WIIWnyQV5YRns4/MqWL5mJk0hhihz+nkvaHYvvRF5nHS1jxPQ6CFGEXBTgJ6rDcvK1O3
         8qng==
X-Gm-Message-State: AOAM532Vui8z2wTLB7YADRntZbFOVvUjm6TIdDQC8JD8Fy+ja+F37iuT
        b1/ZMIoBDFJI9hJvfU+Kr+08Lg==
X-Google-Smtp-Source: ABdhPJyuyGSBM/5g+/5Iuy++F6uNnW110xi5tioCbX0ogE3WZP9UD91lzEs7Nrq937k1kDrynd8ykw==
X-Received: by 2002:a63:4444:: with SMTP id t4mr1256237pgk.329.1612321486466;
        Tue, 02 Feb 2021 19:04:46 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id lf4sm334800pjb.0.2021.02.02.19.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:04:45 -0800 (PST)
Date:   Tue, 02 Feb 2021 19:04:45 -0800 (PST)
X-Google-Original-Date: Tue, 02 Feb 2021 18:39:17 PST (-0800)
Subject:     Re: [RFC PATCH 00/12] Introduce sv48 support without relocable kernel
In-Reply-To: <f38979dc-9f8c-6fce-6b1b-70e5f110e14c@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com,
        anup@brainfault.org, Christoph Hellwig <hch@lst.de>,
        ardb@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-68df8416-8592-48e2-9040-56135ff3bc1d@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jan 2021 01:33:20 PST (-0800), alex@ghiti.fr wrote:
> Hi Palmer,
>
> On 1/4/21 2:58 PM, Alexandre Ghiti wrote:
>> This patchset, contrary to the previous versions, allows to have a single
>> kernel for sv39 and sv48 without being relocatable.
>>
>> The idea comes from Arnd Bergmann who suggested to do the same as x86,
>> that is mapping the kernel to the end of the address space, which allows
>> the kernel to be linked at the same address for both sv39 and sv48 and
>> then does not require to be relocated at runtime.
>>
>> This is an RFC because I need to at least rebase a few commits and add
>> documentation. The most interesting patches where I expect feedbacks are
>> 1/12, 2/12 and 8/12. Note that moving the kernel out of the linear
>> mapping and sv48 support can be separate patchsets, I share them together
>> today to show that it works (this patchset is rebased on top of v5.10).
>>
>> If we agree about the overall idea, I'll rebase my relocatable patchset
>> on top of that and then KASLR implementation from Zong will be greatly
>> simplified since moving the kernel out of the linear mapping will avoid
>> to copy the kernel physically.
>>
>> This implements sv48 support at runtime. The kernel will try to
>> boot with 4-level page table and will fallback to 3-level if the HW does not
>> support it. Folding the 4th level into a 3-level page table has almost no
>> cost at runtime.
>>
>> Finally, the user can now ask for sv39 explicitly by using the device-tree
>> which will reduce memory footprint and reduce the number of memory accesses
>> in case of TLB miss.
>>
>> Alexandre Ghiti (12):
>>    riscv: Move kernel mapping outside of linear mapping
>>    riscv: Protect the kernel linear mapping
>>    riscv: Get rid of compile time logic with MAX_EARLY_MAPPING_SIZE
>>    riscv: Allow to dynamically define VA_BITS
>>    riscv: Simplify MAXPHYSMEM config
>>    riscv: Prepare ptdump for vm layout dynamic addresses
>>    asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
>>    riscv: Implement sv48 support
>>    riscv: Allow user to downgrade to sv39 when hw supports sv48
>>    riscv: Use pgtable_l4_enabled to output mmu type in cpuinfo
>>    riscv: Explicit comment about user virtual address space size
>>    riscv: Improve virtual kernel memory layout dump
>>
>>   arch/riscv/Kconfig                      |  34 +--
>>   arch/riscv/boot/loader.lds.S            |   3 +-
>>   arch/riscv/include/asm/csr.h            |   3 +-
>>   arch/riscv/include/asm/fixmap.h         |   3 +
>>   arch/riscv/include/asm/page.h           |  33 ++-
>>   arch/riscv/include/asm/pgalloc.h        |  40 +++
>>   arch/riscv/include/asm/pgtable-64.h     | 104 ++++++-
>>   arch/riscv/include/asm/pgtable.h        |  68 +++--
>>   arch/riscv/include/asm/sparsemem.h      |   6 +-
>>   arch/riscv/kernel/cpu.c                 |  23 +-
>>   arch/riscv/kernel/head.S                |   6 +-
>>   arch/riscv/kernel/module.c              |   4 +-
>>   arch/riscv/kernel/vmlinux.lds.S         |   3 +-
>>   arch/riscv/mm/context.c                 |   2 +-
>>   arch/riscv/mm/init.c                    | 376 ++++++++++++++++++++----
>>   arch/riscv/mm/physaddr.c                |   2 +-
>>   arch/riscv/mm/ptdump.c                  |  56 +++-
>>   drivers/firmware/efi/libstub/efi-stub.c |   2 +-
>>   include/asm-generic/pgalloc.h           |  24 +-
>>   include/linux/sizes.h                   |   3 +-
>>   20 files changed, 648 insertions(+), 147 deletions(-)
>>
>
> Any thought about the idea ? Is it going in the right direction ? I have
> fixed quite a few things since I posted this so don't bother giving this
> patchset a full review.

My only real issue was the relocation stuff, which appears to be fixed.  I 
haven't had the time to look at the patches, but it wouldn't hurt to send 
another revision.  The best bet might be to just wait until 5.11 and send on 
top of that, it's too late for this one anyway and that'll be a stable base to 
test from.
