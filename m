Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7413145980B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 23:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhKVXBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:01:17 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:60244 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhKVXBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:01:16 -0500
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id EEC96261B41;
        Mon, 22 Nov 2021 23:58:07 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Add DTs for all Apple M1 (t8103) devices
Date:   Mon, 22 Nov 2021 23:58:03 +0100
Message-Id: <20211122225807.8105-1-j@jannau.net>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej All,

this series extends the device tree files and bindings to all current
Apple M1 devices. Specifically it adds DTs for following devices:
- MacBook Air (M1, 2020)
- Macbook Pro (13-inch, M1, 2020)
- iMac (24-inch, M1, 2021)

It also adds i2c and cd321x devices nodes. Bindings and code changes for
those were merged for 5.16 without adding devices to the device tree.
Patches are include in a single series for dependencies

Changes since v2:
 - split i2c and cd321x changes into 2 commit
 - add i2c4 used by MacBooc Pros (j293, 13-inch, M1, 2020)
 - add hpm2 and hpm3 for the additional USB-C ports on j456 iMac
   (24-inch, M1, 2021) models

Series depends for functionality and dtbs verification on
"[PATCH 0/3] Apple Arm patform device tree and bindings fixes".

thanks,
Janne

The series is available as branch from:
    https://github.com/jannau/linux/tree/apple_m1/dt-for-5.17_v3

Janne Grunau (4):
  dt-bindings: arm: apple: Add iMac (24-inch 2021) to Apple bindings
  arm64: dts: apple: Add missing M1 (t8103) devices
  arm64: dts: apple: t8103: Add i2c nodes
  arm64: dts: apple: t8103: Add cd321x nodes

 .../devicetree/bindings/arm/apple.yaml        |  6 +-
 arch/arm64/boot/dts/apple/Makefile            |  4 +
 arch/arm64/boot/dts/apple/t8103-j274.dts      | 33 +------
 arch/arm64/boot/dts/apple/t8103-j293.dts      | 41 +++++++++
 arch/arm64/boot/dts/apple/t8103-j313.dts      | 33 +++++++
 arch/arm64/boot/dts/apple/t8103-j456.dts      | 59 ++++++++++++
 arch/arm64/boot/dts/apple/t8103-j457.dts      | 47 ++++++++++
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi     | 67 ++++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi          | 92 +++++++++++++++++++
 9 files changed, 352 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j293.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j313.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j456.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j457.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi

-- 
2.34.0

