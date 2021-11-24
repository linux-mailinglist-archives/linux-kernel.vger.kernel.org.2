Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9621845B4D4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbhKXHDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:03:23 -0500
Received: from cpanel.siel.si ([46.19.9.99]:58390 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240532AbhKXHDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=t0Jf+qFmflOZj2eCGRD1Xj4geGdmwfwLNHu7TMzdVhc=; b=b3ZEmkxdJx9mNhECzku8VuSSXn
        y/Yq6pkmS+lyJRrBQghRFdrOe5+hLXipZdug2yxNUvTBinibFcbVczXl4zqEddohnHNM1mS4u+KAd
        dhOrbPm2EsOTLN/yQBWF1plXy+tHVJOpmratQSSLdfGUzg2PE1ytOKnsBRFIM/TfS6dPf+PL+Pups
        eOEe5GC2Y/tvwpuKf4Y86HzQxewxC46HxkZ6XGw0ONQeXd79nuKgBTvZBWxawUeglKLIsg8b9GsFe
        1igzrQmzRk9N8b0sJFItyNjqaGgmZl99HSLBuyajZO1O0Z1781pgkALpz1RXJonYMw4pdk23yp7gt
        FFPEwAkg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:38706 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mpm7m-005zb9-Bj; Wed, 24 Nov 2021 07:51:29 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     support.opensource@diasemi.com, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, andrej.picej@norik.com
Subject: [PATCH] mfd: da9062: support SMBus and I2C mode
Date:   Wed, 24 Nov 2021 07:51:19 +0100
Message-Id: <20211124065119.2514872-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the I2C bus mode if I2C_FUNC_I2C is set. Based on da6093 commit:
"586478bfc9f7 mfd: da9063: Support SMBus and I2C mode"

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 drivers/mfd/da9062-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 01f8e10dfa55..2774b2cbaea6 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -556,6 +556,7 @@ static const struct regmap_range da9062_aa_writeable_ranges[] = {
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
 	regmap_reg_range(DA9062AA_BBAT_CONT, DA9062AA_BBAT_CONT),
+	regmap_reg_range(DA9062AA_CONFIG_J, DA9062AA_CONFIG_J),
 	regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
 };
 
@@ -674,6 +675,17 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	/* If SMBus is not available and only I2C is possible, enter I2C mode */
+	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
+		dev_info(chip->dev, "Entering I2C mode!\n");
+		ret = regmap_clear_bits(chip->regmap, DA9062AA_CONFIG_J,
+					DA9062AA_TWOWIRE_TO_MASK);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to set Two-Wire Bus Mode.\n");
+			return ret;
+		}
+	}
+
 	ret = da9062_clear_fault_log(chip);
 	if (ret < 0)
 		dev_warn(chip->dev, "Cannot clear fault log\n");
-- 
2.25.1

