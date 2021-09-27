Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E1D419817
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbhI0Pns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbhI0Pnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:43:47 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AA3C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:42:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g8so70995661edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DY/GmGaqz/rCfMf23PGAAwS1kDGVOXaK9ZQdbNkhJ9I=;
        b=tVAk1UX6y7j6CLVnqGS9ZfZ5CoyNDYUKVPoK6lKbjBG90Dh0Ogpx/Mc8VYGYCPRsEI
         QZzl50/SoKawPQi1Fe3r2kqVT8KlZh9se7tB5skDeyyuV0YHbxWwbTSCKzptYDjovkUO
         RzNl584+43EbwF/UVn7gfyisFe6B2d9MGhWgGyajiMPeG1tNRcxbgPRoXQrh4qTTPf+Z
         /PTtR6YXLnTJXiyPMI288JCVCUdmR7SEYmec/sJAHZd9m/cBFHTueSaAEz1f0xmRzIck
         9II7OtgUmZBtWnqRUaLvytHSsRQn0P4J0/EPI0kX/NKAB1xHq9aFd1CsQh0JQxrRRnx6
         blFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DY/GmGaqz/rCfMf23PGAAwS1kDGVOXaK9ZQdbNkhJ9I=;
        b=l4MD8x7fVnbHWn3ZMuTxrPL7v19qgAhvX/7yyefYzjO8BK/onTu72upBcZFH5CLlc8
         Q02vhnuvRHMxXlHoqRmw8EqrBEZicwqxAxtmFA7QYGr7TF6DId78ZDnrmzNfd+qALonj
         QtNgsmco7Sxg35c/aK/4LwCj9HSYEx1Fvh/EHCu6Eap9H+Hk/6jvbwiYiI252vShWbwo
         brhbQ657tZnRnKdfxhxBtOza9JB0IP/UFeuFKK//nILZRZl/Mc12dTOZJSkrfYOuVCDX
         UwW39hpUtLbhS5k0qIBmXfrDJLdMAUZS+cpPMiaovMBRiKgYUtnMNcl2U3AP1bC4tx2c
         j2sQ==
X-Gm-Message-State: AOAM5306vxOY/URg8r8JuFIrOonuS5fm33+xzVHKCKtVVVEBvPMQv0a7
        Mw/hCxKrJBvTpBWujVIoakfLPQ==
X-Google-Smtp-Source: ABdhPJwAz8M4OC9h2WTa9xCq09uU2B3zaJStXA/7xbNmtT0jg/Q5EBNaHrSS+QQQgzw2LV4Gtr6AQg==
X-Received: by 2002:a50:becf:: with SMTP id e15mr667933edk.114.1632757327992;
        Mon, 27 Sep 2021 08:42:07 -0700 (PDT)
Received: from fedora.. (dh207-96-123.xnet.hr. [88.207.96.123])
        by smtp.googlemail.com with ESMTPSA id n16sm10768025edd.10.2021.09.27.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 08:42:07 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/4] arm64: dts: marvell: espressobin-ultra: fix SPI-NOR config
Date:   Mon, 27 Sep 2021 17:41:57 +0200
Message-Id: <20210927154159.2168500-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927154159.2168500-1-robert.marko@sartura.hr>
References: <20210927154159.2168500-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI config for the SPI-NOR is incorrect and completely breaking
reading/writing to the onboard SPI-NOR.

SPI-NOR is connected in the single(x1) IO mode and not in the quad
(x4) mode.
Also, there is no need to override the max frequency from the DTSI
as the mx25u3235f that is used supports 104Mhz.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index c1770ceff3c1..8a700afd0570 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -75,10 +75,6 @@ &sdhci1 {
 
 &spi0 {
 	flash@0 {
-		spi-max-frequency = <108000000>;
-		spi-rx-bus-width = <4>;
-		spi-tx-bus-width = <4>;
-
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
-- 
2.31.1

