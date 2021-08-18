Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB893F0502
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhHRNkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237095AbhHRNkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46129610C7;
        Wed, 18 Aug 2021 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293979;
        bh=08/x00YF7HqL8PORpWl9EEY2yZc8A2VMH64uD0vct20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i11r6oTLCuN7W5XCO1Igr93h9dyh2sIyPZDnw5FzeSvjSa6vxIFWaElLWNqsgc15m
         5JyGNE/qFIMZH2loUGfyl7owY1fL+8AqJTj7dGH2PiRfH6+Qu96LvpHn4ddQpKo4xK
         tYMajG2smQhS6yMUTUDoGFJ/KISFxeI6gj8lAGea77rrajIxkk/gC0jZ3mmyHoGi5j
         9LPLoIwW/rLPeL90NbSNMh/tRzvLT7RvU/0jE0woDO/gcLfmc75kWRyBjlfhxrabWu
         uHWlIGRj/NI0jvmtitIfouEHCcyPFvlqY3xdtbpc1xxMTgUv+/uOm7ofovHfZbZoBk
         r4/i/6yPt0e0g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 11/16] habanalabs/gaudi: fetch TPC/MME ECC errors from F/W
Date:   Wed, 18 Aug 2021 16:39:17 +0300
Message-Id: <20210818133922.63637-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In case F/W security is enabled driver cannot access ECC registers,
hence driver must fetch the ECC info from F/W.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2f6d019c79e1..6671d1aca8e1 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7458,6 +7458,11 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 	bool extract_info_from_fw;
 	int rc;
 
+	if (hdev->asic_prop.fw_security_enabled) {
+		extract_info_from_fw = true;
+		goto extract_ecc_info;
+	}
+
 	switch (event_type) {
 	case GAUDI_EVENT_PCIE_CORE_SERR ... GAUDI_EVENT_PCIE_PHY_DERR:
 	case GAUDI_EVENT_DMA0_SERR_ECC ... GAUDI_EVENT_MMU_DERR:
@@ -7530,6 +7535,7 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 		return;
 	}
 
+extract_ecc_info:
 	if (extract_info_from_fw) {
 		ecc_address = le64_to_cpu(ecc_data->ecc_address);
 		ecc_syndrom = le64_to_cpu(ecc_data->ecc_syndrom);
-- 
2.17.1

