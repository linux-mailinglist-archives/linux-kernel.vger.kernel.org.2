Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE8733276D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhCINoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:44:02 -0500
Received: from comms.puri.sm ([159.203.221.185]:60048 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231140AbhCINno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:43:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 98A2DE0173;
        Tue,  9 Mar 2021 05:43:12 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 868Bg6DGNy5m; Tue,  9 Mar 2021 05:43:11 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     alice.guo@oss.nxp.com
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] arm64: dts: imx8mq: remove SoC ID compatible
Date:   Tue,  9 Mar 2021 14:42:51 +0100
Message-Id: <20210309134251.2583679-1-martin.kepplinger@puri.sm>
In-Reply-To: <20210104091544.13972-4-alice.guo@oss.nxp.com>
References: <20210104091544.13972-4-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this reverts commit ce58459d8c7f4174e7b8a8ea903dd949631334a3 for imx8mq.

this is most likely not the real fix but works around the problem I have
(with v5.12-rc2) I want to report:

[    0.766925] SoC revision 0x21
[    0.770286] imx8_soc_info soc@0: SoC revision via nvmem read failed: -517

This leads to the system not booting up.

This change makes use of the old way of reading soc_revision and thus
works around the problem.

What could be missing for the nvmem way to work here? Should it work
in any case? I assume so if you add the compatible to imx8mq.dtsi. But
if it would work, why keep the ocotp reads?

thanks a lot,
                             martin


---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index e1ca17fc1fa1..b40f7081e825 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -287,7 +287,7 @@ timer {
 	};
 
 	soc@0 {
-		compatible = "fsl,imx8mq-soc", "simple-bus";
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
-- 
2.30.1

