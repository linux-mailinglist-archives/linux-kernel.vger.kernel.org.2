Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE99E3CB444
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbhGPIax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbhGPIav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:30:51 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A329C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:27:56 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id x6so4210835qvx.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/YkxBfRDtBmkhP+2nUtCJKlfQdr5yzKh5I2Oej3mdw=;
        b=fP7d4VtHE1Tvt1K+Ez2d2PHrWDHgocp+BgKISQ/mQs7CJH7VceDaKYYPXGfhKVWSJy
         XQARSgA/u4viSBPA9r4HM5I/LrlpZtZLvNasgVturM2oGcSFcxGQOv6zr4WWaZqcNGAX
         A27IaNR4lfJ8VWb+KpNpVIy3mAucW/o+TSwHJfUYH32XR4XgoGjDgaT1GSw5yShhsx9r
         i/7k57ad4hIreMlkZJb+49rMOCz6YJPQqZYceRGFTL3k/uEPQbidT1oLKM2vTKMrJJOa
         D5oXrUPJ3+fEPdxRpZPXdzJXVsshExyEheEKumgfUZWAEYwxlO05HfmZMQjElFfmSmgp
         GSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/YkxBfRDtBmkhP+2nUtCJKlfQdr5yzKh5I2Oej3mdw=;
        b=oBQWnnmANA3uhCzUmuR+LFk8qEIBr8QoClpCujgcSIMgdxKHBggFT/k6sGn5/z7Tl2
         ZQH6Y+jWvCHVE47hhA8s8s22pOTH4fN4rtlj5Y6D+uE2M8/4Bzumm3ljSc/bz41E4TjX
         n3KyjX08gCFSFZnmLa62I96+x6TJQBvMOGgDjEvSkF/82s6r8110EVDHvOfkDi3q4MAc
         tliqFT9bN0kJIOk2xdw5sCy/NpnkOnQ16v2gb5j6esY7LNABdT1/m63+F3SbNAtRh+te
         axMQItWxoHb/FwKYIHgCDXTak3aCCP8/3jnAzbaxQBXwHQjHC/sj4KI4X3Tcsp661NK3
         w45Q==
X-Gm-Message-State: AOAM533rhF7X+QxBQ3prkcaw0kr18TlueSvoAGjUzmFFSxCrVIR9BZTP
        BJsQqFDBwAe8+xCpJ+ot1o8=
X-Google-Smtp-Source: ABdhPJzkmMN2JnYjZU7i/Yb+iOp1euFVgbzEGzAmrgu368Yout2rNikTND3y+C+esr/hZxUDq41tBQ==
X-Received: by 2002:a05:6214:20ac:: with SMTP id 12mr9076220qvd.7.1626424075237;
        Fri, 16 Jul 2021 01:27:55 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id q199sm3603540qka.112.2021.07.16.01.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:27:54 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/11] DDW + Indirect Mapping
Date:   Fri, 16 Jul 2021 05:27:45 -0300
Message-Id: <20210716082755.428187-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far it's assumed possible to map the guest RAM 1:1 to the bus, which
works with a small number of devices. SRIOV changes it as the user can
configure hundreds VFs and since phyp preallocates TCEs and does not
allow IOMMU pages bigger than 64K, it has to limit the number of TCEs
per a PE to limit waste of physical pages.

As of today, if the assumed direct mapping is not possible, DDW creation
is skipped and the default DMA window "ibm,dma-window" is used instead.

Using the DDW instead of the default DMA window may allow to expand the
amount of memory that can be DMA-mapped, given the number of pages (TCEs)
may stay the same (or increase) and the default DMA window offers only
4k-pages while DDW may offer larger pages (4k, 64k, 16M ...).

Patch #1 replaces hard-coded 4K page size with a variable containing the
correct page size for the window.

Patch #2 introduces iommu_table_in_use(), and replace manual bit-field
checking where it's used. It will be used for aborting enable_ddw() if
there is any current iommu allocation and we are trying single window
indirect mapping.

Patch #3 introduces iommu_pseries_alloc_table() that will be helpful
when indirect mapping needs to replace the iommu_table.

Patch #4 adds helpers for adding DDWs in the list.

Patch #5 refactors enable_ddw() so it returns if direct mapping is
possible, instead of DMA offset. It helps for next patches on
indirect DMA mapping and also allows DMA windows starting at 0x00.

Patch #6 bring new helper to simplify enable_ddw(), allowing
some reorganization for introducing indirect mapping DDW.

Patch #7 adds new helper _iommu_table_setparms() and use it in other
*setparams*() to fill iommu_table. It will also be used for creating a
new iommu_table for indirect mapping.

Patch #8 updates remove_dma_window() to accept different property names,
so we can introduce a new property for indirect mapping.

Patch #9 extracts find_existing_ddw_windows() into
find_existing_ddw_windows_named(), and calls it by it's property name.
This will be useful when the property for indirect mapping is created,
so we can search the device-tree for both properties.

Patch #10:
Instead of destroying the created DDW if it doesn't map the whole
partition, make use of it instead of the default DMA window as it improves
performance. Also, update the iommu_table and re-generate the pools.
It introduces a new property name for DDW with indirect DMA mapping.

Patch #11:
Does some renaming of 'direct window' to 'dma window', given the DDW
created can now be also used in indirect mapping if direct mapping is not
available.

All patches were tested into an LPAR with an virtio-net interface that
allows default DMA window and DDW to coexist.

Changes since v4:
- Solve conflicts with new upstream versions
- Avoid unecessary code moving by doing variable declaration before definition
- Rename _iommu_table_setparms to iommu_table_setparms_common and changed base
  parameter from unsigned long to void* in order to avoid unecessary casting.
- Fix breaking case for existing direct-mapping.
- Fix IORESOURCE_MEM bound issue
- Move new tbl to pci->table_group->tables[1] instead of replacing [0]
v4 Link: https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=241597&state=%2A&archive=both

Changes since v3:
- Fixed inverted free order at ddw_property_create()
- Updated goto tag naming
v3 Link: https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=240287&state=%2A&archive=both

Changes since v2:
- Some patches got removed from the series and sent by themselves,
- New tbl created for DDW + indirect mapping reserves MMIO32 space,
- Improved reserved area algorithm,
- Improved commit messages,
- Removed define for default DMA window prop name,
- Avoided some unnecessary renaming,
- Removed some unnecessary empty lines,
- Changed some code moving to forward declarations.
v2 Link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=201210&state=%2A&archive=both


Leonardo Bras (11):
  powerpc/pseries/iommu: Replace hard-coded page shift
  powerpc/kernel/iommu: Add new iommu_table_in_use() helper
  powerpc/pseries/iommu: Add iommu_pseries_alloc_table() helper
  powerpc/pseries/iommu: Add ddw_list_new_entry() helper
  powerpc/pseries/iommu: Allow DDW windows starting at 0x00
  powerpc/pseries/iommu: Add ddw_property_create() and refactor
    enable_ddw()
  powerpc/pseries/iommu: Reorganize iommu_table_setparms*() with new
    helper
  powerpc/pseries/iommu: Update remove_dma_window() to accept property
    name
  powerpc/pseries/iommu: Find existing DDW with given property name
  powerpc/pseries/iommu: Make use of DDW for indirect mapping
  powerpc/pseries/iommu: Rename "direct window" to "dma window"

 arch/powerpc/include/asm/iommu.h       |   1 +
 arch/powerpc/include/asm/tce.h         |   8 -
 arch/powerpc/kernel/iommu.c            |  65 ++--
 arch/powerpc/platforms/pseries/iommu.c | 481 +++++++++++++++----------
 4 files changed, 330 insertions(+), 225 deletions(-)

-- 
2.32.0

