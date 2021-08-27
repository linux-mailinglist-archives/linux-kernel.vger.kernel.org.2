Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228803F94D3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244361AbhH0HGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:06:03 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58704 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243085AbhH0HGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:06:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BE778201031;
        Fri, 27 Aug 2021 09:05:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 90394201022;
        Fri, 27 Aug 2021 09:05:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3B554180222A;
        Fri, 27 Aug 2021 15:05:11 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh@kernel.org, l.stach@pengutronix.de, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de
Subject: [PATCH v2 0/3] dt-bindings: PCI: imx6: convert the imx pcie
Date:   Fri, 27 Aug 2021 14:42:57 +0800
Message-Id: <1630046580-19282-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes V1 --> V2:
- Add "Reviewed-by: Lucas Stach <l.stach@pengutronix.de>" and update
  the commit message.
- Apply changes refer to Rob's review comments.
  - remove num-viewport totally, since it's not required anymore, and so on.

This patch-set aims to convert the imx pcie controller bindings from
fsl,imx6q-pcie.txt to json schema file fsl,imx6q-pcie.yaml.

And fix according errors on imx6qdl.dtsi, imx6qp.dtsi, imx6sx.dtsi,
imx7d.dtsi and imx8mq.dtsi found by dt_binding_check and dtbs_check.

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt  | 100 -----------------------------------------
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 202 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
MAINTAINERS                                               |   2 +-
arch/arm/boot/dts/imx6qdl.dtsi                            |   7 ++-
arch/arm/boot/dts/imx6qp.dtsi                             |   2 +-
arch/arm/boot/dts/imx6sx.dtsi                             |   6 +--
arch/arm/boot/dts/imx7d.dtsi                              |   7 ++-
arch/arm64/boot/dts/freescale/imx8mq.dtsi                 |  10 ++---
8 files changed, 217 insertions(+), 119 deletions(-)
delete mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml

[PATCH v2 1/3] dt-bindings: PCI: imx6: convert the imx pcie
[PATCH v2 2/3] arm: dts: imx: fix the schema check errors
[PATCH v2 3/3] arm64: dts: imx8mq: fix the schema check errors
