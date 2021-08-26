Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1B43F86FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242365AbhHZMLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:11:02 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:42647 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242322AbhHZMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:11:01 -0400
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DC33E22248;
        Thu, 26 Aug 2021 14:10:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1629979813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dO+qPj9cDLaMPZKZqeFZ//qD1/rnIU4HoWkDp1cDPKU=;
        b=QzjAd0iEfdwVsRf0JNde3UmsF2S0kqfATZ27F9zOMsSRAYzldWw20QzTCfTY3wtL7ScMBp
        dW2kmjmDChcO/Bval+hQrjkbxxbS6Bm0BpPNGrfEz7zfctcdItP3G7YPGaPdfZLWjMpejC
        b26lrinM4N1ty7e16O90sQzUdKV4PBU=
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
Subject: [PATCH 1/3] drm/etnaviv: use PLATFORM_DEVID_NONE
Date:   Thu, 26 Aug 2021 14:10:04 +0200
Message-Id: <20210826121006.685257-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826121006.685257-1-michael@walle.cc>
References: <20210826121006.685257-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a macro for the magic value. Use it.

Signed-off-by: Michael Walle <michael@walle.cc>
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

