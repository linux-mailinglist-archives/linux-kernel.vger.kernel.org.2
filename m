Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1685359670
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhDIHdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhDIHdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:33:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D204061107;
        Fri,  9 Apr 2021 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617953583;
        bh=GpkQILVYiC09Ip8zqjS9RHquSeBdjqJpZ9Hi15ftwNE=;
        h=From:To:Cc:Subject:Date:From;
        b=GVPF5apRWN7oCDiWFjYyPFko6zdr6xX3XK4rwUFd7YAXRiRSqhVsD4GL8nFXfgkW4
         ainwWuVLMHbzoEzSeYaF2px6m04oJByx5Y5vv9BsBg6cpGj4ZCqnIlPnNAbBTSaZ8U
         45oCgCR8JqQlg36a4aDD3UvTwIzBYGmmNksUVm12nBgSKDuKEl80Pkq32fJa5Zwmcb
         jxVgvR/pjJ6/Ba9i+F53/9L3dC819d4iGfLKSmYyGLyhx1YeDcWk0aJRK4aTrALSp4
         uzj9vogYIqRJbwXynEO2EDTR6iRAqBOdzw0hNtla4bjV3YUkXhtY45+IZNxjLUd9Wd
         E4BarMzVM+NbQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: mvebu: fix SPI device node
Date:   Fri,  9 Apr 2021 09:32:26 +0200
Message-Id: <20210409073252.1764731-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

dtc warns about a mismatched address:

arch/arm/boot/dts/armada-385-atl-x530.dts:171.14-199.4: Warning (spi_bus_reg): /soc/spi@10680/spi-flash@0: SPI bus unit address format error, expected "1"

I assume the "reg" property is correct here, so adjust the unit address
accordingly.

Fixes: c6dfc019c239 ("ARM: dts: mvebu: Add device tree for ATL-x530 Board")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernelci.org bot <bot@kernelci.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I applied this fixup to the arm/dt branch on top of the new file, this
will be part of linux-next and the v5.13 pull request

 arch/arm/boot/dts/armada-385-atl-x530.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-385-atl-x530.dts b/arch/arm/boot/dts/armada-385-atl-x530.dts
index 2041bf09c578..ed3f41c7df71 100644
--- a/arch/arm/boot/dts/armada-385-atl-x530.dts
+++ b/arch/arm/boot/dts/armada-385-atl-x530.dts
@@ -168,7 +168,7 @@ &spi1 {
 	pinctrl-0 = <&spi1_pins>;
 	status = "okay";
 
-	spi-flash@0 {
+	spi-flash@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
-- 
2.29.2

