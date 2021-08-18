Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367133F0503
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbhHRNlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237270AbhHRNkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53762610E6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293984;
        bh=bnVLjo3GTdjO12NtHwiDCL6iWBqb00hNb/jqGqv+2DI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i/7j0bQr8yet4GxR0MgoLfxKGLNQ0o0ujBCvkmCzmakFCLuUYbcLJnTIExpn3TJIi
         MqsehiuQhViKXTYd9xpdLiDEMeJwzxqhCTBHc4dliEJupI4b3fAnZLlIRSE8N+doyU
         IK3VxWhXIZpT8HK8xa1tPwnpFQEzdyxC3piiTRbQkjB2eAEsDA4LBiRx7dhrnaIr06
         ZEfw7xxMPtYVaH7/bP4J7GCy6IY9l6QY+gXS+eHV/rUfkYsdZvHNFrQDnwCdpZrh4g
         84ctp+vl6ol000AHDkJbukMF/jD8Ropc4yCuVa5qo/yHEKlX5y1gCHgNd63zGjc5QT
         F4bR/UjfN6YfA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] habanalabs/gaudi: invalidate PMMU mem cache on init
Date:   Wed, 18 Aug 2021 16:39:22 +0300
Message-Id: <20210818133922.63637-16-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This must be done to clear the internal mem cache so we won't get
ecc errors on the first invalidation.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f244a1b8abca..ca9c3b9f08a1 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3906,6 +3906,9 @@ static int gaudi_mmu_init(struct hl_device *hdev)
 	WREG32(mmSTLB_CACHE_INV_BASE_39_8, MMU_CACHE_MNG_ADDR >> 8);
 	WREG32(mmSTLB_CACHE_INV_BASE_49_40, MMU_CACHE_MNG_ADDR >> 40);
 
+	/* mem cache invalidation */
+	WREG32(mmSTLB_MEM_CACHE_INVALIDATION, 1);
+
 	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, 0);
 
 	WREG32(mmMMU_UP_MMU_ENABLE, 1);
-- 
2.17.1

