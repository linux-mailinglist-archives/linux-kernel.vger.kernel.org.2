Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D633C9616
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 04:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhGODAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 23:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232021AbhGOC7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 22:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626317822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwoHLx2eJfcqWlSuvHPH6Uv2QHfVsHItf+nTiFi6sqA=;
        b=dJchRx769L8qdXO09HDLroPqEQtfvvD/5km5YgYIrrMrSvBoiEYE+4s7g4QYihHfh2iceK
        CgfZNsqjBpl5KuHg3Z5z0AdYkFh6w39DSuMrCvD7KdIkJyJIQ2zDB8MJEB+C3RXCvDnJvD
        9SivLds2I5FGN5G92CnYlSgPM3tTaxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-MxUKuWkdNAaDGJFu6GEnjw-1; Wed, 14 Jul 2021 22:56:58 -0400
X-MC-Unique: MxUKuWkdNAaDGJFu6GEnjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89ABE1835AC3;
        Thu, 15 Jul 2021 02:56:57 +0000 (UTC)
Received: from dreyauc.ausil.us.com (ovpn-112-46.phx2.redhat.com [10.3.112.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E54B626E60;
        Thu, 15 Jul 2021 02:56:56 +0000 (UTC)
From:   Dennis Gilmore <dgilmore@redhat.com>
To:     linux-rockchip@lists.infradead.org
Cc:     dgilmore@redhat.com, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] arm64: dts: rockchip: helios64: add SPI support
Date:   Wed, 14 Jul 2021 21:56:30 -0500
Message-Id: <20210715025635.70452-3-dgilmore@redhat.com>
In-Reply-To: <20210715025635.70452-1-dgilmore@redhat.com>
References: <20210715025635.70452-1-dgilmore@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add SPI support for the helios64, u-boot can live in spi1, spi2 is user
accessible, spi5 is for the sata controller rom.
https://wiki.kobol.io/helios64/spi/

Signed-off-by: Dennis Gilmore <dgilmore@redhat.com>
---
 .../dts/rockchip/rk3399-kobol-helios64.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
index bdcf6472664c..09c5a6fa11ff 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts
@@ -21,6 +21,9 @@ / {
 	aliases {
 		mmc0 = &sdmmc;
 		mmc1 = &sdhci;
+		spi1 = &spi1;
+		spi2 = &spi2;
+		spi5 = &spi5;
 	};
 
 	avdd_0v9_s0: avdd-0v9-s0 {
@@ -473,6 +476,27 @@ &sdmmc {
 	status = "okay";
 };
 
+&spi1 {
+	status = "okay";
+
+	spiflash: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-max-frequency = <25000000>;
+		status = "okay";
+		m25p,fast-read;
+	};
+};
+
+/* UEXT connector */
+&spi2 {
+	status = "okay";
+};
+
+&spi5 {
+	status = "okay";
+};
+
 &tcphy1 {
 	/* phy for &usbdrd_dwc3_1 */
 	status = "okay";
-- 
2.31.1

