Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643B03654DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhDTJKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhDTJKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:10:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA915611F2;
        Tue, 20 Apr 2021 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618909774;
        bh=TVJDUXhJ6CplL+qBeAb0uQbwAMiGJwKZzeHI/o52vzg=;
        h=From:To:Cc:Subject:Date:From;
        b=WP/6RRsHt1xJ6WubZpF0wiLM/Q+b+naQEzZ9T1AGJ7I0BrkiWYXWhBz4D5la8KdBE
         3tyOyGNKIATejyXsplTnTMyCyjbGuqsDRQtl829ReQkddr0kEaMvfMTFMBM9IwSwpk
         OmOHdm7PwLHL+Z526d1n9TFE5nAWi4VMpSdkFbYMj2qKam5pl60VYuh9eqqyfzVCoT
         hyXIqd2uIG/B7n90ABXMRR6OkADFhavU1Rlbj50ScGK/SJsOEWHkSTkd83uVoC50W2
         Yslw+v/GG2aCgoSGiIMHQYouLKY566vD9Y35qh6bnON6EN5opk/p+7jGlYESv2IgbX
         kEzFt62nV8TLQ==
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
Subject: [PATCH v1 0/4] arm64: drop pfn_valid_within() and simplify pfn_valid()
Date:   Tue, 20 Apr 2021 12:09:21 +0300
Message-Id: <20210420090925.7457-1-rppt@kernel.org>
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

Changes since RFC
Link: https://lore.kernel.org/lkml/20210407172607.8812-1-rppt@kernel.org

* Add comment about the semantics of pfn_valid() as Anshuman suggested
* Extend comments about MEMBLOCK_NOMAP, per Anshuman
* Use pfn_is_map_memory() name for the exported wrapper for
  memblock_is_map_memory(). It is still local to arch/arm64 in the end
  because of header dependency issues.

Mike Rapoport (4):
  include/linux/mmzone.h: add documentation for pfn_valid()
  memblock: update initialization of reserved pages
  arm64: decouple check whether pfn is in linear map from pfn_valid()
  arm64: drop pfn_valid_within() and simplify pfn_valid()

 arch/arm64/Kconfig              |  3 ---
 arch/arm64/include/asm/memory.h |  2 +-
 arch/arm64/include/asm/page.h   |  1 +
 arch/arm64/kvm/mmu.c            |  2 +-
 arch/arm64/mm/init.c            | 10 ++++++++--
 arch/arm64/mm/ioremap.c         |  4 ++--
 arch/arm64/mm/mmu.c             |  2 +-
 include/linux/memblock.h        |  4 +++-
 include/linux/mmzone.h          | 11 +++++++++++
 mm/memblock.c                   | 28 ++++++++++++++++++++++++++--
 10 files changed, 54 insertions(+), 13 deletions(-)

base-commit: e49d033bddf5b565044e2abe4241353959bc9120
-- 
2.28.0

