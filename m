Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A858D3C69F4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 07:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhGMF4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 01:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbhGMF4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 01:56:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D457C0613DD;
        Mon, 12 Jul 2021 22:53:20 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 17so18577593pfz.4;
        Mon, 12 Jul 2021 22:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Apgi9n+xzAXbVBKSBVdWWRXmCTfXVngS5mFHrsICTMs=;
        b=B3ioeD3woNIR4eb4hYTJ1NhFODGfBWkLQ9pbW53Ntmb0NMuamJ68xfCoZup2ihwriq
         wDTdzx1v3MTl+aAOIs/ekQHiM/aKejL/nxL3x8BJdgipqgLE3wFo2YPg7ldQwfZea4Bh
         3dsNR7dD8JwY6QQ2KB7P8/RzBAAwf8aHWGHO0/clNBOfbGfL4AmVcKQUN807hxODN6gB
         EUucJO5xCUoV6wfDQ4zA+io413074TdWGFJDSU724W7lXds6Wxjq1TlPvEoMA/3pYU+w
         XDDAiUfnXdayzbwwUm8THqEOFh/pkzRqJDOxCfHAdJwf3vkbSZKByKaTbKEVRNfUWDO6
         ny8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Apgi9n+xzAXbVBKSBVdWWRXmCTfXVngS5mFHrsICTMs=;
        b=nbYqxHWzfJCpBEb9TRhy0tGi66DtnM+PHKJPIwjONLM2SZ9JuqW+NoLfPDfersmLPI
         Gf/TMcZ/R5p2QSSi11xdnVQoDN9XmLY/py8gEV/X+bRPDNJJKuR+nZk5vFGHh5Dr7PuD
         a0WrqsxE0r/JKAN+Wo9Vs789FxeI4t3+KgW6r/uEOlsyyzWKZsDEc6uuGXQ2ZkGV5rAu
         3iQMHJPNQif23jqPmpH7lU31AV7cmeqmo3chn4bNQkoN00pesQoHFykGEhPQMaAmcAre
         rZQ6QIjcNE0igYaFGNovhVUCNsdSVMSx3cdVOz0gLRcojjkk90B+x+CQueC9f9bXc9uW
         E6aQ==
X-Gm-Message-State: AOAM533e/MBxrOGJdPGcp1koi3hF+J7pFNsH23/4zYv9dsyT2hlpIkz0
        YWy/VaTvdKv25fHzgGs1y8I=
X-Google-Smtp-Source: ABdhPJzxR8bJEgTzU8kGrjBoNAgSB6f2OziGqch2oqIf2DEC659r67p0cjibkB2R9Nn/dIX5P6vx4A==
X-Received: by 2002:a63:e205:: with SMTP id q5mr2716251pgh.404.1626155599825;
        Mon, 12 Jul 2021 22:53:19 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.31])
        by smtp.gmail.com with ESMTPSA id x19sm17755198pfa.104.2021.07.12.22.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 22:53:19 -0700 (PDT)
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
Subject: [PATCHv1 2/3] phy: amlogic: meson8b-usb2: Power off the PHY by putting it into reset mode
Date:   Tue, 13 Jul 2021 05:52:14 +0000
Message-Id: <20210713055227.1142-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713055227.1142-1-linux.amoon@gmail.com>
References: <20210713055227.1142-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power off the PHY by putting it into reset mode.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Fix the commit message.
rfc - Keep vendor driver sequence for the power on reset of usb phy
[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20210617194154.2397-8-linux.amoon@gmail.com/
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

