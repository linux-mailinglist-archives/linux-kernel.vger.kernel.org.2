Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFFA350872
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhCaUoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:44:23 -0400
Received: from st43p00im-ztfb10073301.me.com ([17.58.63.186]:32841 "EHLO
        st43p00im-ztfb10073301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236745AbhCaUno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617223423; bh=EtIBL5r4/ZRTUX+loqJ5m2791/RWUC4onGbM+ik/Iq0=;
        h=From:To:Subject:Date:Message-Id;
        b=Xtx3a4ytCQR1iqXwhbJXhSlp8DUtMq8kInkwkWkF40A7fmlyDM3M7bFe3ZkFAhI8H
         qCJMiA3Eiw1wN8ULJjKuSyDmDQuO43WtlBcpT5xJHYLEwbWcLc1/C+ZC8LZhsbVpXN
         SSEdGHNNG39oSytF+a0Lfa+1tfbky9Ae6j/JFDrpYxCxvkU6oHQex70lDX4SfdX4i8
         nH6Zdfmb3rE1Qo4p8o1ivDpBeDUD6V/04gIuwky1cvkp0SrubeDYLpgcO0BK1xw1NT
         HfMZaSKM51UqJdBxo93FoboVurgtN1Dh0DqNv/WmF8FZzakC8aikBk+1yTI2OTiBgo
         fESpRgyzGWlag==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztfb10073301.me.com (Postfix) with ESMTPSA id 157A82A0775;
        Wed, 31 Mar 2021 20:43:42 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v3 11/13] ARM: dts: sti: disable rng11 on the stih418 platform
Date:   Wed, 31 Mar 2021 22:42:26 +0200
Message-Id: <20210331204228.26107-12-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331204228.26107-1-avolmat@me.com>
References: <20210331204228.26107-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_10:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=786 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2103310144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rng11 is not available on the STiH418 hence is disabled in the
stih418.dtsi

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih418.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.dtsi
index a05e2278b448..39a249983496 100644
--- a/arch/arm/boot/dts/stih418.dtsi
+++ b/arch/arm/boot/dts/stih418.dtsi
@@ -27,6 +27,10 @@
 	};
 
 	soc {
+		rng11: rng@8a8a000 {
+			status = "disabled";
+		};
+
 		usb2_picophy1: phy2@0 {
 			compatible = "st,stih407-usb2-phy";
 			reg = <0 0>;
-- 
2.17.1

