Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BE03ABD0F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhFQTrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbhFQTq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:46:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EBCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:44:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u18so490956pfk.11;
        Thu, 17 Jun 2021 12:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+55Ue4W/St8WzVyqe/i5ldF+F9lfhpaazjUIhpwFCbU=;
        b=EZjAcRaCFNPFLV/Dwc3dBcc+5bgU85W2R/dX96oapPujxwKglk9SnSCNmryv1xNeP1
         RFx/XZ2b0Og6wCxyOpVNhSQuV6TNrmgG7BmhFaFap0FX6QvkZlJEVValx6vLby/pgYA4
         85+xlVnVYjiqilbp65xRAT4JSKby3RgC98Na+BqImwSyxLq9NU8Wj9EG2TkySkqNlfPV
         8HCjZB5xH7B57jtI+Tl+58xGhvVo1ihY6beJ1zUeoLj4dw4ezfeQUhyXYkEqyIkiQIpM
         6YeDJAm1Tr1efY5g+wFylrdwaHGWFzbG0r/w/9Nc6T6KX6IeNq16LjpjwT+VtXjGDtqt
         H4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+55Ue4W/St8WzVyqe/i5ldF+F9lfhpaazjUIhpwFCbU=;
        b=j/z6Kd4rHCb0RITTaF2fWABU+8OApAz9YsTzj2GRfAEQsIt7ItWpZzumAGwmRKNnqs
         Sk2tFbXRVpupjPib3HnoS8bLAnmZQSDtjJzj2eFHPmvPnTtGq6yRI13YRFoYeCCGi1aJ
         ibe6bU8JaUt+qkybV44hisLfzJxRGht2MIQT2aNR10qXWKS1xMenfPOBq85Ykf6ZQOeM
         fDLzRWvPFxsd53ekXIyytLJy5zQx4vdjqm01QRCWfjikFoONAfCFmTY+fJueclRaP/uS
         ShXWUl7eb+q9+2wFcQkhG30jVw8ciqvxRMteEtk1wfRvLLhe7gtjugaHnGzByfbaI5g6
         Z3Mg==
X-Gm-Message-State: AOAM531uYAzTgkB66R6Lou2sZl7bQAMdjSFYVl0fXIpBPZ4GfYu+Rtry
        4m6T2AE+VEQdhJXnWTbdR6Y=
X-Google-Smtp-Source: ABdhPJz1NtVS+KHlgLx1xT9I5TBnQfvCgNalkW+pJw42jrPFghbseNcxDTgiOxfCDLd6UXJeprIi5g==
X-Received: by 2002:a62:7e05:0:b029:2ea:57f:ec86 with SMTP id z5-20020a627e050000b02902ea057fec86mr1515090pfc.37.1623959090404;
        Thu, 17 Jun 2021 12:44:50 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.75.27])
        by smtp.gmail.com with ESMTPSA id z9sm5987187pfa.2.2021.06.17.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:44:49 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     --to=linux-phy@lists.infradead.org,
        --to=linux-arm-kernel@lists.infradead.org,
        --to=linux-amlogic@lists.infradead.org,
        --to=linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 8/8] phy: amlogic: meson8b-usb2: don't log an error on -EPROBE_DEFER
Date:   Thu, 17 Jun 2021 19:41:43 +0000
Message-Id: <20210617194154.2397-9-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617194154.2397-1-linux.amoon@gmail.com>
References: <20210617194154.2397-1-linux.amoon@gmail.com>
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
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index d5edd31686bb..bd624781d914 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -332,8 +332,8 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
 
 	phy = devm_phy_create(&pdev->dev, NULL, &phy_meson8b_usb2_ops);
 	if (IS_ERR(phy)) {
-		dev_err(&pdev->dev, "failed to create PHY\n");
-		return PTR_ERR(phy);
+		ret = PTR_ERR(phy);
+		return dev_err_probe(&pdev->dev, ret, "failed to create PHY\n");
 	}
 
 	phy_set_drvdata(phy, priv);
-- 
2.31.1

