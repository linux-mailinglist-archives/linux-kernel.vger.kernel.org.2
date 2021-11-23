Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735B845AF64
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbhKWWwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:52:37 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:58804 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232578AbhKWWwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:52:37 -0500
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id C45FF261B54;
        Tue, 23 Nov 2021 23:49:26 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] Add DTs for all Apple M1 (t8103) devices
Date:   Tue, 23 Nov 2021 23:49:21 +0100
Message-Id: <20211123224926.7722-1-j@jannau.net>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej all,

hopefully the last iteration of this series. Thanks for the reviews.

Changes since v3:
 - fixed typo in "arm64: dts: apple: t8103: Add cd321x nodes" commit
   message
 - fixed node order by address in t8103.dtsi
 - removed clock-names property from i2c nodes
 - renamed cd321x nodes to "usb-pd"
 - added Reviewed-by and Acked-by tags

This series is available as branch at
    https://github.com/jannau/linux/tree/apple_m1/dt-for-5.17_v4

For reference the message from v3:

this series extends the device tree files and bindings to all current
Apple M1 devices. Specifically it adds DTs for following devices:
- MacBook Air (M1, 2020)
- Macbook Pro (13-inch, M1, 2020)
- iMac (24-inch, M1, 2021)

It also adds i2c and cd321x devices nodes. Bindings and code changes for
those were merged for 5.16 without adding devices to the device tree.
Patches are include in a single series for dependencies

Series depends for functionality and dtbs verification on
"[PATCH 0/3] Apple Arm patform device tree and bindings fixes".


Janne Grunau (4):
  dt-bindings: arm: apple: Add iMac (24-inch 2021) to Apple bindings
  arm64: dts: apple: Add missing M1 (t8103) devices
  arm64: dts: apple: t8103: Add i2c nodes
  arm64: dts: apple: t8103: Add cd321x nodes

 .../devicetree/bindings/arm/apple.yaml        |  6 +-
 arch/arm64/boot/dts/apple/Makefile            |  4 +
 arch/arm64/boot/dts/apple/t8103-j274.dts      | 33 ++-----
 arch/arm64/boot/dts/apple/t8103-j293.dts      | 41 +++++++++
 arch/arm64/boot/dts/apple/t8103-j313.dts      | 33 +++++++
 arch/arm64/boot/dts/apple/t8103-j456.dts      | 59 +++++++++++++
 arch/arm64/boot/dts/apple/t8103-j457.dts      | 47 ++++++++++
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi     | 67 ++++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi          | 87 +++++++++++++++++++
 9 files changed, 347 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j293.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j313.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j456.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j457.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
prerequisite-patch-id: 6827208d4389960d14555ee96768586179f9e8a7
prerequisite-patch-id: d5f23530f8cb99fbd9355f4bf0ccbaaca0cd6d7c
prerequisite-patch-id: 40ab5e8cc6dc6b5d44f075d8409f39966452bfb3
-- 
2.34.0

