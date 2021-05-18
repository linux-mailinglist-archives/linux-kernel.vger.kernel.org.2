Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D38E3874B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347799AbhERJHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347765AbhERJHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:07:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7590160720;
        Tue, 18 May 2021 09:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621328779;
        bh=TzSLko8JIrWpgMH4yRw1BrafNW9JkoU7wGnWik8SgXI=;
        h=From:To:Cc:Subject:Date:From;
        b=R3+GEhhOSKW/448lAMB4GPAnhF+NA0EXOBRHzgsTFkGOzmGULZsyhxzBU3oeVytpL
         lw1zqEmpxgJjtbqCil42bs9BrYcsPrQEVxWJGkpiOicZHsRP+ikIFTl0ziVzGsqkL1
         4dsxPoaJ3HP088s5XAE/GJK4mvGwESAGDWzZ4pBjS6yHd3hQKUUP35pco8UDvosNgl
         ZpZ+zcFIJwOS//+NHAwOcr09g0E6fI4ukRbCJjVeQEISGL1Ul5Z8F+gSIVbRxCYf6w
         4BqkQwkwSa8DP+y2Lkl41EZK9fCKM/IeG/oZwzblaxO0ExSa7bYGZ5yAychdWsyPaq
         tJTraJZmqW9VQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/3] memblock, arm: fixes for freeing of the memory map
Date:   Tue, 18 May 2021 12:06:10 +0300
Message-Id: <20210518090613.21519-1-rppt@kernel.org>
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

[1] https://lore.kernel.org/lkml/2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com

Mike Rapoport (3):
  memblock: free_unused_memmap: use pageblock units instead of MAX_ORDER
  memblock: align freed memory map on pageblock boundaries with SPARSEMEM
  arm: extend pfn_valid to take into accound freed memory map alignment

 arch/arm/mm/init.c | 15 ++++++++++++++-
 mm/memblock.c      | 23 ++++++++++++-----------
 2 files changed, 26 insertions(+), 12 deletions(-)


base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
-- 
2.28.0

