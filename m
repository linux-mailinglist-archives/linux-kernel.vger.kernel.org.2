Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC333C5CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhGLMzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 08:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhGLMzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 08:55:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AD176101E;
        Mon, 12 Jul 2021 12:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626094345;
        bh=23TYWgWEH92y6aJX56zuWW+jSgIiPkLpsptVCfnw4oU=;
        h=From:To:Cc:Subject:Date:From;
        b=PQ7wmc+B2ca1TZ4TyTAyruwy05fkTHLgIHtMv8U9T2FtyDG5zlZKDE4+rjBFcqdDW
         g2Ir/H+qQYSXChAh3RB1NUBzPbmlo+EVmc0fluzCD0Rupaf3WFd8Eh8LOac6jRhD37
         t/RnAIxAs8aGEUtBeEcz7PifpCYZQOEcMgMic9pTfUb1Xl4hUCPiKzSTfrNWQLD2YB
         vVg1NVs13gfw72O43MEH1w4qTJRBKFRD+6hoI/eCY1z5qV0zGGdzsQY1aEHmNwjop8
         DAZ5KBWp37KXaz54NLBzraDNwQkf+jIlRPTmcZV9R97IYxkNgZNOi/BfVdXZFexur1
         8IF5hti0e1OYA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Greentime Hu <green.hu@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] nds32/setup: remove unused memblock_region variable in setup_memory()
Date:   Mon, 12 Jul 2021 15:52:18 +0300
Message-Id: <20210712125218.28951-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

kernel test robot reports unused variable warning:

cppcheck possible warnings: (new ones prefixed by >>, may not real
problems)

>> arch/nds32/kernel/setup.c:247:26: warning: Unused variable: region
>> [unusedVariable]
    struct memblock_region *region;
                            ^

Remove the unused variable.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/nds32/kernel/setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index 41725eaf8bac..b3d34d646652 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -244,7 +244,6 @@ static void __init setup_memory(void)
 	unsigned long ram_start_pfn;
 	unsigned long free_ram_start_pfn;
 	phys_addr_t memory_start, memory_end;
-	struct memblock_region *region;
 
 	memory_end = memory_start = 0;
 

base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.28.0

