Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C1F417CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346650AbhIXVHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346324AbhIXVHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:07:00 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2714AC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3ihxcA0mu2RgeBKe0rwDpRoosI603PmzNVoMOlTBmtg=; b=cdOfpAx0jDJkJGRbHYrCwsUgAl
        XkVZk/VRryXQ8apKL7He62rk0iUgIEFosjzJEJ1bZ1wb60KQh8ycsy4+WSqIT6s9IEuECFDa6vcAU
        uWVCDiAQjlVU5pRXnXJyOYrLjaQ8BEBGFJaRoyjBHasAjHVtSadubQMIZbIgt9dxc4gdNEBKk4np3
        vVSVShDoPDUvc0pAK5lLzvq9MY85vW87jeDWxU4G0f7tTV6Qb2qxeFC6q3u6WEKnfPaz7MIOcbZ1O
        hGJPNiIfbJ17VTxLa2A73AjHAief8xf+vdjeF7kcEyM4Rb59F3lkiPUmfNQvBu7JXDpQKTMFqWIwJ
        ZjycmUQA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTsNq-00FX2F-Cw; Fri, 24 Sep 2021 21:05:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Andreas Oetken <andreas.oetken@siemens.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] NIOS2: setup.c: drop unused variable 'dram_start'
Date:   Fri, 24 Sep 2021 14:05:25 -0700
Message-Id: <20210924210525.7053-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a nuisance when CONFIG_WERROR is set, so drop the variable
declaration since the code that used it was removed.

../arch/nios2/kernel/setup.c: In function 'setup_arch':
../arch/nios2/kernel/setup.c:152:13: warning: unused variable 'dram_start' [-Wunused-variable]
  152 |         int dram_start;

Fixes: 7f7bc20bc41a ("nios2: Don't use _end for calculating min_low_pfn")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Andreas Oetken <andreas.oetken@siemens.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/nios2/kernel/setup.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-next-20210917.orig/arch/nios2/kernel/setup.c
+++ linux-next-20210917/arch/nios2/kernel/setup.c
@@ -149,8 +149,6 @@ static void __init find_limits(unsigned
 
 void __init setup_arch(char **cmdline_p)
 {
-	int dram_start;
-
 	console_verbose();
 
 	memory_start = memblock_start_of_DRAM();
