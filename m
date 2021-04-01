Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B77350F3B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhDAGnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:43:35 -0400
Received: from foss.arm.com ([217.140.110.172]:59884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232661AbhDAGna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:43:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D595AD6E;
        Wed, 31 Mar 2021 23:43:29 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.70.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D3773F719;
        Wed, 31 Mar 2021 23:43:27 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH V2 0/6] mm: some config cleanups
Date:   Thu,  1 Apr 2021 12:14:02 +0530
Message-Id: <1617259448-22529-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains config cleanup patches which reduces code duplication
across platforms and also improves maintainability. There is no functional
change intended with this series. This has been boot tested on arm64 but
only build tested on some other platforms.

This applies on 5.12-rc5

Changes in V2:

- Rebased on 5.12-rc5
- Added tags from previous version

Changes in V1:

https://lore.kernel.org/linux-arm-kernel/1615278790-18053-1-git-send-email-anshuman.khandual@arm.com/

Anshuman Khandual (6):
  mm: Generalize ARCH_HAS_CACHE_LINE_SIZE
  mm: Generalize SYS_SUPPORTS_HUGETLBFS (rename as ARCH_SUPPORTS_HUGETLBFS)
  mm: Generalize ARCH_ENABLE_MEMORY_[HOTPLUG|HOTREMOVE]
  mm: Drop redundant ARCH_ENABLE_[HUGEPAGE|THP]_MIGRATION
  mm: Drop redundant ARCH_ENABLE_SPLIT_PMD_PTLOCK
  mm: Drop redundant HAVE_ARCH_TRANSPARENT_HUGEPAGE

 arch/arc/Kconfig                       |  9 ++------
 arch/arm/Kconfig                       | 10 ++-------
 arch/arm64/Kconfig                     | 30 ++++++--------------------
 arch/ia64/Kconfig                      |  8 ++-----
 arch/mips/Kconfig                      |  6 +-----
 arch/parisc/Kconfig                    |  5 +----
 arch/powerpc/Kconfig                   | 11 ++--------
 arch/powerpc/platforms/Kconfig.cputype | 16 +++++---------
 arch/riscv/Kconfig                     |  5 +----
 arch/s390/Kconfig                      | 12 +++--------
 arch/sh/Kconfig                        |  7 +++---
 arch/sh/mm/Kconfig                     |  8 -------
 arch/x86/Kconfig                       | 29 ++++++-------------------
 fs/Kconfig                             |  5 ++++-
 mm/Kconfig                             |  9 ++++++++
 15 files changed, 48 insertions(+), 122 deletions(-)

-- 
2.20.1

