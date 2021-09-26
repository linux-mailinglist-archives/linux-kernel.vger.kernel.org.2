Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D3741887D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 14:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhIZMHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 08:07:12 -0400
Received: from mout.web.de ([217.72.192.78]:52817 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhIZMHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 08:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632657925;
        bh=CD070ALUs6m5DVhfTYGwrLCbmE/6PzKVoSE1UTba9AM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=eIFw0IYRtk88AAykH0jZ8THWDEH5WKxBJxVZtsSCyEo1RdsX3nM3AXX7x2CHTl2i9
         ozOAkJb2gJ/OwyRMDvu5Nre4JBlqZgwa+5ug1Cw6odY5qPsdOJ6hTPAv5hrGxwzOxb
         jMI8VROZD+P3cFNrid30SQP2qCtWXzSNqasxSuwo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from md1f2u6c.fritz.box ([94.217.148.121]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFc1h-1maEDJ4AwX-00EgZL; Sun, 26
 Sep 2021 14:05:25 +0200
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: [PATCH v5 0/6] arm64: dts: Update IOT2050 boards
Date:   Sun, 26 Sep 2021 14:05:11 +0200
Message-Id: <cover.1632657916.git.jan.kiszka@web.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ndA26+vFyRJVGnxtm9XmVqicUwNcfbtojIHtcmYuwpsG5WUyT/k
 d3OeVcg4XWR+JsF0rdALFcXKxxTECGFCger5pTmmsYSWQfq3wZ3863oHj6Z3LUe3UGQdz6x
 mb0qhV4laoxfNHgpvimBb8EbhVAUI8svhqdJKv+85DGL6qCxHyy0HscMMAq0CoAVuvWRJ//
 rKhf4b/6kV4FncZLV2/gQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qRXCwnCT3dI=:jx9yVXchRfhrnsc/SWZyXH
 6EWQr4i8pHB5Rl1SemOohJ9/8Pw/h4wuFT553o4zZFKzL5NfeYG8/+5DJRbnoDY4n+MiPL6bN
 DlVygc1Kjya/Y8bMgQO60rdpKcaZNC3ZQhhouZwC099gjAoKhotZ8Zsz9ZNnoOJcLfSykMj6R
 6YG2xF3Lo4WLYJ99bs6PQXTQfA+AoMsGW3bym8rK7O5VI4MsLo9+qDYvqg3DFOypKYCaxfr0J
 Q4C+pS/FXvd1fs+P2/mQM1wcC23FgdIhIML1J1se302BapIIUIpuayZyfxysSHsRKAuLf82wP
 AYarIICjWCblClFmfG0d4SzpNN/EElL/6k+2q66Uofj2eLu1uC5MYtcGhlRUd1M4i+cMXguBp
 qklwLnxJXAjH/MYsCiCqeNbOBkqIVB5euZcBl0nenaH5UhKBv8kf6yr2CLhelPxAL/MeaMFAb
 igmaVsTogCF7pE9qrM/LJ1NtibFnZOo72kiHGhBXhwduvySJeTMg7+FrFcRuBPzKKredhrp9h
 G9mAygSrcL0vs9mLf3lJMVmc6ljMeIrzsytKSU8jtHy8mR7MQy68EL5v7DsZNgc/8SJeYI+5Z
 Y6N34Usa5F+6EjP2PV1DguARVQdSpVZepOZaukIW0auyxytWOZvBOSY9WKvN6V0OlXSMmFECL
 AQis5BFsikrqnIT8hliHJUrWg8veyZ3UtGOvIsZhBkG+ZRVY/CkynyMXUohHBHjODA2RnCiRb
 1Dff0XVMIQOWLSDNoUtShniNj+b9UsgIFn/JEqtQDEjJMMd6JlRdHfafGGl0K6SHjRf8832Ns
 Vh5Cdmn5ZbnKKdraTeeriSQk17L3iXp7sHqbq6o0GU6EElalGMspzJ55hWyphjUFhhbDi258D
 9ZeLs+aMdU5jDieWvNy3+eoCpmxoHpwrsR2rCg9zm+Gr6q2CdrtX0lU5cAkYxPjotfamE5Bfz
 18/leczQ41c3L9fVOYBbJT0bOnaRp+6A645p40xjdP+paSeHLz6Jm+rZfPuoKsiVdO2iKPCUF
 kYTwYVmrn27BQBdPb7XAhCfP50QUT3Tp/eaZMD7ZEkmfWt8O5yJ4e5qUBqjA0ivgLGQMFxTKH
 1aXWCCjrv9Jmps=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enhances the DTs for the IOT2050, primarily by added support for
upcoming Production Generation 2 (PG2) and by ordering the MMC devices
consistently across variants.

Changes in v5:
 - fix usb0 node (for true USB 3.0 support)
 - added reviewed/acked tags

Changes in v4:
 - update dtbinding with new board names
 - fix review comments on commit messages and style

Changes in v3:
 - move mmc alias back into board DTs
 - add patch to enable R5F cores for rproc

Changes in v2:
 - move mmc alias to SoC level
 - split up into PG2 preparation and addition patch
 - add link to product homepage

Jan

Jan Kiszka (6):
  arm64: dts: ti: iot2050: Flip mmc device ordering on Advanced devices
  arm64: dts: ti: iot2050: Disable SR2.0-only PRUs
  arm64: dts: ti: iot2050: Add/enabled mailboxes and carve-outs for R5F
    cores
  dt-bindings: arm: ti: Add bindings for Siemens IOT2050 PG2 boards
  arm64: dts: ti: iot2050: Prepare for adding 2nd-generation boards
  arm64: dts: ti: iot2050: Add support for product generation 2 boards

 .../devicetree/bindings/arm/ti/k3.yaml        |  2 +
 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 46 +++++++++++++++
 .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 51 +++++++++++++++++
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 39 +++++++++----
 ...ts =3D> k3-am6528-iot2050-basic-common.dtsi} | 12 +---
 .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 24 ++++++++
 .../boot/dts/ti/k3-am6528-iot2050-basic.dts   | 56 +++----------------
 ...=3D> k3-am6548-iot2050-advanced-common.dtsi} |  8 +--
 .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 29 ++++++++++
 .../dts/ti/k3-am6548-iot2050-advanced.dts     | 50 +++--------------
 11 files changed, 201 insertions(+), 118 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
 copy arch/arm64/boot/dts/ti/{k3-am6528-iot2050-basic.dts =3D> k3-am6528-i=
ot2050-basic-common.dtsi} (80%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
 copy arch/arm64/boot/dts/ti/{k3-am6548-iot2050-advanced.dts =3D> k3-am654=
8-iot2050-advanced-common.dtsi} (85%)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.=
dts

=2D-
2.31.1

