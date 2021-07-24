Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3523D4713
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 12:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbhGXJoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 05:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235175AbhGXJmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 05:42:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CDE66056B;
        Sat, 24 Jul 2021 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627122165;
        bh=X4HAMm3gTxqi5bWjYeoEG0UKYk1l0SMi0+wmdif+7j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AErLL9qKBefBLC9IBaTWC/0I2yXMYeFQ+QGNbmWW/EqEGw1jUGZ/Q8U3dURsGW1bl
         qumlIBFUZD21h7ttkwT8aq6c2ku5Y1ocY0ParWLVuZQpbfWon2YV353h+3+zpU/iaj
         tHw+HL/lst2i2Ho1cQWmBfWcMLo6f3pY0DhAUFUIb28/Ci8epBhFOtl6pmLFdvJKwj
         I8LoD+Oqzq/Zqj/ofCba+MW+ImpF8RNIKFR/dooEDQO2VHoikSu+jJk80clXB7WNam
         8HeasVrRHrzYRLa0Oh7pVZHlguSvnFSbwzAyo70YlrSbcWC1r40WDoMlOlkxo2pRkQ
         prfP08rUddirA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m7Enr-00BJmz-3M; Sat, 24 Jul 2021 12:22:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] regulator: hi6421v600: rename voltage range arrays
Date:   Sat, 24 Jul 2021 12:22:42 +0200
Message-Id: <1bdff1d1f23753b69c8044160decfad1e8553d08.1627121912.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627121912.git.mchehab+huawei@kernel.org>
References: <cover.1627121912.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arrays containing the regulator's voltage ranges are
currently named after the first ldo which uses such range.

However, it sounds a lot clearer if those are named with
the voltage range instead.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/regulator/hi6421v600-regulator.c | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index f71e7661b6d7..4671678f6b19 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -27,34 +27,34 @@ struct hi6421_spmi_reg_info {
 	u32			eco_uA;
 };
 
-static const unsigned int ldo3_voltages[] = {
+static const unsigned int range_1v5_to_2v0[] = {
 	1500000, 1550000, 1600000, 1650000,
 	1700000, 1725000, 1750000, 1775000,
 	1800000, 1825000, 1850000, 1875000,
 	1900000, 1925000, 1950000, 2000000
 };
 
-static const unsigned int ldo4_voltages[] = {
+static const unsigned int range_1v725_to_1v9[] = {
 	1725000, 1750000, 1775000, 1800000,
 	1825000, 1850000, 1875000, 1900000
 };
 
-static const unsigned int ldo9_voltages[] = {
+static const unsigned int range_1v75_to_3v3[] = {
 	1750000, 1800000, 1825000, 2800000,
 	2850000, 2950000, 3000000, 3300000
 };
 
-static const unsigned int ldo15_voltages[] = {
+static const unsigned int range_1v8_to_3v0[] = {
 	1800000, 1850000, 2400000, 2600000,
 	2700000, 2850000, 2950000, 3000000
 };
 
-static const unsigned int ldo17_voltages[] = {
+static const unsigned int range_2v5_to_3v3[] = {
 	2500000, 2600000, 2700000, 2800000,
 	3000000, 3100000, 3200000, 3300000
 };
 
-static const unsigned int ldo34_voltages[] = {
+static const unsigned int range_2v6_to_3v3[] = {
 	2600000, 2700000, 2800000, 2900000,
 	3000000, 3100000, 3200000, 3300000
 };
@@ -196,35 +196,35 @@ enum hi6421_spmi_regulator_id {
 };
 
 static struct hi6421_spmi_reg_info regulator_info[] = {
-	HI6421V600_LDO(ldo3, ldo3_voltages,
+	HI6421V600_LDO(ldo3, range_1v5_to_2v0,
 		       0x16, 0x01, 0x51,
 		       20000, 120,
 		       0, 0),
-	HI6421V600_LDO(ldo4, ldo4_voltages,
+	HI6421V600_LDO(ldo4, range_1v725_to_1v9,
 		       0x17, 0x01, 0x52,
 		       20000, 120,
 		       0x10, 10000),
-	HI6421V600_LDO(ldo9, ldo9_voltages,
+	HI6421V600_LDO(ldo9, range_1v75_to_3v3,
 		       0x1c, 0x01, 0x57,
 		       20000, 360,
 		       0x10, 10000),
-	HI6421V600_LDO(ldo15, ldo15_voltages,
+	HI6421V600_LDO(ldo15, range_1v8_to_3v0,
 		       0x21, 0x01, 0x5c,
 		       20000, 360,
 		       0x10, 10000),
-	HI6421V600_LDO(ldo16, ldo15_voltages,
+	HI6421V600_LDO(ldo16, range_1v8_to_3v0,
 		       0x22, 0x01, 0x5d,
 		       20000, 360,
 		       0x10, 10000),
-	HI6421V600_LDO(ldo17, ldo17_voltages,
+	HI6421V600_LDO(ldo17, range_2v5_to_3v3,
 		       0x23, 0x01, 0x5e,
 		       20000, 120,
 		       0x10, 10000),
-	HI6421V600_LDO(ldo33, ldo17_voltages,
+	HI6421V600_LDO(ldo33, range_2v5_to_3v3,
 		       0x32, 0x01, 0x6d,
 		       20000, 120,
 		       0, 0),
-	HI6421V600_LDO(ldo34, ldo34_voltages,
+	HI6421V600_LDO(ldo34, range_2v6_to_3v3,
 		       0x33, 0x01, 0x6e,
 		       20000, 120,
 		       0, 0),
-- 
2.31.1

