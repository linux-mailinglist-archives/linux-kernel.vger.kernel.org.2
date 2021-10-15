Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBBC42EC76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbhJOIiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:38:12 -0400
Received: from comms.puri.sm ([159.203.221.185]:44576 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhJOIiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:38:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 26814DFE31;
        Fri, 15 Oct 2021 01:36:05 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 682hVSIiObDR; Fri, 15 Oct 2021 01:36:04 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        krzk@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [RFC PATCH v1 0/4] support the Librem 5 front camera
Date:   Fri, 15 Oct 2021 10:35:02 +0200
Message-Id: <20211015083506.4182875-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch adds a shared "r3.dtsi" and is only refactoring.

The is an RFC because of patch 2 that describes the power supplies as
regulators. Suggestions are very welcome.

Patch 3 and 4 should be straight forward camera descriptions according to
the drivers.

thank you,
                             martin

Martin Kepplinger (4):
  arm64: dts: split out a shared imx8mq-librem5-r3.dtsi description
  arm64: dts: imx8mq-librem5: describe power supply for cameras
  arm64: dts: imx8mq-librem5: describe the selfie cam
  arm64: dts: imx8mq-librem5-r3.dtsi: describe selfie cam XSHUTDOWN pin

 .../boot/dts/freescale/imx8mq-librem5-r3.dts  | 25 +----
 .../boot/dts/freescale/imx8mq-librem5-r3.dtsi | 45 +++++++++
 .../boot/dts/freescale/imx8mq-librem5-r4.dts  | 16 +---
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 96 ++++++++++++++++++-
 4 files changed, 144 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtsi

-- 
2.30.2

