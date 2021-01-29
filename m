Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EDD3086A4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhA2Hk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:40:57 -0500
Received: from foss.arm.com ([217.140.110.172]:44772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhA2Hke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:40:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C2BE13D5;
        Thu, 28 Jan 2021 23:39:48 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.92.245])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DC4F3F719;
        Thu, 28 Jan 2021 23:39:42 -0800 (PST)
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
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 0/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
Date:   Fri, 29 Jan 2021 13:09:44 +0530
Message-Id: <1611905986-20155-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes pfn_valid() for ZONE_DEVICE based memory and also improves
its performance for normal hotplug memory. While here, it also reorganizes
pfn_valid() on CONFIG_SPARSEMEM. This series is based on v5.11-rc5.

Question - should pfn_section_valid() be tested both for boot and non boot
memory as well ?

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
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Changes in V1:

- Test pfn_section_valid() for non boot memory

Changes in RFC:

https://lore.kernel.org/linux-arm-kernel/1608621144-4001-1-git-send-email-anshuman.khandual@arm.com/

Anshuman Khandual (2):
  arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
  arm64/mm: Reorganize pfn_valid()

 arch/arm64/mm/init.c | 46 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

-- 
2.20.1

