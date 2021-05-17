Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C71383AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239818AbhEQRNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239000AbhEQRNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 231BC61285;
        Mon, 17 May 2021 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621271535;
        bh=ndycr4QzA8ixcEQVQ2wR0BE0OmQouaQA5YNKTPg6Hs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btDZYfk2zlhjAG62qUfBElApgJ0pLnNsznqBxNV/KCJ81E5jfZHsGN9jPjECInx8R
         UHoyscn1/qeFN5NHOTCN5i4TVqQDoOMoAKSeS1ssnuR6I5Mq0SMZPE/Flc45eMSs1n
         667g8Boz4rFV24YExhTIf+eHA5vCZFcHmjm/aV5YmZ+l9LKsCOpPVL9lOuTtG4KvEy
         QUYfJ+CwwBQ2EJcoXvlPKu3zSAK8IgErSbc+liU1ZODj+bMQApb/rPGqg/g9mxHsCO
         dqEXDp2aODXOh4cAhRSTsupDYTEnZFNfiQcE6W9jyZ0y+k2uJkr4NjRRYTPybmlQvl
         qxbKyrx2QNyeg==
From:   abelvesa@kernel.org
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 2/7] arm64: dts: imx8-ss-lsio: Add mu5a mailbox
Date:   Mon, 17 May 2021 20:12:00 +0300
Message-Id: <20210517171205.1581938-3-abelvesa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517171205.1581938-1-abelvesa@kernel.org>
References: <20210517171205.1581938-1-abelvesa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

The mailbox of the lsio mu5a is used by rpmsg on imx8qxp and
imx8dxl platforms.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index ee4e585a9c39..8e3c92c82fac 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -141,6 +141,15 @@ lsio_mu4: mailbox@5d1f0000 {
 		status = "disabled";
 	};
 
+	lsio_mu5: mailbox@5d200000 {
+		compatible = "fsl,imx6sx-mu";
+		reg = <0x5d200000 0x10000>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <2>;
+		power-domains = <&pd IMX_SC_R_MU_5A>;
+	};
+
+
 	lsio_mu13: mailbox@5d280000 {
 		reg = <0x5d280000 0x10000>;
 		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.31.1

