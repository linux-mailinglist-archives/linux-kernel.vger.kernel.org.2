Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39368430D54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 03:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344912AbhJRBOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 21:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344934AbhJRBOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 21:14:31 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC57C061768
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 18:12:18 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 35F56891AF;
        Mon, 18 Oct 2021 14:12:14 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1634519534;
        bh=vAI3LZBG1nn4O83fWRdhNPSKVjmlCAsd0dYOb/Lq23Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZjZXM/894AuNKmoESObIT3p/4LBGxt6rZL1UsWJrVAinGJ6S6m9X88kLv1iquVBkh
         KQRpeVcW5IBOTvBsCHQgk+BXOr0tql17pV38/7b9jQl4cXOzlPpBjNXBZRdu0AiEGw
         8rYy6L5TsLdkMzZ4gMWQi84+2LMDTEPCyEbgJcb70zmdhsflR+piFAPWdg4O1dSJPW
         s3XomozSpUC2CQT34Trdp1IWSRKaYWqubHtADhkVebVvq/oauma3BwKQz3fbhjKxg/
         n9fYfacUcj9+WtkZ/dZHBr3+zbGWgEneR3L28gnWG+zdGWnnCv2VPmCYxFUw/65DE5
         5OZ4Frj1NTLPg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B616cc9ee0001>; Mon, 18 Oct 2021 14:12:14 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.26])
        by pat.atlnz.lc (Postfix) with ESMTP id 145A613ED1E;
        Mon, 18 Oct 2021 14:12:14 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 129A32A0B00; Mon, 18 Oct 2021 14:12:14 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 1/2] arm/arm64: dts: Enable CP0 GPIOs for CN9130-CRB
Date:   Mon, 18 Oct 2021 14:12:10 +1300
Message-Id: <20211018011211.3836590-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
References: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eIJtc0h1 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=8gfv0ekSlNoA:10 a=6oF1C17gH3cd1FedgN0A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the CP0 GPIO devices for the CN9130-CRB. This is needed for a
number of the peripheral devices to function.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Change in v2:
- New

 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boo=
t/dts/marvell/cn9130-crb.dtsi
index e7918f325646..0885c6339d1b 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -17,6 +17,8 @@ aliases {
 		ethernet0 =3D &cp0_eth0;
 		ethernet1 =3D &cp0_eth1;
 		ethernet2 =3D &cp0_eth2;
+		gpio1 =3D &cp0_gpio1;
+		gpio2 =3D &cp0_gpio2;
 	};
=20
 	memory@0 {
@@ -114,6 +116,14 @@ cp0_spi0_pins: cp0-spi-pins-0 {
 	};
 };
=20
+&cp0_gpio1 {
+	status =3D "okay";
+};
+
+&cp0_gpio2 {
+	status =3D "okay";
+};
+
 &cp0_i2c0 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&cp0_i2c0_pins>;
--=20
2.33.0

