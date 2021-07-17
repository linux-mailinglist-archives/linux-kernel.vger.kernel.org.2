Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708AC3CC449
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 17:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbhGQPzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:55:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:56997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234454AbhGQPzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626537126;
        bh=mZcP3QmI7YItRwoSRYnjV0gfYLGImu6x7tc+Qai8wIQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hsKpqVOZ3p7sWvpcDkUU01YH+SeIlBaRhzd4uMxBYC/yOl6zyp61HmktWIY/36gGR
         lMN8wm17G1tB/NYk9x2rpE1wUb1tj6I+DWIiRENBz4JDrj2BsHZT2LBtL04CkcNIuR
         zWFgliqBtNkW5a8M2sl0s2Y/1vNG3gFOr88vYsIg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MgeoI-1lUJje2GA0-00h3sX; Sat, 17 Jul 2021 17:52:06 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/rtl8712: Remove all strcpy() uses in favor of strscpy()
Date:   Sat, 17 Jul 2021 17:51:45 +0200
Message-Id: <20210717155145.15041-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5C1c4EKwqwdWzS1m8cugGHgErNfVnZaBAsgwiLEyAvM7mbWHFh6
 3dPzuepBGkRvzS6i/eiEy9tk2c+MCnBxRn757yPDgAmfn3NbFT7qTul3SG2DocmU/96FEoe
 GsGpaKKgIIO7UDxOv+2O/8x2/9RmZkrEnQYa6NxCRbl1CAqv0zmt4T/HfkyNl1CJQSMCVkn
 ZS54E7eEKFAJOoUSZqPVg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:00IjXtN2iM8=:8GT4FY/lAjE2z6TxXsschr
 h7HSls1qOnKtKjqOTnzolJHU+2Flj2+roAGKB6ppp2N21u5YZVLJ/64gxl7CDdAKnQog4c1iD
 uKbC/V05Zc3yxm6FBcG94TXswtdYY9W0Io71tzSqdLnrtQJqgPjF6jYTNQmRlI7UcgD914Y5q
 W8uHaVEIphKt1jS2xcQEl8RoJ5lKQXUc9Z72FQ08wYJaff8DhgXt2hr4+XMnz6FKX4Oqh832d
 u5yr5AEu4f7OJb9vJD1PXr8amodxKt+0k5czt/hRSfl61l+aWuVnYBxg+g3tn6c2NdGbBPBQ+
 pCenu4efjCn+CpUrP/ls1HMk7c8SwOZF+Ij8/MKq+H4qJqNsZsu8QAQTmapM/Tri3xvxpiojI
 PEuSnh8CDAwTe+ysfQoVRYSg+Jm+Gd9/sdwNaCMRUiEBx4f/9UzI/1k6ZFBJgGzXB7rQBWBdk
 8bFkqTAimOgZOtu/x/nBqlokyZMzdD2h37jVP1XOC0lH4crqLACIXUyg+H+htAAb4Ejm8ISwm
 KRufPyjvzRaC+a9/VTfluE2lcBW5mQ6ayDjFZsN7JLOlwD+FwbccEYpi3Dy1KT89DMEj4zg/2
 SW12lqlRcjx0/Qs36ZE++qCmxPpAaRMuJFecP5MQWZmYQTplqpzsREeeL+W91bs5DjJEPkqkY
 p5UZNSOYmsy2tY/K43LhLDPmTfWuOpys45M4SipCCrx9SfpahQ8az1WVfNCJT67/malL8bSG/
 utXNRGEFlkDSo6Cb3hbC2M4qWW+ShEnUxWzlP6mjYDtwHG0AvK3zmsHmh0Qo2eMD8p1PRArjX
 kWGYiQztd3LCTh3lyCvj4H8Qlh3wke+lexIzIwQEuyhB5DCkaQ6sVWWM2WA6DsbgYBJInW4gJ
 Hk/V06UCvBe7d5lXOq6KZISfXQSBlq+uCuosqqAvLYfE0+rLvd1KA59lCulT1HGxCAK1PFODD
 gspNP4EmkKfMQzCMopeueZ3N06YD3SiqW03HnblJ5aneZyT0uPnE05MStMQXs1fVXw3o9cdAa
 nFoVdvEEX9rTVnyMv2T0WNbBCk6suQ077V9WUtSW8v8O7GH7nB2hM8+oBy45Pg82kkp5dAetu
 70ecFhQAks8caXhhkq9+/nw+UkAZt7Kmz9V
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 drivers/staging/rtl8712/os_intfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/=
os_intfs.c
index 2214aca09730..9502f6aa5306 100644
=2D-- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -203,7 +203,7 @@ struct net_device *r8712_init_netdev(void)
 	if (!pnetdev)
 		return NULL;
 	if (dev_alloc_name(pnetdev, ifname) < 0) {
-		strcpy(ifname, "wlan%d");
+		strscpy(ifname, "wlan%d", sizeof(ifname));
 		dev_alloc_name(pnetdev, ifname);
 	}
 	padapter =3D netdev_priv(pnetdev);
=2D-
2.25.1

