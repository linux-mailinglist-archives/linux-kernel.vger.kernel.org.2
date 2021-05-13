Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AA93800D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 01:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhEMXaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 19:30:06 -0400
Received: from mail.manjaro.org ([176.9.38.148]:44514 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230240AbhEMXaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 19:30:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 58AB1222543;
        Fri, 14 May 2021 01:28:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lOs_WYWHEGdx; Fri, 14 May 2021 01:28:52 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 0/7] Add missing peripherals to Allwinner V3s/V3 device trees
Date:   Fri, 14 May 2021 01:30:17 +0200
Message-Id: <20210513233024.2076725-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V3s/V3 SoCs feature quite a few peripherals that have good
driver support but yet are nowhere to be found in the SoCs dts.
This patchset adds the DMA controller, the relevant DMA properties for all
peripherals supporting DMA, the integrated analog codec and - for the
Allwinner V3 SoC - also the I2S interface.
I've included all of those changes in one patchset since they do all
depend on addition of the DMA controller.
All changes have been tested in a recent project of mine using a Sochip S3
(a rebranded Allwinner V3) and are confirmed working.

This is v2 of this patchset.

Cheers,
Tobias

Changelog:
  v2:
    - add v3/v3s specific compatible strings
    - fix v3s audio codec analog frontend compatible
    - fix an I2S -> I2C typo

Tobias Schramm (7):
  ARM: dts: sun8i: v3s: add DMA controller to v3s dts
  ARM: dts: sun8i: v3s: add DMA properties to peripherals supporting DMA
  ARM: dts: sun8i: v3s: add analog codec and frontend to v3s dts
  ASoC: dt-bindings: sun8i-a23-codec-analog: add compatible for
    Allwinner V3
  ARM: dts: sun8i: V3: add codec analog frontend to V3 dts
  dt-bindings: sound: sun4i-i2s: add Allwinner V3 I2S compatible
  ARM: dts: sun8i: V3: add I2S interface to V3 dts

 .../sound/allwinner,sun4i-a10-i2s.yaml        |  3 ++
 .../allwinner,sun8i-a23-codec-analog.yaml     |  9 +++--
 arch/arm/boot/dts/sun8i-v3.dtsi               | 31 +++++++++++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi              | 39 +++++++++++++++++++
 4 files changed, 79 insertions(+), 3 deletions(-)

-- 
2.31.1

