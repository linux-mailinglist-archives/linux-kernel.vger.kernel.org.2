Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F48832E15F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 06:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhCEFYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 00:24:38 -0500
Received: from foss.arm.com ([217.140.110.172]:47950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEFYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 00:24:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA5E131B;
        Thu,  4 Mar 2021 21:24:36 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.68.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 791283F73B;
        Thu,  4 Mar 2021 21:24:30 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Veronika Kabatova <vkabatov@redhat.com>
Subject: [PATCH V3 0/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
Date:   Fri,  5 Mar 2021 10:54:56 +0530
Message-Id: <1614921898-4099-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes pfn_valid() for ZONE_DEVICE based memory and also improves
its performance for normal hotplug memory. While here, it also reorganizes
pfn_valid() on CONFIG_SPARSEMEM. This series is based on v5.12-rc1.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Veronika Kabatova <vkabatov@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Changes in V3:

- Validate the pfn before fetching mem_section with __pfn_to_section() in [PATCH 2/2]

Changes in V2:

https://lore.kernel.org/linux-mm/1612239114-28428-1-git-send-email-anshuman.khandual@arm.com/

- Dropped pfn_valid() bifurcation based on CONFIG_SPARSEMEM
- Used PFN_PHYS() and PHYS_PFN() instead of __pfn_to_phys() and __phys_to_pfn()
- Moved __pfn_to_section() inside #ifdef CONFIG_SPARSEMEM with a { } construct

Changes in V1:

https://lore.kernel.org/linux-mm/1611905986-20155-1-git-send-email-anshuman.khandual@arm.com/

- Test pfn_section_valid() for non boot memory

Changes in RFC:

https://lore.kernel.org/linux-arm-kernel/1608621144-4001-1-git-send-email-anshuman.khandual@arm.com/

Anshuman Khandual (2):
  arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
  arm64/mm: Reorganize pfn_valid()

 arch/arm64/mm/init.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

-- 
2.20.1

