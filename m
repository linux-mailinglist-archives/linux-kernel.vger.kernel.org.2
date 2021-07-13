Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC13C69F6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 07:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhGMF42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 01:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhGMF40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 01:56:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A97EC0613DD;
        Mon, 12 Jul 2021 22:53:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k20so13675560pgg.7;
        Mon, 12 Jul 2021 22:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqebAial/PxUvQ3x7+4RUByyPvCTdM4/Zaewy8REn3g=;
        b=rBIoJZjfWAT0sRt0CuW/uq1rjG98twshMCwuo4VaQt6XMH78VOKYuwbYlZD2OvKgfC
         WA+Orzbash1JXWVYc0LdD905jDTo2UNkKue11N0vhizpwQ1+hnchElQEiJBRU4v6SNjt
         Mp932YetKM2iQLa5Nj/9O4vS6T72OamP4Gp0oLWthTjgZqMEn8Hqaxfw3XHgTdWLAhZJ
         vNOAFY6WkHQWtbg4rtTy9EVA/q3m0LRP78HkRgMFtqdlBlTwDRm300n2ERdzYDs/3G9W
         dA1Ba+NjXPXtME0rbYx3pBJjluJAjATB5KWc6iP4PSMQA1ewHyFDULGomor4s9LVEIhQ
         v9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqebAial/PxUvQ3x7+4RUByyPvCTdM4/Zaewy8REn3g=;
        b=doeZn9vlPB/KWtXSeDAHSFwkyR98DMDmrJZrpmq8IY+8IAdV23v885CkpsJRtiECyB
         tkE84H6NCjG0Oq8jhSrGfByuP6ChajG4+tPQyVRn2lkBqO/DuydmS2cHuKt40vuPZ1gn
         k5TfnLMYTfL+KnYiOXIXBiSALSqmI1Ane21U+PUVziTi2H9tm8RMJBWBDvhE62d71r+g
         DoAExBE7ThULtwdMorJCzxNnYRGInAevX6Z7O+/iMQg4Nwc9qUcMr+alkSz6ZxlD3zZf
         qjiK8Yww893CQ3c1sKPb1HWb7YCluIknJvBYmAwqr+pO1Dwk6RnTjE/QaBx+mRRuHHZ8
         2yaw==
X-Gm-Message-State: AOAM530BCNf2JyPWrOc/5NQNnXKqx9bedbe/LEPVyBm7K04yX1IwWhPO
        2QSIDyF+yCS4XqiyJrqSUYo=
X-Google-Smtp-Source: ABdhPJyIw7eqiXGaYJ6UUi8zfg205/gHaSO1yNYTVWBN8ejx2F1ONjtA2jg18NkFnJE8nk+PVkgMIA==
X-Received: by 2002:a62:5105:0:b029:305:324:17ae with SMTP id f5-20020a6251050000b0290305032417aemr2832898pfb.28.1626155616030;
        Mon, 12 Jul 2021 22:53:36 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id x19sm17755198pfa.104.2021.07.12.22.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 22:53:35 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        devicetree@vger.kernel.org
Subject: [PATCHv1 3/3] phy: amlogic: meson8b-usb2: don't log an error on -EPROBE_DEFER
Date:   Tue, 13 Jul 2021 05:52:15 +0000
Message-Id: <20210713055227.1142-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713055227.1142-1-linux.amoon@gmail.com>
References: <20210713055227.1142-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_phy_create can return -EPROBE_DEFER if the phy-supply is not ready
yet. Silence this warning as the driver framework will re-attempt
registering the PHY. Use dev_err_probe() for phy resources to indicate
the deferral reason when waiting for the resource to come up.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20210617194154.2397-9-linux.amoon@gmail.com/
---
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 2aad45c55494..cf10bed40528 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -277,8 +277,8 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
 
 	phy = devm_phy_create(&pdev->dev, NULL, &phy_meson8b_usb2_ops);
 	if (IS_ERR(phy)) {
-		dev_err(&pdev->dev, "failed to create PHY\n");
-		return PTR_ERR(phy);
+		return dev_err_probe(&pdev->dev, PTR_ERR(phy),
+				     "failed to create PHY\n");
 	}
 
 	phy_set_drvdata(phy, priv);
-- 
2.32.0

