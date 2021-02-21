Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D9F3209B4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 12:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBULIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 06:08:11 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:59894 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229921AbhBULIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 06:08:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 4454AFB05;
        Sun, 21 Feb 2021 12:07:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KTp4EHo6F5rE; Sun, 21 Feb 2021 12:07:16 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id C0D19403FB; Sun, 21 Feb 2021 12:07:11 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Max Krummenacher <max.oss.09@gmail.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] arm64: dts: librem5-devkit: "Drop Line In Jack"
Date:   Sun, 21 Feb 2021 12:07:08 +0100
Message-Id: <2a64c0083f2024d14e08d1351f8a14888a549160.1613905397.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613905396.git.agx@sigxcpu.org>
References: <cover.1613905396.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SGTL500s LINEINL and LINEINR are N/C.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index d01bed5eb9e0..aac05bbaa001 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -171,12 +171,10 @@ sound {
 		simple-audio-card,widgets =
 			"Microphone", "Microphone Jack",
 			"Headphone", "Headphone Jack",
-			"Speaker", "Builtin Speaker",
-			"Line", "Line In Jack";
+			"Speaker", "Builtin Speaker";
 		simple-audio-card,routing =
 			"MIC_IN", "Microphone Jack",
 			"Microphone Jack", "Mic Bias",
-			"LINE_IN", "Line In Jack",
 			"Headphone Jack", "HP_OUT",
 			"Builtin Speaker", "Speaker Amp OUTR",
 			"Speaker Amp INR", "LINE_OUT";
-- 
2.30.0

