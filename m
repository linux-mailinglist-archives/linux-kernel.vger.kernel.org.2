Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756493C8489
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 14:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbhGNMki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 08:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239284AbhGNMkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 08:40:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA3FA613B2;
        Wed, 14 Jul 2021 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626266265;
        bh=MyPP3ysLnfTJLvyibD3l2UlFIkzFdXWBmuEZG/TSVPk=;
        h=From:To:Cc:Subject:Date:From;
        b=HLXH1K30fK5FCwC5EXrm1k4OgLay4d4qd027S0BgGNFmI6CRmAg4Iqaxv1EX6Rg7B
         LgEomgvD5TucICoERiWzby1PiLf779f5ri3KJZLLmJVbykiD2bzRtUZs/z2/cbGg2A
         WsUzLOVfq3aHS2grHWyDHdzURJbOFhAB0qPBDS19LxbdEKpKZSV5cDJk4GMC8i50qm
         phoXbyadDg/N52auD39g9iOh6QwHfXLgx9U4sGA2bkiHDViUrZd8Az76ltdKB/nTau
         1eZLOn3/ALZ37UB3PBrSYxscFkfCv5PJ8x4vAn5bnDglEJkC7KaVp2BRVq8Cqfq7lC
         dJvEMEAOnOn7A==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/4] mm: ensure consistency of memory map poisoning
Date:   Wed, 14 Jul 2021 15:37:35 +0300
Message-Id: <20210714123739.16493-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

Currently memory map allocation for FLATMEM case does not poison the struct
pages regardless of CONFIG_PAGE_POISON setting.

This happens because allocation of the memory map for FLATMEM and SPARSMEM
use different memblock functions and those that are used for SPARSMEM case
(namely memblock_alloc_try_nid_raw() and memblock_alloc_exact_nid_raw())
implicitly poison the allocated memory.

Another side effect of this implicit poisoning is that early setup code
that uses the same functions to allocate memory burns cycles for the memory
poisoning even if it was not intended.

These patches introduce memmap_alloc() wrapper that ensure that the memory
map allocation is consistent for different memory models.

Mike Rapoport (4):
  mm/page_alloc: always initialize memory map for the holes
  microblaze: simplify pte_alloc_one_kernel()
  mm: introduce memmap_alloc() to unify memory map allocation
  memblock: stop poisoning raw allocations

 arch/microblaze/include/asm/pgtable.h |  2 --
 arch/microblaze/mm/init.c             | 12 ----------
 arch/microblaze/mm/pgtable.c          | 17 +++++++-------
 mm/internal.h                         |  4 ++++
 mm/memblock.c                         | 20 ++++-------------
 mm/page_alloc.c                       | 32 ++++++++++++++++++---------
 mm/sparse.c                           |  6 ++---
 7 files changed, 40 insertions(+), 53 deletions(-)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.28.0

