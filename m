Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D670F45FF30
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 15:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355312AbhK0OZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 09:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351282AbhK0OXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 09:23:07 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF75FC061748;
        Sat, 27 Nov 2021 06:19:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so25222872wrr.8;
        Sat, 27 Nov 2021 06:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knysJR+0JkKxgB5c3JruXDvwT5X6G8sbeHcN6EJjwiQ=;
        b=NiPoYtZV57Fy+h78veSroMO24JY2nzGLUScsxAmzDp0Ewz3CDHc9C3SL0fOYCYrSjg
         KDOIp5ClznO7sFYdjwvb1GEu4o6+SDLIMpFOrX2jj66i4O3IoBahln/hltkJoJII7PA9
         uDOBOdf+ryDecKQ8rSEtiuUTmOM4XxBCYsezG+Xx0SvOQ9YxdWdUnvIpZGOGFyf2Od7Q
         ULsZIKk8LkwtZf2Us0kbUz34PSuWuuuTHYSNTzvYzWV0vyCTvN9vG1H/sXaXD+E7WjWt
         0ixra8ROuw6HFC9DVtlEQICUT2/mgrm+PNwbYpkEsdy7lDf7KwPaZtuPGG5qvr4fItHZ
         mr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knysJR+0JkKxgB5c3JruXDvwT5X6G8sbeHcN6EJjwiQ=;
        b=Yv89CuXtSI4aihbatbMKKw6A1D0sPy7gz47zDjx7LOgtWcg3L+9zMMpzWfcjTGEUHT
         kNOPYjvSi3bJRkChdgqEp1TZ+joeIoh8J9sS8T+/bB3iESG2dmME6Qf2JSURaypkMDEO
         3+zfIgF7Ut+9pKo5eYB+pABt6BgvzrSCTwOvN4AtS/HaGnIGe4bbnYvjCHgkRjfO1O41
         8r275wTAfWamK0uAgR3CINnsjvldvsuruwFJhY7+nVMnXmgtzsLy56exuXyiLBsHKBMn
         42iwthb38lERJPSPbAhirQMP4GsZZn9wUjXuDRKWToMi5Ghnv8cmVlNVIN7UHOvxfpQm
         i62Q==
X-Gm-Message-State: AOAM533UNp+GR743e+shf7BBOLkVlRJKLw8FynA3oCCNWUm+OlS9yBSE
        jVsl3twZHfsGctlBLPAG5IY=
X-Google-Smtp-Source: ABdhPJzeu70tA+QgGcaCcxlfFdluQ7ubejp4mO+3n9hXLlYxhGmQTgjMvG7RsgUn/7LsvXkiMY08OA==
X-Received: by 2002:adf:9bc4:: with SMTP id e4mr21076296wrc.476.1638022791496;
        Sat, 27 Nov 2021 06:19:51 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o1sm8509839wrn.63.2021.11.27.06.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 06:19:51 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Add spi1 pins on Quartz64 A
Date:   Sat, 27 Nov 2021 15:19:09 +0100
Message-Id: <20211127141910.12649-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211127141910.12649-1-frattaroli.nicolas@gmail.com>
References: <20211127141910.12649-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Quartz64 Model A has the SPI pins broken out on its pin
header. The actual pins being used though are not the m0
variant, but the m1 variant, which also lacks the cs1 pin.

This commit overrides pinctrl-0 accordingly for this board.

spi1 is intentionally left disabled, as anyone wishing to add
SPI devices needs to edit the dts anyway, and the pins are more
useful as GPIOs for the rest of the users.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 4d4b2a301b1a..166399b7f13f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -509,6 +509,11 @@ &spdif {
 	status = "okay";
 };
 
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1m1_cs0 &spi1m1_pins>;
+};
+
 &tsadc {
 	/* tshut mode 0:CRU 1:GPIO */
 	rockchip,hw-tshut-mode = <1>;
-- 
2.34.1

