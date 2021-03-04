Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7430F32D050
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbhCDKBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:01:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:54808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238113AbhCDKAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:00:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2CC8CADE3;
        Thu,  4 Mar 2021 10:00:11 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 4/5] x86/Kconfig: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Date:   Thu,  4 Mar 2021 11:00:01 +0100
Message-Id: <20210304100002.7740-5-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210304100002.7740-1-osalvador@suse.de>
References: <20210304100002.7740-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable x86_64 platform to use the MHP_MEMMAP_ON_MEMORY feature.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/x86/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..6d716d8bce1e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2433,6 +2433,10 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
 	def_bool y
 	depends on MEMORY_HOTPLUG
 
+config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+	def_bool y
+	depends on X86_64 && MEMORY_HOTPLUG
+
 config USE_PERCPU_NUMA_NODE_ID
 	def_bool y
 	depends on NUMA
-- 
2.16.3

