Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D01342E70
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 17:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCTQlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 12:41:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:54093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhCTQki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 12:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616258433;
        bh=L26U0dSxXV92Zaj3k91eaUjljjT8BQetpl9WjDf6874=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ilrWU23sAGX2IYU8loALRr+957bF+RDbf7CYTuaclrHh+I7yVOe4hZ1d9NYB7h5qN
         tn0xOrjCYwIpeq+nkjP5BARzmeSHcv4NBcKsgd3JkfZqqWU0o/MBNvb0FBXXexQ+sD
         QCZaD99+4wbcduEJJhknTxKruA0NDNxJ/ys61WAo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4zAy-1ln7X30Wgu-010xBv; Sat, 20
 Mar 2021 17:40:33 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] ARM: dts: Add board-specific compatible string to npcm750-evb devicetree
Date:   Sat, 20 Mar 2021 17:40:22 +0100
Message-Id: <20210320164023.614059-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320164023.614059-1-j.neuschaefer@gmx.net>
References: <20210320164023.614059-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:21kWaxejy7e7NxgQlEvkLx2G+V4V5I4UsiWLRFMInkk9qykpfZO
 /48Yk+VR8pFFR2gz9lBCSPve/2ItAOhLMNs2l+FZnMgZsxZnh/GMpY2DQsmD8CGyZTNFjNL
 6f5T2mJOr0l1xaJjVauH80F/NIpOOwA9Tb2inzlM0QuEux5wd9/cakbXY3hSRpYm3rip0Gs
 p60bFx+vIlcf87JPH3uXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T7u96VjaVqQ=:yS9lxHNITsi5drK87khYQL
 LYCyFbqwpTJpBYEwJZG+/Qqg7Tn0Mg4DDqqBh95YDMOjARmo6t37ytswBuviKYCurmP7+wKMS
 Y7yLAp5a7YfTqcrv/C3qiF8L2e4nENz3ch3Af/Fy/paOBPFxlAtBXHWuGt/mbpWmpufSnIUes
 X11NApJlczPOpNPT466l0zalF1JT+SYkz3MJzMdnBwhY3a16vEJZ4SpM5HBrPPAtEbnmjhtIv
 gPv3i1HI/yufiBeMizSnkHjqITJ186bxNBFt4LskTTK1l0Mb151HYe+YefKztGiIa5LVAX1K8
 z/Nuu2iq+cy8lRwS1In675dRHyWV93Q/i75xI1OGVUKBWzoqPGk85eugA/9sno3h+C0/cuwcj
 i+lZ1sf9+tQi6tGs7rnmiP+iWNbvXBM79DyI2+eG7t7IWo7kr8DZV2z12RzxYMOv2QfwUfuZM
 qvDK68FSx0KAai0Bv5DOy4dFZyxaACcul9Er/6rGoQai9Jggi4db3/uonZK/ZzCPOwjaH6klj
 GmrKql4MTsi4wFxIMgwGXhcb6OgiUM9T/RyMHd7FmYIA9iJNYPLXIo1MmXp/gYsNyaQHdtF1H
 E22zAA7nTUTmDaOvBP+1ok/LdR45GLzWxY5yfdy7uZGpakHnzqECTfHIuprGE/AKPeoVJV4ZU
 quLxIMor634f8D8k31HL0m4ucv7+egqgDBhOh/Z3LyNKKnSg8DHY03LCjhBttri+2JVEplY1y
 ipnV2FrgdHtxgbEjzrGSN7UdLl4LcpsvL08W6wkmaRUYZ1pgAydjObIwCj0Q5eSvDahbLT4mX
 BuFZ36V9hYn27E5sAB+8EHlYnTEpWJypdgNcPf/zfQ72PRSSyUCGY8OUA7iVJFT+LEKWz/zPs
 6ownoy6/7j4evJTJCS3Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the revised binding, the devicetree needs a board-specific
compatible string.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v4:
- the same as v2

v2:
- no changes
=2D--
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts=
/nuvoton-npcm750-evb.dts
index 9f13d08f5804e..dea3dbc4a6a52 100644
=2D-- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -9,7 +9,7 @@

 / {
 	model =3D "Nuvoton npcm750 Development Board (Device Tree)";
-	compatible =3D "nuvoton,npcm750";
+	compatible =3D "nuvoton,npcm750-evb", "nuvoton,npcm750";

 	aliases {
 		ethernet2 =3D &gmac0;
=2D-
2.30.2

