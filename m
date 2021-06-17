Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42D53ABD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhFQTqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFQTqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:46:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B34C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:44:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m15-20020a17090a5a4fb029016f385ffad0so1663969pji.0;
        Thu, 17 Jun 2021 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQPEi5A9nnMFKoiOKyymsLKzhX94jE2VAyrLXIfg84k=;
        b=oF7qwt4MVyLOPRPRZwU7w3KvEGQIUotgOr/2Rooi6tbscOBcNqcc1XD3ENr3WptRU8
         UdhBxiQR1tOYZjcJVD1fa4KleHtJqN7KxHtvJS754EFzMoK4T9Gh2Jx2st8Iz/a2/nhp
         22a8md8h3WN1OnjpWFJrD9iYAxM0o2F6ADNX5fQMR/pQ/e0CWYI4RO+/aMakKaTPHohm
         7RDU6QSEhU2D2TGadIdObyZPW+phnQWWMo1OkSF4NVgn2lFG/8slNhESNif5h22IWKa0
         yAY/349fJ48TmmziwVVoRA40NUaR3gcQ33rXNNwdSCQLCPJQyq7+SGHFi7JBBTMHceDV
         fJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQPEi5A9nnMFKoiOKyymsLKzhX94jE2VAyrLXIfg84k=;
        b=QtjEck/88+fo0Q2ikNJ6wDPA+x+EKwI6pwgxumDeM79HE7zF857KUuBRXvPqbydKX5
         81EPnVrHN7tGjI0uwyEkR6Sj//Dqupfca0NDL+psSpQ65NVlA/GEm4L19cCv3UycpS/I
         apafWWOhv/M5q5p6QjqkiicJ9zkePj9FTuI0jMJOQvYPaLhrx01uB6/MUYGMMo4AlDdq
         cS+BdMxBjpIThR5DSMA9khmauI3ndp42OiQSTBhrsinXuplDCx8r8OTUqEjlsOfEh3F0
         DrSg1oG2eruqS+Ly5v0OKNwWaHCqo0df8fcM7QF6OCKCFUbMBiTR1FGJuXQqhs5Tt4fl
         9drg==
X-Gm-Message-State: AOAM530A/RT1adjXam0ocn+D3kS+vpzW8voUy1OXiM0/jA9ZATqDigmH
        B8Q3hgPxo17E+nc/g5BhGxs=
X-Google-Smtp-Source: ABdhPJzZxNqxDhu1JuR1k4gJl697ElF7Ci5dtFWC4BPWfy/748J3KooaJwzRJ6CEUCMpmbkiVKZ2KA==
X-Received: by 2002:a17:90a:5795:: with SMTP id g21mr6992169pji.235.1623959073592;
        Thu, 17 Jun 2021 12:44:33 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.75.27])
        by smtp.gmail.com with ESMTPSA id z9sm5987187pfa.2.2021.06.17.12.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:44:33 -0700 (PDT)
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
Subject: [RFCv1 7/8] phy: amlogic: meson8b-usb2: Power off the PHY by putting it into reset mode.
Date:   Thu, 17 Jun 2021 19:41:42 +0000
Message-Id: <20210617194154.2397-8-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617194154.2397-1-linux.amoon@gmail.com>
References: <20210617194154.2397-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power off the PHY by putting it into reset mode.
Drop the phy power reset since we are doing reset of phy
after we configure the phy. No functional change.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index c1ed2e5c80d8..d5edd31686bb 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -226,6 +226,11 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
 		regmap_update_bits(priv->regmap, REG_DBG_UART,
 				   REG_DBG_UART_SET_IDDQ,
 				   REG_DBG_UART_SET_IDDQ);
+
+	/* power off the PHY by putting it into reset mode */
+	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET,
+			   REG_CTRL_POWER_ON_RESET);
+
 	return 0;
 }
 
@@ -245,8 +250,6 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_FSEL_MASK,
 			   0x5 << REG_CTRL_FSEL_SHIFT);
 	/* reset the PHY */
-	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET,
-			   REG_CTRL_POWER_ON_RESET);
 	udelay(RESET_COMPLETE_TIME);
 	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET, 0);
 	udelay(RESET_COMPLETE_TIME);
-- 
2.31.1

