Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8143F8700
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbhHZMLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242447AbhHZMLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:11:02 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA55C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 05:10:15 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E27132224D;
        Thu, 26 Aug 2021 14:10:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1629979814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oRQiZA12z5278LSNc0kj7MPQsMh45a7s6hh6cYHR2NQ=;
        b=cVhbzjVibrZQBHsYp9/pglVYtu/clIQEjtvfDlOpVtf8nxfWMbgFoL042KAC8ZWg/jzRK7
        KF0Px9NmoLRaddTcqsQy/lXYxVTWYcME1IUjED/EWCqMBsyEk7jE3VpkqyFAYwBEnHZ2+l
        UlmgP4k3+abGOvT1C27XQNmLhzC8hZc=
From:   Michael Walle <michael@walle.cc>
To:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     "Lukas F . Hartmann" <lukas@mntre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 3/3] drm/etnaviv: use a 32 bit mask as coherent DMA mask
Date:   Thu, 26 Aug 2021 14:10:06 +0200
Message-Id: <20210826121006.685257-4-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826121006.685257-1-michael@walle.cc>
References: <20210826121006.685257-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STLB and the first command buffer (which is used to set up the TLBs)
has a 32 bit size restriction in hardware. There seems to be no way to
specify addresses larger than 32 bit. Keep it simple and restict the
addresses to the lower 4 GiB range for all coherent DMA memory
allocations.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index ff6425f6ebad..0b756ecb1bc2 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -613,8 +613,23 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
 			component_match_add(dev, &match, compare_str, names[i]);
 	}
 
-	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(40);
-	pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+	/*
+	 * PTA and MTLB can have 40 bit base addresses, but
+	 * unfortunately, an entry in the MTLB can only point to a
+	 * 32 bit base address of a STLB. Moreover, to initialize the
+	 * MMU we need a command buffer with a 32 bit address because
+	 * without an MMU there is only an indentity mapping between
+	 * the internal 32 bit addresses and the bus addresses.
+	 *
+	 * To make things easy, we set the dma_coherent_mask to 32
+	 * bit to make sure we are allocating the command buffers and
+	 * TLBs in the lower 4 GiB address space.
+	 */
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(40)) ||
+	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32))) {
+		dev_dbg(&pdev->dev, "No suitable DMA available\n");
+		return -ENODEV;
+	}
 
 	/*
 	 * Apply the same DMA configuration to the virtual etnaviv
-- 
2.30.2

