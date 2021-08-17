Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590B23EE6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhHQGku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhHQGkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:40:47 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5796C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:14 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y144so8909419qkb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umkzGAmsCipKcKjsq0UFHjXQk1tsTPDtPzncTzoDpWk=;
        b=dhkEDDeRVf4DvQXo2P8JcmKd4CS1xAqu5SDnIsMBn20kLiSkcazFNxMNh9x0JMf9gT
         kyPoX1AUHqbIpe0G2j8XSu7ZSASV4qY5QCp9GgNryZhs6y1YLhmcHjM2JP6e3yuWgj7l
         NLjW2kXSead72edYz+1wVIhMx1KBzx1PJfSmqqBnaSecekMeZUwJRSy8CDb8ZlvcGQcZ
         kvJezVVYiGToD4Kb62jQV0gvjUkvsMBCJy38crRD2CwUI7Y/9VeOIoU2i61tTQuogluy
         LiDOh4V2ggxV4Zr2U8S6rnw020oy83iO5gvNJ8nFcX16k5LKU36e6Kzs+bUUI7Eubh61
         oYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umkzGAmsCipKcKjsq0UFHjXQk1tsTPDtPzncTzoDpWk=;
        b=JIQXMb57xm/E3Ha9HgGBW7SEyak82YMXm1W7mXf0siG7pnRqvRJDhY8gNI3gyvy6yo
         /sxy++Fse5Tf8BMNsro8N/5wEZgHjHViGLqcTOF0zdGd7dfHEfvysdA5BrG+FvcjuU6C
         HrqoEBzPA9B7iH7ktsCFMUafYykR+brTATYNq1lgN/uWVJWqA8vz7sb0LGFYvjnOwu2j
         cEvVPHVn8yWTG952snQOB/dbhlxFJxx1SWYDDZNbKSV02nA/NNiyuyAyZeL60lkNtg/j
         zKZlIEmmnvbcURZvkfQCkVeNDatcrvpj8OvneiwUkM92F1nH34ts0ZkDSXSfiKn+YRuX
         Pzsg==
X-Gm-Message-State: AOAM533I6thNTRpxPJFdhQ/gLm3Dz3sGRCp2PP9Rp1vUlp1eUq/WG5FN
        YT4NNdmtTfjkTPN2gOQF6nw=
X-Google-Smtp-Source: ABdhPJyajYj4hl23zFyNyv42DsXx4eYSAfVWsfQ0OLUSx4u3Kj8mraD0IP62bNK7hXucw7MTROIEGg==
X-Received: by 2002:a05:620a:1455:: with SMTP id i21mr1429218qkl.116.1629182413199;
        Mon, 16 Aug 2021 23:40:13 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
        by smtp.gmail.com with ESMTPSA id c11sm526938qth.29.2021.08.16.23.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 23:40:12 -0700 (PDT)
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
Subject: [PATCH v6 00/11] DDW + Indirect Mapping
Date:   Tue, 17 Aug 2021 03:39:18 -0300
Message-Id: <20210817063929.38701-1-leobras.c@gmail.com>
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

Changes since v5:
- Reviews from Frederic Barrat
- 02/11 : memset bitmap only if tbl not in use
- 06/11 : remove_ddw() is not used in enable_ddw() error path anymore 
  New helpers were created for that.
- 10/11 : There was a typo, but got replaced due to 06/11 fix.
v5 Link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=253799&state=%2A&archive=both

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

