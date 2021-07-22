Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8DB23D1FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 10:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhGVIFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:05:03 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50588 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231237AbhGVIC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:02:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 76DDE20085E;
        Thu, 22 Jul 2021 10:42:54 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 403AF20098A;
        Thu, 22 Jul 2021 10:42:54 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E8BB4183AC72;
        Thu, 22 Jul 2021 16:42:52 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh@kernel.org, galak@kernel.crashing.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org
Cc:     l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/2] convert fsl,imx6q-pcie.txt to yaml
Date:   Thu, 22 Jul 2021 16:22:33 +0800
Message-Id: <1626942155-9209-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[RFC 1/2] dt-bindings: PCI: imx6: add fsl,imx6q-pcie.yaml
[RFC 2/2] dt-bindings: PCI: imx6: remove fsl,imx6q-pcie.txt

.../devicetree/bindings/pci/fsl,imx6q-pcie.txt     | 102 ----------
.../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    | 212 +++++++++++++++++++++
MAINTAINERS                                        |   2 +-
3 files changed, 213 insertions(+), 103 deletions(-)
delete mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml

