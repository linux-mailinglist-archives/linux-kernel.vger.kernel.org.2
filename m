Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAA3405A17
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbhIIPTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbhIIPTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:19:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA1FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 08:18:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u9so3086628wrg.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBA3frC1peSMpXkdRxoXGSwcQST+Z0JE3+yWnniewqQ=;
        b=MSDYMf8xVE/k8UvmjEeaoYZko+7eM782tCQpQznij2I3CRvTJu1BWp4Uy2F3vudhtN
         MWq2nmhhJiMRXVMckwtTOq7kEUYo/xYJZqhj+jhkFzo5fpq+W5euc3BfE92Mwv5MG6Dr
         c+vzjT55wLu8R/o+SXoWcpQL/2l8VvbTVjFbw4NvOcpsBRddmlkhr10dfWyV/wsr2X4X
         VgrqfUK+buh1GbgtKis1nkoSRu65yG/fnr4L1Q+IXHGcmS7LTxlsOHrjotXO5TuBgi5P
         gR4XILt+eO4ulV4iCHADSRAwaN0FVjxeA8MwCoJDzqgeIpi9QrN2lFGVzX01YnCLycwY
         NTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBA3frC1peSMpXkdRxoXGSwcQST+Z0JE3+yWnniewqQ=;
        b=2rLVKYnDBYpvHB+74l1CixiD8BD95ulm5eChtGgEPfAnHNuEa/9FWcm15LCan5V7Ix
         UGSW5GSmIb+W/YuzUfzQbq3APSA2AgctGGM/LejRlQgNUCgiPqy9t+KyUbNpvvu66fii
         ua6PStGxuSBTCHJyUZ+ocvDzat/d2Bg2M6FpbIXtrSCYYXnLmdpqI/p3io1RaWWnmD5j
         5acEje/FFZqQ+AdCuT0c7W5PnjfY11kO/+0xWuJSUrUeeDcBcFbr1Ye19J2ZYSli3wMb
         dMdV2u+X+WzV33TasomPnp65GznlBwPmfL8EoGq9CRrJAy1qeUVdtgTdZMJBeFDQcY9b
         rJ7w==
X-Gm-Message-State: AOAM5321yW3/BwYLC2Ji/qNFefOY1pkyj1Hffiur5OeK6DWpBNXXlel2
        +0ycqalK0po4a2A2VBssV2U=
X-Google-Smtp-Source: ABdhPJyfwQ6e928TELH8c6+9FGB9QmPtC1dkAqRIxsnRzJASZBnfNWAK/nqYkDKHEmnwHYBx8Ga7JA==
X-Received: by 2002:adf:c54a:: with SMTP id s10mr4279568wrf.405.1631200718840;
        Thu, 09 Sep 2021 08:18:38 -0700 (PDT)
Received: from agape ([5.171.80.178])
        by smtp.gmail.com with ESMTPSA id i11sm2047158wrb.48.2021.09.09.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 08:18:38 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH] extcon: extcon-axp288: use low level P-Unit semaphore lock for axp288 register accesses
Date:   Thu,  9 Sep 2021 17:18:20 +0200
Message-Id: <20210909151820.5303-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use low level P-Unit semaphore lock for axp288 register
accesses directly and for more than one access a time,
to reduce the number of times this semaphore is locked
and released which is an expensive operation.

i2c-bus to the XPower is shared between the kernel and the
SoCs P-Unit. The P-Unit has a semaphore wich the kernel must
lock for axp288 register accesses. When the P-Unit semaphore
is locked CPU and GPU power states cannot change or the system
will freeze.

The P-Unit semaphore lock is already managed inside the regmap
access logic, but for each access the semaphore is locked and
released. So use directly iosf_mbi_(un)block_punit_i2c_access(),
we are safe in doing so because nested calls to the same
semaphore are turned to nops.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/extcon/extcon-axp288.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index fdb31954cf2b..460402b14ef2 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -24,6 +24,7 @@
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/iosf_mbi.h>
 
 /* Power source status register */
 #define PS_STAT_VBUS_TRIGGER		BIT(0)
@@ -215,6 +216,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 	unsigned int cable = info->previous_cable;
 	bool vbus_attach = false;
 
+	iosf_mbi_block_punit_i2c_access();
+
 	vbus_attach = axp288_get_vbus_attach(info);
 	if (!vbus_attach)
 		goto no_vbus;
@@ -253,6 +256,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 	}
 
 no_vbus:
+	iosf_mbi_unblock_punit_i2c_access();
+
 	extcon_set_state_sync(info->edev, info->previous_cable, false);
 	if (info->previous_cable == EXTCON_CHG_USB_SDP)
 		extcon_set_state_sync(info->edev, EXTCON_USB, false);
@@ -275,6 +280,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 	return 0;
 
 dev_det_ret:
+	iosf_mbi_unblock_punit_i2c_access();
+
 	if (ret < 0)
 		dev_err(info->dev, "failed to detect BC Mod\n");
 
@@ -307,11 +314,14 @@ static irqreturn_t axp288_extcon_isr(int irq, void *data)
 
 static void axp288_extcon_enable(struct axp288_extcon_info *info)
 {
+	iosf_mbi_block_punit_i2c_access();
 	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
 						BC_GLOBAL_RUN, 0);
 	/* Enable the charger detection logic */
 	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
 					BC_GLOBAL_RUN, BC_GLOBAL_RUN);
+
+	iosf_mbi_unblock_punit_i2c_access();
 }
 
 static void axp288_put_role_sw(void *data)
@@ -384,10 +394,14 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 		}
 	}
 
+	iosf_mbi_block_punit_i2c_access();
+
 	info->vbus_attach = axp288_get_vbus_attach(info);
 
 	axp288_extcon_log_rsi(info);
 
+	iosf_mbi_unblock_punit_i2c_access();
+
 	/* Initialize extcon device */
 	info->edev = devm_extcon_dev_allocate(&pdev->dev,
 					      axp288_extcon_cables);
-- 
2.20.1

