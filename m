Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0277402D2C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345191AbhIGQvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345162AbhIGQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:51:03 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA64C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 09:49:56 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A14B222248;
        Tue,  7 Sep 2021 18:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1631033393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkPg7AFotZZ5RXVLzlsT1sFjmgLG9cEQf1g5MYE3IvY=;
        b=j8h3joLiOhJ7c+xnKo88JtGPFbqFvZ92xgSkZiVRYbMZlJ4mSFm8e+v5HtyvMqCG48ID0j
        kHkgtsqj6ADpfXIVVdUuZOLNETzS+OSILAZIRq2Rji4P/lQj8d0o7Epfhs1MAWp4c04fWy
        Zat/Yj4nFFM4YT95s5GwVXXIeaJvfX0=
From:   Michael Walle <michael@walle.cc>
To:     Robin Murphy <robin.murphy@arm.com>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     "Lukas F . Hartmann" <lukas@mntre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/3] drm/etnaviv: use PLATFORM_DEVID_NONE
Date:   Tue,  7 Sep 2021 18:49:43 +0200
Message-Id: <20210907164945.2309815-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907164945.2309815-1-michael@walle.cc>
References: <20210907164945.2309815-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a macro for the magic value. Use it.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 7dcc6392792d..2509b3e85709 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -653,7 +653,7 @@ static int __init etnaviv_init(void)
 		if (!of_device_is_available(np))
 			continue;
 
-		pdev = platform_device_alloc("etnaviv", -1);
+		pdev = platform_device_alloc("etnaviv", PLATFORM_DEVID_NONE);
 		if (!pdev) {
 			ret = -ENOMEM;
 			of_node_put(np);
-- 
2.30.2

