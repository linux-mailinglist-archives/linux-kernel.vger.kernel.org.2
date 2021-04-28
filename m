Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9854536DD9D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhD1Q4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhD1Q4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:56:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A26C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:55:24 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y1so17539514plg.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VrNG2OW17NvNB9/00PtN5Yvgoi3R3It2J4iGHKQybxg=;
        b=eELV53+fEAlNKwGc0K9vnmHx4bNw1p0HiSzzULeAu+FyX2UBt27/MeTQnD+Kev3h4w
         V4UiNjYQngeSEGJY9Yhu0w7miAxqeHd8CswGGUzjiVee1UayhpzYfms7lQa6/DYtnQTe
         a2PMZU0zfspuyjX8uA+1tNY5wjCj1PzU3JzcDwT0ZMTT0DE7N2FTiPGePbPIT88yjvzg
         p+eTc4Ud4btX3RPCv1CYCaXJmLzCIFyiHnHn4ZSP7wbtxsja5x9GN5TrZxMtlYwS1Azo
         j5kyu0jng8lJqmg+oSF2KMh0EJhfiFRCgjzatykzowwLCTuGHF89lOlEMzSbC59AemjB
         2GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VrNG2OW17NvNB9/00PtN5Yvgoi3R3It2J4iGHKQybxg=;
        b=F5bUqfJmVFKTbjYSIl/utwbUuyVgONAX6yfBKe7WDNMKlIaHrPcscOiTZodlfSIiCw
         Swh/BHFR+hjSBV9c8qMRaE0UACNPlNFeFdz21CMQXTFW1zCAJu8zeutbqn3dXCP6k6R8
         N0oomhQoNN8JZwcJMuPHSD0001m4o0HBLe6Ysa+kHGVvWVvdGqrjUzHYlviplFmUVgTA
         zEHdAjat/v5jTc1v92SGky15xnToe/GESP8F/yVIdS3jd15BFd0UznmcLzo5c5ODL6FZ
         3zmbSu4yJb6rriVrGKxvANkuN9HI2N2gJzgcfTIt/EiyXCcyEujfrtlhuNh+tn1p3lKu
         G4RQ==
X-Gm-Message-State: AOAM532fXszmzUEFtdVIemXoU/LN/oJzOQSi9JY2vWIiCqEg2ohxd6kX
        BWoVYQmkZPPkU9/WKEf5W179sKjvGHrlA4DN
X-Google-Smtp-Source: ABdhPJyFDDmhNypj1ExlX0J85KfZDLnFJECMNdupyB2zt5pW7SwWLKlXqv2O+jJhaJrXtFve6E/njA==
X-Received: by 2002:a17:903:2303:b029:ed:26:fb80 with SMTP id d3-20020a1709032303b02900ed0026fb80mr23467504plh.19.1619628923977;
        Wed, 28 Apr 2021 09:55:23 -0700 (PDT)
Received: from localhost ([157.45.42.123])
        by smtp.gmail.com with ESMTPSA id m9sm218535pgt.65.2021.04.28.09.55.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Apr 2021 09:55:23 -0700 (PDT)
Date:   Wed, 28 Apr 2021 22:25:15 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     kishon@ti.com
Cc:     vkoul@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: phy: phy-xgene.c: Fix alignment of comment
Message-ID: <20210428165515.o47o5awzdxirxkqi@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A * has been added at the starting of new line
The closing */ of multi line comment shifted to new line
This is done to maintain code uniformity.

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/phy/phy-xgene.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-xgene.c b/drivers/phy/phy-xgene.c
index f4cd590fbde7..d0f4546648f0 100644
--- a/drivers/phy/phy-xgene.c
+++ b/drivers/phy/phy-xgene.c
@@ -961,7 +961,8 @@ static void xgene_phy_sata_cfg_lanes(struct xgene_phy_ctx *ctx)
 		serdes_wr(ctx, lane, RXTX_REG1, val);
 
 		/* Latch VTT value based on the termination to ground and
-		   enable TX FIFO */
+		 * enable TX FIFO
+		 */
 		serdes_rd(ctx, lane, RXTX_REG2, &val);
 		val = RXTX_REG2_VTT_ENA_SET(val, 0x1);
 		val = RXTX_REG2_VTT_SEL_SET(val, 0x1);
-- 
2.17.1

