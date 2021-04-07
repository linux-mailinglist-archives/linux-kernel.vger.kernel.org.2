Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11819357326
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343907AbhDGR1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhDGR0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:26:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1CB761245;
        Wed,  7 Apr 2021 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617816400;
        bh=X0TznhRQ1rNxYkaGVTvSVgcMdtW1s20eY3i7PGc1DyI=;
        h=From:To:Cc:Subject:Date:From;
        b=kIKMCnKJHZUhcF0j7TRm268bp2eLc+q8uBA03fX/4M51X2fyLiGbYbJgsb9Uo6I21
         HPBaSbHjaY8Mt3/O+jXaBNnl3BEfPKofjxGs0J75TytOzfeyrX0HvfdhsOZPqUkttf
         Fgy+TmPa8WFe0YIEAphXWes1GOYabuwCcpMq7ZNwXyik97KHKI+djm/2MmvE77Rvdh
         vj6VilT6ua5X/fbpSGuFEuS+maCIfhyV4iKeBsfNa1No+2Z3MtRYTEBE9SkwsE9EnL
         nz6LnCgVALJzCe0wx0D5RN8cd6PH273SeFkyj0yLGbNbbzxsOCgrxMG6SjEeW5+yE8
         ka5t4bs9ftKMg==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC/RFT PATCH 0/3] arm64: drop pfn_valid_within() and simplify pfn_valid()
Date:   Wed,  7 Apr 2021 20:26:04 +0300
Message-Id: <20210407172607.8812-1-rppt@kernel.org>
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

Mike Rapoport (3):
  memblock: update initialization of reserved pages
  arm64: decouple check whether pfn is normal memory from pfn_valid()
  arm64: drop pfn_valid_within() and simplify pfn_valid()

 arch/arm64/Kconfig              |  3 ---
 arch/arm64/include/asm/memory.h |  2 +-
 arch/arm64/include/asm/page.h   |  1 +
 arch/arm64/kvm/mmu.c            |  2 +-
 arch/arm64/mm/init.c            | 10 ++++++++--
 arch/arm64/mm/ioremap.c         |  4 ++--
 arch/arm64/mm/mmu.c             |  2 +-
 mm/memblock.c                   | 23 +++++++++++++++++++++--
 8 files changed, 35 insertions(+), 12 deletions(-)


base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.28.0

