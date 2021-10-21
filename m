Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B778435ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhJUKRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:17:34 -0400
Received: from us-smtp-delivery-115.mimecast.com ([170.10.133.115]:24960 "EHLO
        us-smtp-delivery-115.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhJUKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1634811316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=T79PPExOFExhuv89FI2N6LAuJL4VnKlSYS+EFmTsl54=;
        b=NINBnu+2Hs62yTBm85noRCOYMkTM7FH8uDOuGLTol1uLwl6Sl02VqkzNHQytjZhlVy8JU2
        Zzc+cGIuYAJE6EU3abWNb4FkDhRhWujRMyAIDimrPXEDTlQeAkEzlxsswSbUweijXMzdCT
        nCF17mgY3w4edwr+HZ7N3iDlGCcRw2c=
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-y8qf9GqpMCmy1bKFRPTsqQ-1; Thu, 21 Oct 2021 06:15:15 -0400
X-MC-Unique: y8qf9GqpMCmy1bKFRPTsqQ-1
Received: from sgsxdev005.isng.phoenix.local (10.226.81.173) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2242.4;
 Thu, 21 Oct 2021 03:15:13 -0700
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-lgm-soc@maxlinear.com>, Rahul Tanwar <rtanwar@maxlinear.com>
Subject: [PATCH] MAINTAINERS: Add LGM SoC support
Date:   Thu, 21 Oct 2021 18:15:10 +0800
Message-ID: <20211021101510.3141-1-rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA115A51 smtp.mailfrom=rtanwar@maxlinear.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for Maxlinear x86 based LGM SoC support.

Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 MAINTAINERS | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d118d7957d2..ef08adb88e19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11437,6 +11437,28 @@ L:=09netdev@vger.kernel.org
 S:=09Supported
 F:=09drivers/net/phy/mxl-gpy.c
=20
+MAXLINEAR LGM SoC support
+M:=09Rahul Tanwar <rtanwar@maxlinear.com>
+M:=09linux-lgm-soc@maxlinear.com
+S:=09Supported
+F:=09drivers/clk/x86/clk-cgu.c
+F:=09drivers/clk/x86/clk-cgu-pll.c
+F:=09drivers/clk/x86/clk-lgm.c
+F:=09drivers/reset/reset-intel-gw.c
+F:=09drivers/tty/serial/lantiq.c
+F:=09drivers/pinctrl/pinctrl-equilibrium.c
+F:=09drivers/pci/controller/dwc/pcie-intel-gw.c
+F:=09drivers/leds/blink/leds-lgm-sso.c
+F:=09drivers/spi/spi-lantiq-ssc.c
+F:=09drivers/phy/intel/phy-intel-lgm-emmc.c
+F:=09drivers/mtd/nand/raw/ntel-nand-controller.c
+F:=09drivers/phy/phy-lgm-usb.c
+F:=09drivers/pwm/pwm-intel-lgm.c
+F:=09drivers/hwmon/mr75203.c
+F:=09drivers/dma/lgm/lgm-dma.c
+F:=09drivers/phy/intel/phy-intel-lgm-combo.c
+K:=09lgm
+
 MCBA MICROCHIP CAN BUS ANALYZER TOOL DRIVER
 R:=09Yasushi SHOJI <yashi@spacecubics.com>
 L:=09linux-can@vger.kernel.org
--=20
2.17.1

