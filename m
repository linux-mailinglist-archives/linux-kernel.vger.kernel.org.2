Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E19453BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhKPV4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:56:16 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:48810 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhKPV4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:56:15 -0500
Received: from coburn.home.jannau.net (p579ad520.dip0.t-ipconnect.de [87.154.213.32])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 0BD10261AE4;
        Tue, 16 Nov 2021 22:53:16 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add DTs for all Apple M1 (t8103) devices
Date:   Tue, 16 Nov 2021 22:53:13 +0100
Message-Id: <20211116215315.22528-1-j@jannau.net>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this series adds DTs for all current Apple M1 devices.
Specifically it adds DTs for following devices:
- MacBook Air (M1, 2020)
- Macbook Pro (13-inch, M1, 2020)
- iMac (24-inch, M1, 2021)

With the addition of PCIe support the devices started to differ in
their supported hardware. The MacBook Air and Pro do not have an
ethernet and USB PCIe controllers. The 24-inch iMac has a configuration
without USB ihost controller.

In addtion it will help with AsahiLinux bootloader (m1n1). It started
in October to refuse to load DTs that do not match the model it is
running on.

Janne Grunau (2):
  dt-bindings: arm: apple: Add iMac (24-inch 2021) to Apple bindings
  arm64: dts: apple: Add missing M1 (t8103) devices

 .../devicetree/bindings/arm/apple.yaml        |  6 ++-
 arch/arm64/boot/dts/apple/Makefile            |  4 ++
 arch/arm64/boot/dts/apple/t8103-j274.dts      | 29 +----------
 arch/arm64/boot/dts/apple/t8103-j293.dts      | 33 +++++++++++++
 arch/arm64/boot/dts/apple/t8103-j313.dts      | 33 +++++++++++++
 arch/arm64/boot/dts/apple/t8103-j456.dts      | 41 ++++++++++++++++
 arch/arm64/boot/dts/apple/t8103-j457.dts      | 47 ++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi     | 49 +++++++++++++++++++
 8 files changed, 212 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j293.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j313.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j456.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-j457.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi

-- 
2.33.1

