Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0228A37322A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 00:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhEDWDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 18:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhEDWDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 18:03:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC94CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 15:02:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d11so10953794wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 15:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TWgllBMIdI7K4QAKzryp2LC84PsKaAiDjf7lNkKXZQ=;
        b=ZlH+mWWf+79byPCgtelVSm2YH75Hbp6iRcUouYzUWT0WzQkwEHvbtl4o6UrTnRTD7o
         yXGPJCa0BHXKoSRfASMrX/wQYOXiZCU3kMuN4/w1Md5mOQBiGuCKl/E6iUfD9qC2I5vL
         dVohu1OqKGVq1pvHu9mCe2UGEYzFrkIPONlxQk7EMd0E80xjpLQO1bBoPZ2+qvy3E57Q
         fpv4J7R5NDlrKt4f5fhQtCIRK804iwyn28TkLEOp+W6+CNPdRXbuJyFCaXXN/c6HetUD
         TfPkQd6QCXdDaderJUs/EbGMWWRSGQspKM4gRjr1K5WIhL3z22z8qoauycf99WpBIaxT
         YEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TWgllBMIdI7K4QAKzryp2LC84PsKaAiDjf7lNkKXZQ=;
        b=W2uNP6YBVS5kAbLsCGbaBP4k6JJ6Fug+QVWhkOfPEExUh+cEvQXV2a1gESSOh89GtM
         kpiA5MV3RDrC7rjxA9Nz6OVPSwVgbAoaqmECViK/+Pz0ATL7qabcvNUqe/YgrZxdON8/
         XKohza4inbNI/3BWjsa2U1eJRo1PNT/rkemleInpovM5KSNQ1iD765F48Ekgyo6C0o1A
         yHeTryMi4HtY7iCujyXq+TLv7A4Oah3cGxr3MAxl0X5xiSoZEtVpV1rcyzPF9ytBx0fa
         g6Rwm6/xawioFpGtJEGq9Km9Gj3dzJsWmivD/ODkwhWE5h23MizCBVpQz1TDJNOlCqZf
         y7ww==
X-Gm-Message-State: AOAM533EKv6ACmh0/3fKxykZOBbczXyik1L9rYT50z+SvWhrcx878bPT
        YkwXo2WFwLVreDYaGhqccBU=
X-Google-Smtp-Source: ABdhPJz/wkBdr8RQPL2dVJpDaDVtoFKM+eDH55ieQV5sZo21j0ivdtRXGcfmaOqmtPj66IadTM/rDg==
X-Received: by 2002:a5d:6248:: with SMTP id m8mr1256641wrv.42.1620165734418;
        Tue, 04 May 2021 15:02:14 -0700 (PDT)
Received: from localhost.localdomain (2a01cb001102af00348f8588f3a794a5.ipv6.abo.wanadoo.fr. [2a01:cb00:1102:af00:348f:8588:f3a7:94a5])
        by smtp.gmail.com with ESMTPSA id z8sm16845834wrw.74.2021.05.04.15.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 15:02:13 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     msuchanek@suse.de, a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, airlied@linux.ie,
        daniel@ffwll.ch, adrien.grassein@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: fix LONTIUM_LT8912B dependencies
Date:   Wed,  5 May 2021 00:02:07 +0200
Message-Id: <20210504220207.4004511-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LONTIUM_LT8912B uses "drm_display_mode_to_videomode" from
DRM framework that needs VIDEOMODE_HELPERS to be enabled.

Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
Reported-by: Michal Suchánek <msuchanek@suse.de>
Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 400193e38d29..70bcceaae9bf 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -68,6 +68,7 @@ config DRM_LONTIUM_LT8912B
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select REGMAP_I2C
+	select VIDEOMODE_HELPERS
 	help
 	  Driver for Lontium LT8912B DSI to HDMI bridge
 	  chip driver.
-- 
2.25.1

