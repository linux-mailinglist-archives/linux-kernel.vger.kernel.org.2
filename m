Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F4B3BAD9D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 17:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhGDPKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 11:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhGDPKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 11:10:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AEE7613BA;
        Sun,  4 Jul 2021 15:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625411291;
        bh=kJrhh6BxzSNFGHYJ+mlmwYJIYNaq1EtlJUumheQZPao=;
        h=Date:From:To:Cc:Subject:From;
        b=IW/0QBXAUkmSO7TuKZvWoE4iUg3mf6DsEp2WDDZFw7Klt3LLWP1IZUVTv56ksS2Ka
         0VPqP7UohT/wy1NfzAezLFV7OEcsk1L07mm1BfkV+lVIc5w9i9dQ2l9Kcgcq0P7yXo
         Gu7njoftfGKtL+61K6w7x3kISJnPpJZJTIrYgHbuFN/Ht6vqCcT02Q/3eDhHxieq6B
         pJzdMLfrzGdyBlFrAff/snNR62uTpx2j9D0IzpB5RJRPoK8+w1j2v+wAD0SgUYwvJF
         dlDHjpN0frUMkzz42JxcV9DWxB2Tv99KKePvUL0Y+p2FdrYqjwU7SDFkauPqI3HgVj
         GpKgreh6b4xvQ==
Date:   Sun, 4 Jul 2021 18:08:03 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [GIT PULL] memblock, arm: fix crashes caused by holes in the memory
 map
Message-ID: <YOHO05xJAVItsYsg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/memblock-v5.14-rc1

for you to fetch changes up to a4d5613c4dc6d413e0733e37db9d116a2a36b9f3:

  arm: extend pfn_valid to take into account freed memory map alignment (2021-06-30 11:39:00 +0300)

----------------------------------------------------------------
memblock, arm: fix crashes caused by holes in the memory map

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

These crashes can be mitigated by enabling CONFIG_HOLES_IN_ZONE on ARM and
essentially turning pfn_valid_within() to pfn_valid() instead of having it
hardwired to 1 on that architecture, but this would require to keep
CONFIG_HOLES_IN_ZONE solely for this purpose.

A cleaner approach is to update ARM's implementation of pfn_valid() to take
into accounting rounding of the freed memory map to pageblock boundaries
and make sure it returns true for PFNs that have memory map entries even if
there is no physical memory backing those PFNs.

[1] https://lore.kernel.org/lkml/2a1592ad-bc9d-4664-fd19-f7448a37edc0@huawei.com

----------------------------------------------------------------
Mike Rapoport (4):
      memblock: free_unused_memmap: use pageblock units instead of MAX_ORDER
      memblock: align freed memory map on pageblock boundaries with SPARSEMEM
      memblock: ensure there is no overflow in memblock_overlaps_region()
      arm: extend pfn_valid to take into account freed memory map alignment

 arch/arm/mm/init.c | 13 ++++++++++++-
 mm/memblock.c      | 26 ++++++++++++++------------
 2 files changed, 26 insertions(+), 13 deletions(-)

-- 
Sincerely yours,
Mike.
