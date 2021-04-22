Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF1B367A99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhDVHI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 03:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhDVHI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 03:08:26 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F2DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:07:49 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z2so8397668qkb.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 00:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZ8JN3i4Kj5YpOQnOolDJMaTu+l/AsLN7rU+u4Ddbao=;
        b=tNcJs0R0wv699ZcmUt/WV35IZaMJ4fjyER6d5VTIKQUJw36E7kLbOjuoSffdJ62qmx
         PyhEvN/b8AtPlgUuoC0w8kk/ba2tr/6MouC8QKCjALVWPF4TYRLLgGUiexpyOh6qBozH
         HlX/uCs/vcrm1CzpTb1iggA1Y4jsdtJ0+G7JBGF+JMZpjHav+iq9HCwwyOBJm8Gmri1A
         96GWGLHThrhhFS70JbGPc0EseQ558LHlzl9gHetNRd5ln2Y9xokuWwZi9Rnc3/IlIgno
         sM+dGTvg6sNKIjKrrIDI8wn2HLJh5P4ovBc8EOU8DsdhQYxI84tUblYttNf/5onUuz/9
         cRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZ8JN3i4Kj5YpOQnOolDJMaTu+l/AsLN7rU+u4Ddbao=;
        b=t4L4G4+Ic2+BIgHpLaZylIeEeqw6YRd64SPJerHv3Ybj+ma/N8rTT5hA7Wtf2rlq4P
         F5Lmx8chpTQfoWjvuBt3/W33I7OX95kmscw05APb1d8gmJIhoMUJq0EtOFkYH41mYGUl
         NWD6Mp7w0uJpELft0N9o6NtcQZrGChyqHzdeq7MmUmwUNeE7+19DhYasrACvNz63Hs6K
         b/T1A3GIgAzfSoF8gJ535WK1TtwVgH90WhWYTIm1qbm99yVkXh/IkdZ/ciLPhbMStXPY
         HaPEzaMm7REhIORjuMjgVfhG0l8B012acOLVCB5z+Pp/E6IvBaM7IcK048r23Wg0G9W5
         SIDQ==
X-Gm-Message-State: AOAM531ki8SQGMElnLePAm3p4sEDOV0pLucyx7pL6j9uqZ6BcSSLp4o1
        JEfi2ooJmW37bwUGrmCyJN8=
X-Google-Smtp-Source: ABdhPJxmMmwBHAC6MV1jGxKUHNNOegGk5bUlTkwUorBleYhiFdB6IDSc3N8e0pdtkPxvQAWJIsXHfA==
X-Received: by 2002:ae9:ef8a:: with SMTP id d132mr2119249qkg.481.1619075269130;
        Thu, 22 Apr 2021 00:07:49 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id w67sm1658329qkc.79.2021.04.22.00.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 00:07:48 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/11] DDW + Indirect Mapping
Date:   Thu, 22 Apr 2021 04:07:11 -0300
Message-Id: <20210422070721.463912-1-leobras.c@gmail.com>
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

