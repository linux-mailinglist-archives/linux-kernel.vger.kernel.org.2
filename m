Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E074465C6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhKEPdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:33:19 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:26763 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233558AbhKEPdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636126235; x=1667662235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oRR20EjSccrFQYUYLWils29Cevmq6Y1DX5OtWOQacQ8=;
  b=UL65kDo6qLRXLn7X5CWHHlJhqovVfoDTJ21kdiFPDQERZfzYjOWbQyBi
   e7hpOhKEbfH3MCqNgcTklL6AX0KK9TaQcEPZo3tAUhrQ1hSkZ8r5ZxgvC
   q5pGE5H0kF+9MDLh4DuB9RSivteOWUG+6EkJFCEqQMSEEipXfnAU5xfrB
   OvvFSeC6qt7Ordngt4LGGnbg4DxDyQZ9oeV311XtzVX7ZWeCXZ6Tii9oM
   Q1OIH6p+V1KZ9B/Y02JhkNYfly6j2xJM4JWbMYwTwCx3BK+sitO6ufFWq
   y6dnh9BGrpJ22hyKCDoQbdbe5LYmlYsY27a9SMFpeGsr6CDtIkl+cPPMF
   w==;
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="20358797"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 05 Nov 2021 16:30:34 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 05 Nov 2021 16:30:34 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 05 Nov 2021 16:30:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636126234; x=1667662234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oRR20EjSccrFQYUYLWils29Cevmq6Y1DX5OtWOQacQ8=;
  b=dIY4FmAQIP9kJcFnC6SzxnNjJQ3W7+28cXoIa8bNBBbQ09kea5O7XRWv
   UVsqD9phpbBhfvhQpSxAVIYI3Eb4zGljevgRTkthzRtvLNv4t9G4O9KTv
   hrkY4bEg4dAbCnoxZvxaCuFZUZvnQwrL/uBj0dp5bbAa2D36o6/3vK0JT
   TMnC/HfILiE3AIvaNqbuhjiVfvWS2rMan/OU+hxxTXzu4xCA8MM15WCrF
   fhefjt4MBoR4TkAnp1TAFBtXf9LQB3ycS06fOnj34cuFWO865Hlm9wCp9
   FK2TR4Cq83MPobEtVJ9A3qdzGFQF4jkfE67kcbdto2pffP0oxpauEoqvs
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="20358795"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Nov 2021 16:30:33 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id AE6AC280065;
        Fri,  5 Nov 2021 16:30:33 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/7] Support for some TQMa8M* boards
Date:   Fri,  5 Nov 2021 16:30:18 +0100
Message-Id: <20211105153025.187106-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks everyone for their review on v1!

Changes in v2:
* Rebased to next-20211101
* Added Rob's Acked-By on Patch for DT bindings
* for other changes please refer to individual patches

Note on TQMa8Mx:
Due to CPU errata cpuidle is broken and needs to be disabled, see [1] for
pending patch.

This patch set adds support for the following modules:
* TQMa8Mx
* TQMa8MxML
* TQMa8MxNL

Each of the modules is available with different i.MX8M variants, the
bootloader modifies the device tree and disabled paripherals which
are not available on the actual hardware.

All of them can be attached to the same mainboard MBa8Mx, although
TQMa8MxML & TQMa8MxNL need an adapter. For that reason there is a single
mainboard .dtsi file named mba8mx.dtsi.

There is a .dtsi file for each module named imx8m?-tmqa8m*.dts.

Finally there is the final .dts file which includes the mainboard and
the attached module and contains the missing connection, prominently clk
and pinctrl defines.

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20211105095535.3920998-1-alexander.stein@ew.tq-group.com/

Alexander Stein (7):
  dt-bindings: arm: fsl: add TQMa8MxML boards
  arm64: dts: freescale: add initial tree for TQMa8MQML with i.MX8MM
  arm64: defconfig: enable drivers for TQ TQMa8MxML-MBa8Mx
  dt-bindings: arm: fsl: add TQMa8MxNL boards
  arm64: dts: freescale: add initial tree for TQMa8MQNL with i.MX8MN
  dt-bindings: arm: fsl: add TQMa8Mx boards
  arm64: dts: freescale: add initial tree for TQMa8Mx with i.MX8M

 .../devicetree/bindings/arm/fsl.yaml          |  31 ++
 arch/arm64/boot/dts/freescale/Makefile        |   3 +
 .../dts/freescale/imx8mm-tqma8mqml-mba8mx.dts | 299 +++++++++++++
 .../boot/dts/freescale/imx8mm-tqma8mqml.dtsi  | 353 +++++++++++++++
 .../dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts | 283 ++++++++++++
 .../boot/dts/freescale/imx8mn-tqma8mqnl.dtsi  | 340 +++++++++++++++
 .../dts/freescale/imx8mq-tqma8mq-mba8mx.dts   | 412 ++++++++++++++++++
 .../boot/dts/freescale/imx8mq-tqma8mq.dtsi    | 378 ++++++++++++++++
 arch/arm64/boot/dts/freescale/mba8mx.dtsi     | 283 ++++++++++++
 arch/arm64/configs/defconfig                  |   7 +
 10 files changed, 2389 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/mba8mx.dtsi

-- 
2.25.1

