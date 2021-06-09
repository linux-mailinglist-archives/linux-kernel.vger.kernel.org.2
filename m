Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0233A1875
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhFIPFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231521AbhFIPFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:05:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AA9C6128A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623251027;
        bh=qR8WS/pOqLpd58eRNmfqDeSqrq0HwhbbVvERiGY4qNc=;
        h=From:To:Subject:Date:From;
        b=QjabBhtFmV7Lgb5qlYvNQiBcl9k4GA9KaqTrN3nekRWWVy48+YBQUrTWcH+Wxjg2T
         bx3pr4qJ7Cw4YZ5A40zKm2qEFEao/6/Aik4JK6zc57X2v5mhqsykpUzZG36JVJM+PP
         OzOMMP9QatC9bqXlDfxtogPR98FhZeel6zWjz8jUCRyl6EUkdgz7QszEN066P2xFth
         XwsXkkD5S1UefS/bkkTfE5sAyRspLOxdoqnGJooqdYfhkhe9jEar7NUn1t+AONb3dd
         dY8ZEhl8jiniyuoGcrGoTh0hDG4ct8j4ZPixnlAd8gGAvlVRvqfn16tX1aq5qfAKdx
         lDQ35sDwBGL+A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] habanalabs/gaudi: use standard error codes
Date:   Wed,  9 Jun 2021 18:03:37 +0300
Message-Id: <20210609150343.4712-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is an ECC error in the HBM, return a standard error code,
-EIO in this case, and not a positive value.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 703f41488852..9b4bd38c2986 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7471,7 +7471,7 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
 			struct hl_eq_hbm_ecc_data *hbm_ecc_data)
 {
 	u32 base, val, val2, wr_par, rd_par, ca_par, derr, serr, type, ch;
-	int err = 0;
+	int rc = 0;
 
 	if (hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
 					CPU_BOOT_DEV_STS0_HBM_ECC_EN) {
@@ -7516,7 +7516,7 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
 		val = RREG32_MASK(base + ch * 0x1000 + 0x06C, 0x0000FFFF);
 		val = (val & 0xFF) | ((val >> 8) & 0xFF);
 		if (val) {
-			err = 1;
+			rc = -EIO;
 			dev_err(hdev->dev,
 				"HBM%d pc%d interrupts info: WR_PAR=%d, RD_PAR=%d, CA_PAR=%d, SERR=%d, DERR=%d\n",
 				device, ch * 2, val & 0x1, (val >> 1) & 0x1,
@@ -7536,7 +7536,7 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
 		val = RREG32_MASK(base + ch * 0x1000 + 0x07C, 0x0000FFFF);
 		val = (val & 0xFF) | ((val >> 8) & 0xFF);
 		if (val) {
-			err = 1;
+			rc = -EIO;
 			dev_err(hdev->dev,
 				"HBM%d pc%d interrupts info: WR_PAR=%d, RD_PAR=%d, CA_PAR=%d, SERR=%d, DERR=%d\n",
 				device, ch * 2 + 1, val & 0x1, (val >> 1) & 0x1,
@@ -7565,7 +7565,7 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
 	val  = RREG32(base + 0x8F30);
 	val2 = RREG32(base + 0x8F34);
 	if (val | val2) {
-		err = 1;
+		rc = -EIO;
 		dev_err(hdev->dev,
 			"HBM %d MC SRAM SERR info: Reg 0x8F30=0x%x, Reg 0x8F34=0x%x\n",
 			device, val, val2);
@@ -7573,13 +7573,13 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
 	val  = RREG32(base + 0x8F40);
 	val2 = RREG32(base + 0x8F44);
 	if (val | val2) {
-		err = 1;
+		rc = -EIO;
 		dev_err(hdev->dev,
 			"HBM %d MC SRAM DERR info: Reg 0x8F40=0x%x, Reg 0x8F44=0x%x\n",
 			device, val, val2);
 	}
 
-	return err;
+	return rc;
 }
 
 static int gaudi_hbm_event_to_dev(u16 hbm_event_type)
-- 
2.25.1

