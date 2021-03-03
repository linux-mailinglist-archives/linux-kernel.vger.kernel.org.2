Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7741632C00A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386422AbhCCSPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:15:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:39137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245740AbhCCPux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614786452;
        bh=6Klx+LARlH5Cs/YxTUDW1nPNa3j7+K+6thHFi7p4CDc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NXga4I5fLeDHKFRY/TTw0fRfnHqGY6oDVQ089z6IZeq67UkX3Pg08ziXL2H743b5i
         d0a+py7OMtAa26J2M9nY0je4Wab3b4V9Lhg5U6DzJ8qLyK4sj9YnUO2LGttrZHitY8
         CxbGFd15J/PN7ERpWKgtnb1fB+dWsO3JmCu5705w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCOK-1lTewi04sm-00NAoC; Wed, 03
 Mar 2021 16:47:32 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     openbmc@lists.ozlabs.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 2/2] ARM: dts: Add board-specific compatible string to npcm750-evb devicetree
Date:   Wed,  3 Mar 2021 16:46:20 +0100
Message-Id: <20210303154622.3018839-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210303154622.3018839-1-j.neuschaefer@gmx.net>
References: <20210303154622.3018839-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oZazP4cwJZAwbnbneWa1/KK2gj3wzLE2XLsYWmGXk3CjSRbfvMF
 48WVhwdzIpwnyXALsuw6Kf0JtAzusEePLg3qpNFm8NuhG6ZAaKCWpGgQeRcfPS9A9ufIKMa
 N2k76/1dfqa7IHeZxlS2kcPkGBSH7W5lbWUuD4jItsf1CdwCdLaEuh3umHfAargzddIfRxR
 APd80CkmU+7Pdu2nEaUBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TJLq5vx6za8=:5vKlObkYo+3AjOrKHfcu+1
 a3zRSasw6Bmjw2L02HhxeEYb7RvowO+InntKiSri3IHbhRmf9gpSA0Vo82aQa67hCCI2kfbFq
 j1vsvknhLGHgf9l4EV4/Z3HzE7lWH1qs4vE3BVrK78o2MLxA6bgxmQ/rknbT2g0dOLSE46Gd+
 4c3PtbrQsKvJn4nZ3Zw1lahafP3iXeVD1P1rRTsL8zfGN88ldmc7VBbiGoiKPBSFF44j80+G7
 chZKlLBRSz7lgWqKdA1IPRFLoUV4NMGhO5FHp9ppJDAfftoClijat4hqzS8Wrbbdwy88CwsWo
 8XeA4IjCeRkRekYFNLymn6PlzUD5PwIrg+9gn7ujLSoEH5j1A4Oark4KvB19cixDqjhMVRwRZ
 MPIutKpq7jXnGhr4QPKFHHM5FN3AxQqAfCMt3kk3aF0fyiHmQLqCqDhnyBBGKNAIIVltKGbso
 HHYvGnPt0dhlHE0DOuxVuzOEoINescGPhaUZqMhOn7V+Q36+r0Y7FbOD1vS5QfsNh4/qXBROf
 duYcuSqjrDCGTsw3AAqS9MktJfuPblDXaBVre1sxey9QeVPi9P+Ohm1n/lMDvdpksmmoJdQPQ
 N2aboIJyOiPjejoEdDwarjToggi5oifw8ElHm0J/xm5b1z4lktuECDdqzf5jWU2j2hWfkDtMj
 Xw7oIxOZyua6ltWrXazhz1wBav9iK9dKhyNk5x7/23CS6nQ0K9WUcfR8O6mhpQ7VV12YmQg5D
 KzGlG5LTj2ruoJWtprp7hpUsTnwxqQqXWJQTxU7OgJPZizzlv6KVxd7IgiJRBbFHaw9hvoXjI
 dAwN9fAt2zW59JRAla46hXIewR8Q+zVzCC7GfWDgOIua8YLrTuxjU5yuosK/mj1pz4KtJMjum
 WDEbDJREHXRE173kNmuQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the revised binding, the devicetree needs a board-specific
compatible string.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

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
2.29.2

