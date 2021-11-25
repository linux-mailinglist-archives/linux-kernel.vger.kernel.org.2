Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5064A45D5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 09:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352368AbhKYIEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 03:04:07 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:26428 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348858AbhKYICF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 03:02:05 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8619f400db24-0a654; Thu, 25 Nov 2021 15:49:35 +0800 (CST)
X-RM-TRANSID: 2ee8619f400db24-0a654
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9619f400cee5-5f5ba;
        Thu, 25 Nov 2021 15:49:35 +0800 (CST)
X-RM-TRANSID: 2ee9619f400cee5-5f5ba
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, cezary.rojewski@intel.com,
        pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: Intel: atom: Remove redundant check to simplify the code
Date:   Thu, 25 Nov 2021 15:50:28 +0800
Message-Id: <20211125075028.8500-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function sst_platform_get_resources(), if platform_get_irq()
failed, the return should not be zero, as the example in
platform.c is
  * int irq = platform_get_irq(pdev, 0)
  * if (irq < 0)
  * return irq;
So remove the redundant check to simplify the code.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 3be64430c..696d547c5 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -226,8 +226,8 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	/* Find the IRQ */
 	ctx->irq_num = platform_get_irq(pdev,
 				ctx->pdata->res_info->acpi_ipc_irq_index);
-	if (ctx->irq_num <= 0)
-		return ctx->irq_num < 0 ? ctx->irq_num : -EIO;
+	if (ctx->irq_num < 0)
+		return ctx->irq_num;
 
 	return 0;
 }
-- 
2.20.1.windows.1



