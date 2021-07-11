Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A653C3C9F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhGKM52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 08:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232839AbhGKM5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 08:57:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADC746101C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626008073;
        bh=/UJzxg5OalcmyIZzWsLTv5oRXeZcuKHx4YhqOHpAurs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rF4QjZXTHF2qdCgcUtNH/zcTohJsac2ngkm1SP2HmhljA4buRl16FmCgDOXlldHXq
         tP4j/4gnA3Njcd1OeEeu6DPkkxe0pGNDcDkVVZACdLhXN6bQbkP8lcdgb+9R2YtZTu
         NkKZhmoMbsbOD7SFV1lQNF77byauovh+WY2yveiYqDISVhEpT01RSgBrPvFzmjQ8XG
         uBq2lDw0OgIKoLv1qxAMMZfgZRaIKDvYbDdawC+2lOSQNZo7wqehzs49NokUrZb5VL
         O6w4VLHPdMoRqtKqNmxDjX4UCM5Tlv2pRPlXaaODw+DnxNw3/prahpTzEEo2VmFHXj
         EwNpkloPIhm8A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] habanalabs: set dma max segment size
Date:   Sun, 11 Jul 2021 15:54:18 +0300
Message-Id: <20210711125418.17533-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711125418.17533-1-ogabbay@kernel.org>
References: <20210711125418.17533-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required from any device that is capable to perform DMA.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/common/pci/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
index d5bedf5ba011..0b5366cc84fd 100644
--- a/drivers/misc/habanalabs/common/pci/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -436,6 +436,8 @@ int hl_pci_init(struct hl_device *hdev)
 		goto unmap_pci_bars;
 	}
 
+	dma_set_max_seg_size(&pdev->dev, U32_MAX);
+
 	return 0;
 
 unmap_pci_bars:
-- 
2.25.1

