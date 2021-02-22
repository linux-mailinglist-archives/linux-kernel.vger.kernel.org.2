Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A93221F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhBVWJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhBVWIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:08:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C32764E25
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614031695;
        bh=JWUiKQITDQPDw0Ne0RAZlMpnjcHlseBNaY+Zzy6pWmg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gDpU7kRFt1R+7b9+XGRiAjYCyzoCiC4Arbyd07TS7/QaP/9eyRnFxvjQcHvL3nyqZ
         51xirk2kMHZm6dTkqCjYuc+06wW3ZWAVzrcdvjtjxlIZ5C/7Fpruul15hpIkLP6uHO
         v5MiQaTk0wJE41tRXuMUJhW8FHoYc0mAmr0gL2YhI3ZYS/gRzQmB4s3gccVMKMuX9Z
         px8haFWAP/jWCOb0/tBnxHf62B7c9mpSxeDc8iikBBIBHOtJPScIjI5gaVjD8XVPKE
         Q5hckRrIYq11aC2GaOExt5N7IMf66QXgmkGjyARIGCPhcyVfY5pHhe1PtN4rS7BHEs
         0B3UzkVVEbf1A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] habanalabs: reset_upon_device_release is for bring-up
Date:   Tue, 23 Feb 2021 00:08:05 +0200
Message-Id: <20210222220806.9311-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222220806.9311-1-ogabbay@kernel.org>
References: <20210222220806.9311-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the field to correct location in structure and remove comment.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 706361a81410..9ba48f322964 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1920,7 +1920,6 @@ struct hl_mmu_funcs {
  * @device_fini_pending: true if device_fini was called and might be
  *                       waiting for the reset thread to finish
  * @supports_staged_submission: true if staged submissions are supported
- * @reset_upon_device_release: true if reset is required upon device release
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -2027,7 +2026,6 @@ struct hl_device {
 	u8				process_kill_trial_cnt;
 	u8				device_fini_pending;
 	u8				supports_staged_submission;
-	u8				reset_upon_device_release;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
@@ -2045,6 +2043,7 @@ struct hl_device {
 	u8				bmc_enable;
 	u8				rl_enable;
 	u8				reset_on_preboot_fail;
+	u8				reset_upon_device_release;
 };
 
 
-- 
2.25.1

