Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0432E3D9CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 06:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhG2Eab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 00:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhG2Ea1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 00:30:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044FAC061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 21:30:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e5so5423733pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 21:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=PPE0zooLgyR9UCdP8xX+4M+xn5NMefkRnT3Z8S+2rxo=;
        b=jVAy9Axj38CP6qzQCubayURG3GC5N6GQpLn7DerOn3bVNLAo5e2aBMRAWBAlFMjEyZ
         4472RxpG50pI67eMjOrpldqqqzhay6vk6Lb7CdtG0zE9KbIZhrZNpknQ7LG3XXrvYvvg
         9+ZSD0KURwgn7rDsa3vOQIlvOF/4bvQlt3z85tXylMVwPsRRQu9cgVkI0mhelF7lUeAk
         xQxAlcTZ1pz36ZJN1RENmEhvawUmrcKaMmggmRUkq9j6Rnz1lCCJOrjmn8RiIMw/CgQ1
         oalmOGZtWH9kw2Qo/EmvQ1AVOxl6Sgao67e78xpQhmKEDKMDx0mtHp7NEy74QZ3RM8bG
         +HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=PPE0zooLgyR9UCdP8xX+4M+xn5NMefkRnT3Z8S+2rxo=;
        b=O6QfJOg2eIeGVJ554LDrNPGF6bBX5KYXGZIoF96ZkFGPzQd0kxmOnepVTJdt09VOFZ
         LlVR796lJbpNevETKVnQe7oiS349+AGfpxC0i9ZwdAEQOPMUpIgLn6h6CLu5UfcQ57Bi
         0v/tASreAdAQXctJusPYJf8qzsW+kpo92oL2runIIIlyV5T1HFkNLz7YDmtnKHWCpt1X
         zR8ihIEXzkP6Uq45FdLugOb1slEHO/OU5MFhaPKwehTsgMHUp0Iuv7vnK6ks52TdKGYT
         Mf+IEDgXLMrsNFmRzcsTVeBueR98w5xQJGeUn5TmqDfYu7PIzurOV6HtxyZPGt/TsurD
         X/xw==
X-Gm-Message-State: AOAM533Sfjbh99qkJkhgPSoGkAc13yRSED44Nhs5/EZiQEftyUOzs1lY
        8KlHlchyY9xRxG9BEoKqkpZ3euUeZVNQCA==
X-Google-Smtp-Source: ABdhPJxnCACwbpVayPk6V7fFVJvDGneCsIVO8qAKvIDi/fVY508+0MplapegPRHObLAXo+BVyVhlUA==
X-Received: by 2002:a05:6a00:9a3:b029:355:d45b:ad9a with SMTP id u35-20020a056a0009a3b0290355d45bad9amr3098900pfg.73.1627533024171;
        Wed, 28 Jul 2021 21:30:24 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z2sm1752300pgl.61.2021.07.28.21.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 21:30:23 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:30:23 -0700 (PDT)
X-Google-Original-Date: Wed, 28 Jul 2021 20:39:59 PDT (-0700)
Subject:     Re: [RFC 0/5] Support non-coherent DMA on RISC-V using a global pool
In-Reply-To: <20210723214031.3251801-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Christoph Hellwig <hch@lst.de>,
        devicetree@vger.kernel.org, dvyukov@google.com,
        frowand.list@gmail.com, guoren@linux.alibaba.com,
        iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org,
        m.szyprowski@samsung.com, Paul Walmsley <paul.walmsley@sifive.com>,
        robh+dt@kernel.org, robin.murphy@arm.com, tklauser@distanz.ch
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-11e1ab27-21eb-4b20-9185-c256fcaaab99@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 14:40:26 PDT (-0700), Atish Patra wrote:
> RISC-V privilege specification doesn't define an IOMMU or any method modify
> PMA attributes or PTE entries to allow non-coherent mappings yet. In
> the beginning, this approach was adopted assuming that most of the RISC-V
> platforms would support full cache-coherent IO. Here is excerpt from the
> priv spec section 3.6.5
>
> "In RISC-V platforms, the use of hardware-incoherent regions is discouraged
> due to software complexity, performance, and energy impacts."
>
> While some of the RISC-V platforms adhere to the above suggestion, not all
> platforms can afford to build to fully cache-coherent I/O devices. To
> address DMA for non-coherent I/O devices, we need to mark a region of memory
> as non-cacheable. Some of the platforms rely on a fixed region of uncached
> memory that is remapped to the system memory while some other modify
> the PTE entries to achieve that.
>
> The patch3 solves the issue for the fist use case by using a global
> pool of memory that is reserved for DMA. The device access the reserved area
> of the region while corresponding CPU address will be from uncached region
> As the uncached region is remapped to the beginning of the system ram, both
> CPU and device get the same view.
>
> To facilitate streaming DMA APIs, patch 1 introduces a set of generic
> cache operations. Any platform can use the generic ops to provide platform
> specific cache management operations. Once the standard RISC-V CMO extension
> is available, it will also use these generic ops.
>
> To address the second use case, Page Based Memory Attribute (PBMT) extension
> is proposed. Once the extension is in good shape, we can leverage that
> using CONFIG_DIRECT_REMAP. Currently, it is selected via a compile time config
> option. We will probably need another arch specific hooks to know if the
> platform supports direct remap at runtime. For RISC-V, it will check the
> presence of PBMT extension while other arch function will simply return true

IIUC this is another extension that's not yet frozen or implemented in 
hardware?  Is this one compatible with what's in the c906, or is it 
doing things its own way?

> if DIRECT_REMAP is enabled. This is required as arious different config
> (DIRECT_REMAP, GLOBAL_POOL) will be enabled in the defconfig so that a
> unified kernel image can boot on all RISC-V platforms.
>
> This patch series depends on Christoph's global pool support series[1].
> Tested on Qemu, HiFive unleashed and beagleV. This series is also available
> at [2].
> This series also solves the non-coherent DMA support on beagleV but requires
> additional beagleV specific patches[3] which will be upstreamed soon.
>
>
> [1] https://lists.linuxfoundation.org/pipermail/iommu/2021-July/057266.html
> [2] https://github.com/atishp04/linux/tree/riscv_nc_global_pool
> [3] https://github.com/atishp04/linux/tree/wip_beaglev_dma_nc_global
>
> Atish Patra (5):
> RISC-V: Implement arch_sync_dma* functions
> of: Move of_dma_get_range to of_address.h
> dma-mapping: Enable global non-coherent pool support for RISC-V
> dma-direct: Allocate dma pages directly if global pool allocation
> fails
> RISC-V: Support a new config option for non-coherent DMA
>
> arch/riscv/Kconfig                       |  8 +++
> arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
> arch/riscv/mm/Makefile                   |  1 +
> arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
> drivers/of/of_private.h                  | 10 ----
> include/linux/of_address.h               | 12 +++++
> kernel/dma/coherent.c                    | 49 +++++++++++++++---
> kernel/dma/direct.c                      |  7 ++-
> 8 files changed, 152 insertions(+), 20 deletions(-)
> create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
> create mode 100644 arch/riscv/mm/dma-noncoherent.c

Can you guys please make up your minds about how this is going to be 
supported at the ISA level?  I get a different answer every day here: 
sometimes it's that these systems are not compliant, sometimes that 
Linux is the compliance suite, sometimes that we're doing an ISA 
extension, and sometimes that we're doing the SBI stuff.

I don't really care all that much about what the decision is, but it's 
impossible to move forward without some semblance of a plan.
