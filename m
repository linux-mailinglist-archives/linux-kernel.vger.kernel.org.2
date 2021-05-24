Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF6438E67F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhEXMX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhEXMXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:23:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF67C06138A;
        Mon, 24 May 2021 05:21:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y7so14180956eda.2;
        Mon, 24 May 2021 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Ov5aERG07Ts3FrXLC0fuMlLQp2c5+k78EH70ZT9IfI=;
        b=QNCqhzpSzwWan15QuoG+UMxhffwMGdIZJAg9WC+woW88b7DdiLXPb/oXXo1SjZXaZ9
         CQ6CaR8h0lYcDdDDgZQf87j8eiEBgs12LXqryp3D8UqpDiMiwPxp1UCuyAeLwO3uCFoM
         eil6L4G1TBjxu+Ch5rwKfHBwTx26z26od6wiv3AXuAo9tht4uw3/615bev06hsvXwBK6
         WM61YT3OcJEy3SOQs3aw9+pFmvA8wvhMSZIvMTy0dDw4h4PkxkvtzdpNYjeSnGwmval7
         YrilT5MMn1/OY5g+Y4jOO8HF7gpf4Kn1tqPJ4xN5/h3aPUjr+y6F4SS5dJGahVgc1ZAB
         SVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=6Ov5aERG07Ts3FrXLC0fuMlLQp2c5+k78EH70ZT9IfI=;
        b=VQuAQVjZWtBohiOznRg1ZSriOTaQI8McOHNduA5krz8cFfOgfWOO8b5Ezr1f2plcKw
         LpiUfGouZeWDFQzwmHcooDBn1z7vRweL603mAapmLPzZk8kFte4qTwPcwXfR5sJ1s1zo
         V75JbJDhM9ltqaJGTnf+Fp3CwWgHaIgmnEPyr7nMWwH8RXLlZHQNMKbHUDyXiPl9nV0g
         QYouCZM8y1K0fCoFDq36Mi2jjAdnFyx5XDDmi0G391MUcgXduTY/pCWauRJ9wXcqt9mp
         vCndP3vv6Vc5syDMn/ug4DsgKIH5q7GNP/kwGb19fNKIsO5BrxjAjdjbKo/otiptTaPA
         IyQA==
X-Gm-Message-State: AOAM531xt2+fxVq3iHT/Dq1U5SHEvhuIQj9fHlLIcEh6L2kNGUlN3SBy
        UNi5TKTUjEqQKKqzy53aBYY=
X-Google-Smtp-Source: ABdhPJzTOUMPwEq8y/9jEUJ/pcbOGuoV2r1N1uEHI5veHOSfqkKvXEJFgpMvVc4R4glxwRd119I6Ig==
X-Received: by 2002:a05:6402:128d:: with SMTP id w13mr25184101edv.253.1621858908430;
        Mon, 24 May 2021 05:21:48 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id x9sm8213143eje.64.2021.05.24.05.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 05:21:47 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>
Cc:     Vagrant Cascadian <vagrant@reproducible-builds.org>,
        "B.R. Oake" <broake@mailfence.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix ethernet phy-mode
Date:   Mon, 24 May 2021 14:21:11 +0200
Message-Id: <20210524122111.416885-1-carnil@debian.org>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
config") sets the RX/TX delay according to the phy-mode property in the
device tree. For the Orange Pi Plus board this is "rgmii", which is the
wrong setting.

Following the example of a900cac3750b ("ARM: dts: sun7i: a20: bananapro:
Fix ethernet phy-mode") the phy-mode is changed to "rgmii-id" which gets
the Ethernet working again on this board.

Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
Reported-by: "B.R. Oake" <broake@mailfence.com>
Reported-by: Vagrant Cascadian <vagrant@reproducible-builds.org>
Link: https://bugs.debian.org/988574
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---

v2:
 - Add a Reported-by for "B.R. Oake" <broake@mailfence.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
index 97f497854e05..d05fa679dcd3 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
@@ -85,7 +85,7 @@ &emac {
 	pinctrl-0 = <&emac_rgmii_pins>;
 	phy-supply = <&reg_gmac_3v3>;
 	phy-handle = <&ext_rgmii_phy>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 
 	status = "okay";
 };
-- 
2.32.0.rc0

