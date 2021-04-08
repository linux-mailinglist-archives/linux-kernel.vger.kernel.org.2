Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48E4358320
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhDHMSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:18:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39554 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231557AbhDHMSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:18:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53178B114;
        Thu,  8 Apr 2021 12:18:24 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 8/8] arm64/Kconfig: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
Date:   Thu,  8 Apr 2021 14:18:04 +0200
Message-Id: <20210408121804.10440-9-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210408121804.10440-1-osalvador@suse.de>
References: <20210408121804.10440-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable arm64 platform to use the MHP_MEMMAP_ON_MEMORY feature.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/arm64/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5656e7aacd69..0e23acd173f0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -309,6 +309,9 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
 config ARCH_ENABLE_MEMORY_HOTREMOVE
 	def_bool y
 
+config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
+	def_bool y
+
 config SMP
 	def_bool y
 
-- 
2.16.3

