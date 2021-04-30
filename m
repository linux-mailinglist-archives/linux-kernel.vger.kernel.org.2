Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B9336FBCB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 15:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhD3NzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 09:55:13 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:43282 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhD3NzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 09:55:12 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 929BDA4CC5;
        Fri, 30 Apr 2021 15:54:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1619790861;
        bh=SXlFiufzZxGFnc3q9XNjWC73WdXnlKAFExbpvizwEUE=;
        h=From:To:Cc:Subject:Date:From;
        b=YCqxA0BRAMBg30HlA/T2Qi8/BMfbSQD7HLybpu8gaPcPKbJYCqXzjQpX0SE8Qynii
         uuQm7W1ayT8yBmX01jgmBCWgB/hACjekrwTFzddv0EpMOdwLClwo3cvEP4ESTuHjyE
         fuq0Nz9MaW9bG+mh2vdnyVmDNitL9yLwx6FqUm0k=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH] ARM: dts: imx6dl-yapp4: Use aliases to set custom MMC device indexes
Date:   Fri, 30 Apr 2021 15:53:15 +0200
Message-Id: <1619790795-8375-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until commit fa2d0aa96941 ("mmc: core: Allow setting slot index via
device tree alias") was introduced, our usdhc3 and usdhc4 devices
were enumerated as mmc0 and mmc1. The mmc1 device is used to boot/update
the board and its name must be fixed.

With the referenced commit, aliases from imx6qdl.dtsi took effect.
Override the aliases to get back the original device indexes.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 686dab57a1e4..ff8d335ee482 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -11,6 +11,8 @@
 	aliases: aliases {
 		ethernet1 = &eth1;
 		ethernet2 = &eth2;
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc4;
 	};
 
 	backlight: backlight {
-- 
2.1.4

