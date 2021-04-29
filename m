Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D71A36E725
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbhD2Iho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239929AbhD2Ihi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:37:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAF01613F0;
        Thu, 29 Apr 2021 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619685412;
        bh=J5vHzzxX2VNER+zka6PEWkClrD68ro+cEjhzakb7mic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyT6fF4xg5D7Mnqdmc1RjIpsFN/xyGEZHtIejDsPt31etCpuENVLYnPeb5lfk+YBC
         BH6hqv8IeuQi7x9BC1dB2290WHQzp8XB/9gQEM6cyWmduwZ3HnKmPPAQz9GEL5vVcZ
         gju0Pj766jODFEj35NIzUQp02Epm/z2nCWAhGL1eM1tn1ObBM8glU/fEkYtGy+MX1B
         9Ud53B/frNAtwyvWbgQWy8yMnt6tAfthXv7hcw5RI52o2XUtPIFzokIK9vBQ8gGKsa
         g/C2VYkwqOxZL/PvSruO6/ytzP3J3LzFI1cx7LwEy+1qVk6pbHb4t1Q0XQ28s3CjvG
         QfxJcRA7PZXzQ==
Received: by pali.im (Postfix)
        id A5C1B7DF; Thu, 29 Apr 2021 10:36:51 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 mvebu + mvebu/dt64 5/6] firmware: turris-mox-rwtm: add marvell,armada-3700-rwtm-firmware compatible string
Date:   Thu, 29 Apr 2021 10:36:35 +0200
Message-Id: <20210429083636.22560-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210429083636.22560-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210429083636.22560-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more generic compatible string 'marvell,armada-3700-rwtm-firmware' for
this driver, since it can also be used on other Armada 3720 devices.

Current compatible string 'cznic,turris-mox-rwtm' is kept for backward
compatibility.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")

---
We are also planning to work on extending this driver to support
accessing OTP, which will also work with Marvell's default WTMI
firmware.
---
 drivers/firmware/turris-mox-rwtm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 1cf4f1087492..c2d34dc8ba46 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -569,6 +569,7 @@ static int turris_mox_rwtm_remove(struct platform_device *pdev)
 
 static const struct of_device_id turris_mox_rwtm_match[] = {
 	{ .compatible = "cznic,turris-mox-rwtm", },
+	{ .compatible = "marvell,armada-3700-rwtm-firmware", },
 	{ },
 };
 
-- 
2.20.1

