Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075793ACA93
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhFRMG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFRMG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:06:56 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1824CC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:04:47 -0700 (PDT)
Received: from mwalle01.kontron.local (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3A9A12225B;
        Fri, 18 Jun 2021 14:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1624017885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJD/MySWnPvXQuwIf3J/ioBbrWLOimWmN1G5D/biUJc=;
        b=aa60WENuM6qJuScG3Nv4FJ/JuBjXhFbNZYeL5p8Qy7CMFuzBm/jSLxh9G6T3T5qdfEMIjQ
        O0uVn3acXedToDZenD4R6g+SUegJEQzPnbiSTyiFhiFltmZU+nfJQW6rJcyQCQNVbcebaC
        Ybf3ztjWn489PgxE1IAIKPq/hyu/g6Q=
From:   Michael Walle <michael@walle.cc>
To:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lukas F . Hartmann" <lukas@mntre.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] drm/etnaviv: add clock gating workaround for GC7000 r6202
Date:   Fri, 18 Jun 2021 14:04:33 +0200
Message-Id: <20210618120433.14746-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210618120433.14746-1-michael@walle.cc>
References: <20210618120433.14746-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1028A SoC errata sheet mentions A-050121 "GPU hangs if clock
gating for Rasterizer, Setup Engine and Texture Engine are enabled".
The workaround is to disable the corresponding clock gatings.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since RFC:
 - corrected the wording of the comment

 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 4102bcea3341..c297fffe06eb 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -613,6 +613,12 @@ static void etnaviv_gpu_enable_mlcg(struct etnaviv_gpu *gpu)
 	    etnaviv_is_model_rev(gpu, GC2000, 0x5108))
 		pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_TX;
 
+	/* Disable SE, RA and TX clock gating on affected core revisions. */
+	if (etnaviv_is_model_rev(gpu, GC7000, 0x6202))
+		pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_SE |
+		       VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA |
+		       VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_TX;
+
 	pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA_HZ;
 	pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA_EZ;
 
-- 
2.20.1

