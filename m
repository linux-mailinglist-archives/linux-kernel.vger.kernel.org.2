Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031E74147BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbhIVLZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 07:25:52 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:41896
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235439AbhIVLZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:25:50 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8EC1C4015E;
        Wed, 22 Sep 2021 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632309856;
        bh=jPiivGMCA0vYpmru2UiRTorDKmvF0y0XmHoBEgYPsvQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=KJUyde2+TnzqFPXbbGunQw+OLCxj1A1Rkqd798wGAdaZD5z94siUroSYJbHTyEK81
         DR+F9sQ9R5GjyjsjVX1sac8kpOt5oAjNkmH9STDWXE2mimYQQaHeGDUduvR2GOdNyP
         NXXh6hg9xQ9yrTtEiExlBed3M6d92XwUhRTfHOKUqSkZgeW8JDzfqLQYTwFRPToz3S
         K/Gk+bJJjvO+X7McFfGCVqMELivjQRUFZt3GpsnNVOL/V8Y4E9q3kH3AWdpc/ovHEF
         /YeepV7gfW7WoCKbzgbWp+F6f1FtoCvepWSAMqVq1UTM6Oz2CES0eXtFsTpdum7rtJ
         5+TtwFAd7G8mA==
From:   Colin King <colin.king@canonical.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/rockchip: Remove redundant assignment of pointer connector
Date:   Wed, 22 Sep 2021 12:24:16 +0100
Message-Id: <20210922112416.182134-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer connector is being assigned a value that is never
read, it is being updated immediately afterwards. The assignment
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/rockchip/rockchip_rgb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index 09be9678f2bd..18fb84068a64 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -150,7 +150,6 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 	if (ret)
 		goto err_free_encoder;
 
-	connector = &rgb->connector;
 	connector = drm_bridge_connector_init(rgb->drm_dev, encoder);
 	if (IS_ERR(connector)) {
 		DRM_DEV_ERROR(drm_dev->dev,
-- 
2.32.0

