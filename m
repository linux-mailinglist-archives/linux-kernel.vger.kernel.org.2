Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E993837A43C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhEKKHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhEKKHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:07:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F60861360;
        Tue, 11 May 2021 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620727558;
        bh=RlNaQugaThbhHxZD0Bx4H5Pc9CrWxAqv0CUHIawYkSk=;
        h=From:To:Cc:Subject:Date:From;
        b=GmY0r1IkW3ZeGuFPesJIUk10G0bmFN6ceybj46DtgYlzYIMqRRPbswUKdNL2jBhnW
         l/ZvckzitBi4O5D1xMtId10RQRWtXmuPJLUMCooqUixyjZ+ggFmUWAhjBsNaCElc9T
         8wGcvvublT2SaDT1c2KzMw4yGHJjHtzf0/joh0h/IYIYiAZXdKtEjzbQlET6xexDL2
         o7etoJtcP0gOwdCLxDTBw00jI+Plg4iKtTu7BUlIIKrx87a1VRUXOjiwz8C0FoMU2E
         Ld0dMkYL/WSB7Z03xxLA93T3VBfMtc6LT4gd27sv43Kgy32Oz/AIIeG+V3yk7vWNyV
         ERDgF+e43XDbg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 0/4] arm64: drop pfn_valid_within() and simplify pfn_valid()
Date:   Tue, 11 May 2021 13:05:46 +0300
Message-Id: <20210511100550.28178-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

These patches aim to remove CONFIG_HOLES_IN_ZONE and essentially hardwire
pfn_valid_within() to 1. 

The idea is to mark NOMAP pages as reserved in the memory map and restore
the intended semantics of pfn_valid() to designate availability of struct
page for a pfn.

With this the core mm will be able to cope with the fact that it cannot use
NOMAP pages and the holes created by NOMAP ranges within MAX_ORDER blocks
will be treated correctly even without the need for pfn_valid_within.

The patches are boot tested on qemu-system-aarch64.

I beleive it would be best to route these via mmotm tree.

v4:
* rebase on v5.13-rc1

v3: Link: https://lore.kernel.org/lkml/20210422061902.21614-1-rppt@kernel.org
* Fix minor issues found by Anshuman
* Freshen up the declaration of pfn_valid() to make it consistent with
  pfn_is_map_memory()
* Add more Acked-by and Reviewed-by tags, thanks Anshuman and David

v2: Link: https://lore.kernel.org/lkml/20210421065108.1987-1-rppt@kernel.org
* Add check for PFN overflow in pfn_is_map_memory()
* Add Acked-by and Reviewed-by tags, thanks David.

v1: Link: https://lore.kernel.org/lkml/20210420090925.7457-1-rppt@kernel.org
* Add comment about the semantics of pfn_valid() as Anshuman suggested
* Extend comments about MEMBLOCK_NOMAP, per Anshuman
* Use pfn_is_map_memory() name for the exported wrapper for
  memblock_is_map_memory(). It is still local to arch/arm64 in the end
  because of header dependency issues.

rfc: Link: https://lore.kernel.org/lkml/20210407172607.8812-1-rppt@kernel.org

Mike Rapoport (4):
  include/linux/mmzone.h: add documentation for pfn_valid()
  memblock: update initialization of reserved pages
  arm64: decouple check whether pfn is in linear map from pfn_valid()
  arm64: drop pfn_valid_within() and simplify pfn_valid()

 arch/arm64/Kconfig              |  3 ---
 arch/arm64/include/asm/memory.h |  2 +-
 arch/arm64/include/asm/page.h   |  3 ++-
 arch/arm64/kvm/mmu.c            |  2 +-
 arch/arm64/mm/init.c            | 14 +++++++++++++-
 arch/arm64/mm/ioremap.c         |  4 ++--
 arch/arm64/mm/mmu.c             |  2 +-
 include/linux/memblock.h        |  4 +++-
 include/linux/mmzone.h          | 11 +++++++++++
 mm/memblock.c                   | 28 ++++++++++++++++++++++++++--
 10 files changed, 60 insertions(+), 13 deletions(-)


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.28.0

