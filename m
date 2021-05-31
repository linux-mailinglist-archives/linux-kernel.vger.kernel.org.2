Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C685D396629
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhEaQ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233934AbhEaPPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:15:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63E52611CB
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 15:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622474050;
        bh=/RevXDUtJlYQ5/jizsk4atdR7OWNLSaFk7IBIBbMIC8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cO8z/B6I4UPIWlWABiad+4WxZeeWvPi/c/Nbkeu4hzc7Cnwc/2MlT6pMDhoBEoPCQ
         mJmvDjM7Q9vgUE5sWoFhbAjOcfex+NNFpWBQ3qHvQEamnK8sVw1QvxAJos/32dLVVg
         aYGJ2DKPas9WStCL+nz4U9FccUwPM9DCRm4ZIw3GMtRECkqbWGj4l1rJ0FQmaYJAci
         drboyai1kHckrhHFo/y2jWwXFHNvGjmz31WA2HJV3Nxp7GZA254WqcTSi+qSv7NKUB
         FEjGHaYP5k+Vpd7WvlaKFEBSJBF++abtGCU/yqjkV5ATIRBdQhRYvh8JWmmHryMEdR
         ACITMwTESLVQQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] habanalabs/gaudi: don't use nic_ports_mask in compute
Date:   Mon, 31 May 2021 18:13:59 +0300
Message-Id: <20210531151403.12494-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531151403.12494-1-ogabbay@kernel.org>
References: <20210531151403.12494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nic_ports_mask is used by the networking part of the driver.
In the compute part, we use the HW_CAP bits to select what is active
and what is not.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 67c44f3fc55f..1c4da5aff88c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6712,7 +6712,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 	gaudi_mmu_prepare_reg(hdev, mmMME2_ACC_WBC, asid);
 	gaudi_mmu_prepare_reg(hdev, mmMME3_ACC_WBC, asid);
 
-	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC0) {
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC0) {
 		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM0_GLBL_NON_SECURE_PROPS_0,
 				asid);
 		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM0_GLBL_NON_SECURE_PROPS_1,
@@ -6725,7 +6725,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 				asid);
 	}
 
-	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC1) {
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC1) {
 		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM1_GLBL_NON_SECURE_PROPS_0,
 				asid);
 		gaudi_mmu_prepare_reg(hdev, mmNIC0_QM1_GLBL_NON_SECURE_PROPS_1,
@@ -6738,7 +6738,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 				asid);
 	}
 
-	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC2) {
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC2) {
 		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM0_GLBL_NON_SECURE_PROPS_0,
 				asid);
 		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM0_GLBL_NON_SECURE_PROPS_1,
@@ -6751,7 +6751,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 				asid);
 	}
 
-	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC3) {
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC3) {
 		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM1_GLBL_NON_SECURE_PROPS_0,
 				asid);
 		gaudi_mmu_prepare_reg(hdev, mmNIC1_QM1_GLBL_NON_SECURE_PROPS_1,
@@ -6764,7 +6764,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 				asid);
 	}
 
-	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC4) {
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC4) {
 		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM0_GLBL_NON_SECURE_PROPS_0,
 				asid);
 		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM0_GLBL_NON_SECURE_PROPS_1,
@@ -6777,7 +6777,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 				asid);
 	}
 
-	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC5) {
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC5) {
 		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM1_GLBL_NON_SECURE_PROPS_0,
 				asid);
 		gaudi_mmu_prepare_reg(hdev, mmNIC2_QM1_GLBL_NON_SECURE_PROPS_1,
@@ -6790,7 +6790,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 				asid);
 	}
 
-	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC6) {
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC6) {
 		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM0_GLBL_NON_SECURE_PROPS_0,
 				asid);
 		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM0_GLBL_NON_SECURE_PROPS_1,
@@ -6803,7 +6803,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 				asid);
 	}
 
-	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC7) {
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC7) {
 		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM1_GLBL_NON_SECURE_PROPS_0,
 				asid);
 		gaudi_mmu_prepare_reg(hdev, mmNIC3_QM1_GLBL_NON_SECURE_PROPS_1,
@@ -6816,7 +6816,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 				asid);
 	}
 
-	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC8) {
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC8) {
 		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM0_GLBL_NON_SECURE_PROPS_0,
 				asid);
 		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM0_GLBL_NON_SECURE_PROPS_1,
@@ -6829,7 +6829,7 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 				asid);
 	}
 
-	if (hdev->nic_ports_mask & GAUDI_NIC_MASK_NIC9) {
+	if (gaudi->hw_cap_initialized & HW_CAP_NIC9) {
 		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM1_GLBL_NON_SECURE_PROPS_0,
 				asid);
 		gaudi_mmu_prepare_reg(hdev, mmNIC4_QM1_GLBL_NON_SECURE_PROPS_1,
@@ -8239,7 +8239,7 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 	for (i = 0 ; i < (NIC_NUMBER_OF_ENGINES / 2) ; i++) {
 		offset = i * NIC_MACRO_QMAN_OFFSET;
 		port = 2 * i;
-		if (hdev->nic_ports_mask & BIT(port)) {
+		if (gaudi->hw_cap_initialized & BIT(HW_CAP_NIC_SHIFT + port)) {
 			qm_glbl_sts0 = RREG32(mmNIC0_QM0_GLBL_STS0 + offset);
 			qm_cgm_sts = RREG32(mmNIC0_QM0_CGM_STS + offset);
 			is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_cgm_sts);
@@ -8254,7 +8254,7 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 		}
 
 		port = 2 * i + 1;
-		if (hdev->nic_ports_mask & BIT(port)) {
+		if (gaudi->hw_cap_initialized & BIT(HW_CAP_NIC_SHIFT + port)) {
 			qm_glbl_sts0 = RREG32(mmNIC0_QM1_GLBL_STS0 + offset);
 			qm_cgm_sts = RREG32(mmNIC0_QM1_CGM_STS + offset);
 			is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_cgm_sts);
-- 
2.25.1

