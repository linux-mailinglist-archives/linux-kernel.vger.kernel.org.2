Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D693209B1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 12:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBULH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 06:07:59 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:59804 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhBULH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 06:07:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 872EAFB0A;
        Sun, 21 Feb 2021 12:07:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DF_wmRXuiGUH; Sun, 21 Feb 2021 12:07:12 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 99808403CD; Sun, 21 Feb 2021 12:07:11 +0100 (CET)
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
Subject: [PATCH v1 0/6] arm64: dts: librem5-devkit: Improve audio support
Date:   Sun, 21 Feb 2021 12:07:05 +0100
Message-Id: <cover.1613905396.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far only headphone output worked. Thesse patches add support for the
built in speaker and mic, allow a headset microphone to work and wire up jack
detection so audio output can switch to headphones automatically.  They also
adjust the card name to match the board not the codec, similar what's done for
the Librem 5.

Patches are against next-20210210 but also apply against Shawn's imx-dt64-5.12

Guido Günther (6):
  arm64: dts: librem5-devkit: Use a less generic codec name
  arm64: dts: librem5-devkit: Add speaker amplifier
  arm64: dts: librem5-devkit: "Drop Line In Jack"
  arm64: defconfig: Enable asoc simple mux
  arm64: dts: librem5-devkit: Add mux for built-in vs headset mic
  arm64: dts: librem5-devkit: Move headphone detection to sound card

 .../dts/freescale/imx8mq-librem5-devkit.dts   | 69 ++++++++++++++-----
 arch/arm64/configs/defconfig                  |  1 +
 2 files changed, 52 insertions(+), 18 deletions(-)

-- 
2.30.0

