Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD0E3DF462
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 20:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbhHCSLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 14:11:52 -0400
Received: from mail.ispras.ru ([83.149.199.84]:36584 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhHCSLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:11:51 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPS id 5FE6640D3BFF;
        Tue,  3 Aug 2021 18:11:36 +0000 (UTC)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] platform/x86: intel_pmc_core: Fix potential buffer overflows
Date:   Tue,  3 Aug 2021 21:11:35 +0300
Message-Id: <20210803181135.22298-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like pmc_core_get_low_power_modes() mixes up modes and
priorities. In addition to invalid behavior, potentially this can
cause buffer overflows since the driver reads priorities from the
register and then it uses them as indexes for array lpm_priority
that can contain 8 elements at most. The patch swaps modes and
priorities.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 005125bfd70e ("platform/x86: intel_pmc_core: Handle sub-states generically")
Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/platform/x86/intel_pmc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index b0e486a6bdfb..667b3df03764 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1469,8 +1469,8 @@ static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
 		int pri0 = GENMASK(3, 0) & priority;
 		int pri1 = (GENMASK(7, 4) & priority) >> 4;
 
-		lpm_priority[pri0] = mode;
-		lpm_priority[pri1] = mode + 1;
+		lpm_priority[mode] = pri0;
+		lpm_priority[mode + 1] = pri1;
 	}
 
 	/*
-- 
2.26.2

