Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2FD3CB62F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhGPKlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbhGPKlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:41:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FBDC06175F;
        Fri, 16 Jul 2021 03:38:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b12so8580231pfv.6;
        Fri, 16 Jul 2021 03:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijibuOn1o/zyXxVK7//BA8fe5lpTivScoHePVnxddFU=;
        b=Qf9SOx6QD4X/slJCbBN3lWyDjpm8rnJYlFnSC/XJk+r2LL92hc6zo+WOtnP91fFVP9
         tBS4WjcJvji4dkub0v6NU6k/wBh9Cz1PvNCFuH0oHzKURPH9YDtjlVPtskhmeYbMTej1
         WuohWqOG/YtBzDZ3TZqFHj7G8FRZ23T682i3tQ3v1OCnl/E2ttkFVxvaipcM16pADatb
         dvdawIST8n+R8jieSnYb0y9oCqZUgwthwXXuEQnnF9nKqtfeSWdihPHE815Dfmrn8Pnv
         noafRwT/Ncmk3Ct4XeXxNL+ONmErwWKEEqs4a/TxDBib2LoSjDIWnCG4pRXMRbPWJVFU
         QDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ijibuOn1o/zyXxVK7//BA8fe5lpTivScoHePVnxddFU=;
        b=soAC5wqo70dtM+nNzmelH9fw/ZtwObsY0zjtFEUTilT+S11j98MaLK+xkMpf3unyYd
         jua8t6qEpzdV2eGLYgBUO3xbTKhJAm2g3rdQioTa/lTnu/+9/0s/xjy9GQFUKg2SR77c
         ZXkODjzyRbfew2deBH7TekyHCwyC+682qd5QwpjqDtAbfOIs1DvcSyosOpip1wHyRq/9
         7xx4H+zKBb4W4k0vYBt0fmExJQrRAQLa9osGI3+hN0Du1ytDU7oosUON7XlRPUR0mlQv
         zNqBMb/Ws3kCvQ8IY5sfIjEJOqamu86/Vgcvu7gndR2EjLlLjaatENRj1QMe5TPEiA6S
         Nz9Q==
X-Gm-Message-State: AOAM533z+/BXjsL/x+Qj2KSUqB0G4fIJFcv09soVEIwWTl/Ohwp22JXL
        bLC9KTGB8RKux++fv/rTuVs=
X-Google-Smtp-Source: ABdhPJwzFIVx2DLzzS7/EOrIoZqSrUxxZHYoV9gOL39E9P3TfTI27j0dDyl6BT242VupYDs0781MUQ==
X-Received: by 2002:a05:6a00:7d7:b029:32c:b12a:d65d with SMTP id n23-20020a056a0007d7b029032cb12ad65dmr9602132pfu.44.1626431902028;
        Fri, 16 Jul 2021 03:38:22 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id d29sm10070111pfq.193.2021.07.16.03.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:38:21 -0700 (PDT)
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
Subject: [PATCHv2 3/4] phy: amlogic: meson8b-usb2: Power off the PHY by putting it into reset mode
Date:   Fri, 16 Jul 2021 10:36:35 +0000
Message-Id: <20210716103651.1455-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716103651.1455-1-linux.amoon@gmail.com>
References: <20210716103651.1455-1-linux.amoon@gmail.com>
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
None: Added Martin's Ack
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

