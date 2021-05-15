Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9013819DE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhEOQcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 12:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233607AbhEOQcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 12:32:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 741B360551;
        Sat, 15 May 2021 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621096288;
        bh=HABcUcbe1YV7DtECa3gZ7LJrObDdsNdCOfZ/hXuhRNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfG13VzHX6gUq7ZnJQjogTT/OqSpJeF4tPqPqTdMf0D3TfU2kB5QBdrZWkS4ZsoAA
         JkRPiJKO8SU9tEzp91i7VRATi4G5TTcJ7fFhYksic5zbpgKtlngNEcBI6yxH3RNwxY
         t5IYK2pT7PoXiZ2xWQ2Me2vReC/494OED+V17viJUJFPccDpWk+udrBd+G/QfZqJKQ
         FpMTcLEuHnwmhNLfv96gwYngA9kRMQFTEblHSzzX1nTKR028WigDBic/y4S+CWf1nO
         /o4Z3LWjlI9foqvqfDYObMcy31ktYivUSMNgqJR0PsfINCM9dpFSm4HvzgLL7k1zOi
         NaJ+QnG35atwA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 3/5] habanalabs: check if asic secured with asic type
Date:   Sat, 15 May 2021 19:31:14 +0300
Message-Id: <20210515163116.14181-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210515163116.14181-1-ogabbay@kernel.org>
References: <20210515163116.14181-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Fix issue in which the input to the function is_asic_secured was device
PCI_IDS number instead of the asic_type enumeration.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index dc92401e7a3f..df1e91f810cc 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -309,7 +309,7 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 
 	if (pdev)
 		hdev->asic_prop.fw_security_disabled =
-				!is_asic_secured(pdev->device);
+				!is_asic_secured(hdev->asic_type);
 	else
 		hdev->asic_prop.fw_security_disabled = true;
 
-- 
2.25.1

