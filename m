Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3ED3FC871
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbhHaNlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbhHaNlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:41:16 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649C2C061575;
        Tue, 31 Aug 2021 06:40:21 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EB26E22234;
        Tue, 31 Aug 2021 15:40:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1630417219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EzShoYkqiJR7M7i7zrShSPRgbOpJvWf4irzhHEaw+D8=;
        b=g9nqhyhEeshOIS2wBFfnxCKXs8NcIr+7mbxxSbLnhMiv/GRJoxiQ67oAFXiwJOVwsqTjEb
        C0tQCSCRoNfvk7u9JWyr9OvAbIVJ7zAxloXn7J23SxJ7iqiir3b7SCQLSGS1wLE49gE307
        TayCAhxensZiYMBM7mNMj0jSdeGWqao=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 0/7] arm64: dts: ls1028: GPU support and cleanups
Date:   Tue, 31 Aug 2021 15:40:06 +0200
Message-Id: <20210831134013.1625527-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an attempt to unify u-boot's and linux' device tree for the LS1028A SoC
we first need to clean up some network related stuff. Vladimir suggested to
move the Ethernet PHYs into the MDIO controller node, which is already the
case for u-boot's device tree. Further we unify the use of phy-mode and
phy-connection-type. Both have the same meaning, but phy-mode is used more
often in the kernel and for the ls1028a both were used. Replace
phy-connection-type with phy-mode.

Further move all the nodes which belongs to the CCSR into the /soc node.
These are the Mali display conntroller and its associated pixel clock PLL.
Finally, add the GPU node for the etnaviv driver under /soc.

Michael Walle (7):
  arm64: dts: ls1028a: move pixel clock pll into /soc
  arm64: dts: ls1028a: move Mali DP500 node into /soc
  arm64: dts: ls1028a: add Vivante GPU node
  arm64: dts: freescale: fix arm,sp805 compatible string
  arm64: dts: ls1028a: disable usb controller by default
  arm64: dts: ls1028a: move PHY nodes to MDIO controller
  arm64: dts: ls1028a: use phy-mode instead of phy-connection-type

 .../fsl-ls1028a-kontron-sl28-var1.dts         | 60 ++++++++--------
 .../fsl-ls1028a-kontron-sl28-var2.dts         | 17 ++---
 .../fsl-ls1028a-kontron-sl28-var4.dts         | 49 +++++++------
 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 31 +++++----
 .../boot/dts/freescale/fsl-ls1028a-qds.dts    | 10 ++-
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    | 19 +++---
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 68 +++++++++++--------
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 16 ++---
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 16 ++---
 9 files changed, 149 insertions(+), 137 deletions(-)

-- 
2.30.2

