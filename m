Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A175A31509C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhBINnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:43:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:33058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhBINkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:40:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8C12AFFB;
        Tue,  9 Feb 2021 13:39:03 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>, VlastimilBabkavbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 6/7] x86/Kconfig: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Date:   Tue,  9 Feb 2021 14:38:53 +0100
Message-Id: <20210209133854.17399-7-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20210209133854.17399-1-osalvador@suse.de>
References: <20210209133854.17399-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable x86_64 platform to use the MHP_MEMMAP_ON_MEMORY feature.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/x86/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 72663de8b04c..81046b7adb10 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2440,6 +2440,10 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
+config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+	def_bool y
+	depends on X86_64 && MEMORY_HOTPLUG && SPARSEMEM_VMEMMAP_ENABLE
+
 config USE_PERCPU_NUMA_NODE_ID
 	def_bool y
 	depends on NUMA
-- 
2.16.3

