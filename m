Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A700C398FAB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhFBQKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:10:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16533 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFBQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622650129; x=1654186129;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2gw1LPRHVc5WHx/TLUSAc36JsiCrmgOgMOSM1MRoLSY=;
  b=goojyr+/85TNofVrIgiRsDajYnHM0T8GhDZ4NM+WZDLXxR1L+04qUT65
   0i8z5ueEcbUth5nMoQ7OsGx8cBuoFBR5+v5M4CV/zserX3QYnn9PJeyo4
   JIwpgs1yv385bhLrl5nsxo6qQFiif3Gsz9fYhvGq4GiP5qdG4VOykFm8X
   J7THG3EQCdgCGm3csvMXzXd+5hJRcGM1zcYQ/c5cfJgdBUerwW+rTB7mu
   ntGfslvUEPTuaCSHcH0aMXtP5vUWcVf1Ro5VIGKfW60jpr6n84mIK+YiT
   2ZIunsYZDre0leY7I25AWhei4G3ruELjWr+xokqrapZwNPMrnZ836AYPZ
   A==;
IronPort-SDR: fJiU9Iv86kQyanaDFZQyhjRa8bUG5TM9OX4uwRTFTY4U4xePJz7dC+7cj0ucEJtr5azJXzPgpr
 cXICT7dlLL7+b/nsP2OdA8Ownbf6Or2W8Ajj1clbzklh7yikbLAHBpAxb0yrGe6sZajb00QNpa
 UsXfhl8eVkmBanvrXP7G+2UNrxfPM0WxevgJzOLPilxgS8cpFa6JHeHEXyb+c/mv/1p5MrD/1g
 vq6NrAQnOoHuyCW+qWbDovmqVVatfT5f8XGHZZRLXYadvXgTt3a+4BvZ+IOS5XzYym9TcnMcfX
 5Fo=
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="123275472"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jun 2021 09:08:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 09:08:47 -0700
Received: from dan-linux.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 2 Jun 2021 09:08:47 -0700
From:   Dan Sneddon <dan.sneddon@microchip.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Sneddon <dan.sneddon@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH] drm:atmel: Enable the crtc vblank prior to crtc usage.
Date:   Wed, 2 Jun 2021 09:08:45 -0700
Message-ID: <20210602160846.5013-1-dan.sneddon@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'commit eec44d44a3d2 ("drm/atmel: Use drm_atomic_helper_commit")'
removed the home-grown handling of atomic commits and exposed an issue
in the crtc atomic commit handling where vblank is expected to be
enabled but hasn't yet, causing kernel warnings during boot.  This patch
cleans up the crtc vblank handling thus removing the warning on boot.

Fixes: eec44d44a3d2 ("drm/atmel: Use drm_atomic_helper_commit")

Signed-off-by: Dan Sneddon <dan.sneddon@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 05ad75d155e8..cfe4fc69277e 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -232,7 +232,6 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 
 	pm_runtime_put_sync(dev->dev);
 
-	drm_crtc_vblank_on(c);
 }
 
 #define ATMEL_HLCDC_RGB444_OUTPUT	BIT(0)
@@ -343,8 +342,17 @@ static int atmel_hlcdc_crtc_atomic_check(struct drm_crtc *c,
 
 static void atmel_hlcdc_crtc_atomic_begin(struct drm_crtc *c,
 					  struct drm_atomic_state *state)
+{
+	drm_crtc_vblank_on(c);
+}
+
+static void atmel_hlcdc_crtc_atomic_flush(struct drm_crtc *c,
+					  struct drm_atomic_state *state)
 {
 	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->dev->event_lock, flags);
 
 	if (c->state->event) {
 		c->state->event->pipe = drm_crtc_index(c);
@@ -354,12 +362,7 @@ static void atmel_hlcdc_crtc_atomic_begin(struct drm_crtc *c,
 		crtc->event = c->state->event;
 		c->state->event = NULL;
 	}
-}
-
-static void atmel_hlcdc_crtc_atomic_flush(struct drm_crtc *crtc,
-					  struct drm_atomic_state *state)
-{
-	/* TODO: write common plane control register if available */
+	spin_unlock_irqrestore(&c->dev->event_lock, flags);
 }
 
 static const struct drm_crtc_helper_funcs lcdc_crtc_helper_funcs = {
-- 
2.17.1

