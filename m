Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396B344EF57
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhKLWiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:38:01 -0500
Received: from inva020.nxp.com ([92.121.34.13]:57186 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235973AbhKLWhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:37:55 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E8B31A207A;
        Fri, 12 Nov 2021 23:35:03 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D314C1A031E;
        Fri, 12 Nov 2021 23:35:02 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id DB8A340BCF;
        Fri, 12 Nov 2021 15:35:01 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 01/11] dt-bindings: pci: layerscape-pci: Add EP mode compatible strings for ls1028a
Date:   Fri, 12 Nov 2021 16:34:47 -0600
Message-Id: <20211112223457.10599-2-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211112223457.10599-1-leoyang.li@nxp.com>
References: <20211112223457.10599-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add EP mode compatible string for ls1028a.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index f36efa73a470..0d3d78aebe26 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -23,6 +23,7 @@ Required properties:
         "fsl,ls1012a-pcie"
         "fsl,ls1028a-pcie"
   EP mode:
+	"fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep"
 	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
 	"fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep"
 	"fsl,ls2088a-pcie-ep", "fsl,ls-pcie-ep"
-- 
2.25.1

