Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD19423E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhJFNZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:25:13 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:35555 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhJFNZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633526600; x=1665062600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2hi3uyFgBmoXMSx9J/EyEwdcL1aNU2wFfxc4RN7ZiR4=;
  b=l1ehhPyX1Wrhk1yVF2YriWcpnkvd2QpcJ19wkwCOVXTaExicx3eApxtj
   UdV+qYa2jk2Seeu9SpUjSiySmCBefIzPms8TUd+OBXHbxVdfbV747zvwA
   0OByDAK8ooma4DC/F7C7VLZnyDczd2UzFSdNFMT/yiFJsV0o3ANRSHLz8
   HmLwUArwdSngSG7MzHr/zPMmkZkscfHZUXhsib19vP5DREIsXhmEXKLJI
   jFHJ4DL11HSRfTx7Kl3BFopEs2pUuUFRTRW1xbGcnagD4pUCven31shdp
   5ltGwDgHNhetaBgZv3FvBIItRALJftterhipsMH0HNIObU+qC/Ph/0mO4
   g==;
X-IronPort-AV: E=Sophos;i="5.85,350,1624312800"; 
   d="scan'208";a="19897918"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 Oct 2021 15:23:19 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 06 Oct 2021 15:23:19 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 06 Oct 2021 15:23:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1633526599; x=1665062599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2hi3uyFgBmoXMSx9J/EyEwdcL1aNU2wFfxc4RN7ZiR4=;
  b=chGE0wNcgRwbtO+vhZmvxFpLC5ZD+KMw896ZAV2c7vefZKnLjWLdCs7u
   kIwFBLHxEyaS80TNzRLIASI5MwRw4lxepX20QWSC3hyc3H/SaMSe6QtaC
   AifLsmU0mOH7FTJguSuoDUrdR37ca4+zeLHbiq96yapPaDIfBFqWSXm5F
   Lqi0pchMawJIg5rqAwooVi3x/JUvcCD2EDRjQowR9udTyAGxpKwVPB3vR
   fJSJ6qPnRuU52/gSxG1hYY6HxURbyKTy1YVkli5mQC9B0pNXvMKYKM3AW
   6yzHqFjWDS1ZSDkDOxVFDwasyIVEw5JTxZso/FCbBrz1H6AcOJ8oHDtDu
   g==;
X-IronPort-AV: E=Sophos;i="5.85,350,1624312800"; 
   d="scan'208";a="19897917"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Oct 2021 15:23:19 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id CE6F8280065;
        Wed,  6 Oct 2021 15:23:18 +0200 (CEST)
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
Subject: [PATCH 0/7] Support for some TQMa8M* boards
Date:   Wed,  6 Oct 2021 15:23:02 +0200
Message-Id: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 .../dts/freescale/imx8mm-tqma8mqml-mba8mx.dts | 259 +++++++++++
 .../boot/dts/freescale/imx8mm-tqma8mqml.dtsi  | 350 +++++++++++++++
 .../dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts | 283 ++++++++++++
 .../boot/dts/freescale/imx8mn-tqma8mqnl.dtsi  | 345 +++++++++++++++
 .../dts/freescale/imx8mq-tqma8mq-mba8mx.dts   | 416 ++++++++++++++++++
 .../boot/dts/freescale/imx8mq-tqma8mq.dtsi    | 369 ++++++++++++++++
 arch/arm64/boot/dts/freescale/mba8mx.dtsi     | 285 ++++++++++++
 arch/arm64/configs/defconfig                  |   5 +
 10 files changed, 2346 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-tqma8mq.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/mba8mx.dtsi

-- 
2.25.1

