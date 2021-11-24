Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBB845B4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240420AbhKXHDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:03:19 -0500
Received: from cpanel.siel.si ([46.19.9.99]:58376 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhKXHDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:03:17 -0500
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Nov 2021 02:03:17 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iGvyfoGuvl5eFWFZIVNYopEHaDwocy7d4h0QUX5gZgE=; b=XFfm+CjwFbtud1YBKaEB4gT5TI
        yVu9GDrirz61nn8eJEFIYa5lM0LgOt5/PMh46Ihg7t1ylDoyI21d7kK/Mlrh294Fo2U81aZ/q5LNh
        AD3Xqq3nbZzVlZvb04tKC7kxFPljG1LrEhSAygFlKgT8d/hWr3chevHCPfTvnpUiYnSr7nwNR6P5H
        YymodhnAnNAx1MahrKf8j8geouzv2Fr1WPuIeHYgQu/7EKtpvwhknhvUhELWTL2uH7w8GTmjtSvcw
        gr54UyWdt+HQIvU5yBaRTUHaPRFQkhYWlxmU93nH8m/arBsndWuqG6SexFUVZaMdAOrH4w/WZmZwC
        DXBcXWmw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:38850 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mpmG4-0060kg-V3; Wed, 24 Nov 2021 08:00:04 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     support.opensource@diasemi.com, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, andrej.picej@norik.com,
        s.riedmueller@phytec.de
Subject: [PATCH 1/2] mfd: da9062: Make vbuck_a registers volatile
Date:   Wed, 24 Nov 2021 08:00:00 +0100
Message-Id: <20211124070001.2516750-1-andrej.picej@norik.com>
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

From: Stefan Riedmueller <s.riedmueller@phytec.de>

The VBUCK1_A, VBUCK2_A, VBUCK3_A and VBUCK4_A registers are used to set the
desired output voltage of the BUCK 1-4 buck regulators. These values can be
critical if used as input for core voltages. Thus make them volatile so
they do not get cached.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 drivers/mfd/da9062-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 2774b2cbaea6..c0dad5461946 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -572,6 +572,8 @@ static const struct regmap_range da9062_aa_volatile_ranges[] = {
 	regmap_reg_range(DA9062AA_COUNT_S, DA9062AA_SECOND_D),
 	regmap_reg_range(DA9062AA_SEQ, DA9062AA_SEQ),
 	regmap_reg_range(DA9062AA_EN_32K, DA9062AA_EN_32K),
+	regmap_reg_range(DA9062AA_VBUCK2_A, DA9062AA_VBUCK2_A),
+	regmap_reg_range(DA9062AA_VBUCK3_A, DA9062AA_VBUCK3_A),
 };
 
 static const struct regmap_access_table da9062_aa_readable_table = {
-- 
2.25.1

