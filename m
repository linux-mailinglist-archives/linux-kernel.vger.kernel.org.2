Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D43369F08
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 08:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhDXGTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 02:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhDXGTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 02:19:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11643C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 23:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UHtbsdbpwbNeabtBKPBRJb+nauxP3JoNafFlth/EW7A=; b=FnPqf4LID0GMM7t7Il58IshBFO
        i2IuSZMm5y5kZMGogqLKyn1tSWaI6PdpZNYjGGs7HMr/GwzXHzgHr7/96LxNgPrZgDZbkoJ++VNGb
        KDXHKXn2Xgs5aHFhLwiL8TDx//RkFJWltyE7d2U+FKWbHQ92yXFFl3v3gyP5bO4VYPc/R8cy/0fgL
        80BZFAmQYWfvHF89pPu+0Xo8nWppaEOb1XCaJUCCeptAHEVhxPuXRE7qryUUDhhUMpftlsFcyC+Af
        cfRsVnjLC6NI2+yOzuWUJEnm+XyLBacNHtTYGu0n3ymuX0V/fbb7mVuTGw0VarLcL11aNZYkoiGBh
        6NJq6RPw==;
Received: from [2601:1c0:6280:3f0::df68] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1laBcT-0038ar-Qg; Sat, 24 Apr 2021 06:18:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Icenowy Zheng <icenowy@aosc.io>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Torsten Duwe <duwe@suse.de>, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH] drm: bridge: add missing word in Analogix help text
Date:   Fri, 23 Apr 2021 23:18:17 -0700
Message-Id: <20210424061817.7339-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Insert a missing word "power" in Kconfig help text.

Fixes: 6aa192698089 ("drm/bridge: Add Analogix anx6345 support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Icenowy Zheng <icenowy@aosc.io>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Torsten Duwe <duwe@suse.de>
Cc: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/bridge/analogix/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20210423.orig/drivers/gpu/drm/bridge/analogix/Kconfig
+++ linux-next-20210423/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -6,7 +6,7 @@ config DRM_ANALOGIX_ANX6345
 	select DRM_KMS_HELPER
 	select REGMAP_I2C
 	help
-	  ANX6345 is an ultra-low Full-HD DisplayPort/eDP
+	  ANX6345 is an ultra-low power Full-HD DisplayPort/eDP
 	  transmitter designed for portable devices. The
 	  ANX6345 transforms the LVTTL RGB output of an
 	  application processor to eDP or DisplayPort.
