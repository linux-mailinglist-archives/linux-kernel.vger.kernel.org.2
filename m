Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499F03F050B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhHRNll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237225AbhHRNkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E9BF610D2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293983;
        bh=jMD3sB/FPt1BWmWn7Ug+j7vD8I5CLFwzSRuUX9ioFsY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BCdyx0qk6trqKcDHU7ghsc96r7WiRUFJaUl5I3VUPmLIBI0uGV9T23vaSUNsTs0xT
         2IM8Mey4zZarNDYsEZnW7sG8CJ7kIS4JqhkiednerU/Sb21ngt8ekSRNPDRAFfAe7A
         M5XoLAl7BkisHyyxczYRwiYmC/YH003JAPD2y+MfssQB9O5wt4Qun7FTHFqifPyLKP
         QQbSs/ZQmHUjk3lnCps+UAlbci02R6dNPYnUQDtIYa3il6DGjJqtk96VOk0Hgje5Qu
         MeUYKURexTH6I3wPBm/CUmVumubAzoMjz1W++Gs0rJ0iXDtSiEk2zG0gnKZmiP4S5o
         N+GS5VfPNZyqA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 15/16] habanalabs/gaudi: size should be printed in decimal
Date:   Wed, 18 Aug 2021 16:39:21 +0300
Message-Id: <20210818133922.63637-15-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's more readable for the size to be in decimal.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ba1fcdc16f50..f244a1b8abca 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7266,7 +7266,7 @@ static void gaudi_print_sw_config_stream_data(struct hl_device *hdev, u32 stream
 
 	cq_ptr = (((u64) RREG32(cq_ptr_hi)) << 32) | RREG32(cq_ptr_lo);
 	size = RREG32(cq_tsize);
-	dev_info(hdev->dev, "stop on err: stream: %u, addr: %#llx, size: %x\n",
+	dev_info(hdev->dev, "stop on err: stream: %u, addr: %#llx, size: %u\n",
 							stream, cq_ptr, size);
 }
 
@@ -7322,7 +7322,7 @@ static void gaudi_print_last_pqes_on_err(struct hl_device *hdev, u32 qid_base,
 
 		addr = le64_to_cpu(bd->ptr);
 
-		dev_info(hdev->dev, "stop on err PQE(stream %u): ci: %u, addr: %#llx, size: %x\n",
+		dev_info(hdev->dev, "stop on err PQE(stream %u): ci: %u, addr: %#llx, size: %u\n",
 							stream, ci, addr, len);
 
 		/* get previous ci, wrap if needed */
-- 
2.17.1

