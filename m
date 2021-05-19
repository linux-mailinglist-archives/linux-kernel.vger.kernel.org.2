Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4FA389078
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354399AbhESOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354094AbhESOQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:16:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5413361002;
        Wed, 19 May 2021 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621433682;
        bh=fHqldBFRMS+fmzLe1m4GydU7vDZX1DTbIOljHTFkg4c=;
        h=From:To:Cc:Subject:Date:From;
        b=K4tZ7BoZRKoHgEQXptMuPRGrEupaXtj2aDudDfvfRpBKlImkTSSWSdRpJG41/3Qb4
         jE7V9eiD4AlBwuihgt/6vXhJ4UGiXTFLSuyxOADiBTnY61nE3Ka/P9lbpGU4tAarRd
         1yffQK0NqP0mXEL4EdqiL5uUf2k/qaPRzr+UhF47eYN9DlXnuuen8UXkq4FnAEkmb9
         qAF7mpuXgdYFrNJE5inCiufRrQheVIjRI3FDA7izvNx3UkXu3D6Dk9Oc+OKtlE0+4o
         W/HPBs+zypXQt0wlnA9YbQ9vxRoLIVbHyAE/D6Uf0S1FaVTPYJxsDExU5k/MkDtZGi
         XSyuucPDn6EhQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 0/3] memblock, arm: fixes for freeing of the memory map
Date:   Wed, 19 May 2021 17:14:33 +0300
Message-Id: <20210519141436.11961-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

The coordination between freeing of unused memory map, pfn_valid() and core
mm assumptions about validity of the memory map in various ranges was not
designed for complex layouts of the physical memory with a lot of holes all
over the place.

Kefen Wang reported crashes in move_freepages() on a system with the
following memory layout:

  node   0: [mem 0x0000000080a00000-0x00000000855fffff]
  node   0: [mem 0x0000000086a00000-0x0000000087dfffff]
  node   0: [mem 0x000000008bd00000-0x000000008c4fffff]
  node   0: [mem 0x000000008e300000-0x000000008ecfffff]
  node   0: [mem 0x0000000090d00000-0x00000000bfffffff]
  node   0: [mem 0x00000000cc000000-0x00000000dc9fffff]
  node   0: [mem 0x00000000de700000-0x00000000de9fffff]
  node   0: [mem 0x00000000e0800000-0x00000000e0bfffff]
  node   0: [mem 0x00000000f4b00000-0x00000000f6ffffff]
  node   0: [mem 0x00000000fda00000-0x00000000ffffefff]

The crashes can be mitigated by enabling CONFIG_HOLES_IN_ZONE and
essentially turning pfn_valid_within() to pfn_valid() instead of having it
hardwired to 1.

Alternatively, we can update ARM's implementation of pfn_valid() to take
into accounting rounding of the freed memory map to pageblock boundaries
and make sure it returns true for PFNs that have memory map entries even if
there is no physical memory.

I can take the entire series via memblock tree.

@Kefen, I didn't add your Tested-by yet because the patch is slightly
different from the version you've tested.

v2:
* Use single memblock_overlaps_region() instead of several
memblock_is_map_memory() lookups. This makes this series depend on update
of MEMBLOCK_NOMAP handling in the memory map [2]

v1: Link: https://lore.kernel.org/lkml/20210518090613.21519-1-rppt@kernel.org

[1] https://lore.kernel.org/lkml/2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com
[2] https://lore.kernel.org/lkml/20210511100550.28178-1-rppt@kernel.org

Mike Rapoport (3):
  memblock: free_unused_memmap: use pageblock units instead of MAX_ORDER
  memblock: align freed memory map on pageblock boundaries with SPARSEMEM
  arm: extend pfn_valid to take into accound freed memory map alignment

 arch/arm/mm/init.c | 13 ++++++++++++-
 mm/memblock.c      | 23 ++++++++++++-----------
 2 files changed, 24 insertions(+), 12 deletions(-)


base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
-- 
2.28.0

