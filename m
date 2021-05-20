Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8415338AF9B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242375AbhETNHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:07:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:9085 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243359AbhETNHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:07:04 -0400
IronPort-SDR: Z1BGootSLeU31TCDdvkHmwCcYx1p38yyVcKBOqgAK/G4tyPJopLxOi94wcipzhpeQ3siQONJRf
 hWfI4/N33CvA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="201263060"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="201263060"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 06:05:43 -0700
IronPort-SDR: +V+hfeCLByMd/446CuCaRLGabISgSZ30qr+XcV1yl2TADYP7wALuZMB7FHM6g9LNcuYfSbi+PD
 W4haHJuCKlVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="433893524"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 20 May 2021 06:05:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 09DA312A; Thu, 20 May 2021 16:06:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] kernel.h: split out panic and oops helpers (ia64 fix)
Date:   Thu, 20 May 2021 16:05:57 +0300
Message-Id: <20210520130557.55277-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow up fix for the "kernel.h: split out panic and oops helpers" patch.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Andrew, please add as a fix to the above mentioned patch, thanks!

For the record, I haven't got any other messages from any of CIs/bots,
presumably there will be no more or very little reports.

Note, this patch is untested. I have no ia64 compiler at hand.

 arch/ia64/include/asm/pal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ia64/include/asm/pal.h b/arch/ia64/include/asm/pal.h
index 5c51fceedaf9..e6b652f9e45e 100644
--- a/arch/ia64/include/asm/pal.h
+++ b/arch/ia64/include/asm/pal.h
@@ -99,6 +99,7 @@
 
 #include <linux/types.h>
 #include <asm/fpu.h>
+#include <asm/intrinsics.h>
 
 /*
  * Data types needed to pass information into PAL procedures and
-- 
2.30.2

