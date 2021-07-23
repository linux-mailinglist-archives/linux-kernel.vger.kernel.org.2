Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313C13D3C03
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbhGWOLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:11:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:43339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235351AbhGWOLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627051905;
        bh=YqwpkK3WDnXhhqj3NQNMjWZeTXEz38CPziFEMoOgC+k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=FvMfg9CGmIrPzxQ8UdbXAAcbkncahOVDZa1dpV2wNe48hU9WFIC7JRbuexxVPleW5
         5uWM6aH4JSra/g4Eee2tdWtWKc2SBWDoirKfPwC46d3Ba0g3DjyQbvO0Zhl6H9XJ0O
         7/Z7/UbVTEubRrHyROL7jAOGPrWFci26QIlLIUQc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N0oFz-1lCtOu27Jl-00wnKM; Fri, 23 Jul 2021 16:51:45 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging/ks7010: Remove all strcpy() uses in favor of strscpy()
Date:   Fri, 23 Jul 2021 16:51:22 +0200
Message-Id: <20210723145122.5746-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lZYL+o9N15i0U7XTwJYxixhuIsXHSWlXHBr2rf/3JZU6G5x3M1p
 DNhlgSxz/McHWkxIRP4HLrFhGcL+LzfEGZOwKGsiRj0aU6FhVP4EYBuVcfPJrUKuH3y7x4q
 bmpq7YRl7pXv0iJBrxlgPB/pmiB+AEYXeutepao9O9yQK+G8oUcaoUyAmte4afVN6Tg+LjK
 tqrj/l728QAuQJAZ4t2OA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ta/w8L5WZqg=:OL80BLGeR9picO+oDxHZmd
 3pyKCX368JzF3nWuE8iRCAxdRBpY3OWWFeun/f1Xq6JjZapK9ncW/mPnWfOpPSaX/4EgJFS4t
 X9VQuSebVKaHNbkNAqlxhFhx4d/sBDk+IUTcl88iMvnjShA4tIj7po0t5w3ET7ZGo1L/90wEK
 dp3IUcoQvN8A1K6DubOPHH+NQYm7XSPFqJLu2s9FaUFJseQyPoE+0pnJ1r0yLcz7TO3kk7Pci
 LBY3iEqOn61pynVvdioNSaPZZoZQiLuyIikCtlsrX48bNL//3vSaH+zxjzJ3nW4qL/+U5NC3L
 Bg/AaaKjQsDSkf6I0D9z9KSIHeRKS0pmSKdyqA1z1vPJbaql1sq14LBCaJxYZczA0aW4pEuH/
 k5F3Vb4ox8QvsWCpIHl57CGPRp2SBfnLVf9jgOzo4nL3G74QuMFK4fXbduWU4MFvmp1PNP373
 m5AAP+vgeswx2y1EyRUwfgP7YFBLL9aA2YsERnej0gVTNOI+oSivUYxtc9PCHriLDw+9/Qqjw
 GfeWyKirS2UjDeQv2RmNnt7ACFx625pTtMap9PhP7WZAG2GGRMlIThvXmDjl+L7nTPmXSmCQ+
 dSB9pwijIM8Z3ByqPW4+fkrXcoBzxzSUELghcQHcu7tkaZZwKV2t/w+hlRjiHlDmQSD0tFldW
 mrn4nQsw9SDMb1M0Xl2n8NBm7oa1/dNyIKSu7+Zw55KPHh8AAh2sw761GlZefpuDLhG/m55uo
 UB0Dr//DJ2VfGrfqTi4Uc64swKNw/v31H2JvpVY8h10ILHp0QKZ7atr2YotHckHHaqXGEon4b
 1lnK2UdJqc06GWk9lKMrCMaOlpTLYzDsiZ2EOHEDDW272CqCRNCeQraDXUJhAB9KcxZAGnee0
 L/Ki1fTl5r5/mqjYWSNiWLLsJXWbwLiDc7FJT0UCPxiS832+zYHv2dXgg/z5jpYQsuB9uxYm6
 gSarNhw/ATY4HxtZ4goS1pRsxTacYRaGXHhDXQqRt3QH6Mchet4FBpia3PLYwBmyZ+Ku/vvaL
 f3gg++O2THf86W5TPOuERXXRzr0hzi/OT9qaXNqJBfx7Rwe4RYPCUI2NuiqGdmM8BvnJmpkZV
 zWzv+Hc7RRaNJ4EhnE8fsbXPxMyHdLOFHhw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Changelog v1 -> v2
- Use the correct length for the extra pointer (Dan Carpenter).

 drivers/staging/ks7010/ks_wlan_net.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010=
/ks_wlan_net.c
index 09e7b4cd0138..631ad769c3d5 100644
=2D-- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -158,13 +158,13 @@ static int ks_wlan_get_name(struct net_device *dev,

 	/* for SLEEP MODE */
 	if (priv->dev_state < DEVICE_STATE_READY)
-		strcpy(cwrq->name, "NOT READY!");
+		strscpy(cwrq->name, "NOT READY!", sizeof(cwrq->name));
 	else if (priv->reg.phy_type =3D=3D D_11B_ONLY_MODE)
-		strcpy(cwrq->name, "IEEE 802.11b");
+		strscpy(cwrq->name, "IEEE 802.11b", sizeof(cwrq->name));
 	else if (priv->reg.phy_type =3D=3D D_11G_ONLY_MODE)
-		strcpy(cwrq->name, "IEEE 802.11g");
+		strscpy(cwrq->name, "IEEE 802.11g", sizeof(cwrq->name));
 	else
-		strcpy(cwrq->name, "IEEE 802.11b/g");
+		strscpy(cwrq->name, "IEEE 802.11b/g", sizeof(cwrq->name));

 	return 0;
 }
@@ -1808,8 +1808,8 @@ static int ks_wlan_get_firmware_version(struct net_d=
evice *dev,
 {
 	struct ks_wlan_private *priv =3D netdev_priv(dev);

-	strcpy(extra, priv->firmware_version);
 	dwrq->length =3D priv->version_size + 1;
+	strscpy(extra, priv->firmware_version, dwrq->length);
 	return 0;
 }

=2D-
2.25.1

