Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342D13EE579
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 06:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhHQETN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 00:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhHQETJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 00:19:09 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05A2C061764;
        Mon, 16 Aug 2021 21:18:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l11so23327659plk.6;
        Mon, 16 Aug 2021 21:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvpv+8q3g4xCHMUozwIBpDBoqFRGyAKVfv9xddtyv5o=;
        b=ArRnDWoSagJFh4S5NLbf/Ola1AVbgrrsrTUdIAh/Fe7CUJ6va4b5YgnsxcVOfY16uP
         fjDXyZdxRvxHSlNJXWy3dzPAo/psaerexJAvkPeixdGHrWO3EmRtCM+lH5cYtLcHIltz
         zbsXmYg8TiK/IvYSdfRXsSIZ0qlKpgry0OP/9AAtp2v+BAUPNdORRZrVi/QIGVVtSQu7
         s2hbIcvd9FsG2Mxi7mAqO45BLJUEh+Sp8uIzWUJ1u6uGX5uF+sevXdHKcuY8P0N41qVj
         Ctct6nIPCWvaGj79DInYH4tlD/ARfSQMtstiJRTwHEVkdSZAyPXPCqM3TLZCbTP3gH3+
         LB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvpv+8q3g4xCHMUozwIBpDBoqFRGyAKVfv9xddtyv5o=;
        b=GDqPghrDiliBVUwL8wWXkSuwHlZ9Bu387qsQCyKuPsHPnfdPdjh/JCBolxSZT6L8mi
         CvV0hPmVppM3Z3zRvC3oZGkway8bhqnTVfrzqyf5XfGMYzPpUihkP9sOUPZo7XUteM59
         RhV82WGeAhWxycnDp/mz/LMMnkKZBL5grEYMct2aUsvgDkRRrQFUT2TYsOjuE0D2hET/
         07QJO6irnaB06WGQbIP636ddn7pJh5x7iJArOd8mL6XqkHGyRk29zrBjgGdv2ojf6msV
         JP5I+T4GqhwFucGzL+fQUVQA6hdRzkMmIjQXJG0w0w5sLtEUsuXIsVRO02zJJIvKRKB/
         7qUA==
X-Gm-Message-State: AOAM533VF8XAw25ThmIG2aXztTrSsGzllTdkTh+jYl7zzGLkwmHNmxpB
        RO+bFZo06HB4a2YcMGUNZIA=
X-Google-Smtp-Source: ABdhPJyfFtCrZ2P3scFr8d1eXqGQaE49+b6pBgykLWEAqZG3Y0vHwldNwb59wz/fYDPbKVgezj55LQ==
X-Received: by 2002:a05:6a00:cd0:b0:3e2:209e:4e30 with SMTP id b16-20020a056a000cd000b003e2209e4e30mr1630426pfv.59.1629173916369;
        Mon, 16 Aug 2021 21:18:36 -0700 (PDT)
Received: from archl-on1.. ([103.51.72.143])
        by smtp.gmail.com with ESMTPSA id g11sm705676pfo.166.2021.08.16.21.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 21:18:35 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
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
        Brian Kim <brian.kim@hardkernel.com>
Subject: [PATCHv3 6/6] phy: amlogic: meson8b-usb2: don't log an error on -EPROBE_DEFER
Date:   Tue, 17 Aug 2021 09:45:40 +0530
Message-Id: <20210817041548.1276-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817041548.1276-1-linux.amoon@gmail.com>
References: <20210817041548.1276-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_phy_create can return -EPROBE_DEFER if the vbus-supply is not ready
yet. Silence this warning as the driver framework will re-attempt
registering the PHY. Use dev_err_probe() for phy resources to indicate
the deferral reason when waiting for the resource to come up.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
None.
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

