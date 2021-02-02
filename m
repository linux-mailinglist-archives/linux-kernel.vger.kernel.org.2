Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5B30C71A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhBBRK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:10:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236333AbhBBQ4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:56:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5A7B64F86;
        Tue,  2 Feb 2021 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612284968;
        bh=yDkMIr4Qx+NeJi8rys6dcmz42y2akm+IAzTeK220aFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsooDO+4GGwXBZUWk41gJe2riDhRLiZaKII5Kq16KvJ9X8iEHGZWrE7V9RSVjShpW
         Faczh1nxYHVCD7is1ugyepqKVQxhPcjgukHyPMTEM3W0pdyFA6H/tVioh3cmN8uOqH
         qFZZzZA4P9YPhlAjHExgEpz7PNAvpNUNIKxBams1ayj9/t8L1FoBiwKDKLkeCl4Sws
         W2l1B51w5aXT+Wy37x+URtT2eQZBM58gdZzodarK/HHK5p5i32mZxvrVEQLRUqO/3z
         HhUQrPY4RH2I8Vz28FPbXxyIU7qtyzTIZkZn5vZ2XPtCT1U6UWk7hgAYviHoqvMr4F
         6yGnI+o1RtGwA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 3/4] habanalabs/gaudi: use HBM_ECC_EN bit for ECC ERR
Date:   Tue,  2 Feb 2021 18:55:59 +0200
Message-Id: <20210202165600.4620-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202165600.4620-1-ogabbay@kernel.org>
References: <20210202165600.4620-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

driver should use ECC info from FW only if HBM ECC CAP is set.
otherwise, try to fetch the data from MC regs only if security is
disabled.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8fc0de3cf3a9..b929e602fa3d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7105,7 +7105,9 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
 	u32 base, val, val2, wr_par, rd_par, ca_par, derr, serr, type, ch;
 	int err = 0;
 
-	if (!hdev->asic_prop.fw_security_disabled) {
+	if (hdev->asic_prop.fw_security_status_valid &&
+			(hdev->asic_prop.fw_app_security_map &
+				CPU_BOOT_DEV_STS0_HBM_ECC_EN)) {
 		if (!hbm_ecc_data) {
 			dev_err(hdev->dev, "No FW ECC data");
 			return 0;
@@ -7127,14 +7129,24 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
 				le32_to_cpu(hbm_ecc_data->hbm_ecc_info));
 
 		dev_err(hdev->dev,
-			"HBM%d pc%d ECC: TYPE=%d, WR_PAR=%d, RD_PAR=%d, CA_PAR=%d, SERR=%d, DERR=%d\n",
-			device, ch, type, wr_par, rd_par, ca_par, serr, derr);
+			"HBM%d pc%d interrupts info: WR_PAR=%d, RD_PAR=%d, CA_PAR=%d, SERR=%d, DERR=%d\n",
+			device, ch, wr_par, rd_par, ca_par, serr, derr);
+		dev_err(hdev->dev,
+			"HBM%d pc%d ECC info: 1ST_ERR_ADDR=0x%x, 1ST_ERR_TYPE=%d, SEC_CONT_CNT=%u, SEC_CNT=%d, DEC_CNT=%d\n",
+			device, ch, hbm_ecc_data->first_addr, type,
+			hbm_ecc_data->sec_cont_cnt, hbm_ecc_data->sec_cnt,
+			hbm_ecc_data->dec_cnt);
 
 		err = 1;
 
 		return 0;
 	}
 
+	if (!hdev->asic_prop.fw_security_disabled) {
+		dev_info(hdev->dev, "Cannot access MC regs for ECC data while security is enabled\n");
+		return 0;
+	}
+
 	base = GAUDI_HBM_CFG_BASE + device * GAUDI_HBM_CFG_OFFSET;
 	for (ch = 0 ; ch < GAUDI_HBM_CHANNELS ; ch++) {
 		val = RREG32_MASK(base + ch * 0x1000 + 0x06C, 0x0000FFFF);
-- 
2.25.1

