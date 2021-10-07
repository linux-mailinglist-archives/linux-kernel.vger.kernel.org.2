Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4427F424AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbhJGAMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:12:33 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:46001 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbhJGAMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:12:14 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 8A47BC9D;
        Wed,  6 Oct 2021 17:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633565413;
        bh=XbnBokbU4ntbWci1KrAbGbAkUYozeIlG0GRIL9z3qXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EitWl8QleIUt2OPZiPMJHveL8FiAN7YvAna53lj/V5pHG85jwRgWKeB0Wul/1oG+R
         UK2CqTSLh+QHrGhAwU8tWk6lV+2b9ykqCNlrtjz/Q2VlW7CkoV2BXGK1Yns/FebXek
         MK4ZnWkn9bRJ0AIs3j9nJ8x5SEtyaU6WmkO0dO+U=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] ARM: dts: aspeed: Add e3c246d4i BIOS flash device
Date:   Wed,  6 Oct 2021 17:09:54 -0700
Message-Id: <20211007000954.30621-10-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This uses a dynamic DT node because the BIOS SPI flash requires
significant coordination with the host system (power state tracking,
GPIOs, IPMI messages) before the BMC can touch it, and needs to be
relinquished back to the host when the BMC is done accessing it.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
index 9b4cf5ebe6d5..428198703824 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts
@@ -68,6 +68,29 @@ flash@0 {
 	};
 };
 
+&spi1 {
+	/*
+	 * The BIOS SPI flash is shared with the host via an external mux, and
+	 * is not accessible by the BMC by default (hence reserved/dynamic
+	 * here rather than okay).  This would ideally be done on the flash@0
+	 * node instead of the spi1 controller, but the driver infrastructure
+	 * to support dynamic devices at that level of the device tree isn't
+	 * currently in place, and it's the only flash chip on this
+	 * controller, so we can get away with the coarser granularity here
+	 * until support for making individual flash chips dynamic is
+	 * available.
+	 */
+	status = "reserved";
+	dynamic;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
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

