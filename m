Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81645B4D2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbhKXHDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:03:18 -0500
Received: from cpanel.siel.si ([46.19.9.99]:58384 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232332AbhKXHDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fN2K7GgkHjzsIsqwkpyBvJWticPhDEc3LXC1ORWXq/o=; b=DRKExNGQFuXN+8ipsxuBHgV0WV
        IAwizsc0kMrXnkuEQb28qMCE5AVvAS1RguU3vIsgYRV6QyN5Tkv2tWYOKWorowSEmkiOn5rZmARea
        q0KQrxVIuNh3CxpahHqhLu0rIODFXUdvjuBUMaA/zoFvoXTT2i9/CwRzJ2uf075QJHyvAa1+eJuhc
        0mWZ712e1wclz3j0MvW7MISpKifYCHylx75iuzOonBHXAeHQwLgZM6QTnVFeTCjbrD21lwy/9DWhL
        QGtP0LL/MygUfkfZD7XpSVWciWEXw/F88pPCge08AZhkTZPAfhKIq8gVAzFhyXiXI2BHMsQ5NvFzP
        e8I8hw3g==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:38850 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mpmG5-0060kg-1E; Wed, 24 Nov 2021 08:00:04 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     support.opensource@diasemi.com, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, andrej.picej@norik.com,
        s.riedmueller@phytec.de
Subject: [PATCH 2/2] mfd: da9063: Make vbcore registers volatile
Date:   Wed, 24 Nov 2021 08:00:01 +0100
Message-Id: <20211124070001.2516750-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211124070001.2516750-1-andrej.picej@norik.com>
References: <20211124070001.2516750-1-andrej.picej@norik.com>
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

From: Stefan Riedmueller <s.riedmueller@phytec.de>

The VBCORE1_A and VBCORE2_A registers are used to set the desired output
voltage of the BCORE 1 and 2 buck regulators. These values can be critical
if used as input for core voltages. Thus make them volatile so they do not
get cached.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 drivers/mfd/da9063-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 343ed6e96d87..8a3629c30382 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -161,6 +161,7 @@ static const struct regmap_range da9063_ad_volatile_ranges[] = {
 	regmap_reg_range(DA9063_REG_ADC_RES_L, DA9063_AD_REG_SECOND_D),
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_SEQ),
 	regmap_reg_range(DA9063_REG_EN_32K, DA9063_REG_EN_32K),
+	regmap_reg_range(DA9063_REG_VBCORE2_A, DA9063_REG_VBCORE2_A),
 	regmap_reg_range(DA9063_AD_REG_MON_REG_5, DA9063_AD_REG_MON_REG_6),
 };
 
@@ -206,6 +207,7 @@ static const struct regmap_range da9063_bb_da_volatile_ranges[] = {
 	regmap_reg_range(DA9063_REG_ADC_RES_L, DA9063_BB_REG_SECOND_D),
 	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_SEQ),
 	regmap_reg_range(DA9063_REG_EN_32K, DA9063_REG_EN_32K),
+	regmap_reg_range(DA9063_REG_VBCORE2_A, DA9063_REG_VBCORE2_A),
 	regmap_reg_range(DA9063_BB_REG_MON_REG_5, DA9063_BB_REG_MON_REG_6),
 };
 
-- 
2.25.1

