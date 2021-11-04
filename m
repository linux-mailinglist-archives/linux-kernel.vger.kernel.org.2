Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14774453C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhKDN0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:26:14 -0400
Received: from comms.puri.sm ([159.203.221.185]:42014 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhKDN0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:26:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 0886CDFE31;
        Thu,  4 Nov 2021 06:23:35 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aEhtsC27IwzL; Thu,  4 Nov 2021 06:23:34 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v1 0/4] support the Librem 5 front camera
Date:   Thu,  4 Nov 2021 14:22:09 +0100
Message-Id: <20211104132213.470498-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Shawn and all whom this concerns,

3 weeks ago I sent this as RFC that didn't yield feedback, see below :)
Here's the same patches as a proper patchset ready to apply.

The first patch adds a shared "r3.dtsi" and is only refactoring.
Patch 2 that describes the power supplies on the Librem 5 board as regulators.
Patch 3 and 4 should be straight forward camera descriptions according to
the drivers.

thank you,
                             martin

revision history
----------------
RFC v1:
  https://lore.kernel.org/phone-devel/20211015083506.4182875-1-martin.kepplinger@puri.sm/
  and more specifically thoughts on patch 2:
  https://lore.kernel.org/phone-devel/20211015083506.4182875-3-martin.kepplinger@puri.sm/


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

