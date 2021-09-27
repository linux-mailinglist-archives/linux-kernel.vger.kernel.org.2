Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44CF41981B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhI0Pn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbhI0Pnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:43:49 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33C1C061740
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:42:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g8so70995967edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=juM+6gU0xK/tJnkRCnKH9JSf1NnqqHNF9Op7kOVux8s=;
        b=WlZihghXPzhGhYExfbANXkqk0WYAsLgrdQOqlzEdrljD7wOzF5t9x4pViv5d+sRrpi
         EjAmSafmRlDebwfnyeGUdjf1zBIwtqKI8hAO3a9v0E1sa4RJuxX0quwtiHIbyQqMZ7dM
         Lnx/lOXzmHV2djDQ5m/m0pPpyjCxTxlZuy/VP+ponlx1R3kC/tAZc2BTkRHn5WpSPYKn
         z+hlFOS13nzgfKCfhji4qNheFli5ncKrA2301X3XKkiRY8h32VFtVdSmIgdJOzzI09S4
         UnSSvwW3pD8Tuvtl0ooBdGvJ4r96BWWKGMZyXmL52gNzqDX1V+fbk8OPchX+BSLbE61Y
         ff0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=juM+6gU0xK/tJnkRCnKH9JSf1NnqqHNF9Op7kOVux8s=;
        b=P5tEXmPirdNGpkbZjJh0FgVsOrups49ULtAMrq7HubHWgakJ623svxLEEPLLtIseJA
         LAxTCWc9nnRyXHxEDCJINPEB63z1wVYCVHyJyaxPx+ddFaflSiE8G97mi/q11daDFL5L
         SZBCb3GtI6RsVInIB7Vf1k1yQ3SeniPA+Ejrf5RTAt4wkRE+4sITKRe3u03F73uA2/0X
         MDVbUgPVZkHXG3NWqJEpbxhakCVoHXojik9/7QBgQHnEIBPsffXLJw5soOzAnBLgMwbY
         JdUTQBUZ8qcvSavYGfrdJTnVzJZDA4N7YIv5IiaD3DYoIwouA95Zz4oGgrPnG6ALhaZj
         Ee6g==
X-Gm-Message-State: AOAM5316xNA+/2nhNefM8aHbH79Maz74JKAZoYe0icLXBKSPbzpnu+PH
        wYuEgfaVWsZgk+xWVp7kmceo2g==
X-Google-Smtp-Source: ABdhPJxwalP72BgLvd/32aQZy4mLoHFqGDu6v6C6pm4gn9aAcY5K5VhlaO5E3luQJuJFu47zQHG7Cg==
X-Received: by 2002:a17:906:169a:: with SMTP id s26mr465518ejd.278.1632757329473;
        Mon, 27 Sep 2021 08:42:09 -0700 (PDT)
Received: from fedora.. (dh207-96-123.xnet.hr. [88.207.96.123])
        by smtp.googlemail.com with ESMTPSA id n16sm10768025edd.10.2021.09.27.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 08:42:09 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/4] arm64: dts: marvell: espressobin-ultra: add PHY and switch reset pins
Date:   Mon, 27 Sep 2021 17:41:58 +0200
Message-Id: <20210927154159.2168500-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927154159.2168500-1-robert.marko@sartura.hr>
References: <20210927154159.2168500-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the Topaz switch and 88E1512 PHY have their reset and interrupts
connected to the SoC.

So, define the Topaz and 88E1512 reset pins in the DTS.

Defining the interrupt pins wont work as both the 88E1512 and the
Topaz switch uses active LOW IRQ signals but the A37xx GPIO controller
only supports edge triggers.
88E1512 would require special setup anyway as its INT pin is shared with
the LED2 and you first need to configure it as INT.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index 8a700afd0570..96855a10b4a0 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -118,12 +118,16 @@ &usb3 {
 &mdio {
 	extphy: ethernet-phy@1 {
 		reg = <1>;
+
+		reset-gpios = <&gpionb 2 GPIO_ACTIVE_LOW>;
 	};
 };
 
 &switch0 {
 	reg = <3>;
 
+	reset-gpios = <&gpiosb 23 GPIO_ACTIVE_LOW>;
+
 	ports {
 		switch0port1: port@1 {
 			reg = <1>;
-- 
2.31.1

