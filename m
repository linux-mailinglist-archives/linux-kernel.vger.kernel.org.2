Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FF741C3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 13:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343580AbhI2L4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 07:56:41 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:35353 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343528AbhI2L4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 07:56:13 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 87F68C85;
        Wed, 29 Sep 2021 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1632916470;
        bh=8ZmLBz7D/sbq84QJ7vQOxYGraYtGThjNvOcKVo+RF4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZgRjbpv0EC0S8V6wVnuUrHB5EN8Kfa4AFQZWHAkb5f5F/Xz8UtB18GhLfgYS1rh5
         w0H9GjeVe/tPLZ/i1gucxKd3zp6DisjwE002E7lZNvgCjWkrnzKMf8dMiujx8cku4x
         4YQOmo/egYbTKBldqdgY4iIZn/42OhmBn8z6w7dU=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Zev Weiss <zev@bewilderbeest.net>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ARM: dts: aspeed: Add e3c246d4i BIOS flash device
Date:   Wed, 29 Sep 2021 04:54:08 -0700
Message-Id: <20210929115409.21254-7-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929115409.21254-1-zev@bewilderbeest.net>
References: <20210929115409.21254-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
index 9b4cf5ebe6d5..456f4de53869 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
@@ -68,6 +68,22 @@ flash@0 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		/*
+		 * The BIOS SPI flash is shared with the host via an
+		 * external mux, and is not accessible by the BMC by
+		 * default (hence "reserved" rather than "okay").
+		 */
+		status = "reserved";
+		label = "bios";
+		m25p,fast-read;
+	};
+};
+
 &uart5 {
 	status = "okay";
 };
-- 
2.33.0

