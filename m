Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9B231AEF7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 06:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBNFE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 00:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhBNFEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 00:04:55 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CC7C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 21:04:11 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id v10so2727082qtq.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 21:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LV3NAM+JFALnOTUNar5n1Yl4C1DQTr41LXCyFf7ukxE=;
        b=EA8H6qz7V6zi/F9x6BuiQ1e3FILgnhE97QsuIp+9jgwCcK3QSHuw3LlCAERUov5yVX
         tUe9C8+eZksP8K5HSsHRVgWgnlIMtAUp6JJJfkAueTRQSqiLY49prEItBqLzVWmOjhgj
         dH8K7gi/FLsmd1BRxz3bBmepKHFCXwxFuXyF5ivYhIOwiBr0DfOAZ3JrWrtYdaAyIGwx
         kb92NitosS3DSCAkWBAH7dByYrK3q8BFTdPdL0mzJIdq7gCl6p0R7iV1VhUns/JnreJ7
         PWx2VQL+76RSdb+hrj8XkCG3CCK6w6tZtdwjXMYYsemrOUJrPZNoRNcsvB546/hC1ddc
         BvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LV3NAM+JFALnOTUNar5n1Yl4C1DQTr41LXCyFf7ukxE=;
        b=DjguAfMp5avpztXtYAkTGA+m0AZ38jihArdCKgUP2PSDzFw8ObPaRsHKcTGLq8uPrw
         a6oTO81zXA3OIy6md/Sr4neH3KBgsTqs9jq1NeiBmttTjdOT70VNhq4LrW+7G3ZtETWm
         6yDdX6W7+CPyJlRKwBRUKndyr6ZPYZzTNKPwKMoXpApzZIpyVtiGSBstE2sE/sNxHPUr
         SLtalMH39OvWabRGx1OnrzfmhZgtG6e/sgows0yu0BoWWBi2OIAhFvWDmfRHCNixCmtR
         x1BuqpGXwIFbsQQzWbYtiyCXAyq8Bl/zGVmLtdWujeyMVyTWhHhnfVTtgziJnFNjz34C
         h4dQ==
X-Gm-Message-State: AOAM530TeWMKBe3qQo6zrNBLjnDLCobX3yZKeCktvxgifG9Mj3MY5ili
        O0DPfG3DVc47AvEYpv5Ljv/zKmisA9InhQ==
X-Google-Smtp-Source: ABdhPJzvCvv1GoL3vGozTHFgwak9TLbk5kgs7/l57vf3VROkHTgr2DUaz0Kc8Ibn/6ej3WKxgXcu7w==
X-Received: by 2002:ac8:6e9a:: with SMTP id c26mr9215430qtv.220.1613279048737;
        Sat, 13 Feb 2021 21:04:08 -0800 (PST)
Received: from localhost.localdomain ([187.39.20.240])
        by smtp.gmail.com with ESMTPSA id s129sm9737158qkh.37.2021.02.13.21.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 21:04:08 -0800 (PST)
From:   Diego Viola <diego.viola@gmail.com>
To:     bskeggs@redhat.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nouveau@spliet.org, gnurou@gmail.com,
        Diego Viola <diego.viola@gmail.com>
Subject: [PATCH] drm/nouveau/pmu: fix timeout on GP108
Date:   Sun, 14 Feb 2021 02:03:09 -0300
Message-Id: <20210214050309.2395-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code times out on GP108, probably because the BIOS puts it into a
bad state.

Since we reset the PMU on driver load anyway, we are at no risk from
missing a response from it since we are not waiting for one to begin
with.

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
index a0fe607c9c07..4f02c4f14f04 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c
@@ -104,10 +104,6 @@ nvkm_pmu_reset(struct nvkm_pmu *pmu)
 
 	/* Inhibit interrupts, and wait for idle. */
 	nvkm_wr32(device, 0x10a014, 0x0000ffff);
-	nvkm_msec(device, 2000,
-		if (!nvkm_rd32(device, 0x10a04c))
-			break;
-	);
 
 	/* Reset. */
 	if (pmu->func->reset)
-- 
2.30.1

