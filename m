Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1029E3EE577
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 06:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhHQES5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 00:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhHQES4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 00:18:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F15BC061764;
        Mon, 16 Aug 2021 21:18:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j1so29957693pjv.3;
        Mon, 16 Aug 2021 21:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/De+hbEmJZRZ6r7uVfFxTcLTqZUJMY0uXYnWBmH2jqY=;
        b=UPAVPx813tLu01hoTQDKKDPD4TQMFuDerro+n95jRRkWNy/RT0SO9DflqJSdOXEpo8
         NF945T3KYbr2dkLX7mCJrv7oCbijYqRDHaaGyMnJAsNhPak4th2ei+E7Fx/hS4KXN17u
         9Bfr/UD9Ljtn0WCNc8MIlqC0XMbkiSx2HxBediZuEJLik+RtWAcjsSIaacEN3TjxETqM
         5Pjlfvj/l/d2CcCrQqXYRj0uiAIO378u913DdfIfKVZaYqz5sFVbHUQWYDkVgVc44bxA
         955YSQk32VnaKwoPsd81yupWYX4H7s0Ycddn8ref6yXZUkWdwAZdb2fzYlvDPWU1ucyO
         bV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/De+hbEmJZRZ6r7uVfFxTcLTqZUJMY0uXYnWBmH2jqY=;
        b=pk7gFHmEET4YYXj+uOcrjuQscA17A4wfFWr+gxISc/S9m0aVU4cFNGw6VywyZdSzDC
         YGQ2kTkZLgXhm8xtGECxZqKItrS3JovVwlVREIMzSGoJi6YJruMq3csSI+dKuRWah3KD
         MPRrF+BDvfegs5z0669KXZNDnMJWTQYVhGECjI6E2blPw3G/utUWuQCYGY/2KmjX6Q2M
         mWwiy2rl5HgGknPkQTDEP6v1LKooRmpObnUiST3pr+XO/alUO634Pa5Ya5CXs3gC1UAM
         j9Opw1OuXu9KTc54OFH4eUkUzjDpz1CnBK4VK8zVq3ZIqhspHdjTn0D5aqz6zoMuCfE8
         iFMw==
X-Gm-Message-State: AOAM531D+2IAgvyJyuAgtA2bKDw2QlRim+ohLJZw7hLxVx27aPGErxhL
        MLzJOj/g3/qZZT+JPB1ELa0=
X-Google-Smtp-Source: ABdhPJywvJvBG8K/pH/TB32oj8Wb9Zx5SLgjCuvw5NL08QMtDpkX72qoocsfu3ggRwCUPivhw60K4A==
X-Received: by 2002:a17:902:7294:b029:12d:2434:6d26 with SMTP id d20-20020a1709027294b029012d24346d26mr1359556pll.59.1629173903805;
        Mon, 16 Aug 2021 21:18:23 -0700 (PDT)
Received: from archl-on1.. ([103.51.72.143])
        by smtp.gmail.com with ESMTPSA id g11sm705676pfo.166.2021.08.16.21.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 21:18:23 -0700 (PDT)
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
Subject: [PATCHv3 5/6] phy: amlogic: meson8b-usb2: Power off the PHY by putting it into reset mode
Date:   Tue, 17 Aug 2021 09:45:39 +0530
Message-Id: <20210817041548.1276-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817041548.1276-1-linux.amoon@gmail.com>
References: <20210817041548.1276-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power off the PHY by putting it into reset mode.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2 - None
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 03c061dd5f0d..2aad45c55494 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -219,6 +219,10 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
 	clk_disable_unprepare(priv->clk_usb);
 	clk_disable_unprepare(priv->clk_usb_general);
 
+	/* power off the PHY by putting it into reset mode */
+	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET,
+			   REG_CTRL_POWER_ON_RESET);
+
 	return 0;
 }
 
-- 
2.32.0

