Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1855E4585C9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 19:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbhKUSLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 13:11:05 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:55020 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbhKUSLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 13:11:05 -0500
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id C5F98261B33;
        Sun, 21 Nov 2021 19:07:58 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add DTs for all Apple M1 (t8103) devices
Date:   Sun, 21 Nov 2021 19:07:55 +0100
Message-Id: <20211121180758.29477-1-j@jannau.net>
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

It also adds i2c and cd321x devices nodes those support was merged for
5.16 without adding devices to the device tree. [PATCH 3/3] is included
in this series since it depends on PATCH 2/3.

Changes since v1:
 - fixed the nit pointed out in the bindings change
 - add Reviewed-By
 - adds [PATCH 3/3] arm64: dts: apple: t8103: Add i2c and cd321x nodes

For [PATCH 3/3] depends for functionality and dtbs verification on
"[PATCH 0/3] Apple Arm patform device tree and bindings fixes".

thanks,
Janne

The series is available as branch from:
    https://github.com/jannau/linux/tree/apple_m1/dt-for-5.17
 
Janne Grunau (3):
  dt-bindings: arm: apple: Add iMac (24-inch 2021) to Apple bindings
  arm64: dts: apple: Add missing M1 (t8103) devices
  arm64: dts: apple: t8103: Add i2c and cd321x nodes

 .../devicetree/bindings/arm/apple.yaml        |  6 +-
 arch/arm64/boot/dts/apple/Makefile            |  4 +
 arch/arm64/boot/dts/apple/t8103-j274.dts      | 33 ++-------
 arch/arm64/boot/dts/apple/t8103-j293.dts      | 37 ++++++++++
 arch/arm64/boot/dts/apple/t8103-j313.dts      | 33 +++++++++
 arch/arm64/boot/dts/apple/t8103-j456.dts      | 41 +++++++++++
 arch/arm64/boot/dts/apple/t8103-j457.dts      | 47 ++++++++++++
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi     | 67 +++++++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi          | 73 +++++++++++++++++++
 9 files changed, 311 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j293.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j313.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j456.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j457.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi

-- 
2.34.0

