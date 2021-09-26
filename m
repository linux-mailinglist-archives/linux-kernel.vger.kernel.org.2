Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80624418885
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 14:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhIZMHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 08:07:18 -0400
Received: from mout.web.de ([212.227.17.11]:44273 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231356AbhIZMHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 08:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
        s=dbaedf251592; t=1632657927;
        bh=Fk5SREXcGiQX8LPuAbBCjfapNszlY0pzWhK5XpaAyV4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=d+Y7Dp0J7fsXTDyyNvcxHZCy/jrs90VAqiDFAouMHf1OSjiajrdy+MjMokRS9RX5a
         FqmwNivVF946lnn9NLfYthnc1uguQE2iEKHgIiTi/tYy2oqsFVfVUQTTFOBKzvywH7
         33n8BwzfGy7xWVq7iJcTgwuovNpKwzskDJTXvbV0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from md1f2u6c.fritz.box ([94.217.148.121]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ljaei-1n60eU3Owq-00bcrq; Sun, 26
 Sep 2021 14:05:26 +0200
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v5 3/6] arm64: dts: ti: iot2050: Add/enabled mailboxes and carve-outs for R5F cores
Date:   Sun, 26 Sep 2021 14:05:14 +0200
Message-Id: <1776f8be19b39a938d9248fcfc5332b753783c3e.1632657917.git.jan.kiszka@web.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632657916.git.jan.kiszka@web.de>
References: <cover.1632657916.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dp14hlKFy54eJnzueDrBM91JLiiueaexsmj7SEdq785kwzfo87g
 YrdhsftbQU3M8LapCgIjn7rnuaqoJClXsFdFhxtEYKbdBORU6GngX7s0my/2hflrIkzoDy7
 mzAuk8j79GoezzJl3AFpW7axXi11eSFncGUpCSYzRV4vrYNdgMrfahRPzqnTUhbvBEMjy55
 K5S72M+ZBZI1lA6xUF7Pg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:r1sMIBbw0Y8=:9Xk1/WrB/p7m2ExHScKzgc
 Xmh3Fz+qDcx60IKALHFycQwCDd06kn0+jhkp9SE3s1otw5/25PaB4RwGToL57AZk1GPiS/oFT
 JGVAmiUBw4iHKEbwssm/mo3QUIjQhacpaD/INA0IZcajeGu7ISrSnG8t+D+WEZbJpv/YGUAps
 //EEA8f7HLM7EMBv9abQF8bgc0TaPrTkTzYfVvG5SzdszVih1UccndonTFwq3INt7j/1my0eN
 H7kxHtfeu3XaS+sulwKpZPKo7DL5PH8r80G4GapJDbeK/Bjpeg8dWNKAl6wlJRTAtpwuXcrT5
 oVOnjQUf84yA2xw5p+Djlt2jd4tAc73tr9b+uxxB/s+1bmZUPlBZ2XacBV6L+l2zCl6DcHB4m
 1FS5dD3T5sauWcY/NQfGqltYv62bcMrzTjRYH8jbYYmPyJGJJn9g+DUzQIOVCadnxMOFUN17L
 Rj/i6raNPt+ngaWj9VVZGl8uMB2J/3JN4Q4PKKa+nIvkDqi1eO0kbVMuaCGQEQgHXzt6+P+Dg
 y0d30KQcWAXUVi+i43i3gL+QwfeM487IpxPxlDsiVsOYLwXuTuzu3DwlE8fumkemdpZaOHoPU
 eqn++67EemPsAF3n7BN6A9/bpRjU6fEg1a9GnmBE8FnQKi1g36/q334GKsrNFweYlgQvR1zSS
 Xor5KamgQEYVZ0LUqKph19mO/UxRzYVU80MqyQacAnTASNOiwpElJNO7dIYkJhY9CWYZhjGoR
 vXTuKt3wYTuIakojMyZGr7QbV9lRKTpEv1Trv3GLgW2Du4icJ3TqOJutl9NQbC+QhrAdjjawe
 MoOQofQAZofc+nvW/UVXPsRhAm75ynwnoo75eMLaKAUIj/5vFwIlScoesmgkWoEtcXekW0ipV
 eyM2M+IFF3Kfgp4eAaS/wxVIWWzrLCUdkTKkupBNspdjxi0iecXKEqnnnZM43a10CrV5TS2Ns
 +zBhQhR5zWam2kyHaCgdvcg8YKR0zQlWc+QfJ5RaClWIW+Z3WoMe4F+7+9yIEywwB1st9oBzI
 bPiaATn3CO+zEBNdeBG6MdaPTe+ulcut4ARFwZl9Q9KCzuKPf//itknG2S78MBbvH+h+t6Q0J
 Vlj6AZnvnl1Xf4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Analogously to the am654-base-board, configure the mailboxes for the two
R5F cores, add them and the already existing memory carve-outs to the
related MCU nodes. Allows to load applications under Linux onto the
cores, e.g. the RTI watchdog firmware.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Suman Anna <s-anna@ti.com>
=2D--
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm=
64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 58c8e64d5885..b29537088289 100644
=2D-- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -658,11 +658,21 @@ &pcie1_ep {
 };

 &mailbox0_cluster0 {
-	status =3D "disabled";
+	interrupts =3D <436>;
+
+	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
+		ti,mbox-tx =3D <1 0 0>;
+		ti,mbox-rx =3D <0 0 0>;
+	};
 };

 &mailbox0_cluster1 {
-	status =3D "disabled";
+	interrupts =3D <432>;
+
+	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
+		ti,mbox-tx =3D <1 0 0>;
+		ti,mbox-rx =3D <0 0 0>;
+	};
 };

 &mailbox0_cluster2 {
@@ -705,6 +715,18 @@ &mailbox0_cluster11 {
 	status =3D "disabled";
 };

+&mcu_r5fss0_core0 {
+	memory-region =3D <&mcu_r5fss0_core0_dma_memory_region>,
+			<&mcu_r5fss0_core0_memory_region>;
+	mboxes =3D <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+};
+
+&mcu_r5fss0_core1 {
+	memory-region =3D <&mcu_r5fss0_core1_dma_memory_region>,
+			<&mcu_r5fss0_core1_memory_region>;
+	mboxes =3D <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
+};
+
 &icssg0_mdio {
 	status =3D "disabled";
 };
=2D-
2.31.1

