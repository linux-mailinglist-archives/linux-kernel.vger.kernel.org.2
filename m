Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBF1418880
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 14:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhIZMHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 08:07:15 -0400
Received: from mout.web.de ([212.227.17.11]:50149 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhIZMHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 08:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
        s=dbaedf251592; t=1632657925;
        bh=m8VLC/pDV41oz+AGBUYV78PEgpYlctnnA9lRo6HUa8M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qKEmqF8c/KFaSANcVTb2+sfXNfQ2kIgVDN/XD+Udw8JDrPAzijRsdSTPFY75HUkkb
         KNfRNtZt96901B4ys4ECAMzgU+ZFqNBGTsWT+fAG3x/R4ulJGnkDXFNdRLhPiR3Sgt
         Bm0eIB6Pbe0xTs5bm37LdQOCDA1nDsfqWSxTW9wI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from md1f2u6c.fritz.box ([94.217.148.121]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3Bhz-1mo3tK2HZP-00st09; Sun, 26
 Sep 2021 14:05:25 +0200
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v5 1/6] arm64: dts: ti: iot2050: Flip mmc device ordering on Advanced devices
Date:   Sun, 26 Sep 2021 14:05:12 +0200
Message-Id: <fe20d6346f119a28e47d129b616682001299cf0e.1632657917.git.jan.kiszka@web.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632657916.git.jan.kiszka@web.de>
References: <cover.1632657916.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:auiYQJ4Bq4nx5dqRfGmytgDH7QpLmjZPF3Agsep5CCT9sJHgrhc
 b5gWNjuZ1aGyH3PriBoI1TiMVIxC2lmE3yNypzcUGEhfRPqLjqtm+nJ3LHEuCaWSP7n8Bkk
 XmBSvaCltppeojZsoG8hjIEkB9TBHvfwLOExlR1Y28EXzlpmmcWRMkbsyYAdz7XeNlYTh/Q
 mQNBLQNa1pYGy4o0josZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TdmP+nOaQho=:VG5mAqUpmlswNsIpz4XuZa
 euaAD9sFkQK1dIpxtk+ow4JY0d5r+9SpKCz7W8SvDs5XOKvpYwAV91RJOoKo2Z7wT6j3TW8LZ
 /oMlBmOJZcBYyrEgAbrCzjSgRYfJabPLgCaYr3Zd3h6rO/7uAxEwKjVW2wdNKoqaHC/GqonOM
 wdX6fBenrsBfEMdIwuBvnzm9RJNAnAFRRG1hzcsA8V/pbXuncW51hTu0h1uSZM4hffJ2pKWfc
 G8vTYuPa0/PSA10UH8eZj8c4Y4aqBt+GmShMB6RVw+Af+vrL9oivyXcMuJgOISA5SH24JdLSg
 FMMFE6Wl3RwAW0sg7aJWB3XCaWzbQB3rbPUGR3QLwnZz37wIAH4B4XL2snvlY6fe3A4uMjrg5
 kKT4bG4Rx+Yi+QVGu4mMMMDIPA8kEqLSUsHcQ+Nx8Cfz1KN3Q1U5RhQUx3GIEON/RcnTX/+nT
 kRVhasvg75F5PEnvsebpsnRN5Qk0+EoSqra88epcHg3ssZI4R0eyayusOzY2PVIFrCeGpX7P6
 bIwqylfrDM8Iu0SMdCeDNvI50LIXx7QopaK6Q0uB6vxAzRtTLOnU4KkjeSH7yBwRmzec5852R
 Xf3mbVHVsMIn1230SDuq7YdoD4UJPJdIvTzus0tty2OTak3TmdVcwyXpvN3VkcXjR8rkVBKPs
 6T9nRrFQhqw+DCCdoSg1Aqxo5NFCq6KvWuJhastxBPae3dJwu6GHuRNTr2lPLG5MDBHkbeD2g
 Wn1sBexOfIxhLG/39gPp/7qmNZzPbxTocIOwdo2xFOgpYgV1OTVpQMKMhcHQU2ht+U+OOzOna
 E51ORA32EtC7hINNqHQWGhwGr/pyfPKWWrZiBQYkEl7UEzI9UMF2s4EEb5Fv9tMrQhesmPVpD
 7TdGvC9fTMdNiccASQEMHJ6D/zdgSWhAUdrtdJky9xgok04/MUuiGBE7XY8kru2wUYgUYzyzk
 ehIU29Re4Zr/Jl55RHkdT3gXqHkKbb3f0phD6dXvQIdR5cSGaU9WwHCmKuWPw5FrLRFpJPA4G
 00qh3rG+CgqsSR75CmGVMTFhp/1SgXP/7bbfPwAaKAMzPmvT47nhBlBpwlgMBVS+wI+DZgfI3
 tMsg4q3Ot3gd1Y=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This ensures that the SD card will remain mmc0 across Basic and Advanced
devices, also avoiding surprises for users coming from the downstream
kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Aswath Govindraju <a-govindraju@ti.com>
=2D--
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm=
64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 1008e9162ba2..6261ca8ee2d8 100644
=2D-- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -17,6 +17,8 @@
 / {
 	aliases {
 		spi0 =3D &mcu_spi0;
+		mmc0 =3D &sdhci1;
+		mmc1 =3D &sdhci0;
 	};

 	chosen {
=2D-
2.31.1

