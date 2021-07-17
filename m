Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813CB3CC439
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhGQPlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:41:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:36255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234787AbhGQPld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626536304;
        bh=iZJzMiq/vESZ2pyqPpRCYJAQLHIcDzTWUIgzTPJmsb4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WxWI1u3PV381hd3LnI0jFzYt8hfQMwwoDzP5bEDn5qAkU3P2EephUGwGep0G1ZN7q
         HuLjve0tVx+vY2SNzQhj6ZJaI9umeoSoHSOFN+8/mh1M3c2U26xJ0WmOGm4mFwJ6N6
         G+yB5FfzcPQL0QlANjaV/Ucvejy5roAExHjbfSvw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MGQnP-1lv6943nMz-00GpmR; Sat, 17 Jul 2021 17:38:24 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/ks7010: Remove all strcpy() uses in favor of strscpy()
Date:   Sat, 17 Jul 2021 17:37:59 +0200
Message-Id: <20210717153759.13468-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DKK2exlaQxwebtcjUBUsZXnGR2wcU/rdSgHOz1LAEFdMxSF7p78
 cnPT0opL08BKaEjM2CCsl4i+zbwxMqopwc5VuItZ9oc8HJT+yq81aic3EgK4K2UvoThU91s
 /E8qiqad79vEDThG6GQh7gFHsS5megGJTfsKHUo892/FfGa4kLtaXcvVuXGVI6xeb5Gs58h
 ISBIiM4I+16yjsPF0KfmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qEpoHoAWcqA=:7lYDvzrpcfy+7Og0JsmaU6
 Bxa0t/lDZ28zzMPmuNF951Qk3cCqJ51KihfxZaM1I6CIVFH113bj3xXVNRuen6ncH1p7nSZua
 dZHDsMJy50Hfrdslycm5o7Nz80VHGE4r1o2R4djUVY9Mf/BXTw3tqAHkoxGs0XLpX760UyDvF
 h+lxRSul3MoZPHZTh6LxyMd9jjLsfWg9Z9UFVhrfnAOdlOV/31fJEaSIeyyImWn7rJjwlIUaV
 g3ErzY6zVbPiUnF9EVXthOPJfDQxICcMawx4XsMcW5YsdQKu6P2ABkl2PqfpbcrgKHzrrFhWG
 tyg+Kv8qN4gwPv9PWev+epehaxlC5T9Pz2b/dT7rU56W87OomObYKdqXnN19Ka/Q9TnIZw5sy
 q+P9tW8IqbArE1lpz/CYv7/ghThB/ycn+5YJ0gojEO29YQuh5sv2a2p8TrL+OZPsSEbjN3mUH
 ZtAPb7OAnm+HvWvDDrXc9UcsryQJ7j41darlgdZLb/r11kuJDRS/TMKVlaKpEIpXe7C0W3+bH
 aK/hk/wvv30byuWs5+j69uKoogWVUw7IVBlhki8zkAnGXRoAOpjLxhAaNR89wC4ulGyb/J41r
 bfHawYK1fGkPqCieFAjmzBpB5uIJaIYg9hy8bLcMXaxqPsFmYMlhUjL+KH0HAFOWpjJVbUSDT
 HNhA15n+7Q0PBwC2/wGH+l5VDYUceYXQpWG/MRQOqzTgnNeuN61u2M5ptjqXeCjS/DLCDqYlU
 zf8LTyUNx1lfiiXiRMidb1n32ybg6tFV1eA6YotiZ9w7OGojizUVAnDwKiEl/yi8npJ6it634
 D2gffosUAd7QBl1+FpMzmrPW/rb+b6zu8q5imYE39xKiFC5j6V/l2pDQnNDa4jwMnp9z15Li9
 xHeVJYNd7Csgyaa0h2T6GSgJpwrm/jw/CMWidLt6jjLJTIDqT0AG7dvx/24cpex2n5H/2Bq+y
 myeAOnOyaYcvh01KlkztA2WU+6Vf0kIMo0Gyd+U6bgX7NVlNtKGozJd+GOWEqJr+vKI7gGYxT
 R8Pz4wwkBK8e/ZjLZwSvhxXq8DiJf18bBSIo8E1dbbYyrrHxDGvHncD+carpbr8/Ebx6YIVia
 ZC2gcMYRgpn4iwU6BLBjujoDf3L2oU06Glo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/ks7010/ks_wlan_net.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010=
/ks_wlan_net.c
index 09e7b4cd0138..7a38b1ceeb5c 100644
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
@@ -1808,7 +1808,7 @@ static int ks_wlan_get_firmware_version(struct net_d=
evice *dev,
 {
 	struct ks_wlan_private *priv =3D netdev_priv(dev);

-	strcpy(extra, priv->firmware_version);
+	strscpy(extra, priv->firmware_version, sizeof(extra));
 	dwrq->length =3D priv->version_size + 1;
 	return 0;
 }
=2D-
2.25.1

