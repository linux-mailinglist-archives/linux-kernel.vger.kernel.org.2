Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC1D42602F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhJGXI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbhJGXIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:08:21 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29838C061760
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:06:26 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C59818364F;
        Fri,  8 Oct 2021 12:06:21 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1633647981;
        bh=wX/X2kD1QXhISStI3ADWriII7Y2rdwpkkQwJV7ZPUWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ls4DsNZXNQRZpnHOeNZ9ELTy0uuJpaB9NgguDZ2A1ytTV77eEC/7TDp6LEf8UQW/d
         jrYbvcWDecHaoYVDZyFIbyCLh/CrpPfwIR7LwyesDekeQ5q86vB+tk/X+nX1lR9hzo
         GhDdC3noYBoUfV02MZqr82jw2nhi4rAODPc7Ix+U2aSAkErBL7H0yRtemyyggjdr2H
         RYdats1CTgx8032P4rHZe+OSn2isQGxHg7xzOraj2WU9GFtioI79C3h4Eyov2xFcBC
         8Q+8WuEh82B7u/211jQMm/2pGI/2ZUuOkBLoE6mv+KPHnrNGFwKzC0PAbU+Ks5jASP
         zyIlxF/1Bp26w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B615f7d6d0001>; Fri, 08 Oct 2021 12:06:21 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.26])
        by pat.atlnz.lc (Postfix) with ESMTP id A4B7E13EE39;
        Fri,  8 Oct 2021 12:06:21 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A34822A0B00; Fri,  8 Oct 2021 12:06:21 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        kostap@marvell.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] arm/arm64: dts: Enable 2.5G Ethernet port on CN9130-CRB
Date:   Fri,  8 Oct 2021 12:06:18 +1300
Message-Id: <20211007230619.957016-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007230619.957016-1-chris.packham@alliedtelesis.co.nz>
References: <20211007230619.957016-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=fKRHIqSe c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=8gfv0ekSlNoA:10 a=kLFBgOLU39b1_2hPZ6UA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the 2.5G Ethernet port by setting the status to "okay" and the
phy-mode to "2500base-x" on the cn9130-crb boards. Tested on a
CN9130-CRB-A.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

The Marvell SDK adds 2500base-t and uses it in the equivalent dtsi but
looking at the documentation for both the SoC and the PHY I think
2500base-x is correct for the system interface (the line side is
2500base-t).

 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boo=
t/dts/marvell/cn9130-crb.dtsi
index 505ae69289f6..e7918f325646 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -214,8 +214,8 @@ &cp0_eth1 {
 };
=20
 &cp0_eth2 {
-	/* This port uses "2500base-t" phy-mode */
-	status =3D "disabled";
+	status =3D "okay";
+	phy-mode =3D "2500base-x";
 	phy =3D <&nbaset_phy0>;
 	phys =3D <&cp0_comphy5 2>;
 };
--=20
2.33.0

