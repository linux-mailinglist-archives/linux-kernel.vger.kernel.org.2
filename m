Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662583A71D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 00:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhFNWUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 18:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbhFNWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:20:13 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10002C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 15:18:09 -0700 (PDT)
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B1F9422253;
        Tue, 15 Jun 2021 00:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623709086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SD9ah05R7q3Xl2JjUIPjpWWyqe3h4fOAzvP8iSEX2Hk=;
        b=U5MJr1VkoyQo1vU0kwB7yeUkXd4RKn9ihxT/uFlNjhcvsaeKUaKQOJRfUzZq4MRC1rtC9K
        4/WWfmg1EKlDcpzjk0xc2OQteI1TSsFCbIDZ2/d0J2rIKVDuo1I0/UmzFZ+vqJg+9y9oW2
        vNLQ0t/aBNfCsswPMXGlbJAQ5Ti5h3E=
From:   Michael Walle <michael@walle.cc>
To:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 2/2] drm/etnaviv: add clock gating workaround for GC7000 r6202
Date:   Tue, 15 Jun 2021 00:17:52 +0200
Message-Id: <20210614221752.1251-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210614221752.1251-1-michael@walle.cc>
References: <20210614221752.1251-1-michael@walle.cc>
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
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 4102bcea3341..574e4e04dddc 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -613,6 +613,12 @@ static void etnaviv_gpu_enable_mlcg(struct etnaviv_gpu *gpu)
 	    etnaviv_is_model_rev(gpu, GC2000, 0x5108))
 		pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_TX;
 
+	/* Disable RS, SE, TE clock gating on affected core revisions. */
+	if (etnaviv_is_model_rev(gpu, GC7000, 0x6202))
+		pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_SE |
+		       VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA |
+		       VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_TX;
+
 	pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA_HZ;
 	pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_RA_EZ;
 
-- 
2.20.1

