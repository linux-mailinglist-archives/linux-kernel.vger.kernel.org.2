Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA6836FE8E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhD3QdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhD3Qcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:32:51 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F78C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:32:03 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j3so34674299qvs.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXl9TXxVJ9ZoOKdTz5acN42lAgeZGmOu/NfPJbITIgY=;
        b=KVk4ryPUxovH5g+4PI/OhD3YTlt+ZsjpbPXay1UVQQiZy5NqzRWo9XpzV2oL+9sgok
         QYF8R4aYTd8aFDvBtwSbhbzR9BY4AO+oJ3+fHvC78ePgjDvRmqkOY++/Euez8PEhX14/
         ByIteixks64eXimHCL6FZ/UEug6EElKRmLu0O5jMAqqJWPCaAhNnlX6d7STyQGSYESfr
         4Bj+Ran7/xeTuoYjEsSScvqkWx9GZM9XVeC0nL62tF7/OjEupMarJtZaJ2FYH15UbqHr
         nkq/LeOI4XZAtTYQOa5dZCnTodJxTV+wmfFqDMaydyCWb5qbArmF3ZpNOO5POv79aDA/
         BoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXl9TXxVJ9ZoOKdTz5acN42lAgeZGmOu/NfPJbITIgY=;
        b=jkBeelryoo+8ztdHVMsm8bgyPsNpIXQbFYqL5+fJvAb4tqYxyPbG0VarVQmiEOMiT6
         T/REHtB3xl070ld7fdSYXVQ/LXrzGkG6Yw2n5a8iEXhQYblLj/chiXjOG4DqhNHVNMt7
         0Br09KTCOGqeatlYNTfVcqZNJqpkRF0jyPW9vDhgo4uNCU9/UT2oDeYTwBWPKhyC/9PD
         bjfpz2hwJ/YiXmlhgbP56XiC9GbdQhV3kgEoY1rDwK0LyZ8SwIhiDaxozzxwsFV8l50B
         ABLXUHWOuJS2f+hFEDTjJcxv7VP8srVsfFufZtzbhzOX968+uYQHQh7HqhOn8CPI/3Ko
         D4Lw==
X-Gm-Message-State: AOAM530CQ+bl2VtNY+dNzakZsniGicJ69ayn7thpBiERCCuPnDqSD4Kj
        pPW8PQg64F9fR/YQlqPw09g=
X-Google-Smtp-Source: ABdhPJxCn4n5c7NWTvW22Rt+ze6/yWTg5sBVX4VPrqCZGBqWwOMSQdHOUU8sJKXBzUCXQP1HgRvCyA==
X-Received: by 2002:ad4:538a:: with SMTP id i10mr6135443qvv.9.1619800322608;
        Fri, 30 Apr 2021 09:32:02 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([2804:14c:482:7b04::1001])
        by smtp.gmail.com with ESMTPSA id p1sm2624334qtu.89.2021.04.30.09.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 09:32:01 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/11] DDW + Indirect Mapping
Date:   Fri, 30 Apr 2021 13:31:35 -0300
Message-Id: <20210430163145.146984-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Changes since v3:
- Fixed inverted free order at ddw_property_create()
- Updated goto tag naming

Changes since v2:
- Some patches got removed from the series and sent by themselves,
- New tbl created for DDW + indirect mapping reserves MMIO32 space,
- Improved reserved area algorithm,
- Improved commit messages,
- Removed define for default DMA window prop name,
- Avoided some unnecessary renaming,
- Removed some unnecessary empty lines,
- Changed some code moving to forward declarations.
v2
Link: http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=201210&state=%2A&archive=both
 

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
 arch/powerpc/platforms/pseries/iommu.c | 504 +++++++++++++++----------
 4 files changed, 338 insertions(+), 240 deletions(-)

-- 
2.30.2

