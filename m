Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDE43A6711
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhFNMxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233732AbhFNMxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96D6C613B2;
        Mon, 14 Jun 2021 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623675067;
        bh=dUzkPm200JwsFxSk18CwnjXS1TMdE3txsfIeFT3Ecg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A/92ucGvdJ6Q5KuO9yosPLdUlFeqVrvxAmoKqMK/q96i4c0//ntVH7w7SPMR2zxKP
         0ML1DTx/oAUF56fVhPw/2iHhH/+voGWkAs3QdS7Lzkkql14yemUIbXbFEpbZxRuGvL
         a2MC5+ZkZuxiyBQCws3hDr2tJZhOYMkhPLCDJhVN6e7MvZH7hvCZ4M33stvD76inFd
         8GpxT2X9EIK8z4CSK4ZDt0eIz3vviW5yAXIC2dNqojfvPfzUHsRTH1UbJS9A0UR/1l
         YQZx/f5oRJf6xD9R2wJbEcWy0IH4voLzFoI+gp2Jz8Ac34oC5K3J1gIB8P2MkptrUm
         JQcmCBSBdpWqQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 2/9] habanalabs: zero complex structures using memset
Date:   Mon, 14 Jun 2021 15:50:53 +0300
Message-Id: <20210614125100.17627-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614125100.17627-1-ogabbay@kernel.org>
References: <20210614125100.17627-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

fix the following sparse warnings:
'warning: Using plain integer as NULL pointer'
'warning: missing braces around initializer'

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 14e70422af25..d5d0db7fd6ef 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -392,10 +392,11 @@ void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 
 int hl_fw_send_heartbeat(struct hl_device *hdev)
 {
-	struct cpucp_packet hb_pkt = {0};
+	struct cpucp_packet hb_pkt;
 	u64 result;
 	int rc;
 
+	memset(&hb_pkt, 0, sizeof(hb_pkt));
 	hb_pkt.ctl = cpu_to_le32(CPUCP_PACKET_TEST <<
 					CPUCP_PKT_CTL_OPCODE_SHIFT);
 	hb_pkt.value = cpu_to_le64(CPUCP_PACKET_FENCE_VAL);
-- 
2.25.1

