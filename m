Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E1F3B7DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhF3HOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232018AbhF3HOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:14:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2F2C61C8D;
        Wed, 30 Jun 2021 07:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625037138;
        bh=h98dREsVdJUhSNVlPxZc1muoXPqPKUOOk+l4lcg/OiY=;
        h=From:To:Cc:Subject:Date:From;
        b=LgGfCRbgRZ63j8MKoB1udTXqmn7U2QzWIkuI4ti75anaODrjI4u6HOYa33r1fGac5
         3BJL6Ts+urrdYjV1H9Wuj7Uce60pxqoP3QMegMrpknkP+gO0t+dTcGI0T+o2lGW69J
         AgWM1PYKSOYdtQqIB3UC3dJ/R4oKsRt2w8MExYXOLkZwT2ydKxRr2dwViIDQ9RI7RD
         E4nMUzbHb/iXCDtSkotpSrt6v9p1mVUW9oPBbvVShuTpC6yigCmooPUR03kGITtgbw
         +0HnJX4zGDmERLIaN+SPJ0zQT0VS8buXZXR4v72m43ljONhPsWU61kWVaVyb4Uy5x2
         XWhN85/rVVhgw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 0/4] memblock, arm: fixes for freeing of the memory map
Date:   Wed, 30 Jun 2021 10:12:07 +0300
Message-Id: <20210630071211.21011-1-rppt@kernel.org>
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
following memory layout [1]:

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
hardwired to 1, but this would require to keep CONFIG_HOLES_IN_ZONE which
could be removed after arm64 and MIPS stopped using it ([2], [3]).

Alternatively, we can update ARM's implementation of pfn_valid() to take
into accounting rounding of the freed memory map to pageblock boundaries
and make sure it returns true for PFNs that have memory map entries even if
there is no physical memory.

I'm planning to merge this via memblock tree.

v3: 
* Add patch 3/4 to ensure there is no overflow in memblock_overlaps_region()

v2: Link: https://lore.kernel.org/lkml/20210519141436.11961-1-rppt@kernel.org
* Use single memblock_overlaps_region() instead of several
  memblock_is_map_memory() lookups. This makes this series depend on update
  of MEMBLOCK_NOMAP handling in the memory map [2]

v1: Link: https://lore.kernel.org/lkml/20210518090613.21519-1-rppt@kernel.org

[1] https://lore.kernel.org/lkml/2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com
[2] https://lore.kernel.org/lkml/20210511100550.28178-1-rppt@kernel.org
[3] https://lore.kernel.org/lkml/20210418093512.668-1-rppt@kernel.org

Mike Rapoport (4):
  memblock: free_unused_memmap: use pageblock units instead of MAX_ORDER
  memblock: align freed memory map on pageblock boundaries with SPARSEMEM
  memblock: ensure there is no overflow in memblock_overlaps_region()
  arm: extend pfn_valid to take into account freed memory map alignment

 arch/arm/mm/init.c | 13 ++++++++++++-
 mm/memblock.c      | 26 ++++++++++++++------------
 2 files changed, 26 insertions(+), 13 deletions(-)


base-commit: c4681547bcce777daf576925a966ffa824edd09d
-- 
2.28.0

