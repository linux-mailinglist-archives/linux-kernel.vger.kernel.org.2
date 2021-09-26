Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2623418881
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 14:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhIZMHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 08:07:16 -0400
Received: from mout.web.de ([212.227.17.12]:52245 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhIZMHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 08:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632657926;
        bh=JXUBttkyRgrw26wHzfuaQ48olNH5tGrG2ASYsEqtxh4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KfQTyv40EHE9Uh6Hda6/QggsExhelbiwu5Pj8kNOaQOMby1sTFu1qYWQ1KdLcPSTx
         dd5+7kdRXZal7AK0KmxYkYqq/17Oeu/IyITQWJGnRJ2/lsDxNITWf3vRQasKDM7XgW
         IoHcyvD5iTXfuNdGH/blfrO6tW520y9JSMDsBT6A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from md1f2u6c.fritz.box ([94.217.148.121]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M89mf-1mi1kl0zzN-00vcYN; Sun, 26
 Sep 2021 14:05:26 +0200
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH v5 2/6] arm64: dts: ti: iot2050: Disable SR2.0-only PRUs
Date:   Sun, 26 Sep 2021 14:05:13 +0200
Message-Id: <189a91866fb1af02e4fd2345dc56774aa069d5ba.1632657917.git.jan.kiszka@web.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632657916.git.jan.kiszka@web.de>
References: <cover.1632657916.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OuJOHSOPnIVgBIz5KqP4yrx7lCWJMVrDvX93SSJqr6mRhQlAbMN
 fJG5hIw5SrxDNWWuydDZ25NZialc7bEaclQK3Ef2OxIaNQALfu6ihL77N1orjhQiG5lGG+5
 ou5yNEnIa8GyqDAa9+qh4pjvEDFHoRQLT0bd5AKOJ4PbghmD7u+oz6lbYt5nczjzBAeyTiR
 sxTAEBbl2R1cqO3JGA7XQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yhrtHlFDnKc=:qkPD0r5Fau6g+W8OWP3V7D
 u5vDS5abj/FlcqGgEBdqgsmiVdDX5kTHWCmzeBIN/iCv63cS8ZLMT8uaORi8AlO7NN7COPLvc
 Ylo8cgwviXcupIpiqWyXTZB312nPRCu7oASp2ZEMXblAyD16EHuu7QBvRVfy2pSnqUlLDdlN/
 5J+yjUmyO3T7BkAYhRfWGXmlfW02T3P5XUysUu5Jo216VPWo4/fqJDemprItOMDpSsWE3PQIN
 jdCZ9WcFjbGg3dte04MIYcD5HAdOf/c2O/3BYseDEWTZ6NsFWfrgNf5EYDaZ5jukDlOagdMVG
 myFLqYZbMLql5fbU0Z+H4WYO1YQrXHhxPdBy6E1jSV4q093LIl+VmVHY1/9BfXBoVEhPngW1S
 mIAlu7KKXxfcKYa+4oBVq08KGOP9joH2vIv0C+2HkaL9hXNI+4/CXseYHYaSs4um1Mya3bgsk
 1REBe/YkyL88kdKP3ki0KxSJtiee4BiZjm+ncwlUzIYphlnrvtk6VA0ZlCF/yctfSikhCsUBr
 ivYkmyRb6qB7aXfA6AYKhUQxlkGkPgEe1Z1GD5qb8REoK0TdGpo76cL5i+AX7wxwkbFem8HoV
 d5FEGwoGO3ZlpjeBrr1StpDaQ0XX/XEuBIWdNMKz3dfPfjngwXz1PJsGj8HyGKdnSJmrpFZYp
 QPF3GMLM0Cm3baLlK8kol3cx8Xt97yGIArrKE5OUoG2io7I+MjEd2Fu8kMgeOxo6kQrx1YDXW
 GPcqIX/Mv/0UA5EOECXIP0wd5NGhBdyxDZMMKEb+pLXbH287ZSOsRM/jmk269o9+xohq2tSbc
 6DDZcurDEXX/5MMIqAtBLRAkYO+1Cjpd0A5alHbyaCGxRC2LK9T08G3hQBjkI8vlSX6fQDKEe
 EfcxG0KUEc6CsIBlPBoqJq34YuFuVpShMQxyneNvtt3MOvHFJl4kuvB8pkk5Ekv3dFLA8dWrZ
 HOuGkb9ij+l11s/Ps9ZOuT7JibVmJxAtpM4mPIISSiWL+lXoCnoUv6nIOT3NLqzLOu6Fw2srQ
 U9mBRWPn36IMzWnEg7c7m/kmtOOG6AK/VLdEtNq44aMfTvQcJnLNUwQg1tSbnbTxqazEkx1BY
 OMOXVHSWbxKmH4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

The IOT2050 devices described so far are using SR1.0 silicon, thus do
not have the additional PRUs of the ICSSG of the SR2.0. Disable them.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Aswath Govindraju <a-govindraju@ti.com>
Acked-by: Suman Anna <s-anna@ti.com>
=2D--
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm=
64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 6261ca8ee2d8..58c8e64d5885 100644
=2D-- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -716,3 +716,27 @@ &icssg1_mdio {
 &icssg2_mdio {
 	status =3D "disabled";
 };
+
+&tx_pru0_0 {
+	status =3D "disabled";
+};
+
+&tx_pru0_1 {
+	status =3D "disabled";
+};
+
+&tx_pru1_0 {
+	status =3D "disabled";
+};
+
+&tx_pru1_1 {
+	status =3D "disabled";
+};
+
+&tx_pru2_0 {
+	status =3D "disabled";
+};
+
+&tx_pru2_1 {
+	status =3D "disabled";
+};
=2D-
2.31.1

