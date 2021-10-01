Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61F641E55F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 02:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350200AbhJAALP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 20:11:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41398 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhJAALO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 20:11:14 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D360F1A0D8B;
        Fri,  1 Oct 2021 02:09:29 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 982411A0D7C;
        Fri,  1 Oct 2021 02:09:29 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id C47CB40A55;
        Thu, 30 Sep 2021 17:09:28 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 0/5] convert ifc binding to yaml and drop "simple-bus"
Date:   Thu, 30 Sep 2021 19:09:19 -0500
Message-Id: <20211001000924.15421-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ifc binding to yaml schema, in the mean while remove the
"simple-bus" compatible from the binding to make sure ifc device probes
before any of the child devices.  Update the driver and existing DTSes
accordingly.

DTS changes should be merged together with the driver/binding changes
if DTS maintainer is ok with it or after the driver changes are applied.

Li Yang (5):
  dt-bindings: memory: fsl: convert ifc binding to yaml schema
  memory: fsl_ifc: populate child devices without relying on simple-bus
  ARM: dts: ls1021a: remove "simple-bus" compatible from ifc node
  arm64: dts: remove "simple-bus" compatible from ifc node
  powerpc/mpc85xx: remove "simple-bus" compatible from ifc node

 .../bindings/memory-controllers/fsl/ifc.txt   |  82 -----------
 .../bindings/memory-controllers/fsl/ifc.yaml  | 137 ++++++++++++++++++
 arch/arm/boot/dts/ls1021a.dtsi                |   2 +-
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   2 +-
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   2 +-
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   2 +-
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |   2 +-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi      |   2 +-
 arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi |   2 +-
 arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi |   2 +-
 arch/powerpc/boot/dts/fsl/c293si-post.dtsi    |   2 +-
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   |   2 +-
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi   |   2 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi   |   2 +-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi   |   2 +-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi   |   2 +-
 drivers/memory/fsl_ifc.c                      |   9 ++
 17 files changed, 160 insertions(+), 96 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml

-- 
2.25.1

