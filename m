Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E6D3819DC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhEOQcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 12:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232463AbhEOQch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 12:32:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6511613C1
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 16:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621096284;
        bh=KsNEDXfoNVSr78CdrTJBEBpat46fcweBsyHivFq2GPE=;
        h=From:To:Subject:Date:From;
        b=pR3rLV2gBG6AnPAdaYeDnhX1SZs/USuGnWJC5+P3BxVDx1dV0tGM+kZK0ghc9soAq
         eNneiFWzgcFzIXYIkfp0RLPRdboaEGn48F/5Kigi+tTNadcDxBwRWIlwk9pY/zYSgV
         3i3zyX8oJ1h5dLzHfp9+7FKwPmc50qGKfsMb6HLGbk/zeuA5MvzmYDgZ2ekqwdIJUm
         sZ9Joc9e3MgV6o7uQAUC9rjeTtQZzPjR3AQmKuZHYFhAlV3ooml0+lOqld3BvQWRZp
         tflI1h1CUy+OIEcJRcJLKyEF8u1hnTfski8wuzEMUyMJZc15YmnKrnvTC8tDt64Ypg
         TVK+KsuFTm6EQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] habanalabs: notify before f/w loading
Date:   Sat, 15 May 2021 19:31:12 +0300
Message-Id: <20210515163116.14181-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An information print notifying on starting to load the f/w was removed
by mistake when moving to the new dynamic f/w loading mechanism.

Restore that print as the F/W loading usually takes between 10 to 20
seconds and this print helps the user know the status of the driver
load.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 3969351b5513..8922d4a43919 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1951,6 +1951,9 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	struct cpu_dyn_regs *dyn_regs;
 	int rc;
 
+	dev_info(hdev->dev,
+		"Loading firmware to device, may take some time...\n");
+
 	dyn_regs = &fw_loader->dynamic_loader.comm_desc.cpu_dyn_regs;
 
 	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_RST_STATE,
-- 
2.25.1

