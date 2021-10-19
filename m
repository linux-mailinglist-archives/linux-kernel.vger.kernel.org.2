Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEFA433E51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhJSSWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:22:21 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35362
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231586AbhJSSWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:22:20 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 14D0A3FFF4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 18:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634667606;
        bh=64iuIQfOFaMwcVIQxd+Ygwi9Yi5880/D7tGs8YCTSAA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=CvJjXY8PWbJ0AosQ2mmvsLYlkqDAC4uVcctf2lKc1GzGAdfj4AUwn6OQQeFqP5g0h
         71rPBeFi6x4AxomQsO24RV4hMfL27P0K5heGQYJ2ayL8VhAhUTbO5qfh2wRkA7RcdN
         5njfc1evmPkH1yGYMlFYlclDRnqclBPKgTx33c6sF4LcZbjcS174jglY0hhw6MVa02
         DhKMMMV0t1rRgUbS6BL836NSffMYZqTgViDTMbqFRtx3k2/9fMLfzqWgy559F6aCD6
         afUS5DeUmgNbctl2Gz6F6pwm6NVriYUPmzXX7incfhoMhjlxg5KHdMYy6RXPavwbzU
         7aNjFnd7/oAHQ==
Received: by mail-pg1-f200.google.com with SMTP id d6-20020a63d646000000b00268d368ead8so12013180pgj.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 11:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=64iuIQfOFaMwcVIQxd+Ygwi9Yi5880/D7tGs8YCTSAA=;
        b=6e2SdzdPgdPwPUo6CiyxvlGb9UIfcEWobp7RsoM4LSUJxNoH/d0H4bDYNWEprAkI5K
         EwtWGbTOsgRk1fTov8UnJ2ICtQr1b7oRR0uFCjkTohHom/VFC3+mhX85nO+IrQGU8fOa
         AuenbWqsWBZilSv9lTjihnRh/FmA2Ctpi7gGmr5dfikvdeSTRse7npjHWQpWJE7Ps0NW
         4a8hZ1vyv6jBxWL5Ubtsa3KYjibVyJq8QyG4MHPewyHrZ6pUx+HnqQr6uP4zTvNNxZeY
         12Vg9vvWAk4LS70MUjcfOEw4eqpOlMY//DT7whdTbjF2V1ctttFVGJgsQoYwRbbC1jNZ
         CerQ==
X-Gm-Message-State: AOAM530QbqEFoCNxK9GbFTCq/7MGQbig5T+Ny/f7z9tjBf3hTJPn/kgU
        dhZtA4BB9zLdNEwIZwWOI4MrYVk6klIIKsHnpIWM8zLydqeAPz/h4/hm1wa9b5bm6m0ST40ns7q
        wpyFIAsirYW5//uyycJRMfGQZXKy4K6Rm1/8I7MLEjQ==
X-Received: by 2002:a17:902:b907:b0:13f:ccaf:9ed8 with SMTP id bf7-20020a170902b90700b0013fccaf9ed8mr8079812plb.46.1634667604618;
        Tue, 19 Oct 2021 11:20:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6xGnIRPJ4AIpW8LVmU03U3+vcTQNm8XPqCknyqs6SO6Ue5v5xOhqDIECBbvqVreszBB6RYA==
X-Received: by 2002:a17:902:b907:b0:13f:ccaf:9ed8 with SMTP id bf7-20020a170902b90700b0013fccaf9ed8mr8079785plb.46.1634667604269;
        Tue, 19 Oct 2021 11:20:04 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id q16sm9591688pfu.36.2021.10.19.11.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 11:20:03 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     netdev@vger.kernel.org
Cc:     tim.gardner@canonical.com, Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH][linux-next] net: enetc: unmap DMA in enetc_send_cmd()
Date:   Tue, 19 Oct 2021 12:19:50 -0600
Message-Id: <20211019181950.14679-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity complains of a possible dereference of a null return value.

   	5. returned_null: kzalloc returns NULL. [show details]
   	6. var_assigned: Assigning: si_data = NULL return value from kzalloc.
488        si_data = kzalloc(data_size, __GFP_DMA | GFP_KERNEL);
489        cbd.length = cpu_to_le16(data_size);
490
491        dma = dma_map_single(&priv->si->pdev->dev, si_data,
492                             data_size, DMA_FROM_DEVICE);

While this kzalloc() is unlikely to fail, I did notice that the function
returned without unmapping si_data.

Fix this by refactoring the error paths and checking for kzalloc()
failure.

Fixes: 888ae5a3952ba ("net: enetc: add tc flower psfp offload driver")
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---

I am curious why you do not need to call dma_sync_single_for_device() before enetc_send_cmd()
in order to flush the contents of CPU cache to RAM. Is it because __GFP_DMA marks
that page as uncached ? Or is it because of the SOC this runs on ?

rtg
---
 .../net/ethernet/freescale/enetc/enetc_qos.c  | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 4577226d3c6a..a93c55b04287 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -486,14 +486,16 @@ static int enetc_streamid_hw_set(struct enetc_ndev_priv *priv,
 
 	data_size = sizeof(struct streamid_data);
 	si_data = kzalloc(data_size, __GFP_DMA | GFP_KERNEL);
-	cbd.length = cpu_to_le16(data_size);
+	if (!si_data)
+		return -ENOMEM;
+	cbd.length = cpu_to_le16(data_size);
 
 	dma = dma_map_single(&priv->si->pdev->dev, si_data,
 			     data_size, DMA_FROM_DEVICE);
 	if (dma_mapping_error(&priv->si->pdev->dev, dma)) {
 		netdev_err(priv->si->ndev, "DMA mapping failed!\n");
-		kfree(si_data);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out;
 	}
 
 	cbd.addr[0] = cpu_to_le32(lower_32_bits(dma));
@@ -512,12 +514,10 @@ static int enetc_streamid_hw_set(struct enetc_ndev_priv *priv,
 
 	err = enetc_send_cmd(priv->si, &cbd);
 	if (err)
-		return -EINVAL;
+		goto out;
 
-	if (!enable) {
-		kfree(si_data);
-		return 0;
-	}
+	if (!enable)
+		goto out;
 
 	/* Enable the entry overwrite again incase space flushed by hardware */
 	memset(&cbd, 0, sizeof(cbd));
@@ -560,7 +560,11 @@ static int enetc_streamid_hw_set(struct enetc_ndev_priv *priv,
 	}
 
 	err = enetc_send_cmd(priv->si, &cbd);
-	kfree(si_data);
+out:
+	if (!dma_mapping_error(&priv->si->pdev->dev, dma))
+		dma_unmap_single(&priv->si->pdev->dev, dma, data_size, DMA_FROM_DEVICE);
+
+	kfree(si_data);
 
 	return err;
 }
-- 
2.33.1

