Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094DA3CB631
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbhGPKlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbhGPKlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:41:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72EEC06175F;
        Fri, 16 Jul 2021 03:38:41 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h4so9544860pgp.5;
        Fri, 16 Jul 2021 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w3d3QBhIUG9rULiQkPjmvB3VFugYPgFTgKGsQs/0OIs=;
        b=edMHLZZ9Joy3kORNlbb3fA7Oip6TpGrlESLPRoP4j3s+sAQLT1SlBoA6nDewPTbeVZ
         adOYB6al4mrObEuWESAJ8eKqdNEMX2eOcU/YxWBmqhLKf3xbN45sNRIeZKrAtBqyiz9f
         nX3dORJt+ID97uW4aq30eSU7zpLvGnWqQQDutpcN7gU5/m6ZvhDGcnZwvjjaNnqkhHWH
         TaAulTOhfwFITR/T+aDhl6mwTAAaYhoKE8723LObUi/eM/LbPvenJ3bIctfUxk92bowR
         BJ6DACx3dWU2weZVjdGuyk0HaB1noOWHalBTdjC8xkh7RLFCqkc388tyQMAjAHw2k4PS
         KfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3d3QBhIUG9rULiQkPjmvB3VFugYPgFTgKGsQs/0OIs=;
        b=OLVm83A9+OQsMCEHdXVkBmJIBLJLQQeqDFdJVxkJwrPk9ic8T8fdKk6GhfDIpyB0g+
         dQKnWABHzh33RyBdsFi3vGd7CmLHqGYL7KsUSCm7B1gJ8+Cui09vDRH3bBgZPyaAjPN7
         i14lzqiPU2WEKtADmEIXNPLJJzwsy0+dKQ1iJ3Qq2XRLLe3/q33jIoOqy3Ccb4tq6ug8
         3GtYHbp4SELIk7gf+tfkwdkdEbTJvRFMmigiQLaGEPfVkYeasC5Jipt1EfpwTFj9wGsK
         E4T6JIYyKDEXfMldqozymZkeZGOqnc7TZc9FZL9NHxTTzLai30Jt62TyhjfBZQloLHdk
         NeZg==
X-Gm-Message-State: AOAM532A9xsgA9eRBXbkLU5Xs6pdUfPFqiY93VcRAnebjydoLO6dkbIy
        iZ5q3hyHeKVnra+6CVkMzIM=
X-Google-Smtp-Source: ABdhPJzRs9l6a/USkfsyP9AF6K5QWyN3b48FxjpiD1pQ49VAVuin34TLdB+q2UIjut4p6GMWd5n0vw==
X-Received: by 2002:aa7:97bd:0:b029:32c:56cc:8fa9 with SMTP id d29-20020aa797bd0000b029032c56cc8fa9mr9677013pfq.65.1626431921511;
        Fri, 16 Jul 2021 03:38:41 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id d29sm10070111pfq.193.2021.07.16.03.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:38:41 -0700 (PDT)
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
        Brian Kim <brian.kim@hardkernel.com>,
        devicetree@vger.kernel.org
Subject: [PATCHv2 4/4] phy: amlogic: meson8b-usb2: don't log an error on -EPROBE_DEFER
Date:   Fri, 16 Jul 2021 10:36:36 +0000
Message-Id: <20210716103651.1455-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716103651.1455-1-linux.amoon@gmail.com>
References: <20210716103651.1455-1-linux.amoon@gmail.com>
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
None:
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

