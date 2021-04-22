Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2263679C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhDVGTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhDVGTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E070661437;
        Thu, 22 Apr 2021 06:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619072351;
        bh=aiNqPvrK3ZBf/RWLu2gvO3kob5vQAnJH+Nma7uJgE88=;
        h=From:To:Cc:Subject:Date:From;
        b=VL9qOvsr2nvFrKZcsGAOxDY7RsbjZfM7fSRRg5XWY0QXE1qOJhi6l/zAJeuHoiNSi
         4n4fKL8s2YnZodz0Gvbb2OIH52szb02HxHgGZtSz7XVskjXqXynuHgA2BhAkjLZa9U
         SU3J7Nog+EbcP/IRKaM7VwUbdr3VVYBK7r+1Y0n+7TnNnBo8SndU9QbBiMCLqGkeaO
         VHwJvQuXnj3tCoBXjga6jvJtwuQ/GV28YpaNXP62Zo1QPeKtDqLSWh72VHivE451yo
         V+EubptW9xFki40ACOz+J06UIJG30vVc2AfikinF6P0FLp6pQ7AqEheYpFsXgnGPj8
         nYuOW8KRCpkgA==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v3 0/4] arm64: drop pfn_valid_within() and simplify pfn_valid()
Date:   Thu, 22 Apr 2021 09:18:58 +0300
Message-Id: <20210422061902.21614-1-rppt@kernel.org>
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

The patches are only boot tested on qemu-system-aarch64 so I'd really
appreciate memory stress tests on real hardware.

If this actually works we'll be one step closer to drop custom pfn_valid()
on arm64 altogether.

v3:
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
 arch/arm64/mm/init.c            | 16 ++++++++++++++--
 arch/arm64/mm/ioremap.c         |  4 ++--
 arch/arm64/mm/mmu.c             |  2 +-
 include/linux/memblock.h        |  4 +++-
 include/linux/mmzone.h          | 11 +++++++++++
 mm/memblock.c                   | 28 ++++++++++++++++++++++++++--
 10 files changed, 61 insertions(+), 14 deletions(-)

base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.28.0

