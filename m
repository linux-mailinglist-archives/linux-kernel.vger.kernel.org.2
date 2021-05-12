Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB2137B9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhELJ7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:59:49 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:42298 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230096AbhELJ7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:59:47 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 81F10A02C2;
        Wed, 12 May 2021 11:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1620813518;
        bh=SXlFiufzZxGFnc3q9XNjWC73WdXnlKAFExbpvizwEUE=;
        h=From:To:Cc:Subject:Date:From;
        b=Wm8/1cUPgEYqUoiK9ww8Kw04S6sdU04uciNAyAr0cIbymoMVvi1Cu/w9nTned1wJg
         uTgfAdkrFJhJr7AXt2nivoASOodTGIR2UyPoIZNu5kjO39L4+aIl/M8JOGrDocKXOi
         T6gLSwjhGbykrBx1RZsMO+kNDEZY19NMEn8Ne9Kw=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH RESEND] ARM: dts: imx6dl-yapp4: Use aliases to set custom MMC device indexes
Date:   Wed, 12 May 2021 11:58:30 +0200
Message-Id: <1620813510-31079-1-git-send-email-michal.vokac@ysoft.com>
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

