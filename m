Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F114E367AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhDVHTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhDVHTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:19:48 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040D9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:19:14 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id u20so13227855qku.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=tRowv8wxxfn7LKcCXBCPH2fw92UrkVfTs9LAhx2zwW4=;
        b=rqBPuGDijGlcgeeSrcqMV1iHACarctXQVFSHVNohKRVqVaW2V/km0Ffw0Lk6C0lpRU
         +8TXNzNkADx2FhIN9EQaRqRKn2D5dELw3xt7K7ffQyr8ow4ydTPFduOuQu37mKa2Ueoe
         jBfQYbb6UyUMbvF2srLyRx6EbbaCzjILqzmajlZCqds+6tADLKh4zUA5TtHkUrrHSGNU
         hmDC8a31NWPDxlAgYM/hLjWknGvLQ/fkl30vwYg6k0Yq+QfVxNCbEzmbbHt6tIwHBz0j
         NvKGj/Edg+3Lb2VOx86YhpGiQMg1uPi37QfyTBbF5cilJ9leUaoKELCuEM+P3wNNh9d+
         1oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=tRowv8wxxfn7LKcCXBCPH2fw92UrkVfTs9LAhx2zwW4=;
        b=YUYNazJ1a9j/48vXUbzBi8nNQ2jAFdS47z7uw3jU0L5YQb5x31X+IFg8FD939mu2t0
         IHKQsqXTINoRzQfEjmcfMQ4ilM87rSJxxaI+CaHCiDskUlF9hoFUnJYy2ZRt+H7qQj2M
         QvNu7hu+nMuRiqFiZIUi9lafrTu8dJPQjoK8mwHLxRMWbXkLq/qnh2ae7m1EQB1FuolP
         IPhSs5DYm2N9bJukrN3Je2EeEoEaLoICyhc3BcHhsOUZSzoa8+l/LQMXqD63OBjnreb3
         l29KgNL8wHEbU9tVmU7ILgxFEBppvBlxMyb+VhzuT12ShrzQSdBbOlGTSXBCxLTClqu6
         gq2w==
X-Gm-Message-State: AOAM532rE8lYqIxMSlWzJj5XYgjmPbhQ7JqtAHB1BY6NuHkTGa7Oi2+a
        NRhvOmmvI1ZO5r6N7rywTEk=
X-Google-Smtp-Source: ABdhPJxpUP6mg5biT0KoJEiJ0GzW1avdrE1AgZSKJj+lSCOWjiKxKo624hu9DXn2Z9/joM5twXGkKg==
X-Received: by 2002:a05:620a:652:: with SMTP id a18mr2225875qka.475.1619075953281;
        Thu, 22 Apr 2021 00:19:13 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id i6sm1651941qkf.96.2021.04.22.00.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 00:19:12 -0700 (PDT)
Message-ID: <2ea1fde7020cfb1492223a37eb0cfc2251718e8a.camel@gmail.com>
Subject: Re: [PATCH v3 00/11] DDW + Indirect Mapping
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Apr 2021 04:19:09 -0300
In-Reply-To: <20210422070721.463912-1-leobras.c@gmail.com>
References: <20210422070721.463912-1-leobras.c@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
- Some patches got removed from the series and sent by themselves,
- New tbl created for DDW + indirect mapping reserves MMIO32 space,
- Improved reserved area algorithm,
- Improved commit messages,
- Removed define for default DMA window prop name,
- Avoided some unnecessary renaming,
- Removed some unnecessary empty lines,
- Changed some code moving to forward declarations.
v2
Link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=201210&state=%2A&archive=both
 

On Thu, 2021-04-22 at 04:07 -0300, Leonardo Bras wrote:
> So far it's assumed possible to map the guest RAM 1:1 to the bus, which
> works with a small number of devices. SRIOV changes it as the user can
> configure hundreds VFs and since phyp preallocates TCEs and does not
> allow IOMMU pages bigger than 64K, it has to limit the number of TCEs
> per a PE to limit waste of physical pages.
> 
> As of today, if the assumed direct mapping is not possible, DDW creation
> is skipped and the default DMA window "ibm,dma-window" is used instead.
> 
> Using the DDW instead of the default DMA window may allow to expand the
> amount of memory that can be DMA-mapped, given the number of pages (TCEs)
> may stay the same (or increase) and the default DMA window offers only
> 4k-pages while DDW may offer larger pages (4k, 64k, 16M ...).
> 
> Patch #1 replaces hard-coded 4K page size with a variable containing the
> correct page size for the window.
> 
> Patch #2 introduces iommu_table_in_use(), and replace manual bit-field
> checking where it's used. It will be used for aborting enable_ddw() if
> there is any current iommu allocation and we are trying single window
> indirect mapping.
> 
> Patch #3 introduces iommu_pseries_alloc_table() that will be helpful
> when indirect mapping needs to replace the iommu_table.
> 
> Patch #4 adds helpers for adding DDWs in the list.
> 
> Patch #5 refactors enable_ddw() so it returns if direct mapping is
> possible, instead of DMA offset. It helps for next patches on
> indirect DMA mapping and also allows DMA windows starting at 0x00.
> 
> Patch #6 bring new helper to simplify enable_ddw(), allowing
> some reorganization for introducing indirect mapping DDW.
> 
> Patch #7 adds new helper _iommu_table_setparms() and use it in other
> *setparams*() to fill iommu_table. It will also be used for creating a
> new iommu_table for indirect mapping.
> 
> Patch #8 updates remove_dma_window() to accept different property names,
> so we can introduce a new property for indirect mapping.
> 
> Patch #9 extracts find_existing_ddw_windows() into
> find_existing_ddw_windows_named(), and calls it by it's property name.
> This will be useful when the property for indirect mapping is created,
> so we can search the device-tree for both properties.
> 
> Patch #10:
> Instead of destroying the created DDW if it doesn't map the whole
> partition, make use of it instead of the default DMA window as it improves
> performance. Also, update the iommu_table and re-generate the pools.
> It introduces a new property name for DDW with indirect DMA mapping.
> 
> Patch #11:
> Does some renaming of 'direct window' to 'dma window', given the DDW
> created can now be also used in indirect mapping if direct mapping is not
> available.
> 
> All patches were tested into an LPAR with an virtio-net interface that
> allows default DMA window and DDW to coexist.
> 
> Leonardo Bras (11):
>   powerpc/pseries/iommu: Replace hard-coded page shift
>   powerpc/kernel/iommu: Add new iommu_table_in_use() helper
>   powerpc/pseries/iommu: Add iommu_pseries_alloc_table() helper
>   powerpc/pseries/iommu: Add ddw_list_new_entry() helper
>   powerpc/pseries/iommu: Allow DDW windows starting at 0x00
>   powerpc/pseries/iommu: Add ddw_property_create() and refactor
>     enable_ddw()
>   powerpc/pseries/iommu: Reorganize iommu_table_setparms*() with new
>     helper
>   powerpc/pseries/iommu: Update remove_dma_window() to accept property
>     name
>   powerpc/pseries/iommu: Find existing DDW with given property name
>   powerpc/pseries/iommu: Make use of DDW for indirect mapping
>   powerpc/pseries/iommu: Rename "direct window" to "dma window"
> 
>  arch/powerpc/include/asm/iommu.h       |   1 +
>  arch/powerpc/include/asm/tce.h         |   8 -
>  arch/powerpc/kernel/iommu.c            |  65 ++--
>  arch/powerpc/platforms/pseries/iommu.c | 504 +++++++++++++++----------
>  4 files changed, 338 insertions(+), 240 deletions(-)
> 


